indexing
	description: "Representation of a class in the cluster tree."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_CLASS_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			data,
			set_data
		end

creation
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- Create a tree item representing class `a_class'.
		do
			default_create
			set_data (a_class)
		end

feature -- Status report

	data: CLASS_I
			-- Class represented by `Current'.

	stone: CLASSI_STONE is
			-- Class stone representing `Current', can be a classi_stone or a classc_stone.
		do
			if data.compiled then
				create {CLASSC_STONE} Result.make (data.compiled_class)
			else
				create {CLASSI_STONE} Result.make (data)
			end
		end

	editable: BOOLEAN is
			-- Can the class represented by `Current' be edited?
		do
			Result := not data.is_read_only and then not data.cluster.is_library
		end

feature -- Status setting

	set_data (a_class: CLASS_I) is
			-- Change the associated class to `a_class'.
		local
			name: STRING
		do
			name := clone (a_class.name)
			name.to_upper
			set_text (name)
			data := a_class
			set_pebble (stone)
			drop_actions.wipe_out
			drop_actions.set_veto_pebble_function (~droppable)
			set_accept_cursor (Cursors.cur_Class)
			set_deny_cursor (Cursors.cur_X_Class)
--| FIXME XR: Tooltips do not work on tree items yet.
--| Uncomment next line when they work.
--			set_tooltip (name)
			if
				a_class.cluster.is_library or else
				a_class.cluster.is_precompiled or else
				a_class.is_read_only
			then
				if not a_class.compiled then
					set_pixmap (Pixmaps.Icon_read_only_class_gray)
				else
					if a_class.compiled_class.is_deferred then
						set_pixmap (Pixmaps.Icon_deferred_read_only_class_color)
					else
						set_pixmap (Pixmaps.Icon_read_only_class_color)
					end
				end
			else
				if not a_class.compiled then
					set_pixmap (Pixmaps.Icon_class_symbol_gray)
				else
					if a_class.compiled_class.is_deferred then
						set_pixmap (Pixmaps.Icon_deferred_class_symbol_color)
					else
						set_pixmap (Pixmaps.Icon_class_symbol_color)
					end
				end
				drop_actions.extend (~on_class_drop)
--| FIXME XR: When clusters can be moved effectively, uncomment this line.
--				drop_actions.extend (~on_cluster_drop)
			end
		end

	set_associated_textable (textable: EV_TEXT_COMPONENT) is
			-- Associate `Current' with `textable' and change event handling.
		require
			textable /= Void
		do
			associated_textable := textable
			select_actions.wipe_out
			select_actions.extend (~print_name)
		end

	set_associated_window (window: like associated_window) is
			-- Associate `Current' with `window' and change event handling.
		require
			window /= Void
		do
			if associated_window = Void then
				pointer_button_press_actions.extend (~double_press_action)
			end
			associated_window := window
		end

	add_double_click_action (p: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]) is
			-- Add a double click action `p' on `Current'.
		do
			pointer_double_press_actions.extend (p)
		end

	on_class_drop (cstone: CLASSI_STONE) is
			-- Add class corresponding to `cstone' to parent folder.
		local
			fparent: EB_CLASSES_TREE_FOLDER_ITEM
			actual: CLASS_I
		do
			fparent ?= parent
			actual := cstone.class_i
			parent_tree.manager.move_class (actual, actual.cluster, fparent.data.actual_cluster)
		end

	on_cluster_drop (a_cluster: CLUSTER_STONE) is
			-- `a_cluster' was dropped in `Current'.
			-- Add `a_cluster' to `Current' via the cluster manager.
		local
			pcluster: EB_CLASSES_TREE_FOLDER_ITEM
		do
			pcluster ?= parent
			pcluster.on_cluster_drop (a_cluster)
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Interactivity

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	cluster_contains_class (f: CLUSTER_I): BOOLEAN is
			-- Does `f' recursively contains `data'?
		require
			f_not_void: f /= Void
		local
			clu: CLUSTER_I
		do
			from
				clu := data.cluster
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
			conv_folder: CLUSTER_STONE
			conv_st: CLASSI_STONE
			fs: FEATURE_STONE
		do
			conv_folder ?= a_pebble
			if conv_folder /= Void then
				Result := not cluster_contains_class (conv_folder.cluster_i)
			else
				conv_st ?= a_pebble
				fs ?= a_pebble
				Result :=
						-- We have a class stone...
					conv_st /= Void and then
						-- ...from a different cluster...
					conv_st.class_i.cluster /= data.cluster and then
						-- ...and that is not a feature.
					fs = Void
			end
		end

	associated_textable: EV_TEXT_COMPONENT
			-- Text component in which `Current' writes its name when clicked on.

	associated_window: EB_STONABLE
			-- Is `Current' already associated to a window?

	print_name is
			-- Print class name in textable, the associated text component.
		local
			name: STRING
		do
			if associated_textable /= Void then
				create name.make (data.name.count)
				name := clone (data.name)
				name.to_upper
				associated_textable.set_text (name)
			end
		end

end -- class EB_CLASSES_TREE_CLASS_ITEM
