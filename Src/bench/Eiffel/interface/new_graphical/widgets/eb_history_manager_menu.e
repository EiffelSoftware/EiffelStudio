indexing
	description	: "Menu representing all the opened historys."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_MANAGER_MENU

inherit
	EV_MENU

	EB_HISTORY_MANAGER_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_item_added, on_item_removed, on_update
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

	make (a_history_manager: EB_HISTORY_MANAGER) is
			-- Initialization: build the widget and the menu.
		do
				-- Setup the manager.
			history_manager := a_history_manager
			history_manager.add_observer (Current)

				-- Build the menu.
			make_with_text (Interface_names.m_History)
			build_menu
		end

feature -- Element change

	recycle is
			-- To be called when the object is no more used.
		do
			history_manager.remove_observer (Current)
			recycle_items
		end

feature {NONE} -- Initialization Implementation

	build_menu is
			-- build the menu corresponding to `a_favorites'
		local
			menu_item: EV_MENU_ITEM
			an_item: STONE
			menu_sep: EV_MENU_SEPARATOR
			history_list: LIST [STONE]
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			recycle_items
			wipe_out

				-- Back
			command_menu_item := history_manager.back_command.new_menu_item
			add_recyclable (command_menu_item)
			extend (command_menu_item)

				-- Forth
			command_menu_item := history_manager.forth_command.new_menu_item
			add_recyclable (command_menu_item)
			extend (command_menu_item)

				-- Add the separator
			create menu_sep
			extend (menu_sep)

				-- Add the History
			history_list := history_manager.list
			from
				history_list.start
			until
				history_list.after
			loop
				an_item := history_list.item
				if an_item /= Void then
						-- Build the menu item and add it to the menu.
					create menu_item
					menu_item.select_actions.extend (agent history_manager.go_i_th (history_list.index))
					menu_item.set_text (an_item.history_name)
					menu_item.set_data (an_item)
					extend (menu_item)
				end
					-- prepare next iteration
				history_list.forth
			end
		end

feature -- Observer pattern

	on_update is
			-- The history has changed. Refresh `Current'.
		do
			build_menu
		end

	on_item_added (an_item: STONE; index_item: INTEGER) is
			-- `an_item' has just been added
		local
			menu_item: EV_MENU_ITEM
		do
				-- Create a new entry for `a_item' in the menu.
			create menu_item
			menu_item.select_actions.extend (agent history_manager.go_i_th (index_item))
			menu_item.set_text (an_item.history_name)
			menu_item.set_data (index_item)
			extend (menu_item)
		end

	on_item_removed (an_item: STONE; index_item: INTEGER) is
			-- `an_item' has just been removed. 
		do
				-- Remove the menu item that match `an_item' from the menu.
			from
				start
			until
				after
			loop
				if item.data /= Void and then item.data.is_equal (index_item) then
					remove
				else
					forth
				end
			end
		end

feature {NONE} -- Implementation

	history_manager: EB_HISTORY_MANAGER;
			-- Associated history manager

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

end -- class EB_HISTORY_MANAGER_MENU
