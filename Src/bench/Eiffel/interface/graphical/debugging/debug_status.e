indexing

	description:	
		"Display the current execution status in the debug window.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_STATUS

inherit

	ICONED_COMMAND;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do 
			init (c, a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Debug_status
		end;

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Debug_status
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		do
			if Application.is_running then
				Application.status.display_status (Debug_window)
			else
				Debug_window.put_string ("System not launched%N")
			end
		end;

end -- class DEBUG_STATUS
