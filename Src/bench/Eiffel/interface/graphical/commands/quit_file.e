indexing

	description:	
		"Command to quit editing a file.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_FILE 

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as loose_changes
		end

creation

	make
	
feature -- Callbacks

	execute_warner_help is
		do
		end;

	loose_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff
		do
			window_manager.close (tool);
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
			else
				-- First click on open
				if text_window.changed then
					warner (popup_parent).call (Current, w_File_changed)
				else
					window_manager.close (tool)
				end
			end
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := l_Exit;
		end;

end -- class QUIT_FILE
