-- This kind of format is long to process.
-- Ask for a confirmation before executing it.

deferred class LONG_FORMATTER

inherit

	FORMATTER
		redefine
			execute
		end

feature

	execute (argument: ANY) is
			-- Ask for a confirmation before executing the format.
		local
			old_do_format: BOOLEAN
		do
			if
				(argument /= get_in and argument /= get_out) and
				last_warner /= Void
			then
				last_warner.popdown
			end;
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			elseif last_confirmer /= Void and argument = last_confirmer then
					-- The user wants to execute this format,
					-- even though it's a long format.
				if not text_window.changed then
					set_global_cursor (watch_cursor);
					execute_licenced (formatted);
					restore_cursors
				else
					warner (text_window).call (Current, l_File_changed)
				end
			elseif last_warner /= Void and argument = last_warner then
					--| If it comes here this means ok has
					--| been pressed in the warner window
					--| for file modification (only showtext
					--| command can modify text)
				set_global_cursor (watch_cursor);
				text_window.set_changed (false);
					-- Because the text in the window has been changed,
					-- we have to force the new format in order to update
					-- the window as it was before the modifications.
				old_do_format := do_format;
				do_format := true;
				execute_licenced (formatted);
				do_format := old_do_format;
				text_window.history.extend (text_window.root_stone);
				restore_cursors
			else
				if argument = text_window then
					formatted ?= text_window.root_stone
				else
					formatted ?= argument
				end;
				confirmer (text_window).call (Current, 
						"This format requires exploring the entire%N%
						%system and may take a long time...",
						"Continue")
			end
		end;

end
