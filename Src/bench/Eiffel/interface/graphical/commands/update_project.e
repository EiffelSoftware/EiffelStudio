
-- Command to update the Eiffel

class UPDATE_PROJECT 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	ICONED_COMMAND;
	SHARED_DIALOG;
	SHARED_DEBUG

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
			project_dir: PROJECT_DIR;
		do
			debug_info.wipe_out;
			if project_tool.initialized then
				error_window.clear_window;
				if Lace.file_name /= Void then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (true);
					Workbench.recompile;
					if Workbench.successfull then
						link_driver;
						project_tool.set_changed (false);
						system.server_controler.wipe_out; -- ???
						save_workbench_file;
						error_window.put_string ("System recompiled%N");
					end;
					restore_cursors;
					error_window.display;
				elseif argument = warner then
					name_chooser.call (Current)
				elseif argument = void then
					system_tool.display;	
					load_default_ace;	
					system_tool.set_quit_command (Current, 0);
						-- 0 /= void
				elseif argument = name_chooser then
					Lace.set_file_name (name_chooser.selected_file);
					work (Current)
				else
					warner.custom_call (Current, l_Specify_ace,
						"Choose", "Template", "Cancel");
				end;
			elseif argument = name_chooser then
				!!project_dir.make (name_chooser.selected_file);
				project_dir.check_directory (warner);
				if project_dir.is_valid then
					project_tool.open_command.make_project (project_dir);
					work (Current)
				end
			elseif argument = warner then
				name_chooser.call (Current)
			elseif argument = void then
				-- help window
			else
				warner.call(Current, l_Initialize);
			end;
		end;

	link_driver is
		local
			arg1, arg2: STRING;
			req: ASYNC_SHELL;
			cmd_string: STRING
		do
			if System.uses_precompiled then
					-- Source
				arg1 := Precompilation_directory.name.duplicate;
				arg1.append ("/EIFFELGEN/W_code/driver");
					-- Target
				arg2 := Workbench_generation_path.duplicate;
				arg2.append ("/")
				arg2.append (System.system_name);
					-- Request
				!!req;
				!!cmd_string.make (200);
				cmd_string.append
						("$EIFFEL3/bench/spec/$PLATFORM/bin/prelink ");
				cmd_string.append (arg1);
				cmd_string.append (" ");
				cmd_string.append (arg2);
				req.set_command_name (cmd_string);
				req.send	
			end;
		end;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: UNIX_FILE
		do
			!!file.make (Project_file_name);
			file.open_write;
			workbench.basic_store (file);
			file.close;
		rescue
			if not file.is_closed then
				file.close
			end;
			Dialog_window.display 
				("Error in opening/writing EIFFELGEN/.workbench file ");
			retry
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
		end;
				
end
