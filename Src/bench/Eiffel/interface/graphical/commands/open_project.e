indexing

	description:	
		"Command to retrieve a stored project.";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_PROJECT 

inherit

	SHARED_EIFFEL_PROJECT;
	SHARED_APPLICATION_EXECUTION;
	PROJECT_CONTEXT;
	COMMAND_W;
	BENCH_LICENSED_COMMAND
		rename
			parent_window as Project_tool
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_help as exit_bench,
			execute_warner_ok as open_project
		end

feature -- Callbacks

	exit_bench is
		do
			discard_licenses;
			exit
		end;

	open_project (argument: ANY) is
		local
			mp: MOUSE_PTR
		do
			if not project_tool.initialized then
				last_name_chooser.set_window (Project_tool);
				!! mp.do_nothing;
				mp.restore;
				last_name_chooser.call (Current)
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
			project_dir: PROJECT_DIRECTORY;
			last_char: CHARACTER;
			dir_name: STRING;
			expiration: INTEGER;
			new_name_chooser: NAME_CHOOSER_W
		do
			if not project_tool.initialized then
				if argument = project_tool then
					new_name_chooser := name_chooser (Project_tool);
					new_name_chooser.set_directory_selection;
					new_name_chooser.hide_file_selection_list;
					new_name_chooser.hide_file_selection_label;
					new_name_chooser.set_title (Interface_names.t_Select_a_directory)

					if not has_limited_license then
						open_project (argument)
					else
						warner (Project_tool).custom_call (Current,
							expiration_message, Interface_names.b_Ok, Void, Void);
					end
				else
					dir_name := clone (last_name_chooser.selected_file);
					if dir_name.empty then
						warner (Project_tool).custom_call (Current,
							Warning_messages.w_Directory_not_exist (dir_name), 
							Interface_names.b_Ok, Void, Void);
					else
						if dir_name.count > 1 then
							last_char := dir_name.item (dir_name.count); 
							if last_char = Directory_separator then
								dir_name.remove (dir_name.count)
							end
						end;
						!!project_dir.make (dir_name);
						make_project (project_dir);
						last_name_chooser.set_file_selection;
						last_name_chooser.set_title (Interface_names.t_Select_a_file);
						last_name_chooser.show_file_selection_list;
						last_name_chooser.show_file_selection_label;
					end
				end
			end
		end;

feature -- Project Initialization

	make_project (project_dir: PROJECT_DIRECTORY) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			project_eif_file: RAW_FILE;
			ok: BOOLEAN;
			temp: STRING;
			fn: FILE_NAME;
			title: STRING;
			mp: MOUSE_PTR
		do
			ok := True;
			if not project_dir.exists then
				temp := Warning_messages.w_Directory_not_exist (project_dir.name);
				ok := False;
			elseif project_dir.is_new then
					-- Create new project
				if 
					not project_dir.is_readable or else
					not project_dir.is_writable or else
					not project_dir.is_executable
				then
					temp := Warning_messages.w_Directory_wrong_permissions (project_dir.name);
					ok := False;
				else
						-- Create a new project.
					Eiffel_project.make (project_dir);
					init_project;
					title := clone (Interface_names.t_New_project);
					title.append (": ");
					title.append (project_dir.name);
					project_tool.set_title (title);
				end
			else
					-- Retrieve existing project
				project_eif_file := project_dir.project_eif_file;
				if not project_eif_file.is_readable then
					temp := Warning_messages.w_Not_readable (project_eif_file.name);
					ok := False
				elseif not project_eif_file.is_plain then
					temp := Warning_messages.w_Not_a_file (project_eif_file.name);
					ok := False
				else
					!! mp.do_nothing;
					mp.restore
					project_tool.set_title ("Retrieving project...");
					mp.set_watch_cursor;
					retrieve_project (project_dir);
					if not Eiffel_project.error_occurred then
						init_project;
						title := clone (Interface_names.t_Project);
						title.append (": ");
						title.append (project_dir.name);
						if Eiffel_system.is_precompiled then
							title.append ("  (precompiled)");
						end
						project_tool.set_title (title);
						project_tool.set_icon_name (Eiffel_system.name);
					end;
				end;
			end;
	
			if ok then
				project_tool.set_initialized
			else	
				warner (Project_tool).custom_call (Current, temp, 
					" OK ", Void, Void);
			end
		end;

	retrieve_project (project_dir: PROJECT_DIRECTORY) is
			-- Retrieve a project from the disk.
		local
			msg: STRING
		do	
			Eiffel_project.retrieve (project_dir);
			if Eiffel_project.retrieval_error then
				if Eiffel_project.is_corrupted then
					msg := Warning_messages.w_Project_corrupted (project_dir.name)
				elseif Eiffel_project.retrieval_interrupted then
					msg := Warning_messages.w_Project_interrupted (project_dir.name)
				else
					msg := Warning_messages.w_Project_incompatible 
						(project_dir.name, 
						version_number, 
						Eiffel_project.incompatible_version_number)
				end
				warner (Project_tool).custom_call (Current, 
						msg, Void, Interface_names.b_Exit_now, Void)
			elseif Eiffel_project.read_write_error then
				warner (Project_tool).custom_call (Current,
						Warning_messages.w_Cannot_open_project, Void, Interface_names.b_Exit, Void)
			elseif Eiffel_project.is_read_only and then
				not Eiffel_system.is_precompiled
			then
				project_tool.set_initialized;
				warner (Project_tool).custom_call (Current,
						Warning_messages.w_Read_only_project, Interface_names.b_Ok, Interface_names.b_Exit, Void)
			end;
		end;

	init_project is
			-- Initialize project.
		local
			e_displayer: BENCH_ERROR_DISPLAYER;
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT;
		do
			!! e_displayer.make (Error_window);
			Eiffel_project.set_error_displayer (e_displayer);
			Application.set_interrupt_number (Project_resources.interrupt_every_n_instructions.actual_value);
			if not Project_resources.graphical_output_disabled.actual_value then
				!! g_degree_output;
				Eiffel_project.set_degree_output (g_degree_output)
			end
		end;

end -- class OPEN_PROJECT
