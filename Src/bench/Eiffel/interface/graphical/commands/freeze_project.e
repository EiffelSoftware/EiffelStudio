
-- Command to freeze the Eiffel

class FREEZE_PROJECT 

inherit
 
	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	ICONED_COMMAND;
	SHARED_DEBUG;
	SHARED_RESCUE_STATUS
 
creation

	make
 
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window);
			!!request
		end; 
 
feature {NONE}

	work (argument: ANY) is
			-- Update the system and then call "finish freezing" in <project>/C_code.
		local
			freeze_with_argument: STRING;
			file: UNIX_FILE;
			temp: STRING;
			fn: STRING;
			f: UNIX_FILE;
		do
			debug_info.wipe_out;
			if project_tool.initialized then
				error_window.clear_window;
				if Lace.file_name /= Void then
					if 
						(argument = text_window) or else  
						(argument = Current)
					then
						warner.custom_call (Current, 
									"Freezing implies some C compilation%N%
									%and linking. Do you want to do it now?",
									"Freeze now", Void, "Cancel");
					elseif argument = warner then
						set_global_cursor (watch_cursor);
						project_tool.set_changed (true);
						Workbench.recompile;
						if Workbench.successfull then
							System.freeze_system;
							project_tool.set_changed (false);
							system.server_controler.wipe_out;
							save_failed := False;
							save_workbench_file;
							if save_failed then
								!! temp.make (0);
								temp.append ("Could not write to ");
								temp.append (Project_file_name);
								temp.append ("%NPlease check permissions and disk space");
								temp.append ("%NThen press Freeze again%N");
								error_window.put_string (temp)
							else
								error_window.put_string
									("Launching C compilation in background...%N");
								finish_freezing;
								error_window.put_string ("System recompiled%N");
							end;
						end;
					end;
					restore_cursors;
					error_window.display;
				elseif argument = warner then
					name_chooser.call (Current)
				elseif argument = void then
					system_tool.display;	
					load_default_ace;	
				elseif argument = name_chooser then
					fn := name_chooser.selected_file.duplicate;
					!! f.make (fn);
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						Lace.set_file_name (fn);
						work (Current)
					else
						!!temp.make (0);
						temp.append ("File: ");
						temp.append (fn);
						temp.append ("%Ncannot be read. Try again?");
						warner.custom_call 
							(Current, temp, " Ok ", Void, "Cancel");
					end
				elseif argument = text_window then
					warner.custom_call (Current, l_Specify_ace,
						"Choose", "Template", "Cancel");
				end;
			end;
		end;

	retried: BOOLEAN;
	save_failed: BOOLEAN;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: UNIX_FILE;
			temp: STRING
		do
			if not retried then
				!!file.make (Project_file_name);
				file.open_binary_write;
				workbench.basic_store (file);
				file.close;
			else
				retried := False
				if not file.is_closed then
					file.close
				end;
				save_failed := True;
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Freeze 
		end; 

	
feature {NONE}

	command_name: STRING is do Result := l_Freeze end;

	request: ASYNC_SHELL;

	finish_freezing is
		local
			d: DIRECTORY;
			cmd, copy_cmd: STRING;
		do
			!!cmd.make (50);
			cmd.append ("cd ");
			cmd.append (Workbench_generation_path);
			cmd.append ("; finish_freezing");
			
			!!d.make (Workbench_generation_path);
			if not d.has_entry ("finish_freezing") then
				!!copy_cmd.make (50);
				copy_cmd.append ("cp ");
				copy_cmd.append (freeze_command_name);
				copy_cmd.append (" ");
				copy_cmd.append (Workbench_generation_path);
				copy_cmd.append ("; ");	
				cmd.prepend (copy_cmd);
			end;
			request.set_command_name (cmd);
			request.send;
		end;

	load_default_ace is
		require
			project_tool.initialized
		local
			file_name: STRING;
		do
				!!file_name.make (50);	
				file_name.append (Eiffel3_dir_name);
				file_name.append ("/bench/help/defaults/Ace.default");
				system_tool.text_window.show_file_content (file_name);
				system_tool.text_window.set_changed (True)
		end;

			
end
