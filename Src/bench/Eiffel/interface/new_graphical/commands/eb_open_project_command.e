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

feature -- Execution

	execute_with_file (a_project_file_name: STRING; is_fresh_compilation: BOOLEAN) is
			-- Open the specific project named `a_project_file_name'
		require
			a_project_file_name_valid: a_project_file_name /= Void
		local
			wd: EV_WARNING_DIALOG
			file: RAW_FILE
			ebench_name: STRING
			l_project_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			if not Eiffel_project.initialized then
				create l_project_loader.make (parent_window)
				l_project_loader.open_project_file (a_project_file_name, Void, Void, is_fresh_compilation)
			else
				create file.make (valid_file_name (a_project_file_name))
				if not file.exists or else file.is_directory then
					create wd.make_with_text (warning_messages.w_file_not_exist (a_project_file_name))
					wd.show_modal_to_window (parent_window)
				else
					ebench_name := (create {EIFFEL_ENV}).Estudio_command_name.twin
					ebench_name.append (" ")
					ebench_name.append (a_project_file_name)
					launch_ebench (ebench_name)
				end
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
		do
				-- We get the project name and then open the project, if possible
			execute_with_file (argument.file_name, False)
		end

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
