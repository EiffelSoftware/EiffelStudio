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

create
	make,
	make_sub

feature -- Initialization

	make (a_cluster: EB_SORTED_CLUSTER) is
			-- Create a tree item representing `a_cluster'.
		do
			make_sub (a_cluster, "")
		end

	make_sub (a_cluster: EB_SORTED_CLUSTER; a_path: STRING) is
			-- Create a tree item representing a subfolder of `a_cluster'.
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

feature -- Access

	stone: CLUSTER_STONE is
			-- Cluster stone representing `data'.
		do
			create Result.make (data.actual_group)
		end

feature -- Status setting

	set_data (a_cluster: EB_SORTED_CLUSTER) is
			-- Affect `a_cluster' to `data'.
		local
			l_cluster: CLUSTER_I
			l_group: CONF_GROUP
			l_name: STRING
			l_pos: INTEGER
		do
			data := a_cluster
			l_group := a_cluster.actual_group
			l_cluster ?= l_group
			if l_cluster /= Void then
				if not path.is_empty then
					l_pos := path.last_index_of ('/', path.count)
					if l_pos > 0 then
						l_name := path.substring (l_pos+1, path.count)
					else
						create l_name.make_empty
					end
				end
				set_pebble (stone)
			end
			if l_name = Void then
				l_name := l_group.name
			end
			set_text (l_name)
			set_tooltip (l_name)
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
			classes: SORTED_LIST [CLASS_I]
			l_subfolder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class: EB_CLASSES_TREE_CLASS_ITEM
			orig_count: INTEGER
			i, up: INTEGER
			l_dir: KL_DIRECTORY
			l_set: ARRAY [STRING]
			cluster: CLUSTER_I
		do
			orig_count := count

				-- Build the tree.

				-- if we aren't a subfolder show clusters
			if path.is_empty then
				show_groups (data.clusters)
			end

				-- if we are a recursive cluster show subfolders
			cluster ?= data.actual_group
			if cluster /= Void and then cluster.is_recursive then
				create l_dir.make (cluster.location.build_path (path, ""))
				l_set := l_dir.directory_names
				if l_set /= Void then
					create subfolders.make_from_array (l_set)
					subfolders.sort
					from
						i := subfolders.lower
						up := subfolders.upper
					until
						i > up
					loop
						if cluster.file_rule.is_included (path+"/"+subfolders[i]) then
							create l_subfolder.make_sub (data, path+"/"+subfolders[i])
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
			end

			if data.is_library then
					-- show libraries for libraries
				show_groups (data.libraries)

					-- show assemblies for libraries
				show_groups (data.assemblies)
			end

				-- show classes for clusters and assemblies
			if data.is_cluster then
				classes := data.sub_classes.item (path+"/")
			elseif data.is_assembly then
				classes := data.classes
			end
			if classes /= Void then
				from
					classes.start
				until
					classes.after
				loop
					create a_class.make (classes.item)
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
		local
			actual: CLASS_I
		do
			actual := cstone.class_i
			conf_todo
--			parent_tree.manager.move_class (actual, actual.cluster, data.actual_cluster)
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
					conv_class.add_double_click_action (p)
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
		do
			wipe_out
			if not data.classes.is_empty then
				extend (create {EB_CLASSES_TREE_CLASS_ITEM}.make (data.classes.first))
			elseif not data.clusters.is_empty then
				extend (create {EB_CLASSES_TREE_FOLDER_ITEM}.make (data.clusters.first))
			end
		end

feature {NONE} -- Implementation

	cluster_contains_current (f: CLUSTER_I): BOOLEAN is
			-- Does `f' recursively contain `data'?
		require
			f_not_void: f /= Void
		local
			clu: CLUSTER_I
		do
--			from
--				clu := data.actual_cluster
--			until
--				clu = Void or else
--				Result
--			loop
--				Result := (f = clu)
--				clu := clu.parent_cluster
--			end
		end

	double_press_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Send a stone corresponding to `Current' to `associated_window'.
		do
			if data.actual_group.is_cluster and then a_button = 1 and then associated_window /= Void then
				associated_window.set_stone (stone)
			end
		end

	droppable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		local
			a_folder: CLUSTER_STONE
			fs: FEATURE_STONE
		do
			a_folder ?= a_pebble
			if a_folder /= Void then
					-- Do not drop a folder on one of its children or on itself.
				Result := not cluster_contains_current (a_folder.cluster_i) --a_folder.cluster_i /= data.actual_cluster and then (not cluster_contains_current (a_folder.cluster_i))
			else
					-- Some class stone was selected.
				fs ?= a_pebble
				Result := fs = Void
			end
		end

	show_groups (a_groups: SORTED_LIST [EB_SORTED_CLUSTER]) is
			-- Show `a_groups'.
		require
			a_groups_not_void: a_groups /= Void
		local
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
		do
				from
					a_groups.start
				until
					a_groups.after
				loop
					create a_folder.make (a_groups.item)
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
	path_not_void: path /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CLASSES_TREE_FOLDER_ITEM

