
-- Command to open a new ace file

class OPEN_SYSTEM 

inherit

	SHARED_WORKBENCH;
	OPEN_FILE
		redefine
			make, work
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: SYSTEM_TEXT) is
		do
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Open a file.
		do
			if argument = warner then
				-- The user has been warned that he will lose his stuff
				name_chooser.call (Current) 
			elseif argument = name_chooser then
				text_window.show_file (name_chooser.selected_file);
				Lace.set_file_name (name_chooser.selected_file)
			else
				-- First click on open
				if text_window.changed then
					warner.call (Current, l_File_changed)
				else
					name_chooser.call (Current) 
				end
			end
		end;

end
