
-- Command to retrieve a stored project

class OPEN_PROJECT 

inherit

	PROJECT_CONTEXT
		redefine
			init_project_directory
		end;
	SHARED_WORKBENCH;
	ICONED_COMMAND

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	
feature {NONE}

	init_project_directory: PROJECT_DIR;

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
			project_dir: PROJECT_DIR;
			help_window: EXPLAIN_W;
			help_file_name: STRING;
		do

			if not project_tool.initialized then

				if argument = name_chooser then
					!!project_dir.make (name_chooser.selected_file);
					if project_dir.valid then
						make_project (project_dir)
					else
						warner.custom_call (Current, l_Invalid_directory,
							"OK", "Help", "Cancel");
					end
				elseif argument = void then
                	!!help_window.make(project_tool.screen);
                    !!help_file_name.make (50);
                    help_file_name.append (Eiffel3_dir_name);
                    help_file_name.append ("/bin/open_project.explain");
                    help_window.text_window.show_file (help_file_name);
                    help_window.show;
				else
					name_chooser.call (Current)
				end
			elseif argument /= warner then
				warner.call (Current, l_Already)
			end
		end;

	
feature 

	make_project (project_dir: PROJECT_DIR) is
			-- Initialize project as a new one or retrieving existing data in the
			-- valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
		do
			init_project_directory := project_dir;
			if not project_dir.exists then
				project_dir.create;	
			end;
			if project_dir.count < 3 then
				if project_dir /= Project_directory then end;
				if Compilation_directory /= Compilation_directory then end;
				if Generation_directory /= Generation_directory then end;
				!!workb;
				!!init_work.make (workb);
				workb.make;
			else
				if project_dir /= Project_directory then end;
				if Compilation_directory /= Compilation_directory then end;
				if Generation_directory /= Generation_directory then end;
				!!workb;
				!!workbench_file.make_open_read (Project_file_name);
				workb ?= workb.retrieved (workbench_file);
				!!init_work.make (workb);
				Workbench.init
			end;

			project_tool.set_title (name_chooser.selected_file);
			project_tool.set_initialized
		end;

	symbol: PIXMAP is
		once
			!!Result.make;
			Result.read_from_file (bm_Open)
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open_project end

end
