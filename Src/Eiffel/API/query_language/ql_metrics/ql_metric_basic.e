
indexing
	description: "Representation of metric basic objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_METRIC_BASIC

inherit
	QL_METRIC

	QL_SHARED_SCOPES

create
	make,
	make_with_basic_scopes

feature{NONE} -- Initialization

	make (a_unit: like unit; a_basic_scope_info: QL_METRIC_BASIC_SCOPE_INFO) is
			-- Initialize `unit' with `a_unit' and use `a_basic_scope_info' for
			-- domain of any scope in metric calculation.
		require
			a_unit_attached: a_unit /= Void
			a_basic_scope_info_attached: a_basic_scope_info /= Void
			not_a_basic_scope_info_registered: not a_basic_scope_info.is_registered_to_metric
		do
			unit := a_unit
			set_basic_scope_info_for_all (a_basic_scope_info)
		ensure
			unit_set: unit = a_unit
		end

	make_with_basic_scopes (a_unit: like unit; a_basic_scope_info_table: like basic_scope_table) is
			-- Initialize `unit' with `a_unit' and setup `basic_scope_table' with `a_basic_scope_info_table'.
		require
			a_unit_attached: a_unit /= Void
			a_basic_scope_info_table_attached: a_basic_scope_info_table /= Void
		do
			unit := a_unit
			from
				a_basic_scope_info_table.start
			until
				a_basic_scope_info_table.after
			loop
				set_basic_scope_info (a_basic_scope_info_table.item_for_iteration, a_basic_scope_info_table.key_for_iteration)
				a_basic_scope_info_table.forth
			end
		ensure
			unit_set: unit = a_unit
		end

feature -- Value

	value (a_domain: QL_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Value of current metric
		local
			l_calculator: QL_DOMAIN_GENERATOR
			l_quantity: QL_QUANTITY
			l_basic_scope: QL_METRIC_BASIC_SCOPE_INFO
		do
			if value_initialize_function /= Void then
				internal_value := value_initialize_function.item ([])
			else
				internal_value := 0.0
			end
			l_basic_scope := basic_scope_table.item (a_domain.scope)
			if l_basic_scope /= Void then
				l_calculator := l_basic_scope.domain_generator
					-- Here is an optimization, if we don't need to change
					-- the scope of `a_domain' and if no criterion is specified,
					-- we just count items in `a_domain'. Otherwise, we have to
					-- transform the domain into the scope specified by `l_calculator'.
				if
					a_domain.scope = l_calculator.scope and then
					l_basic_scope.calculate_function = Void and then
					l_calculator.criterion = Void
				then
					internal_value := a_domain.count
				else
					l_calculator.reset_domain
					l_calculator.process_domain (a_domain)
				end
			end
			if post_calculation_function /= Void then
				internal_value := post_calculation_function.item ([a_domain, internal_value])
			end
			create l_quantity.make_with_value (internal_value)
			Result := l_quantity.wrapped_domain
		ensure then
			result_correct: Result.first.value = internal_value
		end

feature{QL_METRIC_BASIC_SCOPE_INFO} -- Metric calculation

	internal_value: DOUBLE
			-- Internal value

	increase_value_by (a_value: DOUBLE) is
			-- Increate `value' by `a_value'.
		do
			internal_value := internal_value + a_value
		ensure
			internal_value_set: internal_value = old internal_value + a_value
		end

feature -- Setting

	set_criterion (a_criterion: QL_CRITERION) is
			-- Set criterion used when calculate metric
			-- A metric can have several basic scopes, and `a_criterion' is only set into
			-- that scope which has the same scope as `a_criterion'.
		local
			l_basic_scope_table: like basic_scope_table
			l_generator: QL_DOMAIN_GENERATOR
			l_processed_generators: ARRAYED_LIST [QL_DOMAIN_GENERATOR]
		do
			l_basic_scope_table := basic_scope_table
			from
				create l_processed_generators.make (l_basic_scope_table.count)
				l_basic_scope_table.start
			until
				l_basic_scope_table.after
			loop
				l_generator := l_basic_scope_table.item_for_iteration.domain_generator
				if
					not l_processed_generators.has (l_generator) and then
					l_generator.scope = a_criterion.scope
				then
					l_generator.set_criterion (a_criterion)
					l_processed_generators.extend (l_generator)
				end
				l_basic_scope_table.forth
			end
		end

	set_value_initialize_function (a_function: like value_initialize_function) is
			-- Set `value_initialize_function' with `a_function'.
			-- If `a_function' is Void, `value_initialize_function' will be removed,
			-- and `value' will be set to 0.0 before metric calculation
		do
			value_initialize_function := a_function
		ensure
			value_initialize_function_set: value_initialize_function = a_function
		end

	set_post_calculation_function (a_function: like post_calculation_function) is
			-- Set `post_calculation_function' with `a_function'.
			-- If `a_function' is Void, `post_calculation_function' will be removed,
			-- and `value' will be set to 0.0 before metric calculation
		do
			post_calculation_function := a_function
		ensure
			post_calculation_function_set: post_calculation_function = a_function
		end

	set_basic_scope_info (a_basic_scope_info: QL_METRIC_BASIC_SCOPE_INFO; a_scope: QL_SCOPE) is
			-- Set `a_basic_scope_info' into `basic_scope_table' with key `a_scope'.
			-- This means if we apply current metric to a domain whose scope is `a_scope',
			-- domain generator in `a_basic_scope_info' will be used to calculate the metric.
		require
			a_basic_scope_info_attached: a_basic_scope_info /= Void
			not_a_basic_scope_info_registered: not a_basic_scope_info.is_registered_to_metric
			a_scope_attached: a_scope /= Void
		do
			a_basic_scope_info.set_metric (Current)
			basic_scope_table.force (a_basic_scope_info, a_scope)
		ensure
			a_basic_scope_info_registered: a_basic_scope_info.is_registered_to_metric and then a_basic_scope_info.metric = Current
			a_basic_scope_info_set: basic_scope_table.item (a_scope) = a_basic_scope_info
		end

	set_basic_scope_info_for_all (a_basic_scope_info: QL_METRIC_BASIC_SCOPE_INFO) is
			-- Set `a_basic_scope_info' into `basic_scope_table' with all available keys.
			-- This means if we apply current metric to a domain, no matter what scope
			-- that domain has, the domain generator in `a_basic_scope_info' will be used
			-- to calculate the metric.
		require
			a_basic_scope_info_attached: a_basic_scope_info /= Void
			not_a_basic_scope_info_registered: not a_basic_scope_info.is_registered_to_metric
		local
			l_basic_scope_table: like basic_scope_table
		do
			a_basic_scope_info.set_metric (Current)
			from
				l_basic_scope_table := basic_scope_table
				l_basic_scope_table.start
			until
				l_basic_scope_table.after
			loop
				l_basic_scope_table.force (a_basic_scope_info, l_basic_scope_table.key_for_iteration)
				l_basic_scope_table.forth
			end
		ensure
			a_basic_scope_info_registered: a_basic_scope_info.is_registered_to_metric and then a_basic_scope_info.metric = Current
		end

feature -- Access

	value_initialize_function: FUNCTION [ANY, TUPLE, DOUBLE]
			-- Function to initialize `value' before metric calculation

	post_calculation_function: FUNCTION [ANY, TUPLE [a_source_domain: QL_DOMAIN; a_value: DOUBLE], DOUBLE]
			-- Function invoked after metric calculation.
			-- Parameters are the source domain and the calculated result value.
			-- The final effect metric value will be the return value of this function.

feature{NONE} -- Implementation

	basic_scope_table: HASH_TABLE [QL_METRIC_BASIC_SCOPE_INFO, QL_SCOPE] is
			-- Table of domain generators per scope
		local
			l_scope_list: like scopes
		do
			if internal_generator_table = Void then
				l_scope_list := scopes
				create internal_generator_table.make (l_scope_list.count)
				l_scope_list.do_all (agent internal_generator_table.put (Void, ?))
			end
		end

	internal_generator_table: like basic_scope_table
			-- Implementation of `basic_scope_table'

invariant
	generator_table_attached: basic_scope_table /= Void

indexing
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
