indexing

	description: 
		"Displays ancestors in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ANCESTORS 

inherit

	EWB_COMPILED_CLASS
		rename
			name as ancestors_cmd_name,
			help_message as ancestors_help,
			abbreviation as ancestors_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_ANCESTORS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_ANCESTORS
