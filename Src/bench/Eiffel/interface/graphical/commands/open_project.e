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
			-- Exit from EiffelBench
		do
			discard_licenses
			exit
		end

	open_project (argument: ANY) is
			-- Open the project.
		require else
			project_directory_exists: project_dir /= Void
		do
			if not project_tool.initialized then
				if choose_again then
					last_name_chooser.set_window (Project_tool)
					last_name_chooser.call (Current)
				else
					retrieve_project
				end
			end
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
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
						last_name_chooser.set_window (Project_tool);
						last_name_chooser.call (Current)
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
						!! project_dir.make (dir_name);
						Project_directory.set_directory (dir_name)
						make_project
						last_name_chooser.set_file_selection;
						last_name_chooser.set_title (Interface_names.t_Select_a_file);
						if project_tool.initialized then
							last_name_chooser.show_file_selection_list;
							last_name_chooser.show_file_selection_label;
						end
					end
				end
			end
		end;

feature -- Project Initialization

	make_project is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			project_directory_exist: project_dir /= Void
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			project_eif_file: RAW_FILE;
			ok: BOOLEAN;
			msg: STRING;
			fn: FILE_NAME;
			read_only: BOOLEAN
		do
			ok := True;
			if not project_dir.base_exists then
				msg := Warning_messages.w_Directory_not_exist (project_dir.name);
				choose_again := True
				ok := False;
			elseif project_dir.is_new then
					-- Create a new project.
				if not project_dir.has_base_full_access then
					msg := Warning_messages.w_Cannot_create_project_directory (project_dir.name)
					choose_again := True
					ok := False
				else
					Eiffel_project.make (project_dir)
					init_project
					msg := clone (Interface_names.t_New_project)
					msg.append (": ")
					msg.append (project_dir.name)
					project_tool.set_title (msg)
					project_tool.set_initialized
				end

			elseif not project_dir.exists then
				msg := Warning_messages.w_Project_directory_not_exist (project_dir.name)
				ok := False
				choose_again := True
			else
					-- Retrieve existing project
				project_eif_file := project_dir.project_eif_file;
				if not project_eif_file.is_readable then
					msg := Warning_messages.w_Not_readable (project_eif_file.name);
					ok := False
					choose_again := True
				elseif not project_eif_file.is_plain then
					msg := Warning_messages.w_Not_a_file (project_eif_file.name);
					ok := False
					choose_again := True
				else
					if project_dir.is_readable and then not project_dir.is_writable then
						msg := Warning_messages.w_Read_only_project
						read_only := True
						warner (Project_tool).custom_call (Current, msg, Interface_names.b_Ok, Interface_names.b_Exit, Void)
					else
						retrieve_project
					end
				end;
			end;

			if not read_only and then not ok then
				warner (Project_tool).custom_call (Current, msg, " OK ", Void, Void);
			end
		end;

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
			title: STRING;
			mp: MOUSE_PTR
		do	
			project_tool.set_title ("Retrieving project...");

				-- These 2 lines will updatae effectively the project tool.
			!! mp.do_nothing;
			mp.restore

				-- Put the cursor in the wait state.
			mp.set_watch_cursor

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
				msg := Warning_messages.w_Cannot_open_project
				warner (Project_tool).custom_call (Current, msg, Void, Interface_names.b_Exit, Void)
			end;

			if not Eiffel_project.error_occurred then
				init_project;
				title := clone (Interface_names.t_Project);
				title.append (": ");
				title.append (project_dir.name);
				if Eiffel_system.is_precompiled then
					title.append ("  (precompiled)");
				end
				project_tool.set_title (title);
				project_tool.set_initialized
				project_tool.set_icon_name (Eiffel_system.name);
			end;

			mp.restore
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

feature -- Project directory access

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory.

	choose_again: BOOLEAN
			-- Do we have to display the project directory dialog box again?

end -- class OPEN_PROJECT
