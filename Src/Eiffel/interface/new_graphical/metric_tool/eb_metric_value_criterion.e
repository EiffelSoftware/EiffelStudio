note
	description: "Objects that represents a value criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_CRITERION

inherit
	EB_METRIC_DOMAIN_CRITERION
		redefine
			make,
			is_parameter_valid,
			is_value_criterion,
			process,
			new_criterion
		end

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			metric_name := ""
			create value_tester.make
			Precursor (a_scope, a_name)
		ensure then
			domain_attached: domain /= Void
		end

feature -- Access

	metric_name: STRING
			-- Metric name whose value is tested

	value_tester: EB_METRIC_VALUE_TESTER
			-- Value tester

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION
			-- QL_CRITERION representing current criterion
		do
			Result := criterion_factory_table.item (a_scope).criterion_with_name (name, [agent evaluate_function])
		end

feature -- status report

	is_parameter_valid: BOOLEAN
			-- Is parameters of current criterion valid?
			-- Parameter for current is `domain'.
		do
			Result := domain.is_valid and then
					  (metric_manager.is_metric_calculatable (metric_name))
		end

	is_value_criterion: BOOLEAN = True
			-- Is crrent a value criterion?

	should_delayed_domain_from_parent_be_used: BOOLEAN
			-- Should delayed domain from parent be used?
			-- If True, delayed domain defined in metric whose name is `metric_name' will be replaced
			-- by the domain generated from the item over which current criterion is evaluated.
			-- Otherwise, delayed domain defined in metric whose name is `metric_name' will not change.			
			-- Default: False
			-- For example, we have a metric names class-with-too-many-non-used-features which check if in a class, there are over 10 non-used features.
			-- The definition is like:
			-- class-with-too-many-non-used-feature (type=basic, unit=class)
			--	|
			--  +- criterion
			--		|
			--		+- value_of_metric_is													(1)
			--			|
			--			+- domain: delayed_domain
			--			+- should_delayed_domain_from_parent_be_used = False
			--			+- tester: value > 10
			--			+- metric: non-used-features (type=basic, unit=feature)
			--						|
			--						+- criterion
			--							|
			--							+- value_of_metric_is								(2)
			--								|
			--								+- domain: current_application_target
			--								+- should_delayed_domain_from_parent_be_used = True
			--								+- tester: value = 0
			--								+- metric: callee_is (type=basic, unit=feature)
			--									|
			--									+- criterion
			--										|
			--										+- callee_is (delayed_domain)			(3)
			--
			-- When evaluate criterion (2), we get an QL_ITEM, the delayed_domain at position (3) should be replaced by a domain represented by the
			-- got QL_ITEM (It cannot use the delayed item got when the metric is caluclated of given input domain).
			-- That's why `should_delayed_domain_from_parent_be_used' is set to True for criterion (2).

	has_metric_status_checked: BOOLEAN
			-- Has status of metric whose name is `metric_name' checked?
			-- Note: We check if the metric doesn't have any delayed domain item in it,
			-- so we only need to calculated it once and reuse the value later on.

feature -- Setting

	set_metric_name (a_metric_name: like metric_name)
			-- Set `metric_name' with `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create metric_name.make_from_string (a_metric_name)
		ensure
			metric_name_set: metric_name /= Void
		end

	set_value_tester (a_tester: like value_tester)
			-- Set `value_tester' with `a_tester'.
		require
			a_tester_attached: a_tester /= Void
		do
			value_tester := a_tester
		ensure
			value_tester_set: value_tester = a_tester
		end

	set_should_delayed_domain_from_parent_be_used (b: BOOLEAN)
			-- Set `should_delayed_domain_from_parent_be_used' with `b'.
		do
			should_delayed_domain_from_parent_be_used := b
		ensure
			should_delayed_domain_from_parent_be_used_set: should_delayed_domain_from_parent_be_used = b
		end

	set_metric_value (a_value: DOUBLE)
			-- Set `metric_value' with `a_value'.
		do
			metric_value := a_value
		ensure
			metric_value_set: metric_value = a_value
		end

	set_has_metric_status_checked (b: BOOLEAN)
			-- Set `has_metric_status_checked' with `b'.
		do
			has_metric_status_checked := b
		ensure
			has_metric_status_checked_set: has_metric_status_checked = b
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_value_criterion (Current)
		end

feature{NONE} -- Implementation

	evaluate_function (a_item: QL_ITEM): BOOLEAN
			-- Function to evaluate if Current criterion is satisfied by `a_item'
		require
			a_item_attached: a_item /= Void
		local
			l_metric: EB_METRIC
			l_domain: like domain
			l_helper: EB_METRIC_COMPONENT_HELPER
		do
			if not has_metric_status_checked then
				check_metric_status
				if not metric_has_delayed_domain_item then
					set_metric_value (
						metric_manager.metric_with_name (metric_name).value_item (domain)
					)
				end
			end
			if metric_has_delayed_domain_item then
				l_metric := metric_manager.metric_with_name (metric_name)
				l_domain := domain.actual_domain
				create l_helper
					-- Replace delayed domain item in metric with current item `a_item'.
				l_helper.replace_real_delayed_domain_item (l_domain, a_item.wrapped_domain)
				if should_delayed_domain_from_parent_be_used then
					l_helper.replace_real_delayed_domain_item (l_metric, a_item.wrapped_domain)
				end

					-- Check if metric value satisfies `value_tester'.
				Result := value_tester.is_satisfied_by (l_metric.value_item (l_domain), a_item.wrapped_domain)

					-- Replace delayed domain item in metric back to its original status.
				l_helper.replace_real_delayed_domain_item (l_domain, Void)
				if should_delayed_domain_from_parent_be_used then
					l_helper.replace_real_delayed_domain_item (l_metric, Void)
				end
			else
				Result := value_tester.is_satisfied_by (metric_value, a_item.wrapped_domain)
			end
		end

	metric_has_delayed_domain_item: BOOLEAN
			-- Does metric whose name is `metric_name' has delayed domain item?

	metric_value: DOUBLE
			-- Metric value
			-- Note: If metric whose name is `metric_name' doesn't rely on any delayed domain item,
			-- we just calculate it once and reuse the value. The calculated value is stored here.			

	set_metric_has_delayed_domain_item (b: BOOLEAN)
			-- Set `metric_has_delayed_domain_item' with `b'.
		do
			metric_has_delayed_domain_item := b
		ensure
			metric_has_delayed_domain_item_set: metric_has_delayed_domain_item = b
		end

	check_metric_status
			-- Check status of metric whose name is `metric_name'
			-- to know if that metric doesn't rely on any delayed domain item.
		require
			value_retrieval: is_parameter_valid
		local
			l_visitor: EB_METRIC_COMPONENT_HELPER
		do
			create l_visitor
			set_metric_has_delayed_domain_item (
				l_visitor.component_has_delayed_domain_item (
					metric_manager.metric_with_name (metric_name)
				) or
				l_visitor.component_has_delayed_domain_item (domain)
			)
			set_has_metric_status_checked (True)
		ensure
			metric_status_checked: has_metric_status_checked
		end

invariant
	metric_name_attached: metric_name /= Void
	value_tester_attached: value_tester /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
