note

	description:
		"Command to detach the debuggee from the debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_DETACH_CMD

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			enable_sensitive
		end

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			--l_shortcut: SHORTCUT_PREFERENCE
		do
			--l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("stop_application")
			--create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			--set_referred_shortcut (l_shortcut)
			--accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute
			-- Pause the execution.
		do
			if attached debugger_manager as dbg and then dbg.application_is_executing then
				ask_and_detach
			end
		end

feature -- Element change

	enable_sensitive
		do
			if debugger_manager.is_classic_project then
				Precursor
			else
				prompts.show_warning_prompt ("Detaching application is not yet supported for dotnet Eiffel project", Void, Void)
			end
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_detach
		end

	tooltext: STRING_GENERAL
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_detach
		end

	name: STRING = "Exec_detach"
			-- Name of the command.

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Debug_detach
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debug_detach_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_detach_icon_buffer
		end

feature {NONE} -- Implementation

	ask_and_detach
			-- Pop up a discardable confirmation dialog before detaching the debuggee.
		local
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
		do
			create l_confirm.make_standard (interface_names.l_dbg_confirm_detach, "", create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.dbg_confirm_detach_preference, True))
			l_confirm.set_title (interface_names.t_debugger_question)
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent detach)
			l_confirm.show_on_active_window
			if attached window_manager.last_focused_window as l_window then
				l_window.show
			end
		end

	detach
			-- Effectively detach the application.
		do
			if attached debugger_manager as dbg and then dbg.application_is_executing then
				dbg.application.detach
			end
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end -- class EB_EXEC_QUIT_CMD
