indexing

	description: 
		"Displays the system statistics in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_STATISTICS

inherit

	EWB_SYSTEM
		rename
			name as statistics_cmd_name, 
			help_message as statistics_help, 
			abbreviation as statistics_abb
		end;

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_STATISTICS is
			-- Associated system command to be executed
		once
			!! Result.do_nothing
		end;

end -- class EWB_STATISTICS
