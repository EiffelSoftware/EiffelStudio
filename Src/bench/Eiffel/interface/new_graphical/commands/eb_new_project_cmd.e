indexing
	description: "Command to create a new project."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEW_PROJECT_CMD

inherit
	PROJECT_CONTEXT

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	NEW_EB_CONSTANTS

	EB_PROJECT_TOOL_DATA

	EB_DEBUG_TOOL_DATA

	EB_TOOL_COMMAND
		rename
--			tool as project_tool
		redefine
--			license_checked,
--			project_tool
		end

	EB_SHARED_INTERFACE_TOOLS

	BENCH_COMMAND_EXECUTOR
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

	execute_warner_ok (arg: EV_ARGUMENT1 [EV_DIRECTORY_DIALOG]; data: EV_EVENT_DATA) is
		do
--			if choose_again then
--				choose_again := False
--				if arg /= Void then
--					arg.first.show
--				end
--			else
				init_project
--			end
		end

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

	execute (argument: EV_ARGUMENT1 [EV_DIRECTORY_DIALOG]; data: EV_EVENT_DATA) is
			-- Popup a "select directory" dialog,
			-- OR gets callback information from the dialog, then create the project if possible
		local
			dd: EV_DIRECTORY_DIALOG
			wd: EV_WARNING_DIALOG
			arg: EV_ARGUMENT1 [EV_DIRECTORY_DIALOG]
			dir_name, ebench_name: STRING
			last_char: CHARACTER
		do
			if argument = Void then
					-- We are asked for a "choose directory" dialog
				create dd.make (project_tool.parent)
				dd.set_title (Interface_names.t_Select_a_directory)
				create arg.make (dd)
				dd.add_ok_command (Current, arg)
				dd.show
			else
				dir_name := argument.first.directory
				if dir_name.empty then
					choose_again := True
					create wd.make_default (project_tool.parent, Interface_names.t_Warning,
						Warning_messages.w_directory_not_exist (dir_name))
				else
						--| Since Vision is returning a directory name with
						--| a directory separator, we need to be sure that we
						--| will remove it
					if dir_name.count > 1 then
						last_char := dir_name.item (dir_name.count)
						if last_char = Directory_separator then
							dir_name.remove (dir_name.count)
						end
					end
					if not project_tool.initialized then
						create_project (dir_name)
					else
						ebench_name := ebench_command_name
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
			wd: EV_WARNING_DIALOG
			qd: EV_QUESTION_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			create project_dir.make (dir, Void)
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir)

			if not project_dir.has_base_full_access then
				msg := Warning_messages.w_Cannot_create_project_directory (project_dir.name)	
				choose_again := True
				create wd.make_default (Project_tool.parent, Interface_names.t_Warning, msg)
			elseif project_dir.eifgen_exists then
				msg := Warning_messages.w_Project_exists (project_dir.name)
				create qd.make_with_text (Project_tool.parent, Interface_names.t_Warning, msg)
--				create qd.make (Project_tool.parent)
--				qd.set_message (msg)
				create cmd.make (~execute_warner_ok)
				qd.show_yes_no_buttons
				qd.add_yes_command (cmd, Void)
				qd.show
			else
				init_project
			end
		end

	init_project is
			-- Initialize project.
		local
			e_displayer: BENCH_ERROR_DISPLAYER
			g_degree_output: EB_GRAPHICAL_DEGREE_OUTPUT
			msg: STRING
		do
			Eiffel_project.make_new (project_dir)
			msg := clone (Interface_names.t_New_project)
			msg.append (": ")
			msg.append (project_dir.name)
			project_tool.set_title (msg)
			project_tool.set_initialized

			create e_displayer.make (Error_window)
			Eiffel_project.set_error_displayer (e_displayer)
			Application.set_interrupt_number (Debug_resources.interrupt_every_n_instructions.actual_value)
			if not Project_resources.graphical_output_disabled.actual_value then
				create g_degree_output.make (Project_tool.parent_window)
				Project_tool.set_progress_dialog (g_degree_output)
			end
				-- We erase the content of the Project window
			project_tool.active_menus (True)
		end

feature -- Tool

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory

	choose_again: BOOLEAN
			-- We need to choose again the file

feature {NONE} -- Attributes

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_New_project
--		end
 
--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_New_project
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_New_project
--		end

end -- class EB_NEW_PROJECT_CMD
