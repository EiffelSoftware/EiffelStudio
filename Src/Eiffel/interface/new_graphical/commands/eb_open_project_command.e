note
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

	FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make,
	make_with_parent

feature {NONE} -- Initialization

	make
			-- Create the command relative to the last focused window
		do
			internal_parent_window := Void
		end

	make_with_parent (a_window: EV_WINDOW)
			-- Create the command relative to the parent window `a_window'
		require
			a_window_not_void: a_window /= Void
		do
			internal_parent_window := a_window
		ensure
			internal_parent_window_valid: internal_parent_window /= Void
		end

feature -- Execution

	execute_with_file (a_project_file_name: STRING; is_fresh_compilation: BOOLEAN)
			-- Open the specific project named `a_project_file_name'
		require
			a_project_file_name_valid: a_project_file_name /= Void
		local
			file: RAW_FILE
			ebench_name, l_profile: STRING
			l_project_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			if not Eiffel_project.initialized then
				create l_project_loader.make (parent_window)
				l_project_loader.open_project_file (a_project_file_name, Void, Void, is_fresh_compilation)
			else
				create file.make (valid_file_name (a_project_file_name))
				if not file.exists or else file.is_directory then
					prompts.show_error_prompt (warning_messages.w_file_not_exist (a_project_file_name), parent_window, Void)
				else
					ebench_name := "%"" + eiffel_layout.estudio_command_name + "%""
					l_profile := eiffel_layout.command_line_profile_option
					if not l_profile.is_empty then
						ebench_name.append_character (' ')
						ebench_name.append (l_profile)
					end
					ebench_name.append (" -config %"")
					ebench_name.append (a_project_file_name)
					ebench_name.append_character ('"')
					launch_ebench (ebench_name)
				end
			end
		end

	execute
			-- Popup a dialog for the user to choose the project he wants to open,
		local
			l_dialog: EB_OPEN_PROJECT_DIALOG
		do
			create l_dialog.make (parent_window)
			l_dialog.show
		end

feature {NONE} -- Implementation

	parent_window: EV_WINDOW
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

	valid_file_name (file_name: STRING): STRING
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

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_OPEN_PROJECT_COMMAND
