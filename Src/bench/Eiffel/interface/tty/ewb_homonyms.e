indexing

	description: 
		"Display homonyms of `feature_i' in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_HOMONYMS 

inherit

	EWB_FEATURE
		rename
			name as homonyms_cmd_name,
			help_message as homonyms_help,
			abbreviation as homonyms_abb
		end

create

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_ROUTINE_HOMONYMNS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result.do_nothing
		end;

end -- class EWB_HOMONYMS
