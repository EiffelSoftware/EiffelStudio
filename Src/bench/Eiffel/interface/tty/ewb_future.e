indexing

	description: 
		"Displays descendants version of a feature in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FUTURE 

inherit

	EWB_FEATURE
		rename
			name as descendants_cmd_name,
			help_message as dversions_help,
			abbreviation as descendants_abb
		end

create

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_SHOW_ROUTINE_DESCENDANTS is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		do
			create Result.do_nothing
		end;

end -- class EWB_FUTURE
