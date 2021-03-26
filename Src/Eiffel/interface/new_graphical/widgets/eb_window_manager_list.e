note
	description	: "List representing all opened windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WINDOW_MANAGER_LIST

inherit
	EV_LIST

	EB_WINDOW_MANAGER_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_item_added, on_item_removed, on_item_changed
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_window_manager: EB_WINDOW_MANAGER)
			-- Initialization: build the list.
		do
			window_manager := a_window_manager
			window_manager.add_observer (Current)

				-- Build the list.
			default_create
			build_list

				-- Add actions
			key_press_actions.extend (agent key_action)
			drop_actions.extend (agent drop_class (?))

			set_minimum_height (80)
		end

feature -- Hole processing

	drop_class (a_stone: CLASSI_STONE)
			-- Process dropped stone `a_stone'.
			-- This function exists to filter CLASS_STONEs
		do
			drop_stone (a_stone)
		end

	drop_feature (a_stone: FEATURE_STONE)
			-- Process dropped stone `a_stone'.
			-- This function exists to filter FEATURE_STONEs
		do
			drop_stone (a_stone)
		end

feature {NONE} -- Initialization Implementation

	build_list
			-- Build the list.
		local
			list_item: EV_LIST_ITEM
			an_item: EB_WINDOW
			managed_windows: ARRAYED_LIST [EB_WINDOW]
			window_pixmap: EV_PIXMAP
		do
			managed_windows := window_manager.managed_windows

			from
				managed_windows.start
			until
				managed_windows.after
			loop
				an_item := managed_windows.item
				window_pixmap := an_item.pixmap

					-- Build the list item and add it to the list.
				create list_item
				list_item.set_data (an_item)
				list_item.set_text (an_item.title)
				list_item.set_pebble (an_item)
				list_item.set_configurable_target_menu_mode
				list_item.set_configurable_target_menu_handler (agent context_menu_handler)
				list_item.pointer_double_press_actions.extend (agent button_action (?, ?, ?, ?, ?, ?, ?, ?, list_item))
				if window_pixmap /= Void then
					list_item.set_pixmap (window_pixmap)
				end
				extend (list_item)

					-- prepare next iteration
				managed_windows.forth
			end
		end

feature -- Observer pattern

	on_item_added (an_item: EB_WINDOW)
			-- `an_item' has just been added
		local
			list_item: EV_LIST_ITEM
			window_pixmap: EV_PIXMAP
		do
				-- Create a new entry for `an_item' in the list.
			create list_item
			list_item.set_text (an_item.title)
			window_pixmap := an_item.pixmap
			if window_pixmap /= Void then
				list_item.set_pixmap (window_pixmap)
			end
			list_item.set_data (an_item)
			extend (list_item)
			list_item.set_pebble (an_item)
			list_item.set_configurable_target_menu_mode
			list_item.set_configurable_target_menu_handler (agent context_menu_handler)
			list_item.pointer_double_press_actions.extend (agent button_action (?, ?, ?, ?, ?, ?, ?, ?, list_item))
		end

	on_item_removed (an_item: EB_WINDOW)
			-- `an_item' has just been removed.
		do
				-- Remove the list item that match `an_item' from the list.
			if attached {EV_LIST_ITEM} retrieve_item_by_data (an_item, True) as list_item_to_remove then
				prune (list_item_to_remove)
			end
		end

	on_item_changed (an_item: EB_WINDOW)
			-- `an_item' has just changed.
		do
				-- Remove the list item that match `an_item' from the list.
			if attached {EV_LIST_ITEM} retrieve_item_by_data (an_item, True) as list_item_to_change then
				list_item_to_change.set_text (an_item.title)
			end
		end

feature {NONE} -- Recycle

	internal_recycle
			-- To be called when the object is no more used.
		do
			window_manager.remove_observer (Current)
			wipe_out
			destroy
		end

feature {NONE} -- Implementation

	drop_stone (a_stone: STONE)
			-- Process dropped stone `a_stone': Create a new development window and
			-- set it up with `a_stone'.
		do
			New_development_window_cmd.execute_with_stone (a_stone)
		end

	button_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
					a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
					a_screen_x: INTEGER; a_screen_y: INTEGER; a_item: EV_LIST_ITEM)
			-- Raise Development window corresponding to selected item.
		do
			a_item.enable_select
			raise_selected
		end

	key_action (k: EV_KEY)
			-- If `k' is `Enter' then raise the selected window.
		do
			if k.code = {EV_KEY_CONSTANTS}.Key_enter then
				raise_selected
			end
		end

	raise_selected
			-- Raise Development window corresponding to selected item.
		do
			if
				attached selected_item as l_item and then
				attached {EB_WINDOW} l_item.data as selected_window
			then
				selected_window.show
			end
		end

	window_manager: EB_WINDOW_MANAGER
			-- Associated window manager

	context_menu_handler (menu: EV_MENU; target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; source: EV_PICK_AND_DROPABLE; source_pebble: ANY)
			-- Context menu handler
		local
			l_menu: EV_MENU
			l_item: EV_MENU_ITEM
		do
			if attached {EB_WINDOW} source_pebble as l_window and then not l_window.destroyed then
				l_menu := l_window.new_menu
				menu.wipe_out
				from
					l_menu.start
				until
					l_menu.after or l_menu.is_empty
				loop
					l_item := l_menu.item
					l_menu.remove
					menu.extend (l_item)
				end
			else
				menu.wipe_out
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class EB_WINDOW_MANAGER_LIST
