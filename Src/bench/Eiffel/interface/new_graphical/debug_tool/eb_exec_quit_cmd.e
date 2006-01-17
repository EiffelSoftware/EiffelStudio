indexing

	description:
		"Command to stop the execution of the debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_QUIT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_DEBUG_TOOLS

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
				False, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if eb_debugger_manager.application_is_executing then
				ask_and_kill
			end
		end

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_kill
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_kill
		end

	name: STRING is "Exec_quit"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Debug_kill
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing `Current' on buttons.
		once
			Result := Pixmaps.Icon_exec_quit
		end

feature {NONE} -- Implementation

	ask_and_kill is
			-- Pop up a discardable confirmation dialog before killing the application.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (2, preferences.dialog_data.confirm_kill_string,
					Interface_names.l_Confirm_kill, Interface_names.l_Do_not_show_again,
					preferences.preferences)
			cd.set_ok_action (agent kill)
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			window_manager.last_focused_window.raise
		end

	kill is
			-- Effectively kill the application.
		require
			valid_application: eb_debugger_manager.application_is_executing
		do
			if eb_debugger_manager.application_is_stopped then
				eb_debugger_manager.Application.kill
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

end -- class EB_EXEC_QUIT_CMD
