indexing

	description: 
		"Displays class's routines in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ROUTINES 

inherit

	EWB_COMPILED_CLASS
		rename
			name as routines_cmd_name,
			help_message as routines_help,
			abbreviation as routines_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

    associated_cmd: E_SHOW_ROUTINES is
            -- Associated class command to be executed
            -- after successfully retrieving the compiled
            -- class
        do
			create Result.do_nothing
        end;

end -- class EWB_ROUTINES
