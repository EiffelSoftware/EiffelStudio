indexing

	description:	
		"Display the current execution status in the debug window.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_STATUS

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Debug_status
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := l_Debug_status
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			st: STRUCTURED_TEXT;
		do
			!! st.make;
			if Application.is_running then
				Application.status.display_status (st);
				Debug_window.clear_window;
				Debug_window.process_text (st);
				Debug_window.display
			else
				st.add_string ("System not launched");
				st.add_new_line;
				Debug_window.clear_window;
				Debug_window.process_text (st);
				Debug_window.display
			end
		end;

end -- class DEBUG_STATUS
