indexing

	description:	
		"Command to quit the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, make, text_window, loose_changes
		end

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: like text_window) is
			-- Initialize the command.
		do
			init (c, a_text_window)
		end;

feature -- Callbacks

	loose_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			text_window.clean;
			text_window.tool.hide;
			text_window.set_in_use (false)
		end;

feature -- Properties

	text_window: SYSTEM_TEXT;
			-- Window with the text of the Ace file.

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
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

end -- class QUIT_SYSTEM
