
class SAVE_SYSTEM

inherit
	
	SHARED_WORKBENCH;	
	PROJECT_CONTEXT;
	SAVE_FILE
		redefine
			work
		end;

creation

	make
	
feature {NONE}

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file: UNIX_FILE;
			to_write: STRING;
			file_name: STRING;
		do
			if text_window.file_name /= Void then
				file_name := text_window.file_name;
			else
				!!file_name.make (50);
				file_name.append (Project_directory.name);
				if file_name.item (file_name.count) /= '/' then
					file_name.append ("/");
				end;
				file_name.append ("Ace");
				Lace.set_file_name (file_name);
			end;
			!!new_file.make (file_name);
			new_file.open_write;
			to_write := text_window.text; 
			new_file.putstring (to_write);
			if to_write.item (to_write.count) /= '%N' then 
				-- Add a carriage return like vi if there's none at the end 
				new_file.putchar ('%N')
			end; 
			new_file.close;
			text_window.set_changed (false)
		end;

	
end
