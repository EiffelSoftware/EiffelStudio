indexing

	description: 
		"Displays suppliers of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SUPPLIERS

inherit

	EWB_COMPILED_CLASS
		rename
			name as suppliers_cmd_name,
			help_message as suppliers_help,
			abbreviation as suppliers_abb
		end;

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_SUPPLIERS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_SUPPLIERS
