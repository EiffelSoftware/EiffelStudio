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
				text_window.tool.destroy;
			else
				-- First click on open
				if text_window.changed then
					warner.call (Current, l_File_changed)
				else
					text_window.tool.destroy;
				end
			end
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Quit) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Exit end;

end
