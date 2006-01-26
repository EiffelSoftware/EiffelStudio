indexing

	description:
		"Command to manage exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXCEPTION_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	EB_SHARED_DEBUG_TOOLS

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		local
			dlg: EV_DIALOG
			vb: EV_VERTICAL_BOX
			bt: EV_BUTTON
			lb: EV_LABEL
			dialog: ES_EXCEPTION_HANDLER_DIALOG
			app_exec: APPLICATION_EXECUTION
		do
			app_exec := Eb_debugger_manager.application
			if app_exec.is_dotnet then
				create dialog
				dialog.set_handler (app_exec.exceptions_handler)
				dlg := dialog
			else
				create dlg
				dlg.set_title ("Exceptions handler")
				dlg.set_icon_pixmap (pixmaps.icon_dialog_window)

				create vb

				vb.set_padding_width (5)
				vb.set_border_width (5)
				create lb.make_with_text ("Not yet available for classic system")
				vb.extend (lb)
					--| Close
				create bt.make_with_text_and_action ("Close", agent dlg.destroy)
				dlg.set_default_cancel_button (bt)
				vb.extend (bt)
				dlg.extend (vb)
			end
			dlg.show_relative_to_window (window_manager.last_focused_window.window)
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
--			Result := Interface_names.e_Exec_stop
			Result := "Exception handling"
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := "Exceptions"
		end

	name: STRING is "Exception_handler"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
--			Result := Interface_names.m_Debug_interrupt_new
			Result := "Exception handling"
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			Result := Pixmaps.icon_debugger_exception
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

end
