class QUIT_FILE 

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
			-- Quit cautiously a file.
		do
			if argument = warner then
				-- The user has been warned that he will lose his stuff
				window_manager.close (text_window.tool);
			else
				-- First click on open
				if text_window.changed then
					warner.set_window (text_window);
					warner.call (Current, l_File_changed)
				else
					window_manager.close (text_window.tool);
				end
			end
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Quit 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Exit end;

end
