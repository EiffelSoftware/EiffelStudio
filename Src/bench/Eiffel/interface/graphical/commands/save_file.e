
class SAVE_FILE 

inherit

	ICONED_COMMAND
		redefine
			dark_symbol, licence_checked
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;
	
feature {NONE}

	licence_checked: BOOLEAN is True;

	work (argument: ANY) is
			-- Save a file with the chosen name.
		local   
			new_file: UNIX_FILE;
			to_write: STRING;
			aok: BOOLEAN;
			temp: STRING
		do
			if text_window.file_name /= Void then
				!!new_file.make (text_window.file_name);
				aok := True;
				if
					(new_file.exists) and then (not new_file.is_plain)
				then
					aok := False;
					!! temp.make (0);
					temp.append (new_file.name);
					temp.append ("%Nis not a plain file");
					warner.custom_call
						(Void, temp, Void, Void, " Ok ");
				elseif
					new_file.exists and then (not new_file.is_writable)
				then
					aok := False;
					!! temp.make (0);
					temp.append ("File: ");
					temp.append (new_file.name);
					temp.append (" is not writable.%NPlease check permissions");
					warner.custom_call
						(Void, temp, Void, Void, " Ok ");
				elseif
					 (not new_file.exists) and then (not new_file.is_creatable)
				then
					aok := False;
					!! temp.make (0);
					temp.append ("File: ");
					temp.append (new_file.name);
					temp.append (" cannot be created.%NPlease check permissions");
					warner.custom_call
						(Void, temp, Void, Void, " Ok ");
                end;

				if aok then
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
					text_window.set_changed (false)
				end
			end
		end;

	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Save 
		end;
 
	
feature {NONE}

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_save
		end;

	command_name: STRING is do Result := l_Save end

end
