indexing
	description	: "Tree representing a set of the favorites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_TREE

inherit
	ES_TREE

	EB_FAVORITES_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_item_added, on_item_removed, on_update
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

	make (a_favorites_manager: EB_FAVORITES_MANAGER; clickable: BOOLEAN) is
			-- Initialization: build the widget and the tree.
		do
			is_clickable := clickable
			default_create
			favorites_manager := a_favorites_manager
			build_tree
			favorites.add_observer (Current)
			drop_actions.extend (agent remove_class_stone)
			drop_actions.extend (agent remove_feature_stone)
			drop_actions.extend (agent remove_folder)
			drop_actions.extend (agent add_stone)
			drop_actions.extend (agent add_folder)
			drop_Actions.set_veto_pebble_function (agent valid_stone)

			key_press_actions.extend (agent handle_key)

			if favorites_manager.Favorites.sensitive then
				enable_sensitive
			else
				disable_sensitive
			end

			set_minimum_height (20)
			enable_default_tree_navigation_behavior (False, False, False, True)
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

feature -- Element change

	refresh is
			-- Update `Current's display.
		local
			fitem: EB_FAVORITES_TREE_ITEM
		do
			from
				start
			until
				after
			loop
				fitem ?= item
				if fitem /= Void then
					fitem.refresh
				end
				forth
			end
		end

feature {NONE} -- Cleaning

	internal_recycle is
			-- To be called when the object is no more used.
		do
			if favorites /= Void then
				favorites.remove_observer (Current)
			end
			favorites_manager := Void
		end

feature {NONE} -- Initialization Implementation

	build_tree is
			-- Build the tree corresponding to `a_favorites'.
		local
			tree_item: EB_FAVORITES_TREE_ITEM
			an_item: EB_FAVORITES_ITEM
			a_favorites: like favorites
		do
			wipe_out
			a_favorites := favorites
			from
				a_favorites.start
			until
				a_favorites.after
			loop
				an_item := a_favorites.item
				tree_item := favorite_to_tree_item (an_item)
				extend (tree_item)
				if tree_item.is_expandable then
					tree_item.expand_recursively
				end

					-- prepare next iteration
				a_favorites.forth
			end
		end

	build_tree_folder (a_favorites_folder: EB_FAVORITES_FOLDER): EB_FAVORITES_TREE_ITEM is
			-- Build the tree node corresponding to `a_favorites'.
		local
			tree_item: EB_FAVORITES_TREE_ITEM
			an_item: EB_FAVORITES_ITEM
		do
			create Result.make (a_favorites_folder)
			Result.set_context_menu_factory (context_menu_factory)
			from
				a_favorites_folder.start
			until
				a_favorites_folder.after
			loop
				an_item := a_favorites_folder.item
				tree_item := favorite_to_tree_item (an_item)
				Result.extend (tree_item)

					-- Prepare next iteration.
				a_favorites_folder.forth
			end
		end

	favorite_to_tree_item (an_item: EB_FAVORITES_ITEM): EB_FAVORITES_TREE_ITEM is
			-- Favorite item to Favorite tree item
		local
			a_folder_item: EB_FAVORITES_FOLDER
			a_class_item: EB_FAVORITES_CLASS
			a_feat_item: EB_FAVORITES_FEATURE
			l_tree_item: EB_FAVORITES_TREE_ITEM
		do
			if an_item.is_class then
				a_class_item ?= an_item
				create Result.make (a_class_item)
				Result.set_context_menu_factory (context_menu_factory)
				if is_clickable then
					Result.pointer_button_press_actions.force_extend (
						agent on_button_pressed (a_class_item, ?, ?, ?))
				end
				if not a_class_item.is_empty then
					from
						a_class_item.start
					until
						a_class_item.after
					loop
						l_tree_item := favorite_to_tree_item (a_class_item.item)
						Result.extend (l_tree_item)
						a_class_item.forth
					end
				end
			elseif an_item.is_folder then
				a_folder_item ?= an_item
				Result := build_tree_folder (a_folder_item)
			elseif an_item.is_feature then
				a_feat_item ?= an_item
				create Result.make (a_feat_item)
				Result.set_context_menu_factory (context_menu_factory)
				if is_clickable then
					Result.pointer_button_press_actions.force_extend (
						agent on_button_pressed (a_feat_item, ?, ?, ?))
				end
			end
			Result.set_text (an_item.name)
			Result.set_data (an_item)
		end

feature -- Observer pattern

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'.
		local
			item_list: EV_TREE_NODE_LIST
			a_class_item: EB_FAVORITES_CLASS
			a_feat_item: EB_FAVORITES_FEATURE
			tree_item: EB_FAVORITES_TREE_ITEM
		do
				-- Create a new entry for `a_item' in the tree.
			item_list := get_tree_item_from_path (Current, a_path)
			if item_list /= Void then
				create tree_item.make (a_item)
				tree_item.set_context_menu_factory (context_menu_factory)
				if a_item.is_class then
					a_class_item ?= a_item
					if is_clickable then
						tree_item.pointer_button_press_actions.force_extend (
							agent on_button_pressed (a_class_item, ?, ?, ?))
					end
				elseif a_item.is_feature then
					a_feat_item ?= a_item
					if is_clickable then
						tree_item.pointer_button_press_actions.force_extend (
							agent on_button_pressed (a_feat_item, ?, ?, ?))
					end
				end
				tree_item.set_text (a_item.name)
				tree_item.set_data (a_item)
				item_list.extend (tree_item)
			end
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been removed.
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'.
		local
			item_list: EV_TREE_NODE_LIST
			item_name: STRING
			tree_item_to_remove: EB_FAVORITES_TREE_ITEM
		do
				-- Remove the tree item that match `a_item' from the tree.
			item_name := a_item.name
			item_list := get_tree_item_from_path (Current, a_path)
			if item_list /= Void then
				tree_item_to_remove ?= item_list.retrieve_item_by_data (a_item, True)
				if tree_item_to_remove /= Void then
					item_list.prune (tree_item_to_remove)
				end
			end
		end

	on_update is
			-- Reload the favorites tree.
		do
			wipe_out
			build_tree
		end

	add_stone (a_stone: STONE) is
			-- Add a stone
		local
			l_class_stone: CLASSI_STONE
			l_feat_stone: FEATURE_STONE
		do
			l_class_stone ?= a_stone
			l_feat_stone ?= a_stone
			if l_feat_stone /= Void then
				add_feature_stone (l_feat_stone)
			elseif l_class_stone /= Void then
				add_class_stone (l_class_stone)
			end
		end

	add_feature_stone (a_stone: FEATURE_STONE) is
			-- Add a feature, defined by `a_stone', to the main branch of the tree.
		require
			valid_stone: a_stone /= Void
		do
			favorites.add_feature_stone (a_stone)
		end

	add_class_stone (a_stone: CLASSI_STONE) is
			-- Add a class, defined by `a_stone', to the main branch of the tree.
		require
			valid_stone: a_stone /= Void
		local
			new_item: EB_FAVORITES_CLASS
			l_fcs: EB_FAVORITES_CLASSC_STONE
			l_fc: EB_FAVORITES_CLASS
		do
			create new_item.make_from_class_stone (a_stone, favorites)
			favorites.extend (new_item)

			l_fcs ?= a_stone
			if l_fcs /= Void then
				l_fc := l_fcs.origin
				if l_fc /= Void then
					from
						l_fc.start
					until
						l_fc.after
					loop
						new_item.add_feature (l_fc.item.name)
						l_fc.forth
					end
				end
			end
		end

	add_folder (a_folder: EB_FAVORITES_FOLDER) is
			-- Add a folder, defined by `a_folder', to the main branch of the tree.
		require
			valid_folder: a_folder /= Void
		do
			favorites.extend (a_folder)
		end

	remove_folder (a_folder: EB_FAVORITES_FOLDER) is
			-- Remove a folder, defined by `a_folder', from the tree.
		require
			valid_folder: a_folder /= Void
		do
			a_folder.parent.start
			a_folder.parent.prune (a_folder)
		end

	remove_class_stone (a_stone: EB_FAVORITES_CLASS_STONE) is
			-- Remove a class, defined by `a_stone', from the tree.
		require
			valid_stone: a_stone /= Void
		local
			old_class: EB_FAVORITES_CLASS
		do
			old_class := a_stone.origin
			old_class.parent.start
			old_class.parent.prune (old_class)
		end

	remove_feature_stone (a_stone: EB_FAVORITES_FEATURE_STONE) is
			-- Remove a feature, defined by `a_stone', from the tree.
		require
			valid_stone: a_stone /= Void
		local
			old_feat: EB_FAVORITES_FEATURE
		do
			old_feat := a_stone.origin
			old_feat.parent.start
			old_feat.parent.prune (old_feat)
		end

	on_button_pressed (a_node: ANY; a_x, a_y, a_button: INTEGER) is
			-- Action done when an item is selected.
		local
			l_item: EB_FAVORITES_ITEM
			l_stone: STONE
		do
			l_item ?= a_node
			if l_item /= Void then
				if a_button = 1 then
					favorites_manager.go_to_favorite (l_item)
				elseif a_button = 3 and then ev_application.ctrl_pressed then
					l_stone := l_item.associated_stone
					if l_stone /= Void and then l_stone.is_valid then
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
					end
				end
			end
		end

feature {NONE} -- Implementation

	handle_key (a_key: EV_KEY) is
			-- Handle `a_key' press for favorites tree.
		local
			item_to_delete: EB_FAVORITES_ITEM
			l_selected_item: like selected_item
			item_list: EB_FAVORITES_ITEM_LIST
		do
			l_selected_item := selected_item
			if l_selected_item /= Void and then a_key /= Void and then a_key.code = {EV_KEY_CONSTANTS}.key_delete then
					-- Delete key has been pressed so we remove the selected favorite from the list.
				item_to_delete ?= l_selected_item.data
				item_list := item_to_delete.parent
				item_list.start
				item_list.prune (item_to_delete)
			end
		end

	get_tree_item_from_path (item_list: EV_TREE_NODE_LIST; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]): EV_TREE_NODE_LIST is
			-- Get the tree item corresponding to the path `a_path'
			-- Void if not found.
		local
			new_path: like a_path
			curr_item: EB_FAVORITES_FOLDER
			curr_folder_name: STRING
			sub_tree: EV_TREE_NODE_LIST
		do
			if a_path = Void or else a_path.is_empty then
				Result := item_list
			else
				new_path := a_path.twin
				new_path.start
				curr_item := new_path.item
				curr_folder_name := new_path.item.name
				new_path.remove

				sub_tree ?= item_list.retrieve_item_by_data (curr_item, True)
				Result := get_tree_item_from_path (sub_tree, new_path)
			end
		end

	valid_stone (a_stone: ANY): BOOLEAN is
			--
		local
			l_class: CLASSI_STONE
			l_feat: FEATURE_STONE
		do
			l_class ?= a_stone
			Result := l_class /= Void
			if not Result then
				l_feat ?= a_stone
				Result := l_feat /= Void
			end
		end

feature {NONE} -- Implementation

	context_menu_factory: EB_CONTEXT_MENU_FACTORY is
			-- Context menu factory
		do
			Result := favorites_manager.development_window.menus.context_menu_factory
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

end -- class EB_FAVORITES_TREE
