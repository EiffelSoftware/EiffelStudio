
-- Command to retrieve a stored project

class OPEN_PROJECT 

inherit

	PROJECT_CONTEXT
		redefine
			init_project_directory
		end;
	SHARED_WORKBENCH;
	ICONED_COMMAND;
	SHARED_RESCUE_STATUS;
	SHARED_LICENSE

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
			last_char: CHARACTER;
			dir_name: STRING
		do

			if not project_tool.initialized then
				name_chooser.set_directory_selection;
				name_chooser.hide_file_selection_list;
				name_chooser.hide_file_selection_label;
				if argument = name_chooser then
					dir_name := clone (name_chooser.selected_file);
					last_char := dir_name.item (dir_name.count); 
					if last_char = Directory_separator then
						dir_name.remove (dir_name.count)
					end;
					!!project_dir.make (dir_name);
					make_project (project_dir);
					name_chooser.set_file_selection;
					name_chooser.show_file_selection_list;
					name_chooser.show_file_selection_label;
				elseif argument = void then
					-- No Help
				else
					name_chooser.set_window (text_window);
					name_chooser.call (Current)
				end
			elseif argument = Void then
				discard_licence;
				exit
			end
		end;

	
feature 

	make_project (project_dir: PROJECT_DIR) is
			-- Initialize project as a new one or retrieving existing data in the
			-- valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			workbench_file: RAW_FILE;
			ok: BOOLEAN;
			temp: STRING;
		do
			if not retried then
				ok := True;
					!! temp.make (0);
					temp.append (project_dir.name);
					temp.append (workb_rel_path);
				!!workbench_file.make (temp);
				if 
					project_dir.is_new or else
					(not workbench_file.exists)
				then
						-- Create new project
					if not project_dir.exists then
						temp := w_Directory_not_exist (project_dir.name);
						ok := False;
					elseif not project_dir.is_directory then
						temp := w_Not_a_directory (project_dir.name);
						ok := False;
					elseif 
						not (project_dir.is_readable and then
							project_dir.is_writable and then
							project_dir.is_executable)
					then
						temp := w_Directory_wrong_permissions (project_dir.name);
						ok := False;
					else
						init_project_directory := project_dir;
						if project_dir /= Project_directory then end;
						Create_compilation_directory;
						Create_generation_directory;
	
						!!workb;
						!!init_work.make (workb);
						workb.make;
					end
				else
						-- Retrieve existing project
					if not workbench_file.is_readable then
						temp := w_Not_readable (workbench_file.name);
						ok := False
					elseif not workbench_file.is_plain then
						temp := w_Not_a_file (workbench_file.name);
						ok := False
					else
						retrieve_project (project_dir, workbench_file);
					end;
				end;
		
				if ok then
					project_tool.set_title (project_dir.name);
					project_tool.set_initialized
				else	
					warner (text_window).custom_call (Current, temp, 
						" OK ", Void, Void);
				end
			else
				retried := False;
				warner (text_window).custom_call (Current, 
								w_Cannot_retrieve_project (project_dir.name), 
								" OK ", Void, Void)
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	retried: BOOLEAN;

	retrieve_project (project_dir: PROJECT_DIR; workbench_file: RAW_FILE) is
		local
			init_work: INIT_WORKBENCH;
			precomp_r: PRECOMP_R;
			workb: WORKBENCH_I;
			temp: STRING
		do
			if not retried then
				init_project_directory := project_dir;
				if project_dir /= Project_directory then end;
				!!workb;
				workbench_file.open_read;
				workb ?= workb.retrieved (workbench_file);
				if workb = Void then
					retried := True
				end;
			end;
			if not retried then
				if not workbench_file.is_closed then
					workbench_file.close
				end;
				!!init_work.make (workb);
				Workbench.init;
				if System.uses_precompiled then
					!!precomp_r;
					precomp_r.set_precomp_dir;
				end;
				System.server_controler.init;
				Universe.update_cluster_paths;
				if is_project_writable then
					Project_read_only.set_item (false)
				elseif is_project_readable then
					Project_read_only.set_item (true);
					warner (text_window).custom_call (Current, 
							w_Read_only_project, " OK ", "Exit", Void)
				else
					warner (text_window).custom_call (Current, 
							w_Cannot_open_project, Void, "Exit", Void)
				end;
			else
				retried := False;
					-- This is a big hack to enable clean exit
					-- when the ".workbench" file is corrupted
				if not workbench_file.is_closed then
					workbench_file.close
				end;
				project_tool.set_initialized;
				warner (text_window).custom_call (Current, 
							w_Project_corrupted (project_dir.name), 
							Void, "Exit now", Void)
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	is_project_readable: BOOLEAN is
			-- May the project be used for browsing and debugging?
		do
			Result := 
				(Update_file.exists and then Update_file.is_readable) and then 
				System.server_controler.is_readable
		end;

	is_project_writable: BOOLEAN is
			-- May the project be both compiled and used for browsing?
		local
			w_code_dir, f_code_dir, comp_dir: RAW_FILE;
			project_file: RAW_FILE
		do
			!! w_code_dir.make (Workbench_generation_path);
			!! f_code_dir.make (Final_generation_path);
			!! comp_dir.make (Compilation_path);
			!! project_file.make (Project_file_name);
			Result := project_file.is_writable and then
				Update_file.exists and then
				(Update_file.is_readable and Update_file.is_writable) and then
				(w_code_dir.exists and then w_code_dir.is_writable) and then 
				(f_code_dir.exists and then f_code_dir.is_writable) and then
				(f_code_dir.exists and then comp_dir.is_writable) and then
				System.server_controler.is_writable
		end;

	symbol: PIXMAP is
		once
			Result := bm_Open
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Open_project end

end
