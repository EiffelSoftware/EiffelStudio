note

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

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_manager: like debugger_manager)
			-- Initialize `Current'.
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			debugger_manager := a_manager
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("stop_application")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute
			-- Pause the execution.
		do
			if debugger_manager.application_is_executing then
				ask_and_kill
			end
		end

feature {NONE} -- Attributes

	debugger_manager: DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_kill
		end

	tooltext: STRING_GENERAL
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_kill
		end

	name: STRING = "Exec_quit"
			-- Name of the command.

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Debug_kill
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debug_stop_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_stop_icon_buffer
		end

feature {NONE} -- Implementation

	ask_and_kill
			-- Pop up a discardable confirmation dialog before killing the application.
		local
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
			l_window: EB_WINDOW
		do
			create l_confirm.make_standard (interface_names.l_confirm_kill, "", preferences.dialog_data.confirm_kill_string)
			l_confirm.set_title (interface_names.t_debugger_question)
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent kill)
			l_confirm.show_on_active_window
			l_window := window_manager.last_focused_window
			if l_window /= Void then
				l_window.show
			end
		end

	kill
			-- Effectively kill the application.
		require
			valid_application: debugger_manager.application_is_executing
		do
			if debugger_manager.application_is_executing then
				debugger_manager.application.kill
			end
		end

note
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

end -- class EB_EXEC_QUIT_CMD
