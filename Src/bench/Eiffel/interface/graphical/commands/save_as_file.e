
class SAVE_AS_FILE 

inherit

	ICONED_COMMAND
		redefine
			licence_checked
		end;

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
			fn: STRING;
			new_file: RAW_FILE;
			to_write: STRING;
			aok: BOOLEAN;
			temp: STRING
		do
			if 
				(argument = name_chooser) or else
				(last_warner /= Void and argument = last_warner)
			then
				fn := clone (name_chooser.selected_file);
				if not fn.empty then
					!!new_file.make (fn);
					aok := True;
					if
						(new_file.exists) and then (not new_file.is_plain)
					then
						aok := False;
						warner (text_window).gotcha_call 
							(w_Not_a_plain_file (new_file.name))
					elseif 
						argument = name_chooser and then 
						(new_file.exists and then new_file.is_writable)
					then
						aok := False;
						warner (text_window).custom_call (Current, 
							w_File_exists (new_file.name), 
							"Overwrite", Void, "Cancel");
					elseif
						new_file.exists and then (not new_file.is_writable)
					then
						aok := False;
						warner (text_window).gotcha_call 
							(w_Not_writable (new_file.name))
					elseif
						not new_file.is_creatable
					then
						aok := False;
						warner (text_window).gotcha_call 
							(w_Not_creatable (new_file.name))
					end
				else
					aok := False;
					warner (text_window).gotcha_call 
						(w_Not_a_plain_file (new_file.name))
				end;
				if aok then
					new_file.open_write;
					to_write := text_window.text;
					if not to_write.empty then
						new_file.putstring (to_write);
						if not (to_write.item (to_write.count) = '%N') then
								-- Add a carriage return like vi 
								-- if there's none at the end
							new_file.putchar ('%N')
						end;
					end;
					new_file.close;
					if text_window.changed then 
						text_window.clear_clickable
					end;
					text_window.set_changed (false);
					if text_window.file_name = Void then
						text_window.set_file_name (new_file.name);
						text_window.display_header (new_file.name);
						update_more;
					end;
				end;
			elseif (argument = text_window) then
				name_chooser.set_window (text_window);
				name_chooser.call (Current)
			end
		end;

	update_more is do end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Save_as 
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Save_as end

end
