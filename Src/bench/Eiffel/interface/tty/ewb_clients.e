indexing

	description: 
		"Displays clients in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_CLIENTS

inherit

	EWB_COMPILED_CLASS
		rename
			name as clients_cmd_name,
			help_message as clients_help,
			abbreviation as clients_abb
		end

create

	make, do_nothing

feature {NONE} -- Properties

	associated_cmd: E_SHOW_CLIENTS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result.do_nothing
		end;

end -- class EWB_CLIENTS
