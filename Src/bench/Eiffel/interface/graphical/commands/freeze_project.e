
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
			project_dir: PROJECT_DIR
		do
			if project_tool.initialized then
--				error_window.clean;
--				if not (Lace.file_name = Void) then
--					set_global_cursor (watch_cursor);
--					project_tool.set_changed (true);
--					Workbench.recompile;
--					restore_cursors;
--					if Workbench.successfull then
--						!!freeze_with_argument.make (50);
--						freeze_with_argument.append (Freeze_command_name);
--						freeze_with_argument.append (Generation_path);
--						request.set_command_name (freeze_with_argument);
--						request.send
--					end
--				elseif argument = warner then
--					name_chooser.call (Current)
--				elseif argument = name_chooser then
--					Lace.set_file_name (name_chooser.selected_file);
--					work (Current)
--				else
--					warner.call (Current, l_Specify_ace)
--				end
			elseif argument = name_chooser then
				!!project_dir.make (name_chooser.selected_file);
				if project_dir.valid then
					project_tool.open_command.make_project (project_dir);
					work (Current)
				else
					warner.call (Current, l_Invalid_directory)
				end
			elseif argument = warner then
				name_chooser.call (Current)
			else
				warner.call (Current, l_Initialize)
			end
		end;
 
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Freeze) 
		end; 

	
feature {NONE}

	command_name: STRING is do Result := l_Freeze end;

	request: ASYNC_SHELL

end
