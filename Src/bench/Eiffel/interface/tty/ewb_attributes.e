indexing

	description: 
		"Displays attributes in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ATTRIBUTES 

inherit

	EWB_COMPILED_CLASS
		rename
			name as attributes_cmd_name,
			help_message as attributes_help,
			abbreviation as attributes_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_ATTRIBUTES is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_ATTRIBUTES
