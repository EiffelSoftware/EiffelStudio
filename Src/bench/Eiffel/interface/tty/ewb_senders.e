indexing

	description: 
		"Displays the senders of a feature in output_window."
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

	make, do_nothing

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
			create Result.do_nothing
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

end -- class EWB_SENDERS
