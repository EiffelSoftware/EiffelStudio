indexing

	description: 
		"Displays externals in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_EXTERNALS 

inherit

	EWB_COMPILED_CLASS
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_EXTERNALS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_EXTERNALS
