-- Display the current execution status in the debug window.

class DEBUG_STATUS

inherit

	ICONED_COMMAND;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
		do
			if Application.is_running then
				Application.status.display_status (Debug_window)
			else
				Debug_window.put_string ("System not launched%N")
			end
		end;

feature

	symbol: PIXMAP is
		once
			Result := bm_Debug_status
		end;

	command_name: STRING is
		do
			Result := l_Debug_status
		end;

end -- class DEBUG_STATUS
