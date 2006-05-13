indexing
	description: "Factory to produce metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_METRIC_FACTORY

inherit
	QL_SHARED

	QL_SHARED_UNIT

	QL_SHARED_SCOPES

	SHARED_SERVER

	REFACTORING_HELPER

	SHARED_WORKBENCH

feature -- Metrics

	metric (a_unit: QL_METRIC_UNIT): QL_METRIC is
			-- A metric whose unit is `a_unit'
		require
			a_unit_attached: a_unit /= Void
		do
			Result := metric_creator_table.item (a_unit).item ([])
		ensure
			a_unit_attached: a_unit /= Void
		end

feature{NONE} -- Metric calculation functionalities

	target_metric: QL_METRIC is
			-- New metric to calculate target, e.g., its unit is target
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_TARGET_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_target)
		ensure
			result_attached: Result /= Void
		end

	group_metric: QL_METRIC is
			-- New metric to calculate group, e.g., its unit is group
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_GROUP_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_group)
		ensure
			result_attached: Result /= Void
		end

	class_metric: QL_METRIC is
			-- New metric to calculate class, e.g., its unit is class
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_CLASS_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_class)
		ensure
			result_attached: Result /= Void
		end

	feature_metric: QL_METRIC is
			-- New metric to calculate feature, e.g., its unit is feature
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_FEATURE_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_feature)
		ensure
			result_attached: Result /= Void
		end

	generic_metric: QL_METRIC is
			-- New metric to calculate class formal generic parameters
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_GENERIC_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_generic)
		ensure
			result_attached: Result /= Void
		end

	local_metric: QL_METRIC is
			-- New metric to calculate feature local variables, e.g., its unit is local
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_LOCAL_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_local)
		ensure
			result_attached: Result /= Void
		end

	argument_metric: QL_METRIC is
			-- New metric to calculate feature formal arguments, e.g., its unit is argument
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_ARGUMENT_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_argument)
		ensure
			result_attached: Result /= Void
		end

	assertion_metric: QL_METRIC is
			-- New metric to calculate feature assertions, e.g., its unit is argument
		do
			create {QL_METRIC_BASIC}Result.make (target_unit, create{QL_METRIC_ASSERTION_BASIC_SCOPE_INFO}.make (Void))
			Result.set_name (query_language_names.ql_metric_assertion)
		ensure
			result_attached: Result /= Void
		end

	line_metric: QL_METRIC is
			-- New metric to calculate line, e.g., its unit is line
			-- This metric is faster than `advanced_line_metric'.
		do
			create {QL_METRIC_LINE}Result.make
			Result.set_name (query_language_names.ql_metric_line)
		ensure
			result_attached: Result /= Void
		end

	compilation_metric: QL_METRIC is
			-- New metric to calculate feature local variables, e.g., its unit is local
		local
			l_metric: QL_METRIC_COMPILATION
		do
			create l_metric.make
			Result := l_metric
		ensure
			result_attached: Result /= Void
		end

	count_metric: QL_METRIC is
			-- New metric which returns number of items in a given domain.
			-- This metric is faster, so, if we are just doing simple counting, use this metric.
		do
			create {QL_METRIC_COUNT}Result
			Result.set_name (query_language_names.ql_metric_count)
		ensure
			result_attached: Result /= Void
		end

	sum_metric: QL_METRIC is
			-- New metric which returns sum of a quantity domain
		local
			l_metric: QL_METRIC_BASIC
		do
			create {QL_METRIC_BASIC}Result.make (no_unit, create{QL_METRIC_QUANTITY_BASIC_SCOPE_INFO}.make (agent value_from_quantity))
			l_metric.set_name (query_language_names.ql_metric_sum)
			Result := l_metric
		ensure
			result_attached: Result /= Void
		end

	average_metric: QL_METRIC is
			-- New metric which returns average of a quantity domain
		local
			l_metric: QL_METRIC_BASIC
		do
			create {QL_METRIC_BASIC}Result.make (no_unit, create{QL_METRIC_QUANTITY_BASIC_SCOPE_INFO}.make (agent value_from_quantity))
			l_metric.set_post_calculation_function (agent average_value)
			l_metric.set_name (query_language_names.ql_metric_average)
			Result := l_metric
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Calculation

	average_value (a_domain: QL_DOMAIN; a_sum: DOUBLE): DOUBLE is
			-- Average value: `a_sum' / `a_domain'.count.
		require
			a_domain_attached: a_domain /= Void
		do
			fixme ("Write code here to deal with n / 0")
			Result := a_sum / a_domain.count
		end

	value_from_quantity (a_quantity: QL_QUANTITY): DOUBLE is
			-- Value from `a_quantity'
		require
			a_quantity_attached: a_quantity /= Void
			a_quantity_valid: a_quantity.is_valid_domain_item
		do
			Result := a_quantity.value
		ensure
			good_result: Result = a_quantity.value
		end

feature{NONE} -- Implementation

	metric_creator_table: HASH_TABLE [FUNCTION [ANY, TUPLE, QL_METRIC], QL_METRIC_UNIT] is
			-- Table for metric creators
			-- Key is metric unit, value is the creator for that unit
		do
			if metric_creator_table_internal = Void then
				create metric_creator_table_internal.make (10)
				metric_creator_table_internal.put (agent target_metric,      target_unit)
				metric_creator_table_internal.put (agent group_metric,       group_unit)
				metric_creator_table_internal.put (agent class_metric,       class_unit)
				metric_creator_table_internal.put (agent feature_metric,     feature_unit)
				metric_creator_table_internal.put (agent generic_metric,     generic_unit)
				metric_creator_table_internal.put (agent local_metric,       local_unit)
				metric_creator_table_internal.put (agent argument_metric,    argument_unit)
				metric_creator_table_internal.put (agent assertion_metric,   assertion_unit)
				metric_creator_table_internal.put (agent line_metric,        line_unit)
				metric_creator_table_internal.put (agent compilation_metric, compilation_unit)
				metric_creator_table_internal.put (agent count_metric, no_unit)
			end
			Result := metric_creator_table_internal
		ensure
			result_attached: Result /= Void
			good_result: Result = metric_creator_table_internal
		end

	metric_creator_table_internal: like metric_creator_table;
			-- Implementation of `metric_creator_table'

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
