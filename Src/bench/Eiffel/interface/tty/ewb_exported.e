indexing

	description: 
		"Displays exported features in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EXPORTED 

inherit

	EWB_COMPILED_CLASS
		rename
			name as exported_cmd_name,
			help_message as exported_help,
			abbreviation as exported_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_EXPORTED_ROUTINES is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_EXPORTED
