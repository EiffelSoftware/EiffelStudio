
class SAVE_FILE 

inherit

	ICONED_COMMAND
		redefine
			dark_symbol
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
		local   
			new_file: UNIX_FILE;
			to_write: STRING
		do
			if text_window.file_name /= Void then
				!!new_file.make (text_window.file_name);
				new_file.open_write;
				to_write := text_window.text; 
				new_file.putstring (to_write);
				if to_write.item (to_write.count) /= '%N' then 
					-- Add a carriage return like vi if there's none at the end 
					new_file.putchar ('%N')
				end; 
				new_file.close;
				text_window.set_changed (false)
			end
		end;

	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Save) 
		end;
 
	
feature {NONE}

	dark_symbol: PIXMAP is
		once
			!!Result.make;
			Result.read_from_file (bm_Dark_save)
		end;

	command_name: STRING is do Result := l_Save end

end
