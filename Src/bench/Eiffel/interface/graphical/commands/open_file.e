
class OPEN_FILE 

inherit

	ICONED_COMMAND

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Open a file.
		do
			if argument = warner then
				-- The user has eventually been warned that he will lose his stuff
				name_chooser.call (Current) 
			elseif argument = name_chooser then
				text_window.show_file (name_chooser.selected_file)
			else
				-- First click on open
				if text_window.changed then
					warner.call (Current, l_File_changed)
				else
					name_chooser.call (Current) 
				end
			end
		end;
	
feature 

	symbol: PIXMAP is
		once
			Result := bm_Open
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open end

end
