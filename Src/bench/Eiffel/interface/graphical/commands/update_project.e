
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
			init (c, a_text_window);
			!!request
		end;

feature {NONE}

	reset_debugger is
		do
			debug_info.wipe_out;
			if Run_info.is_running then
				debug_info.restore;
				debug_window.clear_window;   
				debug_window.put_string ("Application terminated%N");
				debug_window.display;
				run_info.set_is_running (false)
			end;
			quit_cmd.exit_now;
		end;

	compile (argument: ANY) is
		local
			temp: STRING
		do
			set_global_cursor (watch_cursor);
			project_tool.set_changed (true);
			Workbench.recompile;
			if Workbench.successfull then
				freezing_actions;
				project_tool.set_changed (false);
				system.server_controler.wipe_out; -- ???
				save_failed := False;
				save_workbench_file;
				if save_failed then
					!! temp.make (0);
					temp.append ("Could not write to ");
					temp.append (Project_file_name);
					temp.append ("%NPlease check permissions and disk space%
								%%NThen press ");
					temp.append (command_name);
					temp.append (" again%N");
					error_window.put_string (temp);
				else
					finalization_actions (argument);
					launch_c_compilation (argument);
				end;
			end;
			restore_cursors;
		end;

	launch_c_compilation (argument: ANY) is
		do
			error_window.put_string ("System recompiled%N");
			if System.freezing_occurred then
				error_window.put_string 
					("System had to be frozen to include new externals.%N%
						%Background C compilation launched.%N");
				finish_freezing 
			else
				link_driver
			end;		
		end;

	freezing_actions is
		do
		end;

	finalization_actions (argument: ANY) is
		do
		end;

	confirm_and_compile (argument: ANY) is
		do
			compile (argument)
		end;

	work (argument: ANY) is
			-- Recompile the project.
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			temp: STRING
		do
			reset_debugger;
			if project_tool.initialized then
				error_window.clear_window;
				if Lace.file_name /= Void then
					confirm_and_compile (argument);
					error_window.display;
				elseif argument = warner then
					name_chooser.call (Current)
				elseif argument = void then
					system_tool.display;	
					load_default_ace;	
				elseif argument = name_chooser then
					fn := clone (name_chooser.selected_file);
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
			arg2: STRING;
			cmd_string: STRING;
			uf: RAW_FILE;
		do
			if System.uses_precompiled then
					-- Target
				arg2 := build_path (Workbench_generation_path,
									System.system_name);
				!!uf.make (arg2);
				if not uf.exists then
						-- Request
					!!cmd_string.make (200);
					cmd_string.append
							("$EIFFEL3/bench/spec/$PLATFORM/bin/prelink ");
					cmd_string.append (Precompilation_driver);
					cmd_string.append (" ");
					cmd_string.append (arg2);
					request.set_command_name (cmd_string);
					request.send
				end;
			end;
		end;

	retried: BOOLEAN;
	save_failed: BOOLEAN;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: RAW_FILE
		do
			if not retried then
				System.server_controler.wipe_out;
				!!file.make (Project_file_name);
				file.open_write;
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

feature {NONE}

	request: ASYNC_SHELL;

	load_default_ace is
		require
			project_tool.initialized
		local
			file_name: STRING;
		do
				!!file_name.make (50);	
				file_name.append (Default_ace_name);
				system_tool.text_window.show_file_content (file_name);
				system_tool.text_window.set_changed (True)
		end;

	c_code_directory: STRING is
		do
			Result := Workbench_generation_path
		end;

feature

	finish_freezing is
		local
			d: DIRECTORY;
			cmd, cp_cmd: STRING;
		do
			!!cmd.make (50);
			cmd.append ("cd ");
			cmd.append (c_code_directory);
			cmd.append ("; ");
			cmd.append (Finish_freezing_script);
 
			!!d.make (c_code_directory);
			if not d.has_entry (Finish_freezing_script) then
				!!cp_cmd.make (50);
				cp_cmd.append (Copy_cmd);
				cp_cmd.extend (' ');
				cp_cmd.append (freeze_command_name);
				cp_cmd.extend (' ');
				cp_cmd.append (c_code_directory);
				cp_cmd.append ("; ");
				cmd.prepend (cp_cmd);
			end;
			request.set_command_name (cmd);
			request.send;
		end;

	symbol: PIXMAP is
		once
			Result := bm_Update
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Update end;

end
