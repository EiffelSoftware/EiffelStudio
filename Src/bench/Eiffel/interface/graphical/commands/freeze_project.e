
-- Command to freeze the Eiffel

class FREEZE_PROJECT 

inherit
 
	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	ICONED_COMMAND
 
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
			project_dir: PROJECT_DIR;
			file: UNIX_FILE;
		do
			if project_tool.initialized then
				bench_error_window.clean;
				if Lace.file_name /= Void then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (true);
					Workbench.recompile;
					if Workbench.successfull then
						System.freeze_system;
						project_tool.set_changed (false);
						system.server_controler.wipe_out;
						!!file.make (Project_file_name);
						file.open_write;
						workbench.basic_store (file);
						file.close;
						finish_freezing;
					end;
					restore_cursors;
				elseif argument = warner then
					name_chooser.call (Current)
				elseif argument = void then
					system_tool.show;	
					load_default_ace;	
					system_tool.set_quit_command (Current, 0);
						-- 0 /= void
				elseif argument = name_chooser then
					Lace.set_file_name (name_chooser.selected_file);
					work (Current)
				else
					warner.custom_call (Current, l_Specify_ace,
						"Choose", "Template", "Cancel");
				end
			elseif argument = name_chooser then
				!!project_dir.make (name_chooser.selected_file);
				if project_dir.valid then
					project_tool.open_command.make_project (project_dir);
					work (Current)
				else
					warner.custom_call (Current, l_Invalid_directory,
						"Try again", "Help", "Cancel");		
				end
			elseif argument = warner then
				name_chooser.call (Current)
			elseif argument = void then
				-- help window
			else
				warner.call(Current, l_Initialize);
			end;
		end;

 
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Freeze) 
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
			cmd.append (Generation_path);
			cmd.append ("; finish_freezing");
			
			!!d.make (Generation_path);
			if not d.has_entry ("finish_freezing") then
				!!copy_cmd.make (50);
				copy_cmd.append ("cp ");
				copy_cmd.append (freeze_command_name);
				copy_cmd.append (" ");
				copy_cmd.append (Generation_path);
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
				file_name.append ("/bin/Ace.default");
				system_tool.text_window.show_file_content (file_name);
		end;

			
end
