indexing
	description: "Command to create a new project."
	date: "$Date$"
	revision: "$Revision$"

class NEW_PROJECT 

inherit
	PROJECT_CONTEXT

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PIXMAP_COMMAND
		rename
			init as make,
			tool as project_tool
		redefine
			license_checked,
			project_tool
		end

	WARNER_CALLBACKS

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		end

creation
	make, make_from_ebench

feature -- Initialization

	make_from_ebench (a_tool: like project_tool; path_name: STRING) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		do
			make (a_tool)
			create_project (path_name)
		end

feature -- Callbacks

	execute_warner_help is
		do
		end

	execute_warner_ok (argument: ANY) is
		do
			if choose_again then
				choose_again := False
					-- `last_name_chooser' can be Void when creating a project
					-- from another EiffelBench session because no chooser has
					-- been created yet.
				if last_name_chooser /= Void then
					last_name_chooser.set_window (Project_tool)
					last_name_chooser.call (Current)
				end
			else
				init_project
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
			new_name_chooser: NAME_CHOOSER_W
			dir_name, ebench_name: STRING
			last_char: CHARACTER
		do
			if not project_tool.initialized then
				if argument = project_tool then
					if last_name_chooser = Void then
						new_name_chooser := name_chooser (project_tool)
					end
					last_name_chooser.set_directory_selection
					last_name_chooser.hide_file_selection_list
					last_name_chooser.hide_file_selection_label
					last_name_chooser.set_title (Interface_names.t_Select_a_directory)

					last_name_chooser.set_window (Project_tool);
					last_name_chooser.call (Current)
				else
					dir_name := clone (last_name_chooser.selected_file)
					if dir_name.is_empty then
						choose_again := True
						warner (Project_tool).custom_call (Current,
							Warning_messages.w_directory_not_exist (dir_name),
							Interface_names.b_Ok, Void, Void)
					else
							--| Since Vision is returning a directory name with
							--| a directory separator, we need to be sure that we
							--| will remove it
						if dir_name.count > 1 then
							last_char := dir_name.item (dir_name.count)
							if last_char = Operating_environment.Directory_separator then
								dir_name.remove (dir_name.count)
							end
						end
						create_project (dir_name)
					end
				end
			else
					-- A Project has been opened, we need to open a new one
				if argument = project_tool then
					if last_name_chooser = Void then
						new_name_chooser := name_chooser (project_tool)
					end
					last_name_chooser.set_directory_selection
					last_name_chooser.hide_file_selection_list
					last_name_chooser.hide_file_selection_label
					last_name_chooser.set_title (Interface_names.t_Select_a_directory)

					last_name_chooser.set_window (Project_tool);
					last_name_chooser.call (Current)
				else
					dir_name := clone (last_name_chooser.selected_file)
					if dir_name.is_empty then
						choose_again := True
						warner (Project_tool).custom_call (Current,
							Warning_messages.w_directory_not_exist (dir_name),
							Interface_names.b_Ok, Void, Void)
					else
							--| Since Vision is returning a directory name with
							--| a directory separator, we need to be sure that we
							--| will remove it
						if dir_name.count > 1 then
							last_char := dir_name.item (dir_name.count)
							if last_char = Operating_environment.Directory_separator then
								dir_name.remove (dir_name.count)
							end
						end
						ebench_name := clone ((create {EIFFEL_ENV}).Estudio_command_name)
						ebench_name.append (" -create ")
						ebench_name.append (dir_name)
						launch_ebench (ebench_name)
					end
				end

			end
		end

feature -- Project initialization

	create_project (dir: STRING) is
		local
			msg: STRING
		do
			!! project_dir.make (dir, Void);
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir)

			if not project_dir.has_base_full_access then
				msg := Warning_messages.w_Cannot_create_project_directory (project_dir.name)	
				choose_again := True
				warner (Project_tool).custom_call (Current, msg ,
					Interface_names.b_Ok, Void, Void)
			elseif project_dir.eifgen_exists then
				msg := Warning_messages.w_Project_exists (project_dir.name)
				warner (Project_tool).custom_call (Current, msg ,
					Interface_names.b_Ok, Interface_names.b_Cancel, Void)
			else
				init_project
			end
		end

	init_project is
			-- Initialize project.
		local
			e_displayer: BENCH_ERROR_DISPLAYER
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
			msg: STRING
			retried: BOOLEAN
		do
			if not retried then
				Eiffel_project.make_new (project_dir, True, Void, Void)
				msg := clone (Interface_names.t_New_project)
				msg.append (": ")
				msg.append (project_dir.name)
				project_tool.set_title (msg)
				project_tool.set_initialized
	
				!! e_displayer.make (Error_window);
				Eiffel_project.set_error_displayer (e_displayer);
				Application.set_interrupt_number (Project_resources.interrupt_every_n_instructions.actual_value);
				if not Project_resources.graphical_output_disabled.actual_value then
					!! g_degree_output
					Project_tool.set_progress_dialog (g_degree_output)
				end
					-- We erase the content of the Project window
				Project_tool.active_menus (True)
			else
				msg := Warning_messages.w_Project_could_not_deleted (project_dir.name)
				choose_again := True
				warner (Project_tool).custom_call (Current, msg ,
					Interface_names.b_Ok, Void, Void)
			end
		rescue
			retried := True
			retry
		end;

feature -- Tool

	project_tool: PROJECT_W
			-- Project tool window

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory

	choose_again: BOOLEAN
			-- Do we need to choose again a file

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_New_project
		end
 
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_project
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_New_project
		end

end -- class NEW_PROJECT
