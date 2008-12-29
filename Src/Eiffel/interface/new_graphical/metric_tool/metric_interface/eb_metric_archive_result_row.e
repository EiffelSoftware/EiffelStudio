note
	description: "Object that represents a row to dispaly archive comparison result"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_RESULT_ROW

create
	make

feature{NONE} -- Initialization

	make (a_metric_name: like metric_name; a_type: like type; a_reference_value: DOUBLE; a_is_ref_set: BOOLEAN; a_current_value: DOUBLE; a_is_cur_set: BOOLEAN; a_time: DATE_TIME)
			-- Initialize.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_type_attached: a_type /= Void
			a_time_attached: a_time /= Void
		do
			create metric_name.make_from_string (a_metric_name)
			create {STRING_32}type.make_from_string (a_type)
			is_reference_value_set := a_is_ref_set
			is_current_value_set := a_is_cur_set
			reference_value := a_reference_value
			current_value := a_current_value
			difference := current_value - reference_value
			if is_ratio_set then
				ratio := current_value / reference_value
			end
			time := a_time
		end

feature -- Access

	metric_name: STRING
			-- Metric name

	type: STRING_GENERAL
			-- Metric type

	reference_value: DOUBLE
			-- Reference value

	current_value: DOUBLE
			-- current value

	difference: DOUBLE
			-- Difference between `current_value' and `reference_value'

	ratio: DOUBLE
			-- Ratio of `current_value' and `reference_value'

	time: DATE_TIME
			-- Time when current metric archive is calculated

feature -- Status report

	is_reference_value_set: BOOLEAN
			-- Is `reference_value' set?

	is_current_value_set: BOOLEAN
			-- Is `current_value' set?

	is_difference_set: BOOLEAN
			-- Is `difference` set?
		do
			Result := is_reference_value_set and is_current_value_set
		end

	is_ratio_set: BOOLEAN
			-- Is `ratio` set?
		do
			Result := (is_reference_value_set and is_current_value_set and then reference_value /= 0)
		end

invariant
	metric_name_attached: metric_name /= Void
	type_attached: type /= Void
	time_attached: time /= Void

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
