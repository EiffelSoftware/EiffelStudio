indexing
	description: "Command to retrieve a stored project."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_PROJECT_CMD

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_APPLICATION_EXECUTION

	PROJECT_CONTEXT

	EB_TOOL_COMMAND
--		rename
--			tool as project_tool
		redefine
--			license_checked,
--			project_tool
		end

	EB_PROJECT_TOOL_DATA

	EB_DEBUG_TOOL_DATA

	BENCH_COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		end

	NEW_EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS

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

--	open_project (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
--			-- Open the project.
--		require else
--			project_directory_exists: project_dir /= Void
--		local
--			fod: EV_FILE_OPEN_DIALOG
--		do
--			if not project_tool.initialized then
--				if choose_again then
--					fod.show
--					choose_again := False
--				elseif redo_project then
--					-- create_project --FIXME 
--				elseif has_project_name then
--				else
--					retrieve_project
--				end
--			end
--		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Open 
--		end

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
			-- Popup a dialog for the user to choose the project he wants to open,
			-- OR gets callback information from the dialog, then opens the project if possible
		local
			file_name: STRING
			expiration: INTEGER
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
			wd: EV_WARNING_DIALOG
			file: RAW_FILE
			environment_variable: EXECUTION_ENVIRONMENT
			last_directory_opened:STRING
			ebench_name: STRING
		do
			if has_project_name then
					-- we are requested to open the specific project named `project_file_name'
				create file.make (valid_file_name (project_file_name))
				if not file.exists or else file.is_directory then
					create wd.make_default (Project_tool.parent, Interface_names.t_Warning,
							Warning_messages.w_file_not_exist (project_file_name))
				else
					if not project_tool.initialized then
						open_project_file (project_file_name)
					else
						ebench_name := ebench_command_name
						ebench_name.append (" ")
						ebench_name.append (project_file_name)
						launch_ebench (ebench_name)
					end
				end

			elseif argument = Void then
					-- User just asked for an open file dialog,
					-- and we set it on the last opened directory.
				create environment_variable
				create fod.make (Project_tool.parent)
				last_directory_opened := environment_variable.get (Bench_Directory_List)
				if last_directory_opened /= Void then
					fod.set_base_directory (last_directory_opened.substring(1,last_directory_opened.index_of(';',1) -1 ))
				end
				fod.set_title (Interface_names.t_Select_a_file)
--				fod.set_filter (<<"Eiffel Project File (*.epr)">>, <<"*.epr">>)
				create arg.make (fod)
				fod.add_ok_command (Current, arg)
--				if not has_limited_license then
					fod.show
--				else
--					choose_again := True
--					create wd.make_default (Project_tool.parent, Interface_names.t_Warning, expiration_message)
--				end

			else
					-- This is a callback from the name chooser.
					-- We get the project name and then open the project, if possible
				file_name := argument.first.file
				if file_name.empty then
					choose_again := True
					create wd.make_default (Project_tool.parent, Interface_names.t_Warning,
							Warning_messages.w_file_not_exist (file_name))
				else
					create file.make (valid_file_name (file_name))
					if not file.exists or else file.is_directory then
						choose_again := True
						create wd.make_default (Project_tool.parent, Interface_names.t_Warning,
								Warning_messages.w_file_not_exist (file_name))
					else
						if not project_tool.initialized then
							open_project_file (file_name)
						else
							ebench_name := ebench_command_name
							ebench_name.append (" ")
							ebench_name.append (file_name)
							launch_ebench (ebench_name)
						end
					end
				end
			end
		end

feature -- Project Initialization

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			file_name_non_void: file_name /= Void
		local
			dir_name: STRING
	 		root_class_name: STRING
			root_class_c: CLASS_C
		do
			dir_name := file_name.substring (1, file_name.last_index_of
				(directory_separator, file_name.count) - 1)
				-- of course we could have chosen to take the directory from the file open dialog.

				--| Retrieve existing project
			create project_file.make (file_name)
			create project_dir.make (dir_name, project_file)
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir_name)

			retrieve_project

			-- We print text in the project_tool text concerning the system.
			debug_tool.display_system_info
		end

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
			title: STRING
--			mp: MOUSE_PTR
			old_title: STRING
			project_name: STRING
			wd: EV_WARNING_DIALOG
		do	
			old_title := project_tool.title
			project_tool.set_title ("Retrieving project...")

				-- These 2 lines will update effectively the project tool.
--			!! mp.do_nothing
--			mp.restore

				-- Put the cursor in the wait state.
--			mp.set_watch_cursor

				-- Retrieve the project
			Eiffel_project.make (project_dir)

			if Eiffel_project.retrieval_error then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
--				!! mp.do_nothing
--				mp.restore
				
				if Eiffel_project.is_incompatible then
					msg := Warning_messages.w_Project_incompatible 
						(project_dir.name, 
						version_number, 
						Eiffel_project.incompatible_version_number)
					redo_project := True
					create wd.make_with_text (Project_tool.parent, Interface_names.t_Warning, msg)
					wd.show_ok_cancel_buttons
					wd.show
				else
					if Eiffel_project.is_corrupted then
						msg := Warning_messages.w_Project_corrupted (project_dir.name)
					elseif Eiffel_project.retrieval_interrupted then
						msg := Warning_messages.w_Project_interrupted (project_dir.name)
					end
					create wd.make_default (project_tool.parent, Interface_names.t_Warning, msg)
				end
			elseif Eiffel_project.incomplete_project then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
--				!! mp.do_nothing
--				mp.restore
				
				msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
				create wd.make_default (project_tool.parent, Interface_names.t_Warning, msg)
			elseif Eiffel_project.read_write_error then
				Project_tool.set_title (old_title)
					-- These 2 lines will update effectively the project tool.
--				!! mp.do_nothing
--				mp.restore
				
				msg := Warning_messages.w_Cannot_open_project
				create wd.make_default (project_tool.parent, Interface_names.t_Warning, msg)
			end

			if not Eiffel_project.error_occurred then
				init_project
				title := clone (Interface_names.t_Project)
				title.append (": ")
				project_name := project_dir.name
				if project_name.item (project_name.count) = Directory_separator then
					project_name.head (project_name.count -1)
				end
				title.append (project_name)
				if Eiffel_system.is_precompiled then
					title.append ("  (precompiled)")
				end
				project_tool.set_title (title)
				project_tool.set_initialized
--				project_tool.set_icon_name (Eiffel_system.name)
				project_tool.save_environment
					-- We don't touch the content of the Project tool.
--				project_tool.active_menus (False)
			end

--			mp.restore
		end

	init_project is
			-- Initialize project.
		local
			e_displayer: BENCH_ERROR_DISPLAYER
			g_degree_output: EB_GRAPHICAL_DEGREE_OUTPUT
		do
			create e_displayer.make (Error_window)
			Eiffel_project.set_error_displayer (e_displayer)
			Application.set_interrupt_number (interrupt_every_n_instructions)
			if not graphical_output_disabled then
				create g_degree_output.make (Project_tool.parent_window)
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

--	project_tool: EB_PROJECT_TOOL
--			-- Project tool

feature {NONE} -- Attributes

	callback: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

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
			if last_char = Directory_separator then
				Result := clone (file_name)
				Result.remove (file_name.count)
			else
				Result := file_name	
			end
		end

invariant
	has_project_name_definition: has_project_name implies (project_file_name /= Void)

end -- class EB_OPEN_PROJECT_CMD
