indexing

	description: 
		"Displays descendants in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DESCENDANTS 

inherit

	EWB_COMPILED_CLASS
		rename
			name as descendants_cmd_name,
			help_message as descendants_help,
			abbreviation as descendants_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_DESCENDANTS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_DESCENDANTS
