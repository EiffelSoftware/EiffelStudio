indexing

	description:	
		"Command to quit editing a file.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_FILE 

inherit

	ICONED_COMMAND

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do
			init (c, a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Quit 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit cautiously a file.
		do
			if last_warner /= Void and argument = last_warner then
				-- The user has been warned that he will lose his stuff
				window_manager.close (text_window.tool);
			else
				-- First click on open
				if text_window.changed then
					warner (text_window).call (Current, l_File_changed)
				else
					window_manager.close (text_window.tool);
				end
			end
		end;

feature {NONE} -- Attributes

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Exit
		end;

end -- class QUIT_FILE
