indexing
	description: "Command to toggle breakpoint slot state."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DBG_TOGGLE_BREAKPOINT_SLOT_STATE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
--		redefine
--			tooltext,
--			set_select
--		end

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			init_accelerator
		end

	init_accelerator is
			-- Initialize accelerator
		local
--			l_preference: EB_SHARED_PREFERENCES
--			l_shortcut: SHORTCUT_PREFERENCE
			l_shortcut: EB_FIXED_SHORTCUT
		do
--			l_shortcut := l_preference.preferences.editor_data.shortcuts.item ("toggle_breakpoint_slot")
			create l_shortcut.make (name,  create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f9), False, False, False)

			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
		end

feature -- Execution

	execute is
			-- Pause the execution.
		local
			frt: ES_FEATURES_RELATION_TOOL_PANEL
			ff: EB_ROUTINE_FLAT_FORMATTER
		do
			frt := eb_debugger_manager.debugging_window.tools.features_relation_tool
			if frt.flat_formatter.widget.is_displayed then
			end
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := once "ToggleBkptSlotState"
		end

	name: STRING = "Toggle_breakpoint_slot_state_cmd"
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			Result := once "Toggle breakpoint slot"
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
--			Result := pixmaps.icon_pixmaps.debugger_environment_without_breakpoints_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
--			Result := pixmaps.icon_pixmaps.debugger_environment_without_breakpoints_icon_buffer		
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

end
