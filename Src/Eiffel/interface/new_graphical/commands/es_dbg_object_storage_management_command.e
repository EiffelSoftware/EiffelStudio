note
	description: "Command that allows the user to save/load remote object from the debuggee"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DBG_OBJECT_STORAGE_MANAGEMENT_COMMAND

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			mini_pixmap,
			mini_pixel_buffer,
			new_mini_sd_toolbar_item
		end

	EB_CONSTANTS

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current' and associate it with `a_tool'.
		do
		end

feature -- Status

	load_operation_enabled: BOOLEAN
			-- Is load operation enabled ?
		do
			Result := active_watch_tool /= Void
		end

feature -- Access

	mini_pixmap: EV_PIXMAP
			-- 8*8 pixmap representing `Current'.
		do
			Result := pixmaps.mini_pixmaps.execution_object_storage_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- 8*8 pixel buffer representing `Current'.
		do
			Result := pixmaps.mini_pixmaps.execution_object_storage_icon_buffer
		end

	tooltext: STRING_GENERAL
			-- Tooltip for Current.
		do
			Result := Interface_names.b_Control_debuggee_object_storage
		end

	tooltip: STRING_GENERAL
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Control_debuggee_object_storage
		end

	description: STRING_GENERAL
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Control_debuggee_object_storage
		end

	name: STRING_GENERAL
			-- Tooltip for Current.
		do
			Result := "RemoteObjectStorage"
		end

	pixmap: EV_PIXMAP
			-- No big pixmap is necessary.
		do
			Result := pixmaps.icon_pixmaps.execution_object_storage_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.execution_object_storage_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Menu name for `Current'.
		do
			Result := Interface_names.m_Save_debuggee_object
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent on_stone_dropped)
			Result.drop_actions.set_veto_pebble_function (agent accepts_stone)
		end

	new_mini_sd_toolbar_item_for_watch_tool (w: like active_watch_tool): like new_mini_sd_toolbar_item
			-- Create a new mini toolbar button for this command.
		do
			Result := new_mini_sd_toolbar_item
			if w /= Void then
				Result.select_actions.put_front (agent set_active_watch_tool (w))
				Result.select_actions.extend (agent set_active_watch_tool (Void))
			end
		end

feature -- Associated tool

	set_active_watch_tool (w: like active_watch_tool)
			-- Set `w' to `active_watch_tool'
		do
			active_watch_tool := w
		end

	active_watch_tool: ES_WATCH_TOOL_PANEL
			-- Active watch tool.

feature -- Status report

	associated_window: EV_WINDOW
			-- Window to which the child dialogs will be modeless to.
		do
			if attached eb_debugger_manager as dbg then
				if attached dbg.debugging_window as dw then
					Result := dw.window
				end
			end
		end

feature -- Status report

	accepts_stone (a_stone: ANY): BOOLEAN
			-- Can the user drop `st'?
		do
			Result := attached {OBJECT_STONE} a_stone as st
		end

feature -- Basic operations

	set_stone (st: OBJECT_STONE)
		do
			if accepts_stone (st) then
				on_stone_dropped (st)
			end
		end

	execute
			-- Launch `Current' as a command.
			-- Pop up a new empty dialog.
		local
			dlg: ES_DBG_OBJECT_STORAGE_MANAGEMENT_DIALOG
		do
			if
				attached debugger_manager as dbg and then
				dbg.safe_application_is_stopped and then
				load_operation_enabled
			then
				create dlg.make
				dlg.enable_load_operation
				dlg.set_object_stone (Void)
				dlg.set_is_modal (True)
				dlg.show_on_active_window

				if active_watch_tool /= Void and attached dlg.object_value as dv then
					active_watch_tool.add_dump_value (dv)
				end
			end
		end

	refresh
			-- Update the state of all dialogs.
		do

		end

	end_debug
			-- A debug session ended. We free the resources.
		do

		end

feature {EB_CONTEXT_MENU_FACTORY} -- Implementation

	on_stone_dropped (st: OBJECT_STONE)
			-- An object was dropped on the button, display it.
		local
			dlg: ES_DBG_OBJECT_STORAGE_MANAGEMENT_DIALOG
		do
			if attached debugger_manager as dbg and then dbg.safe_application_is_stopped then
				create dlg.make
				dlg.set_object_stone (st)
--				dlg.enable_load_operation --| do not enable load operation
				dlg.set_is_modal (True)
				dlg.show_on_active_window
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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


end -- class ES_DBG_OBJECT_STORAGE_MANAGEMENT_COMMAND

