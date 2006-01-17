indexing

	description: 
		"Displays the senders of a feature in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EWB_SENDERS 

inherit
	EWB_FEATURE
		rename
			name as callers_cmd_name,
			help_message as callers_help,
			abbreviation as callers_abb
		redefine
			loop_action
		end
	
	EB_SHARED_PREFERENCES

create
	make, default_create

feature -- Setting

	set_all_callers is
			-- Set `to_show_all_callers' to `True'
		do
			to_show_all_callers := True
		ensure
			to_show_all_callers: to_show_all_callers
		end

	clear_target_only is
			-- Do not restrict callers only to assigners or creators.
		do
			is_assigners_only := False
			is_creators_only := False
		ensure
			not_is_assigners_only: not is_assigners_only
			not_is_creators_only: not is_creators_only
		end

	set_assigners_only is
			-- Restrict callers only to assigners.
		do
			is_assigners_only := True
			is_creators_only := False
		ensure
			is_assigners_only: is_assigners_only
			not_is_creators_only: not is_creators_only
		end

	set_creators_only is
			-- Restrict callers only to creators.
		do
			is_assigners_only := False
			is_creators_only := True
		ensure
			not_is_assigners_only: not is_assigners_only
			is_creators_only: is_creators_only
		end

feature {NONE} -- Implementation

	to_show_all_callers: BOOLEAN
			-- Is the format going to show all callers?

	is_assigners_only: BOOLEAN
			-- Have assigners to be shown only?

	is_creators_only: BOOLEAN
			-- Have creators to be shown only?

	associated_cmd: E_SHOW_CALLERS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result
			if to_show_all_callers then
				Result.set_all_callers
			end
			if is_assigners_only then
				Result.set_flag ({DEPEND_UNIT}.is_in_assignment_flag)
			elseif is_creators_only then
				Result.set_flag ({DEPEND_UNIT}.is_in_creation_flag)
			end
		end

	loop_action is
		do
			command_line_io.get_class_name
			class_name := command_line_io.last_input
			command_line_io.get_feature_name
			feature_name := command_line_io.last_input
			command_line_io.get_filter_name
			filter_name := command_line_io.last_input
			command_line_io.get_option_value ("All senders", preferences.feature_tool_data.show_all_callers)
			to_show_all_callers := command_line_io.last_input.to_boolean
			command_line_io.get_option_value ("Only assigners", False)
			if command_line_io.last_input.to_boolean then
				set_assigners_only
			else
				command_line_io.get_option_value ("Only creators", False)
				if command_line_io.last_input.to_boolean then
					set_creators_only
				else
					clear_target_only
				end
			end
			check_arguments_and_execute
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EWB_SENDERS
