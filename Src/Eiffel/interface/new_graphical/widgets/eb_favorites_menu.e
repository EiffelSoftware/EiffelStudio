indexing
	description	: "Menu representing a set of the favorites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EB_RECYCLABLE
		undefine
			default_create, is_equal, copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
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

feature -- Element change

	refresh is
			-- Update `Current's contents.
		do
			do_all (agent update_menu_item)
		end

	update_folder_item (m: EV_MENU_ITEM) is
		do
			m.set_pixmap (pixmaps.icon_pixmaps.folder_blank_icon)
		end

	update_class_item (a_class_item: EB_FAVORITES_CLASS; m: EV_MENU_ITEM) is
		do
			if a_class_item.associated_class_i /= Void then
				m.set_pixmap (pixmap_from_class_i (a_class_item.associated_class_i))
			else
				m.set_pixmap (pixmaps.icon_pixmaps.class_uncompiled_icon)
			end
		end

	update_feature_item (a_feat_item: EB_FAVORITES_FEATURE; m: EV_MENU_ITEM) is
		do
			if a_feat_item.associated_e_feature /= Void then
				m.set_pixmap (pixmap_from_e_feature (a_feat_item.associated_e_feature))
			end
		end

feature {NONE} -- Initialization Implementation

	build_menu is
			-- build the menu corresponding to `a_favorites'
		local
			menu_item: EV_MENU_ITEM
			an_item: EB_FAVORITES_ITEM
			menu_sep: EV_MENU_SEPARATOR
			a_favorites: like favorites
		do
			a_favorites := favorites

				-- Add the actions (Add to favorites, Organise, ...)
			if favorites_manager.development_window /= Void then
				create menu_item
				menu_item.set_text (Interface_names.m_Add_to_favorites)
				menu_item.select_actions.extend (agent favorites_manager.add_class)
				extend (menu_item)
			end

			create menu_item
			menu_item.set_text (Interface_names.m_Organize_favorites)
			menu_item.select_actions.extend (agent favorites_manager.organize_favorites)
			extend (menu_item)

				-- Add the separator
			if not a_favorites.is_empty then
				create menu_sep
				extend (menu_sep)
			end

				-- Add the favorites
			from
				a_favorites.start
			until
				a_favorites.after
			loop
				an_item := a_favorites.item
				menu_item := favorite_to_menu_item (an_item)
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
		do
			create Result
			from
				a_favorites_folder.start
			until
				a_favorites_folder.after
			loop
				an_item := a_favorites_folder.item
				menu_item := favorite_to_menu_item (an_item)
				Result.extend (menu_item)

					-- prepare next iteration
				a_favorites_folder.forth
			end
		end

	favorite_to_menu_item (an_item: EB_FAVORITES_ITEM): EV_MENU_ITEM is
		local
			l_menu_item: EV_MENU_ITEM
			a_class_item: EB_FAVORITES_CLASS
			l_menu: EV_MENU
		do
			Result := favorite_to_immediate_menu_item (an_item)
			if an_item.is_class then
				a_class_item ?= an_item
				if not a_class_item.is_empty then
					l_menu ?= Result
						-- Create sub items
					from
						a_class_item.start
					until
						a_class_item.after
					loop
						l_menu_item := favorite_to_menu_item (a_class_item.item)
						l_menu.extend (l_menu_item)
						a_class_item.forth
					end
				end
			end
		end

	favorite_to_immediate_menu_item (an_item: EB_FAVORITES_ITEM): EV_MENU_ITEM is
		local
			l_menu_item: EV_MENU_ITEM
			a_folder_item: EB_FAVORITES_FOLDER
			a_class_item: EB_FAVORITES_CLASS
			a_feat_item: EB_FAVORITES_FEATURE
			l_menu: EV_MENU
		do
			if an_item.is_class then
				a_class_item ?= an_item
				if a_class_item.is_empty then
					create Result
					update_class_item (a_class_item, Result)
					Result.select_actions.extend (agent favorites_manager.go_to_favorite (a_class_item))
				else
						-- Create open this item menu
					create l_menu_item
					l_menu_item.set_text (a_class_item.name)
					l_menu_item.set_data (a_class_item)
					l_menu_item.select_actions.extend (agent favorites_manager.go_to_favorite (a_class_item))
					update_class_item (a_class_item, l_menu_item)

					create l_menu
					l_menu.extend (l_menu_item)
					if an_item.is_class then
						update_class_item (a_class_item, l_menu)
					else
						update_folder_item (l_menu)
					end

					Result := l_menu
				end
			elseif an_item.is_folder then
				a_folder_item ?= an_item
				Result := build_menu_folder (a_folder_item)
				update_folder_item (Result)
			elseif an_item.is_feature then
				a_feat_item ?= an_item
				create Result
				Result.select_actions.extend (agent favorites_manager.go_to_favorite (a_feat_item))
				update_feature_item (a_feat_item, Result)
			end
			Result.set_text (an_item.name)
			Result.set_data (an_item)
		end

feature -- Observer pattern

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			l_item: EV_MENU_ITEM
			l_item_data: EB_FAVORITES_ITEM
			l_class_data: EB_FAVORITES_CLASS
			l_menu: EV_MENU
			menu_item: EV_MENU_ITEM
			menu_sep: EV_MENU_SEPARATOR
		do
				-- Create a new entry for `a_item' in the menu.
			menu_item := favorite_to_immediate_menu_item (a_item)
			l_item := get_menu_item_from_path (Current, a_path)
			l_menu ?= l_item
			if l_menu = Void and then l_item /= Void then
				l_item_data ?= l_item.data
				if l_item_data.is_class then
					l_menu ?= favorite_to_immediate_menu_item (l_item_data)
					replace_class_menu_item_by (l_item, l_menu)
				end
			end

			if l_menu /= Void then
				if not l_menu.is_empty then
					l_item_data ?= l_menu.last.data
					if l_item_data = Void then
							-- Creates a separator between favorite options and favorite items.
						create menu_sep
						l_menu.extend (menu_sep)
					elseif l_menu.count = 1 then
						l_class_data ?= l_item_data
						if l_class_data /= Void then
								-- Creates a separator between class an feature items
							create menu_sep
							l_menu.extend (menu_sep)
						end
					end
				end
				l_menu.extend (menu_item)
			end
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been removed.
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			item_list: EV_MENU_ITEM_LIST
			menu_item_to_remove: EV_MENU_ITEM
			a_class_item: EB_FAVORITES_CLASS
			parent_menu: EV_MENU
			l_new_item: EV_MENU_ITEM
			l_sep: EV_MENU_SEPARATOR
		do
				-- Remove the menu item that match `a_item' from the menu.
			item_list ?= get_menu_item_from_path (Current, a_path)
			if item_list /= Void then
				menu_item_to_remove ?= item_list.retrieve_item_by_data (a_item, True)
				if menu_item_to_remove /= Void then
					item_list.prune (menu_item_to_remove)
				end
				if a_item.is_feature then
					a_class_item ?= item_list.data
					if a_class_item /= Void and then a_class_item.is_empty then
						l_new_item := favorite_to_immediate_menu_item (a_class_item)
						parent_menu ?= item_list
						replace_class_menu_item_by (parent_menu, l_new_item)
					end
				end
				if not item_list.is_empty then
					l_sep ?= item_list.last
					if l_sep /= Void then
						item_list.go_i_th (item_list.count)
						item_list.remove
					end
				end

			end
		end

	replace_class_menu_item_by (mi1, mi2: EV_MENU_ITEM) is
			-- Replace mi1 by mi2
		local
			item_list: EV_ITEM_LIST [EV_ITEM]
		do
			item_list := mi1.parent
			item_list.start
			item_list.search (mi1)
			if item_list.exhausted then
				item_list.extend (mi2)
			else
				item_list.replace (mi2)
			end
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if favorites /= Void then
				favorites.remove_observer (Current)
			end
			favorites_manager := Void
			destroy
		end

feature {NONE} -- Implementation

	update_menu_item (a_item: EV_MENU_ITEM) is
			-- Update `a_item' and sub menu items.
		local
			l_class: EB_FAVORITES_CLASS
			l_feature: EB_FAVORITES_FEATURE
			l_menu: EV_MENU
		do
				-- update pixmap
			l_class ?= a_item.data
			if l_class /= Void then
				update_class_item (l_class, a_item)
			else
				l_feature ?= a_item.data
				if l_feature /= Void then
					update_feature_item (l_feature, a_item)
				end
			end

				-- update sub items
			l_menu ?= a_item
			if l_menu /= Void then
				l_menu.do_all (agent update_menu_item)
			end
		end

	get_menu_item_from_path (an_item: EV_MENU_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]): EV_MENU_ITEM is
			-- Get the menu item corresponding to the path `a_path'
			-- Void if not found.
		local
			new_path: like a_path
			curr_item: EB_FAVORITES_FOLDER
			sub_menu: EV_MENU_ITEM
			item_list: EV_MENU_ITEM_LIST
		do
			item_list ?= an_item
			if
				item_list = Void
				or else	a_path = Void
				or else a_path.is_empty
			then
				Result := an_item
			else
				new_path := a_path.twin
				new_path.start
				curr_item := new_path.item
				new_path.remove

				sub_menu ?= item_list.retrieve_item_by_data (curr_item, True)
				Result := get_menu_item_from_path (sub_menu, new_path)
			end
		end

	favorites_manager: EB_FAVORITES_MANAGER;
			-- Associated favorites manager

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

end -- class EB_FAVORITES_MENU
