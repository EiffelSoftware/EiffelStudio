indexing

	description: 
		"Displays once routines of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ONCE 

inherit

	EWB_COMPILED_CLASS
		rename
			name as once_cmd_name,
			help_message as once_help,
			abbreviation as once_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_ONCES is
	        -- Associated class command to be executed
	        -- after successfully retrieving the compiled
	        -- class
	    do
			create Result.do_nothing
	    end;

end -- class EWB_ONCE
