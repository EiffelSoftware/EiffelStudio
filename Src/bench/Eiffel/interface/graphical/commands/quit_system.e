indexing

	description:	
		"Command to quit the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, loose_changes
		end

creation

	make
	
feature -- Callbacks

	loose_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			text_window.clear_window;
			tool.hide;
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		do
			if last_warner /= Void and argument = last_warner then
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).call (Current, Interface_names.w_File_changed)
				else
					text_window.clear_window;
					tool.hide;
					tool.close_windows;
				end
			end
		end;

end -- class QUIT_SYSTEM
