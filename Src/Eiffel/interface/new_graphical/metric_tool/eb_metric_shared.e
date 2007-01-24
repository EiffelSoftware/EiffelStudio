indexing
	description: "Shared metric utilities. Can be used in both batch and gui mode"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SHARED

inherit
	SHARED_NAMES

	EB_SHARED_METRIC_MANAGER

feature -- Access

	metric_validity_checker: EB_METRIC_VALIDITY_VISITOR is
			-- Metric validity checker
		once
			create Result.make (metric_manager)
		ensure
			result_attached: Result /= Void
		end

	archive_validity_checker: EB_METRIC_ARCHIVE_VALIDITY_CHECKER is
			-- Metric archiv evalidity checker
		once
			create Result.make (metric_manager)
		ensure
			result_attached: Result /= Void
		end

	criterion_factory: EB_METRIC_CRITERION_FACTORY is
			-- Criterion factory
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Access/Metric type

	basic_metric_type: INTEGER is 1
			-- Basic metric type

	linear_metric_type: INTEGER is 2
			-- Linear metric type

	ratio_metric_type: INTEGER is 3
			-- Ratio metric type

	metric_type_id (a_metric: EB_METRIC): INTEGER is
			-- Metric type id of `a_metric'
		require
			a_metric_attached: a_metric /= Void
		do
			if a_metric.is_basic then
				Result := basic_metric_type
			elseif a_metric.is_linear then
				Result := linear_metric_type
			elseif a_metric.is_ratio then
				Result := ratio_metric_type
			end
		ensure
			good_result: is_metric_type_valid (Result)
		end

	metric_type_name (a_metric_type_id: INTEGER): STRING_GENERAL is
			-- Metric type name of `a_metrc_type_id'
		require
			a_metric_type_id_valid: is_metric_type_valid (a_metric_type_id)
		do
			inspect
				a_metric_type_id
			when basic_metric_type then
				Result := metric_names.l_basic_metric
			when linear_metric_type then
				Result := metric_names.l_linear_metric
			when ratio_metric_type then
				Result := metric_names.l_ratio_metric
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_metric_type_valid (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid metric type
			-- For information of metric type, see `basic_metric_type', `linear_metric_type' and `ratio_metric_type'
		do
			Result := a_type = basic_metric_type or a_type = linear_metric_type or a_type = ratio_metric_type
		end

	is_uuid_valid (a_uuid: STRING): BOOLEAN is
			-- Is `a_uuid' a valid UUID?
		require
			a_uuid_attached: a_uuid /= Void
		do
			Result := shared_uuid.is_valid_uuid (a_uuid)
		end

feature -- UUID

	shared_uuid: UUID is
			-- UUID
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Value test operator type index

	equal_to_type: INTEGER is 1
	not_equal_to_type: INTEGER is 2
	less_than_type: INTEGER is 3
	less_than_equal_to_type: INTEGER is 4
	greater_than_type: INTEGER is 5
	greater_than_equal_to_type: INTEGER is 6

	equal_to_operator: STRING is "="
	not_equal_to_operator: STRING is "/="
	less_than_operator: STRING is "<"
	less_than_equal_to_operator: STRING is "<="
	greater_than_operator: STRING is ">"
	greater_than_equal_to_operator: STRING is ">="

feature -- Access/Criterion type

	operator_table: HASH_TABLE [STRING, INTEGER] is
			-- Table for "=", "/=", ">", ">=", "<", "<=" operators
			-- Key is operator type index, value is name of that operator
		once
			create Result.make (6)
			Result.put (equal_to_operator, equal_to_type)
			Result.put (not_equal_to_operator, not_equal_to_type)
			Result.put (less_than_operator, less_than_type)
			Result.put (less_than_equal_to_operator, less_than_equal_to_type)
			Result.put (greater_than_operator, greater_than_type)
			Result.put (greater_than_equal_to_operator, greater_than_equal_to_type)
		ensure
			result_attached: Result /= Void
		end

	operator_name_table: HASH_TABLE [INTEGER, STRING] is
			-- Table for "=", "/=", ">", ">=", "<", "<=" operators
			-- Key is the operator name, value is operator type index of that operator
		once
			create Result.make (6)
			Result.put (equal_to_type, equal_to_operator)
			Result.put (not_equal_to_type, not_equal_to_operator)
			Result.put (less_than_type, less_than_operator)
			Result.put (less_than_equal_to_type, less_than_equal_to_operator)
			Result.put (greater_than_type, greater_than_operator)
			Result.put (greater_than_equal_to_type, greater_than_equal_to_operator)
		ensure
			result_attached: Result /= Void
		end

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
