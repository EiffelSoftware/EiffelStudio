indexing

	description: 
		"Displays ancestors version of a feature in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_PAST 

inherit

	EWB_FEATURE
		rename
			name as ancestors_cmd_name,
			help_message as aversions_help,
			abbreviation as ancestors_abb
		end

create

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_ROUTINE_ANCESTORS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result.do_nothing
		end;

end -- class EWB_PAST
