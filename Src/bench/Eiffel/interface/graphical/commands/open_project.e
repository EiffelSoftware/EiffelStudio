
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

	make (a_text_window: TEXT_WINDOW) is
		do
            text_window := a_text_window
		end;

	
feature {NONE}

	init_project_directory: PROJECT_DIR;

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
			project_dir: PROJECT_DIR;
			help_window: EXPLAIN_W;
			help_file_name: STRING;
			last_char: CHARACTER;
			dir_name: STRING
		do

			if not project_tool.initialized then
				if argument = name_chooser then
					dir_name := name_chooser.selected_file.duplicate;
					last_char := dir_name.item (dir_name.count); 
					if last_char = '/' then
						dir_name.remove (dir_name.count)
					end;
					!!project_dir.make (dir_name);
					warner.set_last_caller (Current);
					project_dir.check_directory (warner);
					if project_dir.is_valid then
						make_project (project_dir)
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

	retried: BOOLEAN;

	make_project (project_dir: PROJECT_DIR) is
			-- Initialize project as a new one or retrieving existing data in the
			-- valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
			precomp_r: PRECOMP_R;
		do
			if not retried then
				init_project_directory := project_dir;
				if project_dir.is_new then
						-- Create new project
					if project_dir /= Project_directory then end;
					Create_compilation_directory;
					Create_generation_directory;

					!!workb;
					!!init_work.make (workb);
					workb.make;
				else
						-- Retrieve existing project
					if project_dir /= Project_directory then end;
					Create_compilation_directory;
					Create_generation_directory;

					!!workbench_file.make (Project_file_name);
					!!workb;
					if workbench_file.exists then
						workbench_file.open_read;
						workb ?= workb.retrieved (workbench_file);
						!!init_work.make (workb);
						Workbench.init;
						if System.uses_precompiled then
							!!precomp_r;
							precomp_r.set_precomp_dir;
						end;
						System.server_controler.init;
						Universe.update_cluster_paths
					else
						!!init_work.make (workb);
						workb.make
					end;
				end;
	
				project_tool.set_title (project_dir.name);
				project_tool.set_initialized
			else
				io.error.putstring ("EiffelBench: could not retrieve project%N");
				io.error.putstring (project_dir.name);
				io.error.putstring ("Restart EiffelBench and try again%N");
				exit; -- (from GRAPHICS)
			end;
		rescue
			retried := True;
			--retry
		end;

	symbol: PIXMAP is
		once
			Result := bm_Open
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open_project end

end
