note
	description: "Object to store archive information for one metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_NODE

inherit
	EB_METRIC_VISITABLE

	EB_METRIC_SHARED

	HASHABLE

create
	make

feature{NONE} -- Initialization

	make (a_metric_name: STRING; a_metric_type: INTEGER; a_time: DATE_TIME; a_value: DOUBLE; a_input: like input_domain; a_uuid: STRING; a_filtered: BOOLEAN)
			-- Initialize `metric_name' with `a_metric_name', `metric_type' with `a_metric_type', `calculated_time' with `a_time',
			-- `value' with `a_value', `input_domain' with `a_input' and `uuid' with `a_uuid'.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_metric_type_valid: is_metric_type_valid (a_metric_type)
			a_time_attached: a_time /= Void
			a_input_attached: a_input /= Void
			a_uuid_attached: a_uuid /= Void
			a_uuid_valid: shared_uuid.is_valid_uuid (a_uuid)
		do
			set_metric_name (a_metric_name)
			set_metric_type (a_metric_type)
			set_calculated_time (a_time)
			set_value (a_value)
			set_input_domain (a_input)
			set_uuid (create {UUID}.make_from_string (a_uuid))
			set_is_up_to_date (True)
			set_is_value_valid (True)
			set_is_result_filtered (a_filtered)
			set_value_tester (create {EB_METRIC_VALUE_TESTER}.make)
			set_is_last_warning_check_successful (True)
		end

feature -- Access

	metric_name: STRING
			-- Name of the archived metric

	metric_type: INTEGER
			-- Metric type

	calculated_time: DATE_TIME
			-- Time when current archive is calculated

	input_domain: EB_METRIC_DOMAIN
			-- Domain over which the metric is calcuated
			-- This is only used for display.

	value: DOUBLE
			-- Metric archive value

	uuid: UUID
			-- UUID of current metric

	previous_value: DOUBLE
			-- Previous calculated value, used in archive comparison.
			-- If a metric archive is just loaded, there is no prevous value.
			-- When a metric archive is calculated again, then we get a current value,
			-- so we can compare between current value and `previous_value'.
		require
			previous_value_exists: has_previous_value
		do
			Result := previous_value_internal
		end

	metric: EB_METRIC
			-- Metric associated with Current archive, i.e., metric over which current archive is calculated.
		require
			metric_exists: is_metric_valid
		do
			Result := metric_manager.metric_with_name (metric_name)
		ensure
			result_attached: Result /= Void
		end

	hash_code: INTEGER
			-- Hash code value
		do
			Result :=uuid.hash_code
		end

	detailed_result: QL_DOMAIN
			-- Last detailed result

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.visitable_name (metric_names.l_metric_archive_node, metric_name)
		end

	value_tester: EB_METRIC_VALUE_TESTER
			-- Value tester used to support archive value warning

feature -- Status report

	has_previous_value: BOOLEAN
			-- Does `previous_value' exist?
			-- See `previous_value' for more information.

	has_detailed_result: BOOLEAN
			-- Does current archive contain detailed result?
		do
			Result := detailed_result /= Void
		end

	is_metric_valid: BOOLEAN
			-- Is metric associated with `archive_node' valid?
		do
			Result := metric_manager.is_metric_calculatable (metric_name) and then
					  metric_type_id (metric_manager.metric_with_name (metric_name)) = metric_type
		end

	is_mergable (other: like Current): BOOLEAN
			-- Can `other' be merged into Current?
			-- If `other' is calculated over the same metric as Current's and with the same input domain, it's mergable.
			-- A merge means update `value' and `calculated_time' with value and time from `other', and put original `value'
			-- into `previous_value'.
		require
			other_attached: other /= Void and then other.is_metric_valid
		do
			Result :=
				metric_manager.is_metric_name_equal (metric_name, other.metric_name) and then
				metric_type = other.metric_type
				and then input_domain.is_equivalent (other.input_domain)
		ensure
			symmetric: Result implies other.is_mergable (Current)
		end

	is_input_domain_valid: BOOLEAN
			-- Is `input_domain' valid for current application?
		do
			Result := input_domain.is_valid
		end

	is_recalculatable: BOOLEAN
			-- Can current archive be recalculated?
		do
			Result := is_metric_valid and then is_input_domain_valid
		end

	is_up_to_date: BOOLEAN
			-- Is current archive up-to-date?
			-- An archive can be not up-to-date because of Eiffel compilation (which may cause system changes)
			-- Default: True

	is_value_valid: BOOLEAN
			-- Is `value' valid?
			-- Default: True

	is_result_filtered: BOOLEAN
			-- Should result be filtered if they are not visible?

	is_last_warning_check_successful: BOOLEAN
			-- Is last warning check successful?
			-- Default: True

feature -- Setting

	set_metric_name (a_name: STRING)
			-- Set `metric_name' with `a_name'.
		do
			create metric_name.make_from_string (a_name)
		ensure
			metric_name_set: metric_name /= Void and then metric_name.is_equal (a_name)
		end

	set_metric_type (a_type: INTEGER)
			-- Set `metric_type' with `a_type'.
		require
			type_valid: is_metric_type_valid (a_type)
		do
			metric_type := a_type
		ensure
			metric_type_set: metric_type = a_type
		end

	set_calculated_time (a_time: like calculated_time)
			-- Set `calculated_time' with `a_time'.
		require
			a_time_attached: a_time /= Void
		do
			calculated_time := a_time
		ensure
			calculated_time_set: calculated_time = a_time
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

	set_value (a_value: DOUBLE)
			--  Set `value 'with `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

	set_uuid (a_uuid: like uuid)
			-- Set `uuid' with `a_uuid'.
		require
			a_uuid_attached: a_uuid /= Void
		do
			uuid := a_uuid
		ensure
			uuid_set: uuid = a_uuid
		end

	set_has_previous_value (b: BOOLEAN)
			-- Set `has_previous_value' with `b'.
		do
			has_previous_value := b
		ensure
			result_attached: has_previous_value = b
		end

	set_previous_value (a_value: like previous_value)
			-- Set `previous_value' with `a_value'.
		do
			previous_value_internal := a_value
		ensure
			previous_value_set: previous_value = a_value
		end

	set_is_up_to_date (b: BOOLEAN)
			-- Set `is_up_to_date' with `b'.
		do
			is_up_to_date := b
		ensure
			is_up_to_date_set: is_up_to_date = b
		end

	set_detailed_result (a_result: like detailed_result)
			-- Set `detailed_result' with `a_result'.
		do
			detailed_result := a_result
		ensure
			detailed_result_set: detailed_result = a_result
		end

	set_is_value_valid (b: BOOLEAN)
			-- Set `is_value_valid' with `b'.
		do
			is_value_valid := b
		ensure
			is_value_valid_set: is_value_valid = b
		end

	set_is_result_filtered (b: BOOLEAN)
			-- Set `is_result_filtered' with `b'.
		do
			is_result_filtered := b
		ensure
			is_result_filtered_set: is_result_filtered = b
		end

	set_value_tester (a_value_tester: like value_tester)
			-- Set `value_tester' with `a_value_tester'.
		do
			value_tester := a_value_tester
		ensure
			value_tester_set: value_tester = a_value_tester
		end

	set_is_last_warning_check_successful (b: BOOLEAN)
			-- Set `is_last_warning_check_successful' with `b'.
		do
			is_last_warning_check_successful := b
		ensure
			is_last_warning_check_successful_set: is_last_warning_check_successful = b
		end

	merge (a_archive: like Current)
			-- Update Current with information from `a_archive'.
		require
			current_valid: is_metric_valid
			a_archive_attached: a_archive /= Void
			metric_from_a_archive_is_valid: a_archive.is_metric_valid
			a_archive_mergable: is_mergable (a_archive)
		do
			set_has_previous_value (True)
			set_previous_value (value)
			set_value (a_archive.value)
			set_calculated_time (a_archive.calculated_time)
			set_detailed_result (a_archive.detailed_result)
		ensure
			value_set: value = a_archive.value
			calculated_Time_set: calculated_time.is_equal (a_archive.calculated_time)
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_metric_archive_node (Current)
		end

feature{NONE} -- Implementation

	previous_value_internal: like previous_value
			-- Implementation of `previous_value'.		

invariant
	metric_name_attached: metric_name /= Void
	metric_type_valid: is_metric_type_valid (metric_type)
	calculated_time_attached: calculated_time /= Void
	input_domain_attached: input_domain /= Void
	uuid_attached: uuid /= Void
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
