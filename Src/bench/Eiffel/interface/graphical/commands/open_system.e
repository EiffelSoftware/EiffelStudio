
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
		local
			fn: STRING;
			f: UNIX_FILE;
			temp: STRING
		do
			if argument = warner then
				-- The user has been warned that he will lose his stuff
				name_chooser.call (Current) 
			elseif argument = name_chooser then
				fn := name_chooser.selected_file.duplicate;
				!! f.make (fn);
				if
					f.exists and then f.is_readable and then f.is_plain
				then
					text_window.show_file (fn);
					text_window.display_header (fn);
					Lace.set_file_name (fn)
				else
					!!temp.make (0);
					temp.append ("File: ");
					temp.append (fn);
					temp.append ("%Ncannot be read. Try again?");
					warner.custom_call (Current, temp, " Ok ", Void, "Cancel");
				end
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
