
class SAVE_AS_SYSTEM 

inherit

	SHARED_WORKBENCH;
	SAVE_AS_FILE
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
			-- Save a file with the chosen name.
			-- Update the ace file name.
		local
			new_file: UNIX_FILE;
			to_write: STRING
		do
			if argument = name_chooser then
				!!new_file.make (name_chooser.selected_file);
				new_file.open_write;
				to_write := text_window.text;
				if not to_write.empty then
					new_file.putstring (to_write);
					if to_write.item (to_write.count) /= '%N' then
						-- Add a carriage return like vi if there's none at the end
						new_file.putchar ('%N')
					end;
				end;
				new_file.close;
                		if Lace.file_name = Void then
					-- Not a format shown
--					Lace.set_file_name (name_chooser.selected_file);
					text_window.set_file_name (name_chooser.selected_file);
					text_window.set_changed (false)
				end
			else
				name_chooser.call (Current)
			end
		end

end
