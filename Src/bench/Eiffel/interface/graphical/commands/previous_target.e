-- Retarget the tool with the previous target in history

class PREVIOUS_TARGET

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
			-- Retarget the tool with the previous target in history.
		do
		end;

feature

	symbol: PIXMAP is
		once
			Result := bm_Previous_target
		end;

	command_name: STRING is
		do
			Result := l_Previous_target
		end;

end -- class PREVIOUS_TARGET
