class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, make
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if argument = warner then
				-- The user has been warned that he will lose his stuff
				text_window.clean;
				text_window.tool.hide;
			else
				-- First click on open
				if text_window.changed then
					warner.call (Current, l_File_changed)
				else
					text_window.clean;
					text_window.tool.hide;
					text_window.tool.close_windows;
				end
			end
		end;

end
