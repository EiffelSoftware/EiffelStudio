indexing
	description	: "Command to clear debugging information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class 
	EB_TOGGLE_BREAKPOINTS_TOOL_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item, new_mini_toolbar_item, mini_pixmap,
			tooltext
		end
	
	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

feature -- Access

	description: STRING is
			-- What is printed in the customize dialog.
		do
			Result := Interface_names.e_Bkpt_info
		end

	tooltip: STRING is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING is
			-- Text for toolbar button
		do
			Result := Interface_names.b_Bkpt_info
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
		end

	menu_name: STRING is
			-- Menu entry corresponding tp `Current'.
		do
			Result := Interface_names.m_Bkpt_info
		end

	pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.tool_breakpoints_icon
		end

	mini_pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.tool_breakpoints_icon
		end

	name: STRING is "Bkpt_info"
			-- Name of `Current' to identify it.

feature -- Execution

	execute is
			-- Execute with confirmation dialog.
		local
--			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
--			app_exec: APPLICATION_EXECUTION
		do
--			app_exec := Debugger_manager.application
--			if app_exec.has_breakpoints then
--				create cd.make_initialized (
--					2, preferences.dialog_data.confirm_clear_breakpoints_string,
--					Warning_messages.w_Clear_breakpoints, Interface_names.l_Dont_ask_me_again,
--					preferences.preferences
--				)
--				cd.set_ok_action (agent clear_breakpoints)
--				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
--
--					-- Update output tools
--				debugger_manager.notify_breakpoints_changes
--			end
		end

feature {NONE} -- Implementation

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

end -- class EB_CLEAR_STOP_POINTS_COMMAND
