-- Retarget the tool with the previous target in history

class PREVIOUS_TARGET

inherit

	ICONED_COMMAND
		redefine
			execute
		end

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
			-- Retarget the tool with the previous target in history.
		local
			history: STONE_HISTORY
		do
			history := text_window.history;
			if history.empty or else (history.isfirst or history.before) then
				warner.set_window (text_window);
				warner.gotcha_call (w_Beginning_of_history)
			else
				history.back;
				text_window.last_format.execute (history.item)
			end
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
