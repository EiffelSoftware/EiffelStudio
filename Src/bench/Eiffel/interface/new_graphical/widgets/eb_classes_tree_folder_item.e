indexing
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
			set_data
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
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
	make_sub

feature -- Initialization

	make (a_cluster: EB_SORTED_CLUSTER) is
			-- Create a tree item representing `a_cluster'.
		require
			a_cluster_ok: a_cluster /= Void
		do
			make_sub (a_cluster, "")
		end

	make_sub (a_cluster: EB_SORTED_CLUSTER; a_path: STRING) is
			-- Create a tree item representing a subfolder of `a_cluster'.
		require
			a_path_ok: a_path /= Void
			a_cluster_ok: a_cluster /= Void
			sub_elements_imply_initialized: not a_path.is_empty implies a_cluster.is_initialized
		do
			default_create
			path := a_path
			if path = Void then
				create path.make_empty
			end
			create classes_double_click_agents.make
			set_data (a_cluster)
			expand_actions.extend (agent load)
		end


feature -- Status report

	data: EB_SORTED_CLUSTER
			-- cluster represented by `Current'.

	path: STRING
			-- relativ path to cluster location (for recursive clusters).

	name: STRING
			-- name of the item.

feature -- Access

	stone: CLUSTER_STONE is
			-- Cluster stone representing `data'.
		local
			l_group: CONF_GROUP
		do
			l_group := data.actual_group
			if l_group.is_cluster then
				create Result.make_subfolder (data.actual_group, path)
			else
				create Result.make (data.actual_group)
			end
		end

feature -- Status setting

	set_data (a_cluster: EB_SORTED_CLUSTER) is
			-- Affect `a_cluster' to `data'.
		local
			l_group: CONF_GROUP
			l_pos: INTEGER
		do
			data := a_cluster
			l_group := a_cluster.actual_group
			set_pebble (stone)
			if not path.is_empty then
				l_pos := path.last_index_of ('/', path.count)
				if l_pos > 0 then
					name := path.substring (l_pos+1, path.count)
				else
					create name.make_empty
				end
			end
			if name = Void then
				name := l_group.name
			end
			set_text (name)
			set_tooltip (name)
			set_accept_cursor (Cursors.cur_Cluster)
			set_deny_cursor (Cursors.cur_X_Cluster)
			set_pixmap (pixmap_from_group (l_group))
			if not (l_group.is_readonly) then
				drop_actions.set_veto_pebble_function (agent droppable)
				drop_actions.extend (agent on_class_drop)
--| FIXME XR: When clusters can be moved effectively, uncomment this line.
--				drop_actions.extend (~on_cluster_drop)
			end
			fake_load
		ensure then
			data = a_cluster
			name_set: name /= Void
		end

	add_class (a_class: CLASS_I) is
			-- Add `a_class' to `Current' at its right place.
		local
			conv_class_item: EB_CLASSES_TREE_CLASS_ITEM
			found: BOOLEAN
			new_class: EB_CLASSES_TREE_CLASS_ITEM
		do
			from
				start
			until
				found or else after
			loop
				conv_class_item ?= item
				if conv_class_item /= Void then
					if conv_class_item.data >= a_class then
						found := True
					else
						forth
					end
				else
					forth
				end
			end
			create new_class.make (a_class)
			put_left (new_class)

			if associated_window /= Void then
				new_class.set_associated_window (associated_window)
			end
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

feature {EB_CLASSES_TREE_CLASS_ITEM} -- Interactivity

	load is
			-- Load the classes and the sub_clusters of `data'.
		local
			subfolders: SORTABLE_ARRAY [STRING]
			classes: DS_LIST [CLASS_I]
			l_subfolder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class: EB_CLASSES_TREE_CLASS_ITEM
			orig_count: INTEGER
			i, up: INTEGER
			l_dir: KL_DIRECTORY
			l_set: ARRAY [STRING]
			l_hash_set: DS_HASH_SET [STRING]
			cluster: CLUSTER_I
			group: CONF_GROUP
			l_sub_path: STRING
			l_fr: CONF_FILE_RULE
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
			cluster ?= group
			if cluster /= Void and then cluster.is_recursive then
				create l_dir.make (group.location.build_path (path, ""))
				l_set := l_dir.directory_names
				if l_set /= Void then
					create subfolders.make_from_array (l_set)
					subfolders.sort
					from
						l_fr := cluster.file_rule
						i := subfolders.lower
						up := subfolders.upper
					until
						i > up
					loop
						l_sub_path := path+"/"+subfolders[i]
						if l_fr.is_included (l_sub_path) then
							create l_subfolder.make_sub (data, l_sub_path)
							if associated_window /= Void then
								l_subfolder.associate_with_window (associated_window)
							end
							if associated_textable /= Void then
								l_subfolder.associate_textable_with_classes (associated_textable)
							end

							extend (l_subfolder)
						end
						i := i + 1
					end
				end
				-- if we are an assembly show subfolders
			elseif group.is_assembly then
				l_hash_set := data.sub_folders.item (path+"/")
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
						create l_subfolder.make_sub (data, path+"/"+subfolders[i])
						if associated_window /= Void then
							l_subfolder.associate_with_window (associated_window)
						end
						if associated_textable /= Void then
							l_subfolder.associate_textable_with_classes (associated_textable)
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
			if path.is_empty and data.is_assembly then
				show_groups (data.assemblies)
			end

				-- show classes for clusters and assemblies
			if data.is_cluster or data.is_assembly then
				classes := data.sub_classes.item (path+"/")
			end
			if classes /= Void then
				from
					classes.start
				until
					classes.after
				loop
					create a_class.make (classes.item_for_iteration)
					if associated_window /= Void then
						a_class.set_associated_window (associated_window)
					end
					if associated_textable /= Void then
						a_class.set_associated_textable (associated_textable)
					end

					from
						classes_double_click_agents.start
					until
						classes_double_click_agents.after
					loop
						a_class.add_double_click_action (classes_double_click_agents.item)
						classes_double_click_agents.forth
					end
					extend (a_class)
					classes.forth
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
		end

	on_class_drop (cstone: CLASSI_STONE) is
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

	on_cluster_drop (cluster: CLUSTER_STONE) is
			-- A cluster was dropped in `Current'.
			-- Add `cluster' to `Current' via the cluster manager.
		do
--			parent_tree.manager.move_cluster (cluster.cluster_i, data.actual_cluster)
--			parent_tree.manager.remove_cluster_i (cluster.cluster_i)
--			parent_tree.manager.add_cluster_i (cluster.cluster_i, data.actual_cluster)
		end

feature -- Interactivity

	associate_textable_with_classes (textable: EV_TEXT_COMPONENT) is
			-- Recursively associate `textable' with sub-classes so they can write their names in `textable'.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
			conv_class: EB_CLASSES_TREE_CLASS_ITEM
		do
			associated_textable := textable

			from
				start
			until
				after
			loop
				conv_folder ?= item
				if conv_folder /= Void then
					conv_folder.associate_textable_with_classes (textable)
				else
					conv_class ?= item
					conv_class.set_associated_textable (textable)
				end
				forth
			end
		end

	associate_with_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Recursively associate `a_window' with sub-classes so they can call `set_stone' on `a_window'.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
			conv_class: EB_CLASSES_TREE_CLASS_ITEM
		do
			if associated_window = Void then
				pointer_button_press_actions.extend (agent double_press_action)
			end

			associated_window := a_window

			from
				start
			until
				after
			loop
				conv_folder ?= item
				if conv_folder /= Void then
					conv_folder.associate_with_window (a_window)
				else
					conv_class ?= item
					conv_class.set_associated_window (a_window)
				end
				forth
			end
		end

	add_double_click_action_to_classes (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add `p' recursively to the list of actions associated with a double click in child classes.
		local
			conv_folder: EB_CLASSES_TREE_FOLDER_ITEM
			conv_class: EB_CLASSES_TREE_CLASS_ITEM
		do
			classes_double_click_agents.extend (p)

			from
				start
			until
				after
			loop
				conv_folder ?= item
				if conv_folder /= Void then
					conv_folder.add_double_click_action_to_classes (p)
				else
					conv_class ?= item
					if conv_class /= Void then
						conv_class.add_double_click_action (p)
					end
				end
				forth
			end
		end

feature {NONE} -- Implementation

	associated_textable: EV_TEXT_COMPONENT
			-- Where should clicked classes print their names?

	associated_window: EB_DEVELOPMENT_WINDOW
			-- Where should clicked classes set a stone?

	classes_double_click_agents: LINKED_LIST [PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]]
			-- Agents associated to double-clicks on classes.

feature {EB_CLASSES_TREE} -- Implementation

	fake_load is
			-- Load only one child, preferably a class (quicker to create).
			-- This is needed to have allow for expansion if we have children.
		local
			l_has_children: BOOLEAN
			l_dir: KL_DIRECTORY
			l_sub_dirs: ARRAY [STRING]
			i, up: INTEGER
			l_fr: CONF_FILE_RULE
			l_sub_path: STRING
		do
			wipe_out
				-- non sub elements
			if path.is_empty then
				l_has_children := data.has_children
				-- sub elements
			else
					-- check classes
				l_has_children := data.sub_classes.has (path + "/")

					-- check folders
				if not l_has_children then
					if data.is_assembly then
						l_has_children := data.sub_folders.has (path + "/")
					elseif data.is_cluster then
						create l_dir.make (data.actual_group.location.build_path (path, ""))
						l_sub_dirs := l_dir.directory_names
						if l_sub_dirs /= Void then
							from
								l_fr := data.actual_cluster.file_rule
								i := l_sub_dirs.lower
								up := l_sub_dirs.upper
							until
								i > up or l_has_children
							loop
								l_sub_path := path+"/"+l_sub_dirs[i]
								if l_fr.is_included (l_sub_path) then
									l_has_children := True
								end
								i := i + 1
							end
						end
					end
				end
			end
			if l_has_children then
					-- add a dummy item
				extend (create {EB_CLASSES_TREE_CLASS_ITEM}.make (system.any_class))
			end
		end

feature {NONE} -- Implementation

	double_press_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Send a stone corresponding to `Current' to `associated_window'.
		do
			if a_button = 1 and then associated_window /= Void then
				associated_window.set_stone (stone)
			end
		end

	droppable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		local
			cs: CLASSI_STONE
			fs: FEATURE_STONE
		do
				-- we can only drop on clusters
			if data.is_cluster then
				cs ?= a_pebble
				if cs /= Void then
						-- Some class stone was selected.
					fs ?= a_pebble
					Result := fs = Void
				end
			end
		end

	show_groups (a_groups: DS_LIST [EB_SORTED_CLUSTER]) is
			-- Show `a_groups'.
		require
			a_groups_not_void: a_groups /= Void
		local
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			l_group: EB_SORTED_CLUSTER
		do
				from
					a_groups.start
				until
					a_groups.after
				loop
					l_group := a_groups.item_for_iteration
					create a_folder.make (l_group)

					if associated_window /= Void then
						a_folder.associate_with_window (associated_window)
					end
					if associated_textable /= Void then
						a_folder.associate_textable_with_classes (associated_textable)
					end

					from
						classes_double_click_agents.start
					until
						classes_double_click_agents.after
					loop
						a_folder.add_double_click_action_to_classes (classes_double_click_agents.item)
						classes_double_click_agents.forth
					end
					extend (a_folder)
					a_groups.forth
				end
		end

invariant
	data_not_void: data /= Void
	path_not_void: path /= Void
	sub_elements_imply_initialized: not path.is_empty implies data.is_initialized

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
