
class OPEN_FILE 

inherit

	ICONED_COMMAND

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Open a file.
		local
			fn: STRING;
			f: RAW_FILE;
			temp: STRING
		do
			if last_warner /= Void and argument = last_warner then
				-- The user has eventually been warned that he will lose his stuff
				name_chooser.set_window (text_window);
				name_chooser.call (Current) 
			elseif argument = name_chooser then
				fn := clone (name_chooser.selected_file);
				if not fn.empty then
					!! f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						text_window.show_file (fn);
						text_window.display_header (fn)
					elseif f.exists and then not f.is_plain then
						warner (text_window).custom_call (Current, 
							w_Not_a_file_retry (fn), " OK ", Void, "Cancel");
					else
						warner (text_window).custom_call (Current, 
						w_Cannot_read_file_retry (fn), " OK ", Void, "Cancel");
					end
				else
					warner (text_window).custom_call (Current, 
						w_Not_a_file_retry (fn), " OK ", Void, "Cancel");
				end
			else
				-- First click on open
				if text_window.changed then
					warner (text_window).call (Current, l_File_changed)
				else
					name_chooser.set_window (text_window);
					name_chooser.call (Current) 
				end
			end
		end;
	
feature 

	symbol: PIXMAP is
		once
			Result := bm_Open
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open end

end
