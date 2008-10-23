indexing
	description	: "Tree showing the classes present in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLASSES_TREE

inherit
	ES_TREE

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
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make,
	make_without_targets,
	make_with_options

feature {NONE} -- Initialization

	make (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY) is
			-- Initialize the tree of clusters.
		do
			default_create
			context_menu_factory := a_context_menu_factory
			prepare
			manager.extend (Current)
--| FIXME XR: When clusters can be moved for real, uncomment this line.
--			drop_actions.extend (~on_cluster_drop)
			create classes_double_click_agents.make
			create cluster_double_click_agents.make
			create expanded_clusters.make (20)
			set_minimum_height (20)
			enable_default_tree_navigation_behavior (False, False, False, True)
			has_targets := True
			is_show_classes := True
		end

	make_without_targets (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY) is
			-- Create a tree where targets of system are not shown.
		do
			make (a_context_menu_factory)
			has_targets := False
		end

	make_with_options (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_show_targets, a_show_classes: BOOLEAN)
			-- Create a tree with options
		do
			make (a_context_menu_factory)
			has_targets := a_show_targets
			is_show_classes := a_show_classes
		ensure
			set: has_targets = a_show_targets
			set: is_show_classes = a_show_classes
		end

	prepare is
			-- Create the controls and setup the layout.
		do
			set_pixmaps_size (16, 16)
		end

	build_tree is
			-- Remove and replace contents of `Current'.
		local
			l_env: EV_ENVIRONMENT
			l_locked: BOOLEAN
		do
			create l_env
			if window /= Void and l_env.application.locked_window = Void then
					-- Lock update of window, so rebuilding of `Current'
					-- is hidden.			
				window.lock_update
				l_locked := True
			end

			build_tree_on_list (Current)

			if window /= Void and l_locked then
					-- Unlock update of window as `Current' has
					-- been rebuilt.
				window.unlock_update
			end
		end

	build_tree_on_list (a_list: EV_DYNAMIC_LIST [EV_CONTAINABLE])
			-- Build tree on `a_list'
		require
			a_list_not_void: a_list /= Void
		local
			l_target: CONF_TARGET
		do
				-- Remove all items, ready for rebuilding.
			if Eiffel_project.initialized and then Universe.target /= Void then
				store_expanded_state
					-- Store expanded state of `Current'

				a_list.wipe_out

				l_target := Universe.target

					-- sort clusters
				create cluster_header.make (interface_names.l_class_tree_clusters, pixmaps.icon_pixmaps.top_level_folder_clusters_icon)
				build_group_tree (a_list, manager.clusters, cluster_header)
				cluster_header.set_pebble (create {DATA_STONE}.make (groups_from_sorted_clusters (manager.clusters, True), agent is_group_valid))
				if context_menu_factory /= Void then
					cluster_header.set_configurable_target_menu_mode
					cluster_header.set_configurable_target_menu_handler (agent context_menu_factory.clusters_data_menu)
				end

					-- sort overrides
				create override_header.make (interface_names.l_class_tree_overrides, pixmaps.icon_pixmaps.top_level_folder_overrides_icon)
				build_group_tree (a_list, manager.overrides, override_header)
				override_header.set_pebble (create {DATA_STONE}.make (groups_from_sorted_clusters (manager.overrides, False), agent is_group_valid))
				if context_menu_factory /= Void then
					override_header.set_configurable_target_menu_mode
					override_header.set_configurable_target_menu_handler (agent context_menu_factory.clusters_data_menu)
				end

					-- sort libraries
				create library_header.make (interface_names.l_class_tree_libraries, pixmaps.icon_pixmaps.top_level_folder_library_icon)
				build_group_tree (a_list, manager.libraries, library_header)
				library_header.set_pebble (create {DATA_STONE}.make (groups_from_sorted_clusters (manager.libraries, False), agent is_group_valid))
				if context_menu_factory /= Void then
					library_header.set_configurable_target_menu_mode
					library_header.set_configurable_target_menu_handler (agent context_menu_factory.libraries_data_menu)
				end

					-- sort assemblies
				create assembly_header.make (interface_names.l_class_tree_assemblies, pixmaps.icon_pixmaps.top_level_folder_references_icon)
				build_group_tree (a_list, manager.assemblies, assembly_header)
				assembly_header.set_pebble (create {DATA_STONE}.make (groups_from_sorted_clusters (manager.assemblies, False), agent is_group_valid))
				if context_menu_factory /= Void then
					assembly_header.set_configurable_target_menu_mode
					assembly_header.set_configurable_target_menu_handler (agent context_menu_factory.assemblies_data_menu)
				end

					-- targets
				if has_targets then
					build_target_tree (a_list)
				end

				restore_expanded_state
					-- Restore original expanded state, stored during last call to
					-- `store_expanded_state'				
			end
		end

feature -- Activation

	associate_textable_recursively (a_textable: EV_TEXT_COMPONENT; a_list: EV_DYNAMIC_LIST [EV_TREE_NODE]) is
			-- Associate `a_textable' with all items in `a_list'
		require
			not_void: a_textable /= Void
			not_void: a_list /= Void
		local
			l_item: EB_CLASSES_TREE_ITEM
			l_actions: EV_TREE_NODE_ACTION_SEQUENCES
		do
			from
				a_list.start
			until
				a_list.after
			loop
				l_item ?= a_list.item
				if l_item /= Void then
					l_item.set_associated_textable (a_textable)

					if l_item.text.is_equal (l_item.dummy_string) then
						-- Current `a_list' contain dummy node, we set `a_textable' with it in expand actions
						l_actions ?= a_list
						if l_actions /= Void then
							l_actions.expand_actions.extend_kamikaze (agent associate_textable_recursively (a_textable, a_list))
						end
					end
				end

				associate_textable_recursively (a_textable, a_list.item)
				a_list.forth
			end
		end

	associate_textable_with_classes (a_textable: EV_TEXT_COMPONENT) is
			-- Set `textable' to `a_textable'
		do
			textable := a_textable
		end

	associate_with_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Set `window' to `a_window'.
		do
			if window = Void then
				key_press_actions.extend (agent on_key_pushed)
			end
			window := a_window
		end

	add_double_click_action_to_classes (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add a double click action for classes.
		do
			classes_double_click_agents.extend (p)
		end

	add_double_click_action_to_cluster (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add a double click action for classes.
		do
			cluster_double_click_agents.extend (p)
		end

	show_stone (a_stone: STONE) is
			-- Display node that represents `a_stone'.
		require
			a_stone_not_void: a_stone /= Void
		local
			classi_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
			l_grp: CONF_GROUP
			l_path: STRING
		do
			classi_stone ?= a_stone
			if classi_stone /= Void then
				l_grp := classi_stone.group
				l_path := classi_stone.class_i.config_class.path
			end
			if l_grp = Void then
				cluster_stone ?= a_stone
				if cluster_stone /= Void then
					l_grp := cluster_stone.group
					l_path := cluster_stone.path
				end
			end
			if l_grp /= Void then
				check
					path_set: l_path /= Void
				end
				show_subfolder (l_grp, l_path)
			end
		end

	show_subfolder (a_group: CONF_GROUP; a_path: STRING) is
			-- Expand all parents of `a_group' and `a_path' and show the folder.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			path: LINKED_LIST [CONF_GROUP]
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			l_sub: LIST [STRING]
		do
			path := cluster_parents (a_group)
			from
				path.start
				a_folder := find_cluster_in (path.item, a_folder)
				if a_folder /= Void and then a_folder.is_expandable and not a_folder.is_expanded then
					a_folder.expand
				end
				path.forth
			until
				path.after or else a_folder = Void
			loop
				a_folder := find_cluster_in (path.item, a_folder)
				if a_folder /= Void and then a_folder.is_expandable and not a_folder.is_expanded then
					a_folder.expand
				end
				path.forth
			end
			l_sub := a_path.split ('/')
			check
				not_empty: not l_sub.is_empty
			end
			from
				l_sub.start
				l_sub.forth
			until
				l_sub.after or a_folder = Void
			loop
				a_folder := find_subfolder_in (l_sub.item, a_folder)
				if a_folder /= Void and then a_folder.is_expandable and not a_folder.is_expanded then
					a_folder.expand
				end
				l_sub.forth
			end
			if a_folder /= Void then
				a_folder.enable_select
			end
		end

	show_class (a_class: CLASS_I) is
			-- Expand all parents of `a_class' and highlight `a_class'.
		local
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class_item: EB_CLASSES_TREE_CLASS_ITEM
		do
			show_subfolder (a_class.group, a_class.config_class.path)
			a_folder ?= selected_item
			if a_folder /= Void then
				a_class_item := find_class_in (a_class, a_folder)
				if a_class_item /= Void then
					a_class_item.enable_select
				end
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

	on_class_moved (a_class: CONF_CLASS; old_group: CONF_GROUP; old_path: STRING) is
			-- Refresh the tree to display `a_class' in its new folder.
			-- `old_path' is old relative path in `old_group'
		do
			refresh
		end

	on_cluster_added (a_cluster: CLUSTER_I) is
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

feature {NONE} -- Status report

	has_readonly_items: BOOLEAN
			-- Shall read only items be shown in `Current'?
		do
			Result := True
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		local
			l_item: EB_CLASSES_TREE_ITEM
		do
			manager.remove_observer (Current)
			from
				start
			until
				after
			loop
				l_item ?= item
				if l_item /= Void then
					l_item.recycle
				end
				forth
			end
			set_configurable_target_menu_handler (Void)
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

	target: EB_CLASSES_TREE_TARGET_ITEM
			-- Targets.

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
				if selected_item /= Void and is_displayed then
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
						prompts.show_warning_prompt ("Class file could not be read. Removing class from the system.", Void, Void)
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
			l_sys: CONF_SYSTEM
		do
			l_sys := universe.target.system
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
				if l_next_group = Void then
					l_next_group := l_group.target.system.lowest_used_in_library
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
				elseif clusteri.is_assembly or clusteri.is_physical_assembly then
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

	build_group_tree (a_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]; a_grps: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]; a_header: EB_CLASSES_TREE_HEADER_ITEM) is
			-- Build a tree for `a_grps' under `a_header' and add it to the tree if we have elements.
			-- Attach the tree to `a_list'
		require
			a_list_not_void: a_list /= Void
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
				if not l_group.actual_group.is_internal and (has_readonly_items or l_group.is_writable) then
					l_item := create_folder_item (l_group)

					if textable /= void and not is_show_classes then
						l_item.set_associated_textable (textable)
					end

					a_header.extend (l_item)
					l_item.associate_with_window (window)
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
					from
						cluster_double_click_agents.start
					until
						cluster_double_click_agents.after
					loop
						l_item.add_double_click_action_to_cluster (cluster_double_click_agents.item)
						cluster_double_click_agents.forth
					end
				end
				a_grps.forth
			end
			if not a_header.is_empty then
				a_list.extend (a_header)
			end
		end

	build_target_tree (a_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]) is
			-- Build a tree for the targets of the current system, that make up the application target.
			-- Attach the tree to `a_list'
		require
			a_list_not_void: a_list /= Void
		local
			l_target: CONF_TARGET
			l_item, l_new_item: EB_CLASSES_TREE_TARGET_ITEM
		do
			from
				l_target := universe.target
				create l_item.make (l_target)
			until
				l_target.extends = Void
			loop
				l_target := l_target.extends
				create l_new_item.make (l_target)
				l_new_item.extend (l_item)
				l_item := l_new_item
			end
			target := l_item
			a_list.extend (target)
			target.associate_with_window (window)
		end

	has_targets: BOOLEAN
			-- Is tree showing targets?

	groups_from_sorted_clusters (a_sorted_clusters: DS_LIST [EB_SORTED_CLUSTER]; a_recursive: BOOLEAN): LIST [CONF_GROUP] is
			-- List of groups from `a_sorted_clusters'.
			-- If `a_recursive' is True, retrieve groups recursively.
		local
			l_group_set: DS_HASH_SET [CONF_GROUP]
			l_set_cursor: DS_HASH_SET_CURSOR [CONF_GROUP]
			l_list_cursor: DS_LIST_CURSOR [EB_SORTED_CLUSTER]
		do
			create {LINKED_LIST [CONF_GROUP]} Result.make
			if a_sorted_clusters /= Void then
				create l_group_set.make (10)
				l_list_cursor := a_sorted_clusters.new_cursor
				from
					l_list_cursor.start
				until
					l_list_cursor.after
				loop
					find_groups (l_list_cursor.item, l_group_set, a_recursive)
					l_list_cursor.forth
				end

				l_set_cursor := l_group_set.new_cursor
				from
					l_set_cursor.start
				until
					l_set_cursor.after
				loop
					Result.extend (l_set_cursor.item)
					l_set_cursor.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

	find_groups (a_source: EB_SORTED_CLUSTER; a_group_set: DS_HASH_SET [CONF_GROUP]; a_recursive: BOOLEAN) is
			-- Find groups from `a_source' and store them in `a_group_set'.
			-- If `a_recursive' is True, search for groups recursively.
		require
			a_source_attached: a_source /= Void
			a_group_set_attached: a_group_set /= Void
		local
			l_group: CONF_GROUP
			l_children: DS_LINKED_LIST [EB_SORTED_CLUSTER]
			l_cursor: DS_LINKED_LIST_CURSOR [EB_SORTED_CLUSTER]
		do
			l_group := a_source.actual_group
			if l_group /= Void and then not a_group_set.has (l_group) then
				a_group_set.force_last (l_group)
				if a_recursive then
					create l_children.make
					safe_append_list (l_children, a_source.clusters)
					safe_append_list (l_children, a_source.overrides)
					safe_append_list (l_children, a_source.libraries)
					safe_append_list (l_children, a_source.assemblies)
					l_cursor := l_children.new_cursor
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						find_groups (l_cursor.item, a_group_set, a_recursive)
						l_cursor.forth
					end
				end
			end
		end

	safe_append_list (a_source: DS_LIST [EB_SORTED_CLUSTER]; a_dest: DS_LIST [EB_SORTED_CLUSTER]) is
			-- If `a_dest' is not Void, append it to `a_source'.
		require
			a_source_attached: a_source /= Void
		do
			if a_dest /= Void then
				a_source.append_last (a_dest)
			end
		end

	is_group_valid (a_data: ANY): BOOLEAN is
			-- Does `a_data' contain valid groups information?
		local
			l_groups: LIST [CONF_GROUP]
		do
			if a_data = Void then
				Result := True
			else
				l_groups ?= a_data
				if l_groups /= Void then
					Result := l_groups.for_all (agent (a_group: CONF_GROUP): BOOLEAN do Result := a_group /= Void and then a_group.is_valid end)
				end
			end
		end

	is_show_classes: BOOLEAN
			-- Show classes notes?

feature {NONE} -- Factory

	create_folder_item (a_group: EB_SORTED_CLUSTER): EB_CLASSES_TREE_FOLDER_ITEM
			-- Create new folder item
		do
			create Result.make_with_option (a_group, is_show_classes)
		end

feature {EB_CLASSES_TREE_ITEM} -- Protected Properties

	context_menu_factory: EB_CONTEXT_MENU_FACTORY
			-- Context menu factory

	classes_double_click_agents: LINKED_LIST [PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]]
			-- Agents associated to double-clicks on classes.

	cluster_double_click_agents: LINKED_LIST [PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]];
			-- Agents associated to double-clicks on clusters.

invariant
	classes_double_click_agents_not_void: classes_double_click_agents /= Void
	cluster_double_click_agents_not_void: cluster_double_click_agents /= Void
	expanded_clusters_not_void: expanded_clusters /= Void

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
