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
		local
			history: STONE_HISTORY
		do
			history := text_window.history;
			if history.empty then
				warner.set_window (text_window);
				warner.gotcha_call ("Beginning of history")
			elseif history.islast or history.after then
				warner.set_window (text_window);
				warner.gotcha_call ("Beginning of history")
			else
				history.forth;
				text_window.last_format.execute (history.item)
			end
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
