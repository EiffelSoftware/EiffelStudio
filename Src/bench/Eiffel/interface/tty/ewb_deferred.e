indexing

	description: 
		"Displays deferred routines in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DEFERRED 

inherit

	EWB_COMPILED_CLASS
		rename
			name as deferred_cmd_name,
			help_message as deferred_help,
			abbreviation as deferred_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_DEFERRED_ROUTINES is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_DEFERRED
