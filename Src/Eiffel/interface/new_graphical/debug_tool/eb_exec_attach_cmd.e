note

	description:
		"Command to attach the debuggee from the debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_ATTACH_CMD

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Formatting

	execute
			-- Pause the execution.
		do
			if attached debugger_manager as dbg and then not dbg.application_is_executing then
				attach_debuggee
			end
		end

feature -- Command property

	name: STRING = "Exec_attach"
			-- Name of the command.

feature {NONE} -- Attributes

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_attach
		end

	tooltext: STRING_GENERAL
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_attach
		end

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Debug_attach
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debug_attach_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_attach_icon_buffer
		end

feature {NONE} -- Implementation

--	ask_and_attach
--			-- Pop up a discardable confirmation dialog before detaching the debuggee.
--		local
--			dlg: ES_QUESTION_PROMPT
--			s: ES_SHARED_PROMPT_PROVIDER
--		do
------			create dlg.make ("Port?", a_buttons: [like buttons] DS_SET [INTEGER_32], a_default: [like default_button] INTEGER_32, a_default_confirm: [like default_confirm_button] INTEGER_32, a_default_cancel: [like default_cancel_button] INTEGER_32)
----			create l_confirm.make_standard (interface_names.l_dbg_confirm_detach, "", create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.dbg_confirm_detach_preference, True))
----			l_confirm.set_title (interface_names.t_debugger_question)
----			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent attach_debuggee)
----			l_confirm.show_on_active_window
--			if attached window_manager.last_focused_window as l_window then
--				create s
--				s.prompts.show_info_prompt ("Not yet available", l_window.window, Void)
--			end
--		end

	attach_debuggee
			-- Effectively attach the application.
		local
			dlg: ES_EXEC_ATTACH_DIALOG
			p: INTEGER
		do
			if attached debugger_manager as dbg and then not dbg.application_is_executing then
				if dbg.is_classic_project then
					create dlg.make
					dlg.show_on_active_window
					if dlg.attaching_confirmed then
						p := dlg.port_field.value
						if p >= 1000 then
							dbg.controller.attach_application (p)
						end
					end
				else
					prompts.show_warning_prompt ("Attaching application supported only for classic Eiffel project", Void, Void)
				end
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
