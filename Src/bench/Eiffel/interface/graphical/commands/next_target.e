-- Retarget the tool with the next target in history

class NEXT_TARGET

inherit

	ICONED_COMMAND
		redefine
			execute
		end;

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end;

	execute (argument: ANY) is
		do
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
            elseif argument = warner then
					-- The changes will be lost.
				text_window.clear_clickable;
				text_window.set_changed (false);
				execute_licenced (Void)
			else
				warner.popdown;
				if not text_window.changed then
					execute_licenced (argument)
				else
					warner.set_window (text_window);
					warner.call (Current, l_File_changed)
				end
			end
		end;
		
feature {NONE}

	work (argument: ANY) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := text_window.history;
			if history.empty or else (history.islast or history.after) then
				warner.set_window (text_window);
				warner.gotcha_call ("End of history")
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
