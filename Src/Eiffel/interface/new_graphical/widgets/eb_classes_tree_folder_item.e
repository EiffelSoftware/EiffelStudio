note
	description: "Representation of a cluster in the cluster tree."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_FOLDER_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			data,
			set_data,
			print_name,
			internal_recycle,
			associate_with_window
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make,
	make_sub,
	make_with_option,
	make_with_all_options

feature -- Initialization

	make (a_cluster: EB_SORTED_CLUSTER)
			-- Create a tree item representing `a_cluster'.
		require
			a_cluster_ok: a_cluster /= Void
		do
			make_sub (a_cluster, "")
		end

	make_sub (a_cluster: EB_SORTED_CLUSTER; a_path: READABLE_STRING_32)
			-- Create a tree item representing a subfolder of `a_cluster'.
		require
			a_path_ok: a_path /= Void
			a_cluster_ok: a_cluster /= Void
			sub_elements_imply_initialized: not a_path.is_empty implies a_cluster.is_initialized
		do
			default_create
			create path.make_from_string (a_path)
			if path = Void then
				create path.make_empty
			end
			create classes_double_click_agents.make
			create cluster_double_click_agents.make
			create classes_single_click_agents.make
			create cluster_single_click_agents.make
			pointer_button_press_actions.extend (agent register_pressed_item)
			set_data (a_cluster)
			expand_actions.extend (agent load)
			is_show_classes := True
		end

	make_with_all_options (a_cluster: EB_SORTED_CLUSTER; a_path: READABLE_STRING_32; a_show_classes: BOOLEAN)
			-- Create with various options
		require
			a_cluster_ok: a_cluster /= Void
			a_path_ok: a_path /= Void
			sub_elements_imply_initialized: not a_path.is_empty implies a_cluster.is_initialized
		do
			make_sub (a_cluster, a_path)
			is_show_classes := a_show_classes
		end

	make_with_option (a_cluster: EB_SORTED_CLUSTER; a_show_classes: BOOLEAN)
			-- Create with option `a_show_classes'
		require
			a_cluster_ok: a_cluster /= Void
		do
			make (a_cluster)
			is_show_classes := a_show_classes
		end

	is_show_classes: BOOLEAN
		-- Show classes notes?

feature -- Status report

	data: EB_SORTED_CLUSTER
			-- cluster represented by `Current'.

	path: IMMUTABLE_STRING_32
			-- Relative path to cluster location (for recursive clusters).

	name: IMMUTABLE_STRING_32
			-- name of the item.

feature -- Access

	stone: CLUSTER_STONE
			-- Cluster stone representing `data'.
		local
			l_group: CONF_GROUP
		do
			l_group := data.actual_group
			if l_group.is_cluster then
				create Result.make_subfolder (data.actual_group, path, name)
			else
				create Result.make (data.actual_group)
			end
		end

feature -- Status setting

	set_data (a_cluster: EB_SORTED_CLUSTER)
			-- Affect `a_cluster' to `data'.
		local
			l_group: CONF_GROUP
			l_pos: INTEGER
		do
			data := a_cluster
			l_group := a_cluster.actual_group
			if not path.is_empty then
				l_pos := path.last_index_of ('/', path.count)
				if l_pos > 0 then
					name := path.substring (l_pos + 1, path.count)
				else
					name := path
				end
			else
				name := l_group.name
			end
			set_pebble (stone)
			set_text (name)
			set_tooltip (tooltip_text)
			if a_cluster.is_assembly then
				set_accept_cursor (cursors.cur_assembly)
				set_deny_cursor (cursors.cur_x_assembly)
			elseif a_cluster.is_library then
				set_accept_cursor (cursors.cur_library)
				set_deny_cursor (cursors.cur_x_library)
			else
				set_accept_cursor (Cursors.cur_Cluster)
				set_deny_cursor (Cursors.cur_X_Cluster)
			end
			associated_pixmap := pixmap_from_group_path (l_group, path)
			set_pixmap (associated_pixmap)
			if not (l_group.is_readonly) then
				drop_actions.set_veto_pebble_function (agent droppable)
				drop_actions.extend (agent on_class_drop)
--| FIXME XR: When clusters can be moved effectively, uncomment this line.
--				drop_actions.extend (~on_cluster_drop)
			end
			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
			fake_load
		ensure then
			data = a_cluster
			name_set: name /= Void
		end

	add_class (a_class: CLASS_I)
			-- Add `a_class' to `Current' at its right place.
		local
			found: BOOLEAN
			new_class: EB_CLASSES_TREE_CLASS_ITEM
			l_name: STRING_32
		do
			from
				start
			until
				found or else after
			loop
				if attached {EB_CLASSES_TREE_CLASS_ITEM} item as conv_class_item then
					if conv_class_item.data >= a_class then
						found := True
					else
						forth
					end
				else
					forth
				end
			end
			l_name := a_class.name.twin
			if data.renaming.has (l_name)  then
				l_name := data.renaming.item (l_name)
			end
			l_name.prepend (data.name_prefix)
			create new_class.make (a_class, l_name)
			put_left (new_class)

			new_class.associate_with_window (associated_window)
			if associated_textable /= Void then
				new_class.set_associated_textable (associated_textable)
			end
			from
				classes_double_click_agents.start
			until
				classes_double_click_agents.after
			loop
				new_class.add_double_click_action (classes_double_click_agents.item)
				classes_double_click_agents.forth
			end
		end

feature {NONE} -- Query

	is_valid_class (a_class: CLASS_I): BOOLEAN
			-- Is class valid for beeing displayed in `Current'?
		do
			Result := a_class.is_valid
		ensure
			result_implies_valid: Result implies a_class.is_valid
		end

feature {EB_CLASSES_TREE_CLASS_ITEM} -- Interactivity

	 load
			-- Load the classes and the sub_clusters of `data'.
		local
			subfolders: SORTABLE_ARRAY [READABLE_STRING_32]
			classes: DS_LIST [CLASS_I]
			l_subfolder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class: EB_CLASSES_TREE_CLASS_ITEM
			orig_count: INTEGER
			i, up: INTEGER
			l_set: LIST [STRING_32]
			l_hash_set: DS_HASH_SET [READABLE_STRING_32]
			group: CONF_GROUP
			l_sub_path: IMMUTABLE_STRING_32
			l_fr: CONF_FILE_RULE
			l_name: STRING
			l_agents: like classes_double_click_agents
			u: FILE_UTILITIES
			l_sorter: QUICK_SORTER [STRING_32]
		do
			orig_count := count

			if not data.is_initialized then
				data.initialize
			end

				-- Build the tree.

				-- if we aren't a subfolder show clusters
			if path.is_empty then
				show_groups (data.clusters)
			end

				-- if we are a recursive cluster show subfolders
			group := data.actual_group
			if attached {CLUSTER_I} group as cluster and then cluster.is_recursive then
				l_set := u.directory_names (group.location.build_path (path, "").name)
				if l_set /= Void then
					create l_sorter.make (create {COMPARABLE_COMPARATOR [STRING_32]})
					l_sorter.sort (l_set)
					from
						l_fr := cluster.active_file_rule (universe.conf_state)
						l_set.start
					until
						l_set.after
					loop
						if l_fr.is_included (path, l_set.item) then
							if not path.is_empty then
								l_sub_path := path + cluster_separator + l_set.item
							else
								l_sub_path := l_set.item
							end
							l_subfolder := create_folder_item_with_options (data, l_sub_path)
							l_subfolder.associate_with_window (associated_window)
							if associated_textable /= Void then
								l_subfolder.associate_textable_with_classes (associated_textable)
							end

							if associated_textable /= Void and not is_show_classes then
								l_subfolder.set_associated_textable (associated_textable)
							end

							extend (l_subfolder)
						end
						l_set.forth
					end
				end
				-- if we are an assembly show subfolders
			elseif group.is_assembly or group.is_physical_assembly then
				l_hash_set := data.sub_folders.item (path)
				if l_hash_set /= Void then
					create subfolders.make (1, l_hash_set.count)
					from
						l_hash_set.start
						i := 1
					until
						l_hash_set.after
					loop
						subfolders.force (l_hash_set.item_for_iteration, i)
						i := i + 1
						l_hash_set.forth
					end
					subfolders.sort
					from
						i := subfolders.lower
						up := subfolders.upper
					until
						i > up
					loop
						if not path.is_empty then
							l_sub_path := path + cluster_separator + subfolders.item (i)
						else
							l_sub_path := subfolders.item (i)
						end
						l_subfolder := create_folder_item_with_options (data, l_sub_path)
						l_subfolder.associate_with_window (associated_window)
						if associated_textable /= Void then
							l_subfolder.associate_textable_with_classes (associated_textable)
						end
						if associated_textable /= Void and not is_show_classes then
							l_subfolder.set_associated_textable (associated_textable)
						end
						extend (l_subfolder)
						i := i + 1
					end
				end
			end

			if data.is_library then
					-- show overrides for libraries
				show_groups (data.overrides)

					-- show libraries for libraries
				show_groups (data.libraries)

					-- show assemblies for libraries
				show_groups (data.assemblies)
			end

				-- show assembly dependencies for assemblies if we are on not a subfolder
			if path.is_empty and (data.is_assembly or data.is_physical_assembly) then
				show_groups (data.assemblies)
			end

				-- show classes for clusters and assemblies
			if data.is_cluster or (data.is_assembly or data.is_physical_assembly) then
				if is_show_classes then
					classes := data.sub_classes.item (path)
					if classes /= Void then
						from
							classes.start
						until
							classes.after
						loop
							if is_valid_class (classes.item_for_iteration) then
								l_name := classes.item_for_iteration.name.twin
								if data.renaming.has (l_name) then
									l_name := data.renaming.item (l_name)
								end
								l_name.prepend (data.name_prefix)
								create a_class.make (classes.item_for_iteration, l_name)
								a_class.associate_with_window (associated_window)
								if associated_textable /= Void then
									a_class.set_associated_textable (associated_textable)
								end

								a_class.load_overriden_children
								extend (a_class)
							end
							classes.forth
						end
					end
				else
					if associated_textable /= Void then
						set_associated_textable (associated_textable)
					end
				end
			end

			l_agents := classes_double_click_agents
			if l_agents.is_empty then
				l_agents := parent_tree.classes_double_click_agents
			end
			if l_agents /= Void then
				from
					start
				until
					after
				loop
					from
						l_agents.start
					until
						l_agents.after
					loop
						if attached {EB_CLASSES_TREE_CLASS_ITEM} item as cl then
							cl.add_double_click_action (l_agents.item)
						else
							if attached {EB_CLASSES_TREE_FOLDER_ITEM} l_subfolder as sf then
								sf.add_double_click_action_to_classes (l_agents.item)
							end
						end
						l_agents.forth
					end
					l_agents := cluster_double_click_agents
					from
						l_agents.start
					until
						l_agents.after
					loop
						if attached {EB_CLASSES_TREE_FOLDER_ITEM} l_subfolder as sf then
							l_subfolder.add_double_click_action_to_cluster (l_agents.item)
						end
						l_agents.forth
					end
					l_agents := classes_single_click_agents
					from
						l_agents.start
					until
						l_agents.after
					loop

						if attached {EB_CLASSES_TREE_CLASS_ITEM} item as cl then
							cl.add_single_click_action (l_agents.item)
						elseif attached {EB_CLASSES_TREE_FOLDER_ITEM} l_subfolder as sf then
							l_subfolder.add_single_click_action_to_classes (l_agents.item)
						end
						l_agents.forth
					end
					l_agents := cluster_single_click_agents
					from
						l_agents.start
					until
						l_agents.after
					loop
						if attached {EB_CLASSES_TREE_FOLDER_ITEM} l_subfolder as sf then
							l_subfolder.add_single_click_action_to_cluster (l_agents.item)
						end
						l_agents.forth
					end
					forth
				end
			end

				-- We now remove all the items that were present at the beginning.
				--| We cannot wipe_out at first because under GTK it collapses `Current'.
			from
				i := 0
				start
			until
				i = orig_count
			loop
				remove
				i := i + 1
			end
				-- By removing `load' from `expand_actions', it ensures that
				-- the contents of the item are no longer created dynamically.
				-- This ensures that the tree retains its state as nodes are contracted and
				-- then expanded.
			expand_actions.wipe_out

				-- Notify the tree.
			if attached parent_tree as l_tree then
				l_tree.on_post_folder_loaded (Current)
			end
		end

	cluster_separator: STRING_32 = "/"
			-- Cluster sub path separator

	on_class_drop (cstone: CLASSI_STONE)
			-- A class was dropped in `Current'.
			-- Add corresponding class to `Current' via the cluster manager.
		require
			cluster: data.is_cluster
		local
			actual: CLASS_I
		do
			actual := cstone.class_i
			parent_tree.manager.move_class (actual.config_class, actual.group, data.actual_cluster, path)
		end

	on_cluster_drop (cluster: CLUSTER_STONE)
			-- A cluster was dropped in `Current'.
			-- Add `cluster' to `Current' via the cluster manager.
		do
--			parent_tree.manager.move_cluster (cluster.cluster_i, data.actual_cluster)
--			parent_tree.manager.remove_cluster_i (cluster.cluster_i)
--			parent_tree.manager.add_cluster_i (cluster.cluster_i, data.actual_cluster)
		end

feature -- Interactivity

	associate_textable_with_classes (textable: EV_TEXT_COMPONENT)
			-- Recursively associate `textable' with sub-classes so they can write their names in `textable'.
		do
			associated_textable := textable

			from
				start
			until
				after
			loop
				if attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder then
					conv_folder.associate_textable_with_classes (textable)
				elseif attached {EB_CLASSES_TREE_CLASS_ITEM} item as conv_class then
					conv_class.set_associated_textable (textable)
				else
					check either_folder_or_class: False end
				end
				forth
			end
		end

	associate_with_window (a_window: EB_STONABLE)
			-- Recursively associate `a_window' with sub-classes so they can call `set_stone' on `a_window'.
		do
			Precursor (a_window)
			from
				start
			until
				after
			loop
				if attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder then
					conv_folder.associate_with_window (a_window)
				elseif attached {EB_CLASSES_TREE_CLASS_ITEM} item as conv_class then
					conv_class.associate_with_window (a_window)
				else
					check either_folder_or_class: False end
				end
				forth
			end
		end

	add_double_click_action_to_classes (p: PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Add `p' recursively to the list of actions associated with a double click in child classes.
		do
			classes_double_click_agents.extend (p)

			from
				start
			until
				after
			loop
				if attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder then
					conv_folder.add_double_click_action_to_classes (p)
				elseif attached {EB_CLASSES_TREE_CLASS_ITEM} item as conv_class then
					conv_class.add_double_click_action (p)
				end
				forth
			end
		end

	add_double_click_action_to_cluster (p: PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Add `p' recursively to the list of actions associated with a double click in child clusters.
		local
			l_group: CONF_GROUP
		do
			cluster_double_click_agents.extend (p)

			from
				start
			until
				after
			loop
				if
					attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder and then
				 	attached {EB_SORTED_CLUSTER} conv_folder.data as l_cluster
				 then
					l_group := l_cluster.actual_group
					if l_group /= Void and then (l_group.is_cluster or l_group.is_library) then
						conv_folder.add_double_click_action_to_cluster (p)
					end
				end
				forth
			end
			pointer_double_press_actions.extend (p)
		end

	add_single_click_action_to_classes (p: PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Add `p' recursively to the list of actions associated with a single click in child classes.
		do
			classes_single_click_agents.extend (p)

			from
				start
			until
				after
			loop
				if attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder then
					conv_folder.add_single_click_action_to_classes (p)
				elseif attached {EB_CLASSES_TREE_CLASS_ITEM} item as conv_class then
					conv_class.add_single_click_action (p)
				end
				forth
			end
		end

	add_single_click_action_to_cluster (p: PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
			-- Add `p' recursively to the list of actions associated with a single click in child clusters.
		local
			l_group: CONF_GROUP
		do
			cluster_single_click_agents.extend (p)

			from
				start
			until
				after
			loop
				if
					attached {EB_CLASSES_TREE_FOLDER_ITEM} item as conv_folder and then
		 			attached {EB_SORTED_CLUSTER} conv_folder.data as l_cluster
		 		then
					l_group := l_cluster.actual_group
					if l_group /= Void and then (l_group.is_cluster or l_group.is_library) then
						conv_folder.add_single_click_action_to_cluster (p)
					end
				end
				forth
			end
			pointer_button_press_actions.extend (p)
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			Precursor {EB_CLASSES_TREE_ITEM}
			associated_window := Void
		end

feature {NONE} -- Implementation

	classes_double_click_agents: LINKED_LIST [PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			-- Agents associated to double-clicks on classes.

	cluster_double_click_agents: LINKED_LIST [PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			-- Agents associated to double-clicks on cluster.

	classes_single_click_agents: LINKED_LIST [PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			-- Agents associated to single-clicks on classes.

	cluster_single_click_agents: LINKED_LIST [PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			-- Agents associated to single-clicks on cluster.

feature {EB_CLASSES_TREE} -- Implementation

	fake_load
			-- Load only one child, preferably a class (quicker to create).
			-- This is needed to have allow for expansion if we have children.
		local
			l_has_children: BOOLEAN
			l_sub_dirs: ARRAYED_LIST [STRING_32]
			l_fr: CONF_FILE_RULE
			u: FILE_UTILITIES
			l_sorter: QUICK_SORTER [STRING_32]
		do
			wipe_out
				-- non sub elements
			if path.is_empty then
				l_has_children := data.has_children
				-- sub elements
			else
					-- check classes
				l_has_children := data.sub_classes.has (path)

					-- check folders
				if not l_has_children then
					if data.is_assembly or data.is_physical_assembly then
						l_has_children := data.sub_folders.has (path)
					elseif data.is_cluster then
						l_sub_dirs := u.directory_names (data.actual_group.location.build_path (path, "").name)
						if l_sub_dirs /= Void then
							create l_sorter.make (create {COMPARABLE_COMPARATOR [STRING_32]})
							l_sorter.sort (l_sub_dirs)
							from
								l_fr := data.actual_cluster.active_file_rule (universe.conf_state)
								l_sub_dirs.start
							until
								l_sub_dirs.after or l_has_children
							loop
								if l_fr.is_included (path, l_sub_dirs.item) then
									l_has_children := True
								end
								l_sub_dirs.forth
							end
						end
					end
				end
			end
			if l_has_children then
					-- add a dummy item
				if system.any_class /= Void then
					extend (create {EB_CLASSES_TREE_CLASS_ITEM}.make (system.any_class, dummy_string))
				end
			end
		end

feature {NONE} -- Implementation

	physical_assembly_tooltip_text (a_assembly: CONF_PHYSICAL_ASSEMBLY): STRING_32
			-- Generate tooltip text for `a_assembly'.
		local
			l_tmp: STRING_32
		do
			create Result.make_empty
			if a_assembly /= Void then
				Result.append (a_assembly.assembly_name)
				if not path.is_empty then
					Result.append_string_general (": ")
					create l_tmp.make_from_string_general (path)
					l_tmp.replace_substring_all (cluster_separator, {STRING_32} ".")
					Result.append (l_tmp)
				end
				Result.append_string_general ("%N")
				if attached a_assembly.assembly_culture as l_culture then
					Result.append (l_culture)
					Result.append_string_general ("%N")
				end
				if attached a_assembly.assembly_version as l_version then
					Result.append (l_version)
					Result.append_string_general ("%N")
				end
				if attached a_assembly.assembly_public_key_token as l_token then
					Result.append (l_token )
					Result.append_string_general ("%N")
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	tooltip_text: STRING_32
			-- Generate tooltip text for `data' and `path'.
		local
			l_as: CONF_ASSEMBLY
			l_lib: CONF_LIBRARY
		do
			create Result.make_empty
			if data.is_assembly then
				l_as := data.actual_assembly
				if l_as.classes_set then
					if attached {CONF_PHYSICAL_ASSEMBLY} l_as.physical_assembly as l_phys_as then
						Result.append (physical_assembly_tooltip_text (l_phys_as))
					else
						check is_physical_assembly: False end
					end
				end
				Result.append (data.actual_group.location.evaluated_path.name)
			elseif data.is_physical_assembly then
				if attached {CONF_PHYSICAL_ASSEMBLY} data.actual_group as l_phys_as then
					Result.append (physical_assembly_tooltip_text (l_phys_as))
					Result.append (data.actual_group.location.evaluated_path.name)
				else
					check is_physical_assembly: False end
				end
			elseif data.is_library then
				l_lib := data.actual_library
				if l_lib.library_target /= Void then
					Result.append (l_lib.library_target.system.name + "%N")
				else
					Result.append (l_lib.name + "%N")
				end
				Result.append (data.actual_group.location.evaluated_path.name)
			elseif data.is_cluster then
				Result.append (data.actual_group.name)
				if not path.is_empty then
					Result.append_character (':')
					Result.append_string_general (path)
				end
				Result.append_character ('%N')
				Result.append (data.actual_group.location.build_path (path, "").name)
			else
				check should_not_reach: False end
			end
			if attached data.actual_group.description as d then
				Result.append_character ('%N')
				Result.append_string (d)
			end
		ensure
			Result_not_void: Result /= Void
		end

	droppable (a_pebble: ANY): BOOLEAN
			-- Can user drop `a_pebble' on `Current'?
		do
				-- we can only drop on clusters
			if data.is_cluster then
				if attached {CLASSI_STONE} a_pebble as cs then
						-- Some class stone was selected.
					Result := not attached {FEATURE_STONE} a_pebble
				end
			end
		end

	show_groups (a_groups: DS_LIST [EB_SORTED_CLUSTER])
			-- Show `a_groups'.
		require
			a_groups_not_void: a_groups /= Void
		local
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			l_group: EB_SORTED_CLUSTER
			l_agents: like classes_double_click_agents
		do
			from
				a_groups.start
			until
				a_groups.after
			loop
				l_group := a_groups.item_for_iteration
				a_folder := create_folder_item (l_group)

				a_folder.associate_with_window (associated_window)
				if associated_textable /= Void then
					a_folder.associate_textable_with_classes (associated_textable)
				end

				l_agents := classes_double_click_agents
				from
					l_agents.start
				until
					l_agents.after
				loop
					a_folder.add_double_click_action_to_classes (l_agents.item)
					l_agents.forth
				end
				l_agents := classes_single_click_agents
				from
					l_agents.start
				until
					l_agents.after
				loop
					a_folder.add_single_click_action_to_classes (l_agents.item)
					l_agents.forth
				end
				extend (a_folder)
				a_groups.forth
			end
		end

	print_name
			-- Print class name in textable, the associated text component.
		local
			l_tmp, l_current_cluster: READABLE_STRING_GENERAL
		do
			l_tmp := path
			if associated_textable /= Void then
				if l_tmp /= Void and not l_tmp.is_empty then
					check only_one: cluster_separator.count = 1 end
					l_current_cluster := data.actual_cluster.cluster_name + l_tmp
				elseif data.is_cluster then
					l_current_cluster := data.actual_cluster.cluster_name
				else
				end

				if l_current_cluster /= Void then
					-- We set result here, query by EB_CHOOSE_CLUSTER_DIALOG.
					-- We first set data, then set text, so clients can hook to `change_actions' of `associated_textable' to query the data
					associated_textable.set_data ([id_solution.id_of_group (data.actual_cluster), path])

					associated_textable.set_text (l_current_cluster)
				else
					associated_textable.set_data (Void)
					associated_textable.set_text (text)
				end
			end
		end

	id_solution: EB_SHARED_ID_SOLUTION
			-- ID solution
		once
			create Result
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Factory

	create_folder_item_with_options (a_cluster: EB_SORTED_CLUSTER; a_path: READABLE_STRING_32): EB_CLASSES_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_all_options (a_cluster, a_path, is_show_classes)
		end

	create_folder_item (a_cluster: EB_SORTED_CLUSTER): EB_CLASSES_TREE_FOLDER_ITEM
			-- Create new folder item.
		do
			create Result.make_with_option (a_cluster, is_show_classes)
		end

invariant
	data_not_void: data /= Void
	path_not_void: path /= Void
	sub_elements_imply_initialized: not path.is_empty implies data.is_initialized

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end
