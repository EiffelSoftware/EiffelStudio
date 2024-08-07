note
	description	: "Menu representing all the opened windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WINDOW_MANAGER_MENU

inherit
	EV_MENU

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

	EB_RECYCLER
		rename
			destroy as recycle_items
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
			-- Initialization: build the widget and the menu.
		do
				-- Setup the manager.
			window_manager := a_window_manager
			window_manager.add_observer (Current)

				-- Build the menu.
			make_with_text (Interface_names.m_Window)
			build_menu
		end

feature {NONE} -- Element change

	internal_recycle
			-- To be called when the object is no more used.
		do
			window_manager.remove_observer (Current)
			recycle_items
			destroy
		end

feature {NONE} -- Initialization Implementation

	build_menu
			-- build the menu corresponding to `a_favorites'
		local
			menu_item: EV_MENU_ITEM
			an_item: EB_WINDOW
			menu_sep: EV_MENU_SEPARATOR
			managed_windows: ARRAYED_LIST [EB_WINDOW]
			command_menu_item: EB_COMMAND_MENU_ITEM
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			managed_windows := window_manager.managed_windows

				-- Add the actions (New window, Minimize all, ...)
			command_menu_item := New_development_window_cmd.new_menu_item
			auto_recycle (command_menu_item)
			extend (command_menu_item)

			command_menu_item := window_manager.minimize_all_cmd.new_menu_item
			auto_recycle (command_menu_item)
			extend (command_menu_item)

			command_menu_item := window_manager.raise_all_cmd.new_menu_item
			auto_recycle (command_menu_item)
			extend (command_menu_item)

			command_menu_item := window_manager.raise_all_unsaved_cmd.new_menu_item
			auto_recycle (command_menu_item)
			extend (command_menu_item)

				-- Add the separator
			create menu_sep
			extend (menu_sep)

				-- Add the favorites
			from
				managed_windows.start
			until
				managed_windows.after
			loop
				an_item := managed_windows.item

					-- Build the menu item and add it to the menu.
				create menu_item
				menu_item.select_actions.extend (agent window_manager.show_window (an_item))
				conv_dev ?= an_item
				if
					conv_dev = Void or else
					conv_dev.stone = Void
				then
					menu_item.set_text (an_item.title)
				else
					menu_item.set_text (conv_dev.stone.history_name)
				end
				menu_item.set_data (an_item)
				extend (menu_item)

					-- prepare next iteration
				managed_windows.forth
			end
		end

feature -- Observer pattern

	on_item_added (an_item: EB_WINDOW)
			-- `an_item' has just been added
		local
			menu_item: EV_MENU_ITEM
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
				-- Create a new entry for `a_item' in the menu.
			create menu_item
			menu_item.select_actions.extend (agent window_manager.show_window (an_item))
			conv_dev ?= an_item
			if
				conv_dev = Void or else
				conv_dev.stone = Void
			then
				menu_item.set_text (an_item.title)
			else
				menu_item.set_text (conv_dev.stone.history_name)
			end
			menu_item.set_data (an_item)
			extend (menu_item)
		end

	on_item_removed (an_item: EB_WINDOW)
			-- `an_item' has just been removed.
		local
			menu_item_to_remove: EV_MENU_ITEM
		do
				-- Remove the menu item that match `a_item' from the menu.
			menu_item_to_remove ?= retrieve_item_by_data (an_item, True)
			if menu_item_to_remove /= Void then
				prune (menu_item_to_remove)
			end
		end

	on_item_changed (an_item: EB_WINDOW)
			-- `an_item' has just been removed.
		local
			menu_item_to_change: EV_MENU_ITEM
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			menu_item_to_change ?= retrieve_item_by_data (an_item, True)
			conv_dev ?= an_item
			if menu_item_to_change /= Void then
				if
					conv_dev = Void or else
					conv_dev.stone = Void
				then
					menu_item_to_change.set_text (an_item.title)
				else
					menu_item_to_change.set_text (conv_dev.stone.history_name)
				end
			end
		end

feature {NONE} -- Implementation

	window_manager: EB_WINDOW_MANAGER;
			-- Associated window manager

note
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

end -- class EB_WINDOW_MANAGER_MENU
