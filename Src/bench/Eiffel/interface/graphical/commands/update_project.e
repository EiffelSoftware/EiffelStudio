
-- Command to update the Eiffel

class UPDATE_PROJECT 

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
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Recompile the project.
		local
			fn: STRING;
			f: UNIX_FILE;
			temp: STRING
		do
			debug_info.wipe_out;
			if project_tool.initialized then
				error_window.clear_window;
				if Lace.file_name /= Void then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (true);
					Workbench.recompile;
					if Workbench.successfull then
						project_tool.set_changed (false);
						system.server_controler.wipe_out; -- ???
						save_failed := False;
						save_workbench_file;
						if save_failed then
							!! temp.make (0);
							temp.append ("Could not write to ");
							temp.append (Project_file_name);
							temp.append ("%NPlease check permissions and disk space");
							temp.append ("%NThen press Melt again%N");
							error_window.put_string (temp);
						else
							error_window.put_string ("System recompiled%N");
							if System.freezing_occurred then
								error_window.put_string 
									("System had to be frozen to include new externals.%N");
								error_window.put_string 
									("Background C compilation launched.%N");
								finish_freezing 
							else
								link_driver
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

	link_driver is
		local
			arg1, arg2: STRING;
			req: ASYNC_SHELL;
			cmd_string: STRING
		do
			if System.uses_precompiled then
					-- Target
				arg2 := build_path (Workbench_generation_path,
									System.system_name);
					-- Request
				!!req;
				!!cmd_string.make (200);
				cmd_string.append
						("$EIFFEL3/bench/spec/$PLATFORM/bin/prelink ");
				cmd_string.append (Precompilation_driver);
				cmd_string.append (" ");
				cmd_string.append (arg2);
				req.set_command_name (cmd_string);
				req.send	
			end;
		end;

	retried: BOOLEAN;
	save_failed: BOOLEAN;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: UNIX_FILE
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
			Result := bm_Update
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Update end;

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
				
	finish_freezing is
		local
			d: DIRECTORY;
			cmd, copy_cmd: STRING;
			request: ASYNC_SHELL
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
			!! request;
			request.set_command_name (cmd);
			request.send;
		end;

end
