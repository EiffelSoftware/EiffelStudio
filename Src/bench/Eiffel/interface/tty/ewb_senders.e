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
	TTY_CONSTANTS

creation

	make, do_nothing

feature -- Setting

	set_all_callers is
			-- Set `to_show_all_callers' to `True'
		do
			to_show_all_callers := True
		ensure
			to_show_all_callers: to_show_all_callers
		end

feature {NONE} -- Implementation

	to_show_all_callers: BOOLEAN
			-- Is the format going to show all callers?

	associated_cmd: E_SHOW_CALLERS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result.do_nothing
			if to_show_all_callers then
				Result.set_all_callers
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
			command_line_io.get_option_value ("All senders", show_all_callers)
			to_show_all_callers := command_line_io.last_input.to_boolean
			check_arguments_and_execute
		end

end -- class EWB_SENDERS
