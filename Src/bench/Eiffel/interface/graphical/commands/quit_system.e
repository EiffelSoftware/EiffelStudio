class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, make, text_window
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: like text_window) is
		do
			init (c, a_text_window)
		end;

	text_window: SYSTEM_TEXT;

feature {NONE}

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
				-- The user has been warned that he will lose his stuff
				text_window.clean;
				text_window.tool.hide;
				text_window.set_in_use (false)
			else
				-- First click on open
				if text_window.changed then
					warner (text_window).call (Current, l_File_changed)
				else
					text_window.clean;
					text_window.tool.hide;
					text_window.tool.close_windows;
					text_window.set_in_use (false)
				end
			end
		end;

end
