indexing
	description: "Objects that represent a clipboard command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_XML_UTILITIES
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
			set_tooltip ("Clipboard")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_clipboard)
			set_name ("Clipboard")
			set_menu_name ("Clipboard")
			disable_sensitive
			add_agent (agent execute)
			drop_agent := agent drop_object
			pebble_function := agent pick_object
			components.clipboard.content_change_actions.extend (agent contents_changed)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			object_stone: GB_OBJECT_STONE
		do
			object_stone ?= components.system_status.pick_and_drop_pebble
			Result := (not components.clipboard.is_empty) or (object_stone /= Void)
		end

feature -- Basic operations

	clipboard_dialog_up_to_date: BOOLEAN
		-- Are the contents of `clipboard_dialog' up to date with the clipboard?
		-- If not, then they must be rebuilt.

	contents_changed is
			-- Respond to the changing of the clipboard contents.
		do
			clipboard_dialog_up_to_date := False
			if components.tools.clipboard_dialog.is_show_requested then
					-- Only rebuild contents of `clipboard_dialog' if it is shown,
					-- otherwise wait until it is displayed.
				update_clipboard_dialog
			end
		end

	update_clipboard_dialog is
			-- Update `clipboard_dialog' with a representation of
			-- the clipboard contents.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			widget: EV_WIDGET
			menu_bar: EV_MENU_BAR
			all_children: ARRAYED_LIST [GB_OBJECT]
			locked_in_here: BOOLEAN
		do
			components.system_status.block
			if components.tools.clipboard_dialog.is_displayed then
					-- If the clipboard is displayed, locking it will reduce unecessary flicker
					-- while the contents are rebuilt.
				components.tools.clipboard_dialog.lock_update
				locked_in_here := True
			end
			if last_clipboard_object /= Void then
					-- Destroy the previous clipboard objects if any.
				create all_children.make (20)
				last_clipboard_object.all_children_recursive (all_children)
				all_children.extend (last_clipboard_object)
				from
					all_children.start
				until
					all_children.off
				loop
					all_children.item.destroy
					all_children.forth
				end
			end

				-- Store the new object into `last_clipboard_object' for future deletion.
			last_clipboard_object := components.clipboard.internal_object
			window_object ?= last_clipboard_object
			if window_object /= Void then
				widget := window_object.object.item
				window_object.object.wipe_out
				insert_into_window (widget, components.tools.clipboard_dialog)
				menu_bar := window_object.object.menu_bar
				if menu_bar /= Void then
					window_object.object.remove_menu_bar
					insert_into_window (menu_bar, components.tools.clipboard_dialog)
				end
			else
				insert_into_window (last_clipboard_object.object, components.tools.clipboard_dialog)
			end

				-- Flag `clipboard_dialog' as up to date.
			clipboard_dialog_up_to_date := True
			if locked_in_here then
				components.tools.clipboard_dialog.unlock_update
			end
			components.system_status.resume
		end

	execute is
			-- Execute `Current'.
		do
			if not components.tools.clipboard_dialog.is_show_requested then
				if not clipboard_dialog_up_to_date then
					update_clipboard_dialog
				end
				components.tools.clipboard_dialog.set_size (components.tools.clipboard_dialog.minimum_width, components.tools.clipboard_dialog.minimum_height)
				components.tools.clipboard_dialog.show_relative_to_window (components.tools.main_window)
			end

			if components.system_status.is_in_debug_mode then
				show_element (components.clipboard.contents_cell.item, components.tools.main_window)
			end
		end

	drop_object (object_stone: GB_OBJECT_STONE) is
			-- Place representation of `an_object' within clipboard.
		require
			object_stone_not_void: object_stone /= Void
		do
			components.system_status.block
			components.clipboard.set_object (object_stone.object)
			components.system_status.resume
		end

	pick_object: GB_CLIPBOARD_OBJECT_STONE is
				-- Execute `Current'.
			require
				clipboard_not_empty: not components.clipboard.is_empty
			do
				Result := components.clipboard.object_stone
			end

	last_clipboard_object: GB_OBJECT;
		-- Last clipboard object built into the `clipboard_dialog'.

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


end -- class GB_CLIPBOARD_COMMAND
