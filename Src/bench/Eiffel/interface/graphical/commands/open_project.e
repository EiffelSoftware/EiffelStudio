
-- Command to retrieve a stored project

class OPEN_PROJECT 

inherit

	PROJECT_CONTEXT
		redefine
			init_project_directory,
			init_precompilation_directory
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
	init_precompilation_directory: PROJECT_DIR;

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

	retried: BOOLEAN;

	make_project (project_dir: PROJECT_DIR) is
			-- Initialize project as a new one or retrieving existing data in the
			-- valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: UNIX_FILE;
		do
			if not retried then
				init_project_directory := project_dir;
				if not project_dir.exists then
					project_dir.create;	
				end;
				if project_dir.count < 3 then
						-- Create new project
					if project_dir /= Project_directory then end;
					Create_compilation_directory;
					Create_generation_directory;

					get_precompilation_directory;

					if precompiled_project_name /= Void then
						!! init_precompilation_directory.make 
										(precompiled_project_name);
						if Precompilation_directory /= Precompilation_directory then end;
						!!workb;
						!!workbench_file.make_open_read (Precompilation_file_name);
						workb ?= workb.retrieved (workbench_file);
						!! init_work.make (workb);
						Workbench.init;	
						System.server_controler.init;
						System.set_precompilation (False);
					else
						!!workb;
						!!init_work.make (workb);
						workb.make;
					end;
				else
						-- Retrieve existing project
					if project_dir /= Project_directory then end;
					Create_compilation_directory;
					Create_generation_directory;

					!!workb;
					!!workbench_file.make_open_read (Project_file_name);
					workb ?= workb.retrieved (workbench_file);
					!!init_work.make (workb);
					Workbench.init;
					if System.uses_precompiled then
						get_precompilation_directory;
						if precompiled_project_name /= Void then
							!! init_precompilation_directory.make (precompiled_project_name);
							if Precompilation_directory /= Precompilation_directory then end;
						end;
					end;
					System.server_controler.init;
				end;
	
				project_tool.set_title (project_dir.name);
				project_tool.set_initialized
			else
				io.error.putstring ("EiffelBench: could not retrieve project%N");
				io.error.putstring ("Restart EiffelBench and try again%N");
				exit; -- (from GRAPHICS)
			end;
		rescue
			retried := True;
			retry
		end;

	precompiled_project_name: STRING;

	get_precompilation_directory is
		local
			f: UNIX_FILE;
			fn: STRING;
			i, j: INTEGER;
		do
			fn := Project_directory.name.duplicate;
			from
				i := 1
			until
				i > fn.count
			loop
				if (fn.item (i) = '/') then
					j := i
				end;
				i := i + 1
			end;
			fn.replace_substring (".precomp", j+1,fn.count);
			!!f.make (fn);
			if f.exists and then f.is_readable then
				f.open_read;
				if not f.empty then
					f.readline;
					precompiled_project_name := f.laststring.duplicate;
				end;
				f.close
			end;
		end;

	symbol: PIXMAP is
		once
			Result := bm_Open
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open_project end

end
