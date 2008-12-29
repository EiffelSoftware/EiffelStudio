note
	description:
		"Displays the callees of a feature in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_CALLEES

inherit
	EWB_SENDERS
		rename
			set_all_callers as set_all_callees,
			set_assigners_only as set_assignees_only,
			set_creators_only as set_creations_only
		redefine
			name,
			help_message,
			abbreviation,
			associated_cmd,
			loop_action
		end

create
	make, default_create

feature -- Access

	name: STRING
			-- Name of current command
		do
			Result := callees_cmd_name
		end

	help_message: STRING_32
			-- Help message for current command
		do
			Result := callees_help
		end

	abbreviation: CHARACTER
			-- Abbreviation for current command
		do
			Result := callees_abb
		end

feature{NONE} -- Implementation

	associated_cmd: E_SHOW_CALLERS
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result
			Result.show_callees
			Result.set_all_callers (to_show_all_callers)
			if is_assigners_only then
				Result.set_flag ({DEPEND_UNIT}.is_in_assignment_flag)
			elseif is_creators_only then
				Result.set_flag ({DEPEND_UNIT}.is_in_creation_flag)
			end
		end

	loop_action
		do
			command_line_io.get_class_name
			class_name := command_line_io.last_input
			command_line_io.get_feature_name
			feature_name := command_line_io.last_input
			command_line_io.get_filter_name
			filter_name := command_line_io.last_input
			command_line_io.get_option_value (ewb_names.all_calees, preferences.feature_tool_data.show_all_callers)
			to_show_all_callers := command_line_io.last_input.to_boolean
			command_line_io.get_option_value (ewb_names.only_assignees, False)
			if command_line_io.last_input.to_boolean then
				set_assignees_only
			else
				command_line_io.get_option_value (ewb_names.only_creators, False)
				if command_line_io.last_input.to_boolean then
					set_creations_only
				else
					clear_target_only
				end
			end
			check_arguments_and_execute
		end

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
