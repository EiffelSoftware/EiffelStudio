indexing
	description	: "Menu representing a set of the favorites"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_MENU

inherit
	EV_MENU

	EB_FAVORITES_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_item_added, on_item_removed
		end

	EB_CONSTANTS
		export
			{NONE} all
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

	make (a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Initialization: build the widget and the menu.
		do
			make_with_text (Interface_names.m_Favorites)
			favorites_manager := a_favorites_manager
			build_menu
			favorites.add_observer (Current)
			if not favorites.sensitive then
				disable_sensitive
			end
		end

feature -- Access

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	refresh is
			-- Update `Current's contents.
		do
			-- Nothing to do since the favorites already took away all dead classes.
		end

feature {NONE} -- Initialization Implementation

	build_menu is
			-- build the menu corresponding to `a_favorites'
		local
			menu_item: EV_MENU_ITEM
			an_item: EB_FAVORITES_ITEM
			menu_sep: EV_MENU_SEPARATOR
			a_folder_item: EB_FAVORITES_FOLDER
			a_class_item: EB_FAVORITES_CLASS
			a_favorites: like favorites
		do
			a_favorites := favorites

				-- Add the actions (Add to favorites, Organise, ...)
			if favorites_manager.development_window /= Void then
				create menu_item
				menu_item.set_text (Interface_names.m_Add_to_favorites)
				menu_item.select_actions.extend (favorites_manager~add_class)
				extend (menu_item)
			end

			create menu_item
			menu_item.set_text (Interface_names.m_Organize_favorites)
			menu_item.select_actions.extend (favorites_manager~organize_favorites)
			extend (menu_item)

				-- Add the separator
			create menu_sep
			extend (menu_sep)

				-- Add the favorites
			from
				a_favorites.start
			until
				a_favorites.after
			loop
				an_item := a_favorites.item
				if an_item.is_folder then
					a_folder_item ?= an_item
					menu_item := build_menu_folder (a_folder_item)
				else
					a_class_item ?= an_item
					create menu_item
					menu_item.select_actions.extend (favorites_manager~go_to (a_class_item))
				end
				menu_item.set_text (an_item.name)
				menu_item.set_data (an_item)
				extend (menu_item)

					-- prepare next iteration
				a_favorites.forth
			end
		end

	build_menu_folder (a_favorites_folder: EB_FAVORITES_FOLDER): EV_MENU is
			-- build the menu corresponding `a_favorites'
		local
			menu_item: EV_MENU_ITEM
			an_item: EB_FAVORITES_ITEM
			a_folder_item: EB_FAVORITES_FOLDER
			a_class_item: EB_FAVORITES_CLASS
		do
			create Result
			from
				a_favorites_folder.start
			until
				a_favorites_folder.after
			loop
				an_item := a_favorites_folder.item
				if an_item.is_folder then
					a_folder_item ?= an_item
					menu_item := build_menu_folder (a_folder_item)
				else
					a_class_item ?= an_item
					create menu_item
					menu_item.select_actions.extend (favorites_manager~go_to (a_class_item))
				end
				menu_item.set_text (an_item.name)
				menu_item.set_data (an_item)
				Result.extend (menu_item)

					-- prepare next iteration
				a_favorites_folder.forth
			end
		end

feature -- Observer pattern

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			item_list: EV_MENU_ITEM_LIST
			a_class_item: EB_FAVORITES_CLASS
			menu_item: EV_MENU_ITEM
		do
				-- Create a new entry for `a_item' in the menu.
			item_list := get_menu_item_from_path (Current, a_path)
			if item_list /= Void then
				if a_item.is_folder then
					create {EV_MENU} menu_item
				else
					create menu_item
					a_class_item ?= a_item
					menu_item.select_actions.extend (favorites_manager~go_to (a_class_item))
				end
				menu_item.set_text (a_item.name)
				menu_item.set_data (a_item)
				item_list.extend (menu_item)
			end
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been removed. 
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			item_list: EV_MENU_ITEM_LIST
			item_name: STRING
			menu_item_to_remove: EV_MENU_ITEM
		do
				-- Remove the menu item that match `a_item' from the menu.
			item_name := a_item.name
			item_list := get_menu_item_from_path (Current, a_path)
			if item_list /= Void then
				menu_item_to_remove ?= item_list.item_by_data (a_item)
				if menu_item_to_remove /= void then
					item_list.prune_all (menu_item_to_remove)
				end
			end
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			favorites.remove_observer (Current)
			favorites_manager := Void
		end

feature {NONE} -- Implementation
		
	get_menu_item_from_path (item_list: EV_MENU_ITEM_LIST; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]): EV_MENU_ITEM_LIST is
			-- Get the menu item corresponding to the path `a_path'
			-- Void if not found.
		local
			new_path: like a_path
			curr_item: EB_FAVORITES_FOLDER
			sub_menu: EV_MENU
		do
			if a_path = Void or else a_path.is_empty then
				Result := item_list
			else
				new_path := clone (a_path)
				new_path.start
				curr_item := new_path.item
				new_path.remove
		
				sub_menu ?= item_list.item_by_data (curr_item)
				Result := get_menu_item_from_path (sub_menu, new_path)
			end
		end

	favorites_manager: EB_FAVORITES_MANAGER
			-- Associated favorites manager

end -- class EB_FAVORITES_MENU
