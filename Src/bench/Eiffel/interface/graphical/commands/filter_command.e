class FILTER_COMMAND 

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_FORMAT_TABLES;
	SHARED_RESOURCES

creation

	make
	
feature 

	filter_window: FILTER_W;
			-- Associated popup window

	filter_name: STRING is
			-- Name of the filter to be applied
		local
			filter_dir: DIRECTORY;
			file_name, dir_entry: STRING;
			found: BOOLEAN
		once
			Result := resources.get_string (r_Filter_name, "PostScript");
				-- Check whether that filter exists or not.
			!!filter_dir.make (filter_path);
			if filter_dir.exists and then filter_dir.is_readable then
				from
					file_name := clone (Result);
					file_name.to_lower;
					file_name.append (".fil");
					filter_dir.open_read;
					filter_dir.start;
					filter_dir.readentry;
					dir_entry := filter_dir.lastentry
				until
					found or dir_entry = Void
				loop
					dir_entry.to_lower;
					found := dir_entry.is_equal (file_name);
                    filter_dir.readentry;
                    dir_entry := filter_dir.lastentry
				end
			end;
			if not found then
				Result := ""
			end
		end;

	shell_command_name: STRING is
			-- Command name to be executed
		once
			Result := resources.get_string (r_Filter_command, "")
		end;

	text_window: CLASS_TEXT;

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			!!filter_window.make (c, Current);
			init (c, a_text_window);
			add_button_click_action (3, Current, Void)
		end;

feature {NONE}

	work (argument: ANY) is
			-- If left mouse button was pressed -> execute filter.
			-- If right mouse button was pressed -> bring up filter window. 
		local
			cmd_string: STRING;
			filterable_format: FILTERABLE;
			shell_request: ASYNC_SHELL;
			filename, new_text: STRING
		do
			set_global_cursor (watch_cursor);
			if argument = Void then
					-- 3rd button pressed
				filter_window.call 
			elseif argument = last_warner then
					-- If it comes here this means ok has
					-- been pressed in the warner window
					-- for text modification.
				text_window.last_format.filter (filter_name)
			elseif argument = filter_window then
					-- Display the filter output in `text_window'
				if text_window.changed then
					warner (text_window).call (Current, l_File_changed)
				else
					text_window.last_format.filter (filter_name)
				end
			elseif text_window.root_stone /= Void then
					-- Execute the shell command
				filterable_format ?= text_window.last_format;
				if filterable_format = Void then
					warner (text_window).gotcha_call (w_Not_a_filterable_format)
				else
					if 
						filterable_format.filtered and
						equal (filterable_format.filter_name, filter_name) 
					then
							-- The filtered text is in `text_window'
						filename := filterable_format.temp_filtered_file_name
										(text_window.root_stone, filter_name);
						save_to_file (text_window.text, filename);
						text_window.set_changed (false)
					else
						new_text := filterable_format.filtered_text 
										(text_window.root_stone, filter_name); 
							-- `filtered_text' of FILTERABLE has a side effect
							-- (i.e. set the suffix to be used to build the
							-- targetted file name) and as a consequence we
							-- cannot put the next line outside of the
							-- if-instruction.
						filename := filterable_format.temp_filtered_file_name
										(text_window.root_stone, filter_name);
						if new_text /= Void then
							save_to_file (new_text, filename)
						end
					end;
					cmd_string := clone (shell_command_name);
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$target", filename);
					end;
					!!shell_request;
					shell_request.set_command_name (cmd_string);
					shell_request.send;
				end
			end;
			restore_cursors
		end;
	
	save_to_file (a_text: STRING; a_filename: STRING) is
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void;
			a_filename_not_void: a_filename /= Void
		local
			new_file: PLAIN_TEXT_FILE
		do
			if not a_filename.empty then
				!!new_file.make (a_filename);
				if new_file.exists and then not new_file.is_plain then
					warner (text_window).gotcha_call 
						(w_Not_a_plain_file (new_file.name))
				elseif new_file.exists and then not new_file.is_writable then
					warner (text_window).gotcha_call 
						(w_Not_writable (new_file.name))
				elseif not new_file.exists and then not new_file.is_creatable then
					warner (text_window).gotcha_call 
						(w_Not_creatable (new_file.name))
				else
					new_file.open_write;
					if not a_text.empty then
						new_file.putstring (a_text);
						if a_text.item (a_text.count) /= '%N' then
								-- Add a carriage return like vi 
								-- if there's none at the end
							new_file.putchar ('%N')
						end
					end;
					new_file.close
				end
			end
		end;

feature {NONE}

	symbol: PIXMAP is 
		once 
			Result := bm_Filter 
		end;
 
	command_name: STRING is do Result := l_Filter end;

invariant

	filter_name_not_void: filter_name /= Void;
	shell_command_name_not_void: shell_command_name /= Void

end -- class FILTER_COMMAND
