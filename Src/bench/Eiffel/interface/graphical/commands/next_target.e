-- Retarget the tool with the next target in history

class NEXT_TARGET

inherit

	ICONED_COMMAND

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		do
		end;

feature

	symbol: PIXMAP is
		once
			Result := bm_Next_target
		end;

	command_name: STRING is
		do
			Result := l_Next_target
		end;

end -- class NEXT_TARGET
