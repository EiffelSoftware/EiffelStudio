note
	description: "Command to retrieve a stored project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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

	execute_with_file_and_target (a_project_file_name: PATH; target: READABLE_STRING_GENERAL; is_fresh_compilation: BOOLEAN)
			-- Open the specific project named `a_project_file_name' with the given `target' (if any)
		require
			a_project_file_name_valid: a_project_file_name /= Void
		local
			file: RAW_FILE
			l_project_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			if not Eiffel_project.initialized then
				create l_project_loader.make (parent_window)
				l_project_loader.open_project_file (a_project_file_name, target.as_string_8, Void, is_fresh_compilation, Void)
			else
				create file.make_with_path (a_project_file_name)
				if not file.exists or else file.is_directory then
					prompts.show_error_prompt (warning_messages.w_file_not_exist (a_project_file_name.name), parent_window, Void)
				else
					launch_ebench (eiffel_layout.studio_command_line (a_project_file_name, target, Void, True, is_fresh_compilation))
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

invariant

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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

end
