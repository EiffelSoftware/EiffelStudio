indexing

	description: 
		"Displays the senders of a feature in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SENDERS 

inherit

	EWB_FEATURE
		rename
			name as callers_cmd_name,
			help_message as callers_help,
			abbreviation as callers_abb
		end;
	SHARED_SERVER

creation

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_CALLERS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		once
			!! Result.do_nothing
		end;

end -- class EWB_SENDERS
