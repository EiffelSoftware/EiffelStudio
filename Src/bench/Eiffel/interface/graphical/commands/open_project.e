indexing
	description: "Command to retrieve a stored project."
	date: "$Date$"
	revision: "$Revision$"

class OPEN_PROJECT 

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_APPLICATION_EXECUTION

	PROJECT_CONTEXT

	PIXMAP_COMMAND
		rename
			init as make,
			tool as project_tool
		redefine
			license_checked,
			project_tool
		end

	WARNER_CALLBACKS
		rename
			execute_warner_help as exit_bench,
			execute_warner_ok as open_project
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		end

creation
	make,
	make_from_project_file

feature -- Initialization

	make_from_project_file (a_tool: like project_tool; file_name: STRING) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		do
			make (a_tool)
			project_file_name := file_name
			has_project_name := True
		end

feature -- Callbacks

	exit_bench is
			-- Exit from EiffelBench
		do
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
					choose_again := False
				elseif redo_project then
					-- create_project --FIXME 
				elseif has_project_name then
				else
					retrieve_project
				end
			end
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Open 
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
			file_name: STRING
			new_name_chooser: NAME_CHOOSER_W
			file: RAW_FILE
			environment_variable: EXECUTION_ENVIRONMENT
			last_directory_opened:STRING
			ebench_name: STRING
		do
			if not project_tool.initialized then
				if has_project_name then
					!! file.make (valid_file_name (project_file_name))
					if not file.exists or else file.is_directory then
						warner (Project_tool).custom_call (Current,
								Warning_messages.w_file_not_exist (project_file_name), 
								Interface_names.b_Ok, Void, Void)
					else
						open_project_file (project_file_name)
					end
				else
					if argument = project_tool then
						-- We open the file_selection dialog on the last opened directory.
						!! environment_variable
						new_name_chooser := name_chooser (Project_tool)
						last_directory_opened := environment_variable.get (Studio_Directory_List)
						if last_directory_opened /= Void then
							new_name_chooser.set_last_directory_viewed(last_directory_opened.substring(1,last_directory_opened.index_of(';',1) -1 ))
						end
						new_name_chooser.set_file_selection

						new_name_chooser.set_title (Interface_names.t_Select_a_file)
						new_name_chooser.set_pattern ("*.epr")
						new_name_chooser.set_pattern_name ("Eiffel Project File (*.epr)")

						if not has_limited_license then
							last_name_chooser.set_window (Project_tool)
							last_name_chooser.call (Current)
						else
							choose_again := True
							warner (Project_tool).custom_call (Current,
								expiration_message, Interface_names.b_Ok, Void, Void)
						end
					else
						file_name := clone (last_name_chooser.selected_file)
						if file_name.is_empty then
							choose_again := True
							warner (Project_tool).custom_call (Current,
								Warning_messages.w_file_not_exist (file_name), 
								Interface_names.b_Ok, Void, Void)
						else
							!! file.make (valid_file_name (file_name))
							if not file.exists or else file.is_directory then
								choose_again := True
								warner (Project_tool).custom_call (Current,
									Warning_messages.w_file_not_exist (file_name), 
									Interface_names.b_Ok, Void, Void)
							else
								open_project_file (file_name)
							end
						end
					end
				end
			else
					-- A project has been opened, we need to open a new one
				if has_project_name then
					!! file.make (valid_file_name (project_file_name))
					if not file.exists or else file.is_directory then
						warner (Project_tool).custom_call (Current,
								Warning_messages.w_file_not_exist (project_file_name), 
								Interface_names.b_Ok, Void, Void)
					else
						ebench_name := clone ((create {EIFFEL_ENV}).Estudio_command_name)
						ebench_name.append (" ")
						ebench_name.append (project_file_name)
						launch_ebench (ebench_name)
					end
				else
					if argument = project_tool then
						-- We open the file_selection dialog on the last opened directory.
						!! environment_variable
						new_name_chooser := name_chooser (Project_tool)
						last_directory_opened := environment_variable.get (Studio_Directory_List)
						if last_directory_opened /= Void then
							new_name_chooser.set_last_directory_viewed(last_directory_opened.substring(1,last_directory_opened.index_of(';',1) -1 ))
						end
						new_name_chooser.set_file_selection

						new_name_chooser.set_title (Interface_names.t_Select_a_file)
						new_name_chooser.set_pattern ("*.epr")
						new_name_chooser.set_pattern_name ("Eiffel Project File (*.epr)")

						if not has_limited_license then
							last_name_chooser.set_window (Project_tool)
							last_name_chooser.call (Current)
						else
							choose_again := True
							warner (Project_tool).custom_call (Current,
								expiration_message, Interface_names.b_Ok, Void, Void)
						end
					else
						file_name := clone (last_name_chooser.selected_file)
						if file_name.is_empty then
							choose_again := True
							warner (Project_tool).custom_call (Current,
								Warning_messages.w_file_not_exist (file_name), 
								Interface_names.b_Ok, Void, Void)
						else
							!! file.make (valid_file_name (file_name))
							if not file.exists or else file.is_directory then
								choose_again := True
								warner (Project_tool).custom_call (Current,
									Warning_messages.w_file_not_exist (file_name), 
									Interface_names.b_Ok, Void, Void)
							else
								ebench_name := clone ((create {EIFFEL_ENV}).Estudio_command_name)
								ebench_name.append (" ")
								ebench_name.append (file_name)
								launch_ebench (ebench_name)
							end
						end
					end
				end
			end
		end

feature -- Project Initialization

	open_from_ebench is
			-- To open a project from `ebench'.
		require
			open_from_name: has_project_name
			project_file_name_exists: project_file_name /= Void
		local
			file: RAW_FILE
		do
			!! file.make (valid_file_name (project_file_name))
			if not file.exists or else file.is_directory then
				warner (Project_tool).custom_call (Current,
					Warning_messages.w_file_not_exist (project_file_name), 
					Interface_names.b_Ok, Void, Void)
			else
				open_project_file (project_file_name)
			end
		end

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			given_project_file_name_exists: file_name /= Void
		local
			dir_name: STRING
		do
			if has_project_name then
				dir_name := file_name.substring (1, file_name.last_index_of
							(Operating_environment.directory_separator, file_name.count) - 1)
			else
				dir_name := clone (last_name_chooser.directory)
			end

				--| Retrieve existing project
			!! project_file.make (file_name)
			!! project_dir.make (dir_name, project_file)
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir_name)

			retrieve_project
	
			-- We print text in the project_tool text concerning the system.
			project_tool.display_system_info	
		end

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
			title: STRING
			mp: MOUSE_PTR
			old_title: STRING
			project_name: STRING
		do	
			old_title := project_tool.title
			project_tool.set_title ("Retrieving project...")

				-- These 2 lines will update effectively the project tool.
			!! mp.do_nothing
			mp.restore

				-- Put the cursor in the wait state.
			mp.set_watch_cursor

				-- Retrieve the project
			Eiffel_project.make (project_dir)

			if Eiffel_project.retrieval_error then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
				!! mp.do_nothing
				mp.restore
				
				if Eiffel_project.is_incompatible then
					msg := Warning_messages.w_Project_incompatible 
						(project_dir.name, 
						version_number, 
						Eiffel_project.incompatible_version_number)
					redo_project := True
					warner (Project_tool).custom_call (Current, 
							msg, Interface_names.b_ok, Interface_names.b_cancel, Void)
				else
					if Eiffel_project.is_corrupted then
						msg := Warning_messages.w_Project_corrupted (project_dir.name)
					elseif Eiffel_project.retrieval_interrupted then
						msg := Warning_messages.w_Project_interrupted (project_dir.name)
					end
					warner (Project_tool).custom_call (Current, 
							msg, Void, Interface_names.b_cancel, Void)
				end
			elseif Eiffel_project.incomplete_project then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
				!! mp.do_nothing
				mp.restore
				
				msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
				warner (Project_tool).custom_call (Current, msg, Void, Interface_names.b_cancel, Void)
			elseif Eiffel_project.read_write_error then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
				!! mp.do_nothing
				mp.restore
				
				msg := Warning_messages.w_Cannot_open_project
				warner (Project_tool).custom_call (Current, msg, Void, Interface_names.b_cancel, Void)
			end

			if not Eiffel_project.error_occurred then
				init_project

					-- Retrieve breakpoints list
				project_tool.set_title ("Retrieving debug information...")
					-- These 2 lines will update effectively the project tool.
				!! mp.do_nothing
				mp.restore
				if Application /= Void then
					Application.load_debug_info
				end

					-- display the title of the main window
				title := clone (Interface_names.t_Project)
				title.append (": ")
				project_name := project_dir.name
				if project_name.item (project_name.count) = Operating_environment.Directory_separator then
					project_name.head (project_name.count -1)
				end
				title.append (project_name)
				if Eiffel_system.is_precompiled then
					title.append ("  (precompiled)")
				end
				project_tool.set_title (title)
				project_tool.set_initialized
				project_tool.set_icon_name (Eiffel_system.name)
				project_tool.save_environment
					-- We don't touch the content of the Project tool.
				project_tool.active_menus (False)
			end

			mp.restore
		end

	init_project is
			-- Initialize project.
		local
			e_displayer: BENCH_ERROR_DISPLAYER
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
		do
			!! e_displayer.make (Error_window)
			Eiffel_project.set_error_displayer (e_displayer)
			Application.set_interrupt_number (Project_resources.interrupt_every_n_instructions.actual_value)
			if not Project_resources.graphical_output_disabled.actual_value then
				!! g_degree_output
				Project_tool.set_progress_dialog (g_degree_output)
			end
		end

feature -- Project directory access

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory.

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information 
			-- about the current project are saved.

	project_file_name: STRING
			-- Name of project file name when `has_project_name'

	has_project_name: BOOLEAN
			-- Has the project file name been specified?

	choose_again: BOOLEAN
			-- Do we have to display the project directory dialog box again?

	redo_project: BOOLEAN
			-- The previous EIFGEN is not compatible with the current version,
			-- we do need to rename the old EIFGEN and build a new one.

	project_tool: PROJECT_W
			-- Project tool window

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Open_project
		end
 
	menu_name: STRING is
			-- Name used in menu entry
		do
			if has_project_name then
				Result := project_file_name 
			else
				Result := Interface_names.m_Open_project
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			if not has_project_name then
				Result := Interface_names.a_Open_project
			end
		end

feature {NONE} -- Implementation

	valid_file_name (file_name: STRING): STRING is
			-- Generate a valid file name from `file_name'
			--| Useful when the file name is a directory with a 
			--| directory separator at the end.
		require
			file_name_not_void: file_name /= Void
		local
			last_char: CHARACTER
		do
			last_char := file_name.item (file_name.count)
			if last_char = Operating_environment.Directory_separator then
				Result := clone (file_name)
				Result.remove (file_name.count)
			else
				Result := file_name	
			end
		end

end -- class OPEN_PROJECT
