indexing

	description: 
		"Displays routine flat in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_R_FLAT 

inherit

	EWB_FEATURE
		rename
			name as flat_cmd_name,
			help_message as r_flat_help,
			abbreviation as flat_abb
		end

create

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_ROUTINE_FLAT is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result.do_nothing
		end;

end -- class EWB_R_FLAT
