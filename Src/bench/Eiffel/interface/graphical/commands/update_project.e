
-- Command to update the Eiffel

class UPDATE_PROJECT 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
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
			-- Recompile the project.
		local
			project_dir: PROJECT_DIR
		do
			if project_tool.initialized then
				error_window.clean;
				if Lace.file_name /= Void then
					set_global_cursor (watch_cursor);
					project_tool.set_changed (true);
					Workbench.recompile;
					restore_cursors
				elseif argument = warner then
					name_chooser.call (Current)
				elseif argument = name_chooser then
					Lace.set_file_name (name_chooser.selected_file);
					work (Current)
				else
					warner.call (Current, l_Specify_ace)
				end
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
			Result.read_from_file (bm_Update)
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Update end

end
