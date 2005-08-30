indexing

	description: 
		"Display the implementers of a feature in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_HISTORY 

inherit

	EWB_FEATURE
		rename
			name as implementers_cmd_name,
			help_message as implementers_help,
			abbreviation as implementers_abb
		end

create
	make, default_create

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_ROUTINE_IMPLEMENTERS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result
		end;

end -- class EWB_HISTORY
