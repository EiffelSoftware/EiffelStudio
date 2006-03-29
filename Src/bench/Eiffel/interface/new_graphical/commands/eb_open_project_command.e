indexing
	description	: "Command to retrieve a stored project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_OPEN_PROJECT_COMMAND

inherit
	EB_COMMAND

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EB_ERROR_MANAGER
		export
			{NONE} all
		end

	EB_GRAPHICAL_ERROR_MANAGER
		export
			{NONE} all
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CONF_REFACTORING

create
	make,
	make_with_parent

feature {NONE} -- Initialization

	make is
			-- Create the command relative to the last focused window
		do
			internal_parent_window := Void
		end

	make_with_parent (a_window: EV_WINDOW) is
			-- Create the command relative to the parent window `a_window'
		require
			a_window_not_void: a_window /= Void
		do
			internal_parent_window := a_window
		ensure
			internal_parent_window_valid: internal_parent_window /= Void
		end

feature -- License managment

	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Execution

	execute_with_file (a_project_file_name: STRING) is
			-- Open the specific project named `a_project_file_name'
		require
			a_project_file_name_valid: a_project_file_name /= Void
		local
			wd: EV_WARNING_DIALOG
			file: RAW_FILE
			ebench_name: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				create file.make (valid_file_name (a_project_file_name))
				if not file.exists or else file.is_directory then
					create wd.make_with_text (Warning_messages.w_file_not_exist (a_project_file_name))
					wd.show_modal_to_window (parent_window)
				else
					if not Eiffel_project.initialized then
						open_project_file (a_project_file_name)
					else
						ebench_name := (create {EIFFEL_ENV}).Estudio_command_name.twin
						ebench_name.append (" ")
						ebench_name.append (a_project_file_name)
						launch_ebench (ebench_name)
					end
				end
			end
		rescue
			add_error_message (Warning_messages.w_Unable_to_retrieve_project)
			display_error_message (parent_window)
			if catch_exception then
				rescued := True
				retry
			end
		end

	execute is
			-- Popup a dialog for the user to choose the project he wants to open,
		local
			fod: EB_FILE_OPEN_DIALOG
			environment_variable: EXECUTION_ENVIRONMENT
			last_directory_opened: STRING
		do
				-- User just asked for an open file dialog,
				-- and we set it on the last opened directory.
			create environment_variable
			create fod.make_with_preference (preferences.dialog_data.last_opened_project_directory_preference)
			last_directory_opened := environment_variable.get (Studio_Directory_List)
			if last_directory_opened /= Void then
				fod.set_start_directory (last_directory_opened.substring (1,last_directory_opened.index_of(';',1) -1 ))
			end
			fod.set_title (Interface_names.t_Select_a_file)
			set_dialog_filters_and_add_all (fod, <<config_files_filter, ace_files_filter, eiffel_project_files_filter>>)
			fod.open_actions.extend (agent file_choice_callback (fod))
			fod.show_modal_to_window (parent_window)
		end

feature {NONE} -- Callbacks

	file_choice_callback (argument: EB_FILE_OPEN_DIALOG) is
			-- This is a callback from the name chooser.
			-- We get the project name and then open the project, if possible
		local
			file_name: STRING
			wd: EV_WARNING_DIALOG
			file: RAW_FILE
		do
				-- This is a callback from the name chooser.
				-- We get the project name and then open the project, if possible
			file_name := argument.file_name
			if file_name.is_empty then
				choose_again := True
				create wd.make_with_text (Warning_messages.w_file_not_exist (file_name))
				wd.show_modal_to_window (parent_window)
			else
				create file.make (valid_file_name (file_name))
				if not file.exists or else file.is_directory then
					choose_again := True
					create wd.make_with_text (Warning_messages.w_file_not_exist (file_name))
					wd.show_modal_to_window (parent_window)
				else
					execute_with_file (file_name)
				end
			end
		end

feature {NONE} -- Project Initialization

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			file_name_non_void: file_name /= Void
		local
			l_ext: STRING
			l_pos: INTEGER
			l_not_processed: BOOLEAN
			l_file_name: FILE_NAME
		do
			workbench.make

			conf_todo_msg ("Handle errors")
				-- Try to extract the extension of the file.
			l_pos := file_name.last_index_of ('.', file_name.count)
			if l_pos > 0 and then l_pos < file_name.count then
				l_ext := file_name.substring (l_pos + 1, file_name.count)
				if l_ext.is_equal (config_extension) then
					lace.set_file_name (file_name)
					lace.load
				elseif l_ext.is_equal (project_extension) then
					lace.convert_project (file_name)
					lace.load
				elseif l_ext.is_equal (ace_file_extension) then
					lace.convert_ace (file_name)
					lace.load
				else
					l_not_processed := True
				end
			else
				l_not_processed := True
			end

			if l_not_processed then
					-- We try to load it as a normal config file.
				lace.set_file_name (file_name)
				lace.load
			end

				--| Retrieve existing project
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (lace.project_path)
			create l_file_name.make_from_string (eiffel_gen_path)
			l_file_name.set_file_name (project_file_name)
			create project_file.make (l_file_name)
			create project_dir.make (eiffel_gen_path, project_file)

			retrieve_project
			lace.recompile
		end

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
			title: STRING
			project_name: STRING
			wd: EV_WARNING_DIALOG
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			l_display_system_info: BOOLEAN
		do
				-- Retrieve the project
			Eiffel_project.make (project_dir)

			if Eiffel_project.retrieval_error then
				if Eiffel_project.manager.is_created then
					Eiffel_project.manager.on_project_close
				end

				if Eiffel_project.is_incompatible then
					if Eiffel_project.ace_file_path /= Void then
							-- Ace file included in the header of the .epr file...we can recompile if needed.
						create cd.make_initialized (
							2, preferences.dialog_data.confirm_convert_project_string,
							Warning_messages.w_Project_incompatible_version (project_dir.name, version_number,
								Eiffel_project.incompatible_version_number),
							Interface_names.l_Discard_convert_project_dialog,
							preferences.preferences
						)
						cd.set_ok_action (agent recompile_project (project_dir.name, Eiffel_project.ace_file_path))
						cd.show_modal_to_window (parent_window)
					else
							-- Ace file NOT included in the header of the .epr file...we can't do much
						msg := Warning_messages.w_Project_incompatible (project_dir.name, version_number,
							Eiffel_project.incompatible_version_number)
						create wd.make_with_text (msg)
						wd.show_modal_to_window (parent_window)
					end
				else
					if Eiffel_project.is_corrupted then
						msg := Warning_messages.w_Project_corrupted (project_dir.name)
					elseif Eiffel_project.retrieval_interrupted then
						msg := Warning_messages.w_Project_interrupted (project_dir.name)
					end
					create wd.make_with_text (msg)
					wd.show_modal_to_window (parent_window)
				end

			elseif Eiffel_project.incomplete_project then
				msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
				create wd.make_with_text (msg)
				wd.show_modal_to_window (parent_window)

			elseif Eiffel_project.read_write_error then
				msg := Warning_messages.w_Cannot_open_project
				create wd.make_with_text (msg)
				wd.show_modal_to_window (parent_window)
			else
					-- There was no error, meaning that retrieval was successful
					-- without a recompilation of the non-compatible project.
					-- Therefore we display the system information.
				l_display_system_info := True
			end

			if not Eiffel_project.error_occurred then
				init_project
				title := Interface_names.l_Loaded_project.twin
				project_name := project_dir.name
				if project_name.item (project_name.count) = Operating_environment.Directory_separator then
					project_name.keep_head (project_name.count -1)
				end
				title.append (project_name)
				if Eiffel_system.is_precompiled then
					title.append ("  (precompiled)")
				end
				window_manager.display_message (title)
				Recent_projects_manager.save_environment

				--| IEK With project session handling this code is no longer needed, remove when fully integrated.
				if l_display_system_info then
						-- We print text in the project_tool text concerning the system
						-- because we were successful retrieving the project without
						-- errors or conversion.
					output_manager.display_system_info
				end
			end
		end

	init_project is
			-- Initialize project.
		do
		end

feature {NONE} -- Project directory access

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory.

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information
			-- about the current project are saved.

	choose_again: BOOLEAN
			-- Do we have to display the project directory dialog box again?

feature {NONE} -- Implementation

	parent_window: EV_WINDOW is
			-- Parent window.
		local
			dev_window: EB_DEVELOPMENT_WINDOW
		do
			if internal_parent_window /= Void then
				Result := internal_parent_window
			else
				dev_window := window_manager.last_focused_development_window
				if dev_window /= Void then
					Result := dev_window.window
				else
					create Result
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	internal_parent_window: EV_WINDOW
			-- Parent window if any, Void if none.

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
				Result := file_name.twin
				Result.remove (file_name.count)
			else
				Result := file_name
			end
		end

	recompile_project (a_directory_name: STRING; an_ace_file_name: STRING) is
			-- Create a new project
		local
			create_project_dialog: EB_CREATE_PROJECT_DIALOG
			dev_window: EB_DEVELOPMENT_WINDOW
		do
				-- Create the project.
			create create_project_dialog.make_with_ace_and_directory_and_flags (
				parent_window, an_ace_file_name, a_directory_name, True, True)
			create_project_dialog.create_project

				-- Compile if needed.
			if create_project_dialog.success and then create_project_dialog.compile_project then
				dev_window := window_manager.last_focused_development_window
				if dev_window /= Void then
					dev_window.Melt_project_cmd.execute
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_OPEN_PROJECT_COMMAND
