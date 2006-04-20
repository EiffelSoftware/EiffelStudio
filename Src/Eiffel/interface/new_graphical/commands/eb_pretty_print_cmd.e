indexing
	description: "Command that allows the user to have a nicer display for his object value %
				%especially strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRETTY_PRINT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

	EB_CONSTANTS

	EB_SHARED_DEBUG_TOOLS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current' and associate it with `a_tool'.
		do
			create opened_dialogs.make (5)
		end

feature -- Access

	mini_pixmap: EV_PIXMAP is
			-- 8*8 pixmap representing `Current'.
		do
			Result := pixmaps.small_pixmaps.icon_expand_string
		end

	tooltip: STRING is
			-- Tooltip for Current.
		do
			Result := Interface_names.e_Pretty_print
		end

	description: STRING is
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

	menu_name: STRING is
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

feature -- Status report

	associated_window: EV_WINDOW is
			-- Window to which the child dialogs will be modeless to.
		do
			Result := Eb_debugger_manager.debugging_window.window
		end

feature {EB_PRETTY_PRINT_DIALOG} -- Status report

	accepts_stone (st: OBJECT_STONE): BOOLEAN is
			-- Can the user drop `st'?
		local
			dv: DUMP_VALUE
		do
			if st /= Void then
				create dv.make_object (st.object_address, st.dynamic_class)
				Result := dv.has_formatted_output
			end
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
			pop_up_new_dialog
		end

	refresh is
			-- Update the state of all dialogs.
		do
			from
				opened_dialogs.start
			until
				opened_dialogs.after
			loop
				opened_dialogs.item.refresh
				opened_dialogs.forth
			end
		end

	end_debug is
			-- A debug session ended. We free the resources.
		do
			from
			until
				opened_dialogs.is_empty
			loop
				opened_dialogs.start
				opened_dialogs.item.destroy
			end
		end

feature {EB_PRETTY_PRINT_DIALOG} -- Dialog

	remove_dialog (d: EB_PRETTY_PRINT_DIALOG) is
			-- Remove `d' from the list of displayed dialogs.
		require
			is_now_destroyed: d.is_destroyed
		do
			opened_dialogs.start
			opened_dialogs.prune_all (d)
		ensure
			is_no_longer_known: not opened_dialogs.has (d)
		end

feature {NONE} -- Implementation

	on_stone_dropped (st: OBJECT_STONE) is
			-- An object was dropped on the button, display it.
		do
			pop_up_new_dialog
			last_opened_dialog.set_stone (st)
		end

	opened_dialogs: ARRAYED_LIST [EB_PRETTY_PRINT_DIALOG]
			-- All pretty print dialogs that are appear on the screen (linked to `Current').

	pop_up_new_dialog is
			-- Create and display a new pretty print dialog.
		local
			nd: EB_PRETTY_PRINT_DIALOG
		do
			create nd.make (Current)
			opened_dialogs.extend (nd)
			last_opened_dialog := nd
			nd.raise
		ensure
			added_a_dialog: opened_dialogs.count = (old opened_dialogs.count) + 1
		end

	last_opened_dialog: EB_PRETTY_PRINT_DIALOG;
			-- The last dialog that `Current' opened.

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
