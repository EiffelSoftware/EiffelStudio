-- Display the current execution status in the debug window.

class DEBUG_STATUS

inherit

	ICONED_COMMAND;
	SHARED_DEBUG

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
			Run_info.display_status
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
