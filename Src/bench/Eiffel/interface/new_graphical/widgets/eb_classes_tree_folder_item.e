indexing
	description: "Representation of a cluster in the cluster tree."
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

creation
	make

feature -- Initialization

	make (a_cluster: EB_SORTED_CLUSTER) is
			-- Create a tree item representing `a_cluster'.
		do
			default_create
			create classes_double_click_agents.make
			set_data (a_cluster)
			collapse_actions.extend (~fake_load)
			expand_actions.extend (~load)
		end

feature -- Status report

	data: EB_SORTED_CLUSTER
			-- cluster represented by `Current'.

feature -- Access

	stone: CLUSTER_STONE is
			-- Cluster stone representing `data'.
		do
			create Result.make (data.actual_cluster)
		end

feature -- Status setting

	set_data (a_cluster: EB_SORTED_CLUSTER) is
			-- Affect `a_cluster' to `data'.
		local
			actual: CLUSTER_I
			name: STRING
		do
			actual := a_cluster.actual_cluster
			if not actual.belongs_to_all then
				set_text (actual.cluster_name)
			else
				name := actual.cluster_name
				set_text (name.substring (name.last_index_of ('.', name.count) + 1, name.count))
			end
			set_tooltip (actual.cluster_name)
			data := a_cluster
			set_pebble (stone)
			set_accept_cursor (Cursors.cur_Cluster)
			set_deny_cursor (Cursors.cur_X_Cluster)
			if actual.is_library or actual.is_precompiled then
				set_pixmap (Pixmaps.Icon_read_only_cluster)
			else
				set_pixmap (Pixmaps.Icon_cluster_symbol @ 1)
				drop_actions.set_veto_pebble_function (~droppable)
				drop_actions.extend (~on_class_drop)
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
			clusters: SORTED_LIST [EB_SORTED_CLUSTER]
			classes: SORTED_LIST [CLASS_I]
			a_folder: EB_CLASSES_TREE_FOLDER_ITEM
			a_class: EB_CLASSES_TREE_CLASS_ITEM
			orig_count: INTEGER
			i: INTEGER
		do
			orig_count := count
			clusters := data.clusters
			classes := data.classes
				-- Build the tree.
			from
				clusters.start
			until
				clusters.after
			loop
				create a_folder.make (clusters.item)
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
				clusters.forth
			end

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
		end

	on_class_drop (cstone: CLASSI_STONE) is
			-- A class was dropped in `Current'.
			-- Add corresponding class to `Current' via the cluster manager.
		local
			actual: CLASS_I
		do
			actual := cstone.class_i
			parent_tree.manager.move_class (actual, actual.cluster, data.actual_cluster)
		end

	on_cluster_drop (cluster: CLUSTER_STONE) is
			-- A cluster was dropped in `Current'.
			-- Add `cluster' to `Current' via the cluster manager.
		do
			parent_tree.manager.move_cluster (cluster.cluster_i, data.actual_cluster)
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
				pointer_button_press_actions.extend (~double_press_action)
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
			from
				clu := data.actual_cluster
			until
				clu = Void or else
				Result
			loop
				Result := (f = clu)
				clu := clu.parent_cluster
			end
		end

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
			a_folder: CLUSTER_STONE
		do
			a_folder ?= a_pebble
			if a_folder /= Void then
					-- Do not drop a folder on one of its children or on itself.
				Result := not cluster_contains_current (a_folder.cluster_i) --a_folder.cluster_i /= data.actual_cluster and then (not cluster_contains_current (a_folder.cluster_i))
			else
					-- Some class stone was selected.
				Result := True
			end
		end

invariant
	invariant_clause: -- Your invariant here

end -- class EB_CLASSES_TREE_FOLDER_ITEM

