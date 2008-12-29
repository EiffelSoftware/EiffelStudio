note
	description: "Value retriever to get metric value over a given domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_METRIC_VALUE_RETRIEVER

inherit
	EB_METRIC_VALUE_RETRIEVER
		redefine
			default_create,
			process
		end

	EB_METRIC_SHARED
		undefine
			default_create
		end

create
	default_create,
	make

feature{NONE} -- Initialization

	default_create
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
			metric_name := ""
			create input_domain.make
		end

	make (a_metric_name: like metric_name; a_input_domain: like input_domain)
			-- Initialization `metric_name' with `a_metric_name' and `input_domain' with `a_input_domain'.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_input_domain_attached: a_input_domain /= Void
		do
			set_metric_name (a_metric_name)
			set_input_domain (a_input_domain)
		ensure
			metric_name_set: metric_name.is_equal (a_metric_name)
			input_domain_set: input_domain = a_input_domain
		end

feature -- Access

	metric_name: STRING
			-- Name of the metric from which `value' is caluculated over `input_domain'

	input_domain: EB_METRIC_DOMAIN
			-- Input domain

	value (a_ql_domain: QL_DOMAIN): DOUBLE
			-- Retrieved value			
		local
			l_metric: EB_METRIC
			l_domain: like input_domain
			l_helper: EB_METRIC_COMPONENT_HELPER
		do
			l_domain := input_domain.actual_domain
			if not has_metric_status_checked then
				check_metric_status
				if not metric_has_delayed_domain_item then
						-- If metric doesn't rely on any domain item, we just calculate it once and
						-- store it value in `metric_value'.
					set_metric_value (metric_manager.metric_with_name (metric_name).value_item (l_domain))
				end
			end
			if metric_has_delayed_domain_item then
					-- If metric relies on delayed domain item, we have to calculate it everytime.				
				l_metric := metric_manager.metric_with_name (metric_name)

					-- Replace delayed domain with actual domain.
				l_helper.replace_real_delayed_domain_item (l_domain, a_ql_domain)
				if is_external_delayed_domain_used then
					l_helper.replace_real_delayed_domain_item (l_metric, a_ql_domain)
				end

				Result := l_metric.value_item (l_domain)

					-- Restore original delayed domain.
				l_helper.replace_real_delayed_domain_item (l_domain, Void)
				if is_external_delayed_domain_used then
					l_helper.replace_real_delayed_domain_item (l_metric, a_ql_domain)
				end
			else
				Result := metric_value
			end
		end

	value_with_domain (a_domain: EB_METRIC_DOMAIN): DOUBLE
			-- Retrieved value.
			-- This is used in metric archive warning checking.
			-- `a_domain' is the input domain used to calculate metric archive node.
		local
			l_helper: EB_METRIC_COMPONENT_HELPER
			l_metric: EB_METRIC
		do
			create l_helper
			l_metric := metric_manager.metric_with_name (metric_name)
			l_helper.prepare_for_calculation (l_metric)
			if input_domain.has_delayed_input_domain_item then
				Result := l_metric.value_item (a_domain)
			else
				Result := l_metric.value_item (input_domain)
			end

		end

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.visitable_name (metric_names.l_metric_value, metric_name)
		end

feature -- Status report

	is_retrievable: BOOLEAN
			-- Is `value' retrievable?
		do
			Result := metric_manager.is_metric_calculatable (metric_name) and then input_domain.is_valid
		end

	has_metric_status_checked: BOOLEAN
			-- Has status of metric whose name is `metric_name' checked?
			-- Note: We check if the metric doesn't have any delayed domain item in it,
			-- so we only need to calculated it once and reuse the value later on.

	metric_has_delayed_domain_item: BOOLEAN
			-- Does metric has delayed item in it?

	is_external_delayed_domain_used: BOOLEAN
			-- Is external delayed domain used?

feature -- Setting

	set_has_metric_status_checked (b: BOOLEAN)
			-- Set `has_metric_status_check' with `b'.
		do
			has_metric_status_checked := b
		ensure
			has_metric_status_checked_set: has_metric_status_checked = b
		end

	set_metric_has_delayed_domain_item (b: BOOLEAN)
			-- Set `metric_has_delayed_domain_item' with `b'.
		do
			metric_has_delayed_domain_item := b
		ensure
			metric_has_delayed_domain_item_set: metric_has_delayed_domain_item = b
		end

	set_metric_name (a_name: like metric_name)
			-- Set `metric_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			create metric_name.make_from_string (a_name)
		ensure
			metric_name_set: metric_name.is_equal (a_name)
		end

	set_input_domain (a_domain: like input_domain)
			-- Set `input_domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			input_domain := a_domain
		ensure
			input_domain_set: input_domain = a_domain
		end

	set_is_external_delayed_domain_used (b: BOOLEAN)
			-- Set `is_external_delayed_domain_used' with `b'.
		do
			is_external_delayed_domain_used := b
		ensure
			is_external_delayed_domain_used_set: is_external_delayed_domain_used = b
		end

	set_metric_value (a_value: DOUBLE)
			-- Set `metric_value' with `a_value'.
		do
			metric_value := a_value
		ensure
			metric_value_set: metric_value = a_value
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_metric_value_retriever (Current)
		end

feature{NONE} -- Implementation

	check_metric_status
			-- Check status of metric whose name is `metric_name'
			-- to know if that metric doesn't rely on any delayed domain item.
		require
			value_retrieval: is_retrievable
		local
			l_visitor: EB_METRIC_COMPONENT_HELPER
		do
			create l_visitor
			set_metric_has_delayed_domain_item (
				l_visitor.component_has_delayed_domain_item (
					metric_manager.metric_with_name (metric_name)
				) or
				l_visitor.component_has_delayed_domain_item (input_domain.actual_domain)
			)
			set_has_metric_status_checked (True)
		ensure
			metric_status_checked: has_metric_status_checked
		end

	metric_value: DOUBLE
			-- Metric value
			-- Note: If metric whose name is `metric_name' doesn't rely on any delayed domain item,
			-- we just calculate it once and reuse the value. The calculated value is stored here.			

invariant
	metric_name_attached: metric_name /= Void
	input_domain_attached: input_domain /= Void

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
