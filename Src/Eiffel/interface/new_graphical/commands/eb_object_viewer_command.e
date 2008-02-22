indexing
	description: "Command that allows the user to have a nicer display for his object value %
				%especially strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_VIEWER_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			mini_pixel_buffer,
			new_mini_toolbar_item,
			new_mini_sd_toolbar_item
		end

	EB_CONSTANTS

	EV_SHARED_APPLICATION

	EB_SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current' and associate it with `a_tool'.
		do
			create opened_viewers.make (3)
		end

feature -- Access

	mini_pixmap: EV_PIXMAP is
			-- 8*8 pixmap representing `Current'.
		do
			Result := pixmaps.mini_pixmaps.debugger_expand_info_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- 8*8 pixel buffer representing `Current'.
		do
			Result := pixmaps.mini_pixmaps.debugger_expand_info_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Pretty_print
		end

	description: STRING_GENERAL is
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Pretty_print
		end

	name: STRING is
			-- Tooltip for Current.
		do
			Result := "Pretty_print"
		end

	pixmap: EV_PIXMAP is
			-- No big pixmap is necessary.
		do

		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			-- Currently there is no pixel buffer for this command.
		end

	menu_name: STRING_GENERAL is
			-- Menu name for `Current'.
		do
			Result := Interface_names.m_Pretty_print
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent on_stone_dropped)
			Result.drop_actions.set_veto_pebble_function (agent accepts_stone)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent on_stone_dropped)
			Result.drop_actions.set_veto_pebble_function (agent accepts_stone)
		end

feature -- Status report

	associated_window: EV_WINDOW is
			-- Window to which the child dialogs will be modeless to.
		do
			Result := Eb_debugger_manager.debugging_window.window
		end

feature -- Status report

	accepts_stone (st: OBJECT_STONE): BOOLEAN is
			-- Can the user drop `st'?
		do
			Result := st /= Void
		end

feature -- Basic operations

	set_stone (st: OBJECT_STONE) is
		do
			if accepts_stone (st) then
				on_stone_dropped (st)
			end
		end

	execute is
			-- Launch `Current' as a command.
			-- Pop up a new empty dialog.
		do
			open_new_dialog
		end

	refresh is
			-- Update the state of all dialogs.
		do
			from
				opened_viewers.start
			until
				opened_viewers.after
			loop
				opened_viewers.item.refresh
				opened_viewers.forth
			end
		end

	end_debug is
			-- A debug session ended. We free the resources.
		do
			from
			until
				opened_viewers.is_empty
			loop
				opened_viewers.start
				opened_viewers.item.close
			end
		end

feature {ES_OBJECT_VIEWER_TOOL_PANEL, EB_OBJECT_VIEWERS_DIALOG} -- Dialog

	remove_entry (e: like last_opened_viewer) is
			-- Remove `e' from the list of displayed viewers.
		require
			is_now_destroyed: e.is_destroyed
		do
			opened_viewers.prune_all (e)
		ensure
			is_no_longer_known: not opened_viewers.has (e)
		end

feature {EB_CONTEXT_MENU_FACTORY} -- Implementation

	on_stone_dropped (st: OBJECT_STONE) is
			-- An object was dropped on the button, display it.
		do
			open_new_dialog
			last_opened_viewer.set_stone (st)
		end

feature {NONE} -- Implementation

	opened_viewers: ARRAYED_LIST [EB_OBJECT_VIEWERS_I]
			-- All expanded viewers linked to `Current'.		

	open_new_dialog is
			-- Create and display a new expanded viewer dialog
		local
			dlg: EB_OBJECT_VIEWERS_DIALOG
			w: EV_WINDOW
		do
			create dlg.make_with_command (Current)
			dlg.is_modal := False
			opened_viewers.extend (dlg)
			last_opened_viewer := dlg

			w := associated_window
			if w /= Void then
				dlg.show (w)
			else
				dlg.show_on_active_window
			end
		ensure
			added_a_dialog: opened_viewers.count = (old opened_viewers.count) + 1
		end

	last_opened_viewer: EB_OBJECT_VIEWERS_I;
			-- The last viewers that `Current' opened.

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

end -- class EB_PRETTY_PRINT_CMD

