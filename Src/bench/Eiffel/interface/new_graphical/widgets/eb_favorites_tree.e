indexing
	description	: "Tree representing a set of the favorites"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_TREE

inherit
	EV_TREE

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
			drop_actions.extend (~remove_class_stone)
			drop_actions.extend (~remove_folder)
			drop_actions.extend (~add_class_stone)
			drop_actions.extend (~add_folder)
			
			if favorites_manager.Favorites.sensitive then
				enable_sensitive
			else
				disable_sensitive
			end

			set_minimum_height (20)
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

	recycle is
			-- To be called when the object is no more used.
		do
			favorites.remove_observer (Current)
		end

feature {NONE} -- Initialization Implementation

	build_tree is
			-- Build the tree corresponding to `a_favorites'.
		local
			tree_item: EB_FAVORITES_TREE_ITEM
			an_item: EB_FAVORITES_ITEM
			a_folder_item: EB_FAVORITES_FOLDER
			a_favorites: like favorites
			a_class_item: EB_FAVORITES_CLASS
		do
			wipe_out
			a_favorites := favorites
			from
				a_favorites.start
			until
				a_favorites.after
			loop
				an_item := a_favorites.item
				if an_item.is_folder then
					a_folder_item ?= an_item
					tree_item := build_tree_folder (a_folder_item)
				else
					a_class_item ?= an_item
					create tree_item.make (a_class_item)
					if is_clickable then
						tree_item.select_actions.extend (favorites_manager~go_to (a_class_item))
					end
				end
				tree_item.set_text (an_item.name)
				tree_item.set_data (an_item)
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
			a_folder_item: EB_FAVORITES_FOLDER
			a_class_item: EB_FAVORITES_CLASS
		do
			create Result.make (a_favorites_folder)
			from
				a_favorites_folder.start
			until
				a_favorites_folder.after
			loop
				an_item := a_favorites_folder.item
				if an_item.is_folder then
					a_folder_item ?= an_item
					tree_item := build_tree_folder (a_folder_item)
				else
					a_class_item ?= an_item
					create tree_item.make (a_class_item)
					if is_clickable then
						tree_item.select_actions.extend (favorites_manager~go_to (a_class_item))
					end
				end
				tree_item.set_text (an_item.name)
				tree_item.set_data (an_item)
				Result.extend (tree_item)

					-- Prepare next iteration.
				a_favorites_folder.forth
			end
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
			tree_item: EB_FAVORITES_TREE_ITEM
		do
				-- Create a new entry for `a_item' in the tree.
			item_list := get_tree_item_from_path (Current, a_path)
			if item_list /= Void then
				if a_item.is_folder then
					create tree_item.make (a_item)
				else
					create tree_item.make (a_item)
					a_class_item ?= a_item
					if is_clickable then
						tree_item.select_actions.extend (favorites_manager~go_to (a_class_item))
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
				tree_item_to_remove ?= item_list.item_by_data (a_item)
				if tree_item_to_remove /= Void then
					item_list.prune_all (tree_item_to_remove)
				end
			end
		end

	on_update is
			-- Reload the favorites tree.
		do
			wipe_out
			build_tree
		end

	add_class_stone (a_stone: CLASSI_STONE) is
			-- Add a class, defined by `a_stone', to the main branch of the tree.
		require
			valid_stone: a_stone /= Void
		local
			new_item: EB_FAVORITES_CLASS
		do
			create new_item.make_from_class_stone (a_stone, favorites)
			favorites.extend (new_item)
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

feature {NONE} -- Implementation
		
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
				new_path := clone (a_path)
				new_path.start
				curr_item := new_path.item
				curr_folder_name := new_path.item.name
				new_path.remove

				sub_tree ?= item_list.item_by_data (curr_item)
				Result := get_tree_item_from_path (sub_tree, new_path)
			end
		end

feature {NONE} -- Implementation
		
	favorites_manager: EB_FAVORITES_MANAGER
			-- Associated favorites manager

end -- class EB_FAVORITES_TREE
