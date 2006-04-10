indexing
	description	: "Tree showing the classes present in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLASSES_TREE

inherit
	EV_TREE

	EB_CLUSTER_MANAGER_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_class_added, on_class_removed, on_class_moved,
			on_cluster_added, on_cluster_removed, on_cluster_changed, on_cluster_moved,
			on_project_loaded, on_project_unloaded,
			refresh
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_RECYCLABLE
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	CONF_REFACTORING
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the tree of clusters.
		do
			default_create
			prepare
			manager.extend (Current)
--| FIXME XR: When clusters can be moved for real, uncomment this line.
--			drop_actions.extend (~on_cluster_drop)
			create classes_double_click_agents.make
			create expanded_clusters.make (20)
			set_minimum_height (20)
		end

	prepare is
			-- Create the controls and setup the layout.
		do
			set_pixmaps_size (16, 16)
		end

	build_tree is
			-- Remove and replace contents of `Current'.
		local
			l_target: CONF_TARGET
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_clu: CONF_CLUSTER
			l_sort_grps: SORTED_TWO_WAY_LIST [CONF_GROUP]
		do
			if window /= Void then
					-- Lock update of window, so rebuilding of `Current'
					-- is hidden.
				window.lock_update
			end

				-- Remove all items, ready for rebuilding.
			if Eiffel_project.initialized and then Universe.target /= Void then
				store_expanded_state
					-- Store expanded state of `Current'

				wipe_out

				l_target := Universe.target

					-- sort clusters
				create cluster_header.make (interface_names.l_class_tree_clusters, pixmaps.icon_cluster_symbol)
				build_group_tree (manager.clusters, cluster_header)

					-- sort overrides
				create override_header.make (interface_names.l_class_tree_overrides, pixmaps.icon_override_symbol)
				build_group_tree (manager.overrides, override_header)

					-- sort libraries
				create library_header.make (interface_names.l_class_tree_libraries, pixmaps.icon_library_symbol)
				build_group_tree (manager.libraries, library_header)

					-- sort assemblies
				create assembly_header.make (interface_names.l_class_tree_assemblies, pixmaps.icon_read_only_assembly)
				build_group_tree (manager.assemblies, assembly_header)

				restore_expanded_state
					-- Restore original expanded state, stored during last call to
					-- `store_expanded_state'				
			end

			if window /= Void then
					-- Unlock update of window as `Current' has
					-- been rebuilt.
				window.unlock_update
			end
		end

feature -- Activation

	associate_textable_with_classes (a_textable: EV_TEXT_COMPONENT) is
			-- Tell classes recursively to print their names in textable when they're being clicked on.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			textable := a_textable
			from
				start
			until
				after
			loop
				conv_folder ?= item
				conv_folder.associate_textable_with_classes (textable)
				forth
			end
		end

	associate_with_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Tell classes recursively to call `set_stone' on a_window when they are clicked on.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			if window = Void then
				key_press_actions.extend (agent on_key_pushed)
			end
			window := a_window
			from
				start
			until
				after
			loop
				conv_folder ?= item
				conv_folder.associate_with_window (a_window)
				forth
			end
		end

	add_double_click_action_to_classes (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Tell classes recursively to execute p when they're being double-clicked on.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			classes_double_click_agents.extend (p)
			from
				start
			until
				after
			loop
				conv_folder ?= item
				conv_folder.add_double_click_action_to_classes (p)
				forth
			end
		end

	show_cluster (a_cluster: CLUSTER_I) is
			-- Expand all parents of `a_cluster' and highlight `a_cluster'.
		local
			path: LINKED_LIST [CONF_GROUP]
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			path := cluster_parents (a_cluster)
			path.finish
			path.remove
			if not path.is_empty then
				from
					path.start
					a_folder := find_cluster_in (path.item, a_folder)
					if not a_folder.is_expanded then
						a_folder.expand
					end
					path.forth
				until
					path.after or else a_folder = Void
				loop
					a_folder := find_cluster_in (path.item, a_folder)
					if not a_folder.is_expanded then
						a_folder.expand
					end
					path.forth
				end
			end
			a_folder := find_cluster_in (a_cluster, a_folder)
			a_folder.enable_select
		end

	show_class (a_class: CLASS_I) is
			-- Expand all parents of `a_class' and highlight `a_class'.
		local
			path: LINKED_LIST [CONF_GROUP]
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class_item: EB_CLASSES_TREE_CLASS_ITEM
			l_sub: LIST [STRING]
		do
			path := cluster_parents (a_class.group)
			from
				path.start
				a_folder := find_cluster_in (path.item, a_folder)
				if a_folder /= Void and then not a_folder.is_expanded then
					a_folder.expand
				end
				path.forth
			until
				path.after or else a_folder = Void
			loop
				a_folder := find_cluster_in (path.item, a_folder)
				if a_folder /= Void and then not a_folder.is_expanded then
					a_folder.expand
				end
				path.forth
			end
				-- we may have to look at subfolders
			l_sub := a_class.path.split ('/')
			check not_empty: not l_sub.is_empty end
			from
				l_sub.start
				l_sub.forth
			until
				l_sub.after
			loop
				a_folder := find_subfolder_in (l_sub.item, a_folder)
				if a_folder /= Void and then not a_folder.is_expanded then
					a_folder.expand
				end
				l_sub.forth
			end

			a_class_item := find_class_in (a_class, a_folder)
			if a_class_item /= Void then
				a_class_item.enable_select
			end
		end

feature -- Observer pattern

	refresh is
			-- Rebuild the tree.
		do
			build_tree
		end

	on_class_added (a_class: EIFFEL_CLASS_I) is
			-- Refresh the tree to display the new class.
		do
			refresh
		end

	on_class_removed (a_class: EIFFEL_CLASS_I) is
			-- Refresh the tree not to display the old class.
		do
			refresh
		end

	on_class_moved (a_class: CONF_CLASS; old_group: CONF_GROUP) is
			-- Refresh the tree to display `a_class' in its new folder.
		do
			refresh
		end

	on_cluster_added (a_cluster: EB_SORTED_CLUSTER) is
			-- Refresh the tree to display the new cluster.
		do
			refresh
		end

	on_cluster_changed (a_cluster: CLUSTER_I) is
			-- Refresh the tree to display the modified cluster.
		do
			refresh
		end

	on_cluster_moved (a_cluster: EB_SORTED_CLUSTER; old_cluster: CLUSTER_I) is
			-- Refresh the tree to display `a_cluster' in its new folder.
		do
			refresh
		end

	on_cluster_removed (a_group: EB_SORTED_CLUSTER; a_path: STRING) is
			-- Refresh the tree not to display the old cluster.
		do
			refresh
		end

	on_project_loaded is
			-- Refresh the tree to display the new project.
		do
			refresh
		end

	on_project_unloaded is
			-- Erase the tree.
		do
			wipe_out
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			manager.remove_observer (Current)
			window := Void
		end

feature {NONE} -- Rebuilding

	cluster_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Header for clusters.

	override_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Header for overrides.

	assembly_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Header for assemblies.

	library_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Header for libraries.

	expanded_clusters: HASH_TABLE [STRING, STRING]
		-- All cluster names marked as expanded during last call to
		-- `store_expanded_state'.

	selected_name: STRING
		-- Full name of item selected in `Current' before rebuilding,
		-- including path.

	store_expanded_state is
			-- Store expanded state of `Current' into `expanded_clusters'.
		do
			expanded_clusters.wipe_out
				-- Clear last set of expanded clusters.

			if selected_item /= Void then
					-- Store inclusive path of item currently selected in `Current'.
					-- This is used to restore the selected item post rebuilding.
				selected_name := path_name_from_tree_node (selected_item)
			end
			recursive_store (Current)
				-- Actually perform recursion.
		end

	recursive_store (tree_list: EV_TREE_NODE_LIST) is
			-- Store full path name of clusters associated with all
			-- expanded nodes of `tree_item', recursively into `expanded_clusters'.
		require
			tree_list_not_void: tree_list /= Void
		local
			cluster: EB_SORTED_CLUSTER
			current_node: EV_TREE_NODE
			l_parent: EV_TREE_NODE
			l_name: STRING
		do
			from
				tree_list.start
			until
				tree_list.off
			loop
				current_node := tree_list.item
				if current_node.is_expanded then
					recursive_store (current_node)
					l_parent ?= current_node.parent
					l_name := path_name_from_tree_node (current_node)
					expanded_clusters.put (l_name, l_name)
				end
				tree_list.forth
			end
		end

	restore_expanded_state is
			-- Restore all nodes of `Current', represented in `expanded_clusters'.
		local
			keys: ARRAY [STRING]
			counter: INTEGER
			key: STRING
		do
			keys := expanded_clusters.current_keys
			from
				counter := 1
			until
				counter > keys.count
			loop
				key := keys.item (counter)
				expand_tree_item (key, Current)
				counter := counter + 1
			end
			if selected_name /= Void then
					-- If an item was selected before the rebuild, re-select
					-- the item.
				select_tree_item (selected_name, Current)
				if selected_item /= Void then
						-- Ensure that the selected item is visible on screen.
					ensure_item_visible (selected_item)
				end
			elseif not is_empty and is_displayed then
					-- Ensure that the first item is displayed.
					--| FIXME Julian Rogers 08/12/03
					--| When EiffelVision2 provides a method of returning the displayed index
					--| back to its exact original position, use this instead.
				ensure_item_visible (first)
			end
		end

	select_tree_item (full_path: STRING; tree_list: EV_TREE_NODE_LIST) is
			-- Select item in `tree_list' recursively, whose data path matches `full_path'.
		require
			full_path_not_void: full_path /= Void
			tree_list_not_void: tree_list /= Void
		local
			key: STRING
			item_key: STRING
			dot_index: INTEGER
		do
			key := full_path
			dot_index := key.index_of ('.', 1)
			if dot_index = 0 then
					-- If there is no dot, `item_key' is set to `key'.
				item_key := key
			else
					-- Set `item_key' to the next part of `key' up to the dot.
				item_key := key.substring (1, dot_index - 1)
			end
			from
				tree_list.start
			until
				tree_list.off
			loop
				if tree_list.item.text.is_equal (item_key) or else tree_list.item.text.is_equal (item_key.as_upper) then
					if dot_index /= 0 then
						select_tree_item (full_path.substring (dot_index + 1,full_path.count), tree_list.item)
					else
						tree_list.item.enable_select
					end
				end
				tree_list.forth
			end
		end

	expand_tree_item (full_path: STRING; tree_item: EV_TREE_NODE_LIST) is
			-- Expand item of `tree_item', whose data matches `full_path'.
		require
			full_path_not_void: full_path /= Void
			tree_item_not_void: tree_item /= Void
		local
			key: STRING
			item_key: STRING
			dot_index: INTEGER
		do
			key := full_path
			dot_index := key.index_of ('.', 1)
			item_key := key.substring (1, dot_index - 1)
			from
				tree_item.start
			until
				tree_item.off
			loop
				if tree_item.item.text.is_equal (item_key) or tree_item.item.text.is_equal (key) then
					if dot_index /= 0 then
						if tree_item.item.is_expandable and then not tree_item.item.is_expanded then
							tree_item.item.expand
						end
						expand_tree_item (full_path.substring (dot_index + 1, full_path.count), tree_item.item)
					else
						if tree_item.item.is_expandable and then not tree_item.item.is_expanded then
							tree_item.item.expand
						end
					end
				end
				tree_item.forth
			end
		end

feature {NONE} -- Implementation

	path_name_from_tree_node (tree_node: EV_TREE_NODE): STRING is
			-- `Result' is a path name representing `tree_node' in the
			-- form "base.kernel.COMPARABLE".
		require
			tree_node_not_void: tree_node /= Void
		local
			l_parent: EV_TREE_NODE
		do
			from
				l_parent ?= tree_node.parent
				Result := tree_node.text
			until
				l_parent = Void
			loop
				Result.prepend_character ('.')
				Result.prepend (l_parent.text)
				l_parent ?= l_parent.parent
			end
		ensure
			Result_not_void: Result /= Void
		end

	on_key_pushed (a_key: EV_KEY) is
			-- If `a_key' is enter, set a stone in the development window.
		local
			conv_class: EB_CLASSES_TREE_CLASS_ITEM
			conv_cluster: EB_CLASSES_TREE_FOLDER_ITEM
			titem: EV_TREE_NODE
			testfile: RAW_FILE
			wd: EV_WARNING_DIALOG
		do
			titem := selected_item
			if
				a_key.code = Key_enter and then
				window /= Void and then
				titem /= Void
			then
				conv_class ?= titem
				if conv_class /= Void then
					create testfile.make (conv_class.data.file_name)
					if testfile.exists and then testfile.is_readable then
						window.set_stone (conv_class.stone)
					else
						create wd.make_with_text ("Class file could not be read.%N%
											%Removing class from the system.")
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
						manager.remove_class (conv_class.data)
					end
				else
					conv_cluster ?=  titem
					if conv_cluster /= Void then
						window.set_stone (conv_cluster.stone)
					end
				end
			end
		end

	on_cluster_drop (a_cluster: CLUSTER_STONE) is
			-- Move `a_cluster' to the tree root.
		do
--			manager.move_cluster (a_cluster.cluster_i, Void)
		end

	cluster_parents (a_group: CONF_GROUP): LINKED_LIST [CONF_GROUP] is
			-- List of parent groups of `group', from the root to `group', `cluster' included.
		local
			l_group, l_next_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_libuse: ARRAYED_LIST [CONF_LIBRARY]
		do
			from
				create Result.make
				l_group := a_group
			until
				l_group = Void -- root attained
			loop
				Result.put_front (l_group)
				if l_group.is_cluster then
					l_cluster ?= l_group
					check cluster: l_cluster /= Void end
					l_next_group := l_cluster.parent
				else
					l_next_group := Void
				end
				l_libuse := l_group.target.used_in_libraries
				if l_next_group = Void and l_libuse /= Void and then not l_libuse.is_empty then
						-- if one of the libraries is used in the application target use this one, else just take one
					from
						l_libuse.start
					until
						l_next_group /= Void or l_libuse.after
					loop
						if l_libuse.item.target = universe.target then
							l_next_group := l_libuse.item
						end
						l_libuse.forth
					end
					if l_next_group = Void then
						l_next_group := l_libuse.first
					end
				end
				l_group := l_next_group
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	find_subfolder_in (a_name: STRING; parent_cluster: EB_CLASSES_TREE_FOLDER_ITEM): EB_CLASSES_TREE_FOLDER_ITEM is
			-- Fint the tree item associated to `a_name' in `parent_cluster'.
		require
			parent_cluster_not_void: parent_cluster /= Void
		local
			l_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			from
				parent_cluster.start
			until
				parent_cluster.after or Result /= Void
			loop
				l_folder ?= parent_cluster.item
				if l_folder /= Void and then l_folder.name.is_equal (a_name) then
					Result := l_folder
				end
				parent_cluster.forth
			end
		end

	find_cluster_in (clusteri: CONF_GROUP; parent_cluster: EB_CLASSES_TREE_FOLDER_ITEM): EB_CLASSES_TREE_FOLDER_ITEM is
			-- Find the tree item associated to `clusteri' in `parent_cluster'.
		local
			folder_list: EV_TREE_NODE_LIST
			folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
			if parent_cluster = Void then
				if clusteri.is_override then
					folder_list := override_header
				elseif clusteri.is_cluster then
					folder_list := cluster_header
				elseif clusteri.is_assembly then
					folder_list := assembly_header
				elseif clusteri.is_library then
					folder_list := library_header
				else
					check should_not_reach: False end
				end
			else
				if not parent_cluster.is_initialized then
					parent_cluster.initialize
				end
				folder_list := parent_cluster
			end

			from
				folder_list.start
			until
				folder_list.after or else Result /= Void
			loop
				folder ?= folder_list.item
				if folder /= Void and then folder.data.actual_group = clusteri then
					Result := folder
				end
				folder_list.forth
			end
		end

	find_class_in (a_class: CLASS_I; parent_cluster: EB_CLASSES_TREE_FOLDER_ITEM): EB_CLASSES_TREE_CLASS_ITEM is
			-- Find the tree item associated to `a_class' in `parent_cluster'.
		local
			folder_list: EV_TREE_NODE_LIST
			folder: EB_CLASSES_TREE_CLASS_ITEM
		do
			if parent_cluster = Void then
				folder_list := Current
			else
				folder_list := parent_cluster
			end

			from
				folder_list.start
			until
				folder_list.after or else Result /= Void
			loop
				folder ?= folder_list.item
				if folder /= Void and then folder.data = a_class then
					Result := folder
				end
				folder_list.forth
			end
		end

	window: EB_DEVELOPMENT_WINDOW
			-- Development window classes should be associated with.

	textable: EV_TEXT_COMPONENT
			-- Text component classes should be associated with.

	classes_double_click_agents: LINKED_LIST [PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]];
			-- Agents associated to double-clicks on classes.

	build_group_tree (a_grps: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]; a_header: EB_CLASSES_TREE_HEADER_ITEM) is
			-- Build a tree for `a_grps' under `a_header' and add it to the tree if we have elements.
		require
			a_grps_not_void: a_grps /= Void
			a_header_not_void: a_header /= Void
		local
			l_item: EB_CLASSES_TREE_FOLDER_ITEM
			l_group: EB_SORTED_CLUSTER
		do
			from
				a_grps.start
			until
				a_grps.after
			loop
				l_group := a_grps.item_for_iteration
				create l_item.make (l_group)

				a_header.extend (l_item)
				if window /= Void then
					l_item.associate_with_window (window)
				end
				if textable /= Void then
					l_item.associate_textable_with_classes (textable)
				end
				from
					classes_double_click_agents.start
				until
					classes_double_click_agents.after
				loop
					l_item.add_double_click_action_to_classes (classes_double_click_agents.item)
					classes_double_click_agents.forth
				end
				a_grps.forth
			end
			if not a_header.is_empty then
				extend (a_header)
			end
		end


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

end
