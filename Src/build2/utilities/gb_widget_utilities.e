indexing	
	description: "Objects that provide useful facilities for widgets."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_WIDGET_UTILITIES

feature -- Basic operations

	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		local
			window: EV_WINDOW
		do
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := parent_window (widget.parent)
				end	
			else
				Result := window
			end	
		end
		
	parent_dialog (widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		local
			dialog: EV_DIALOG
		do
			dialog ?= widget.parent
			if dialog = Void then
				if widget.parent /= Void then
					Result := parent_dialog (widget.parent)
				end	
			else
				Result := dialog
			end	
		end
		
	x_position_relative_to_window (widget: EV_WIDGET): INTEGER is
			-- `Result' is the x position of `widget' relative to
			-- the EV_WINDOW containing `widget'.
			-- If `widget' is not contained in an EV_WINDOW, then
			-- there will be problems.
		local
			window: EV_WINDOW
		do
			Result := Result + widget.x_position
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := Result + x_position_relative_to_window (widget.parent)
				else
					check
						Widget_was_not_parented_in_a_window: False
					end
				end
			end
		end
		
	y_position_relative_to_window (widget: EV_WIDGET): INTEGER is
			-- `Result' is the y position of `widget' relative to
			-- the EV_WINDOW containing `widget'.
			-- If `widget' is not contained in an EV_WINDOW, then
			-- there will be problems.
		local
			window: EV_WINDOW
		do
			Result := Result + widget.y_position
			window ?= widget.parent
			if window = Void then
				if widget.parent /= Void then
					Result := Result + y_position_relative_to_window (widget.parent)
				else
					check
						Widget_was_not_parented_in_a_window: False
					end
				end
			end
		end

	extend_no_expand (a_box: EV_BOX; a_widget: EV_WIDGET) is
			-- Extend `a_widget' into `a_box' and disable expandability.
		require
			box_not_void: a_box /= Void
			a_widget_not_void: a_widget /= Void
		do
			a_box.extend (a_widget)
			a_box.disable_item_expand (a_widget)
		ensure
			box_contains_widget: a_box.has (a_widget)
			widget_not_expanded: not a_box.is_item_expanded (a_widget)
		end
		
	disable_all_items (b: EV_BOX) is
			-- Call `disable_item_expand' on all items in `b'.
		require
			box_not_void: b /= Void
		do
			from
				b.start
			until
				b.off
			loop
				b.disable_item_expand (b.item)
				b.forth
			end
		end
		
	align_labels_left (b: EV_BOX) is
			-- For every item in `b' of type EV_LABEL, align the test left.
		require
			box_not_void: b /= Void
		local
			label: EV_LABEL
		do
			from
				b.start
			until
				b.off
			loop
				label ?= b.item
				if label /= Void then
					label.align_text_left
				end
				b.forth
			end
		end
		
	unparent_ev_object (ev_object: EV_ANY) is
			-- Remove `ev_object' from its parent.
		local
			dynamic_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]
			container: EV_CONTAINER
			widget: EV_WIDGET
			containable: EV_CONTAINABLE
			menu_bar: EV_MENU_BAR
			titled_window: EV_TITLED_WINDOW
		do
			containable ?= ev_object
			check
				containable_not_void: containable /= Void
				containable_has_parent: containable.parent /= Void
			end
			dynamic_list ?= containable.parent
			if dynamic_list /= Void then
				check
					containable_contained_in_parent: dynamic_list.has (containable)
				end
				dynamic_list.prune (containable)
			else
				menu_bar ?= containable
				if menu_bar /= Void then
					titled_window ?= containable.parent
					check
						titled_window_not_void: titled_window /= Void
					end
					titled_window.remove_menu_bar
				else
					container ?= containable.parent
					widget ?= containable
					check
						container_not_void: container /= Void
						widget_not_void: widget /= Void
					end
					container.prune (widget)
				end
			end
			check
				containable_unparented: containable.parent = Void
			end
		end
		
	fake_cancel_button (a_dialog: EV_DIALOG; action: PROCEDURE [ANY, TUPLE]) is
			-- Place a cancel button in `a_dialog',
			-- and then remove it, so that we have
			-- a cross on the window.
		require
			a_dialog_not_void: a_dialog /= Void
			action_not_void: action /= Void
		local
			button: EV_BUTTON
			widget: EV_WIDGET
		do
				-- If `a_dialog' is already full, then empty it
				-- so the button may be inserted.
			if a_dialog.full then
				widget := a_dialog.item
				a_dialog.prune_all (widget)
			end
			create button
			a_dialog.extend (button)
			button.select_actions.extend (action)
			a_dialog.set_default_cancel_button (button)
			a_dialog.prune_all (button)
				-- If there was originally a widget in `a_dialog'
				-- then restore it.
			if widget /= Void then
				a_dialog.extend (widget)
			end
		end

	expand_tree_recursive (tree: EV_TREE) is
			-- Ensure that every node of `tree' is expanded.
		do
			tree.recursive_do_all (agent expand_node)
		end
		
	collapse_tree_recursive (tree: EV_TREE) is
			-- Ensure that every node of `tree' is not epanded.
		do
			tree.recursive_do_all (agent collapse_node)
		end
		
	unparent_tree_node (tree_node: EV_TREE_NODE) is
			-- Remove `tree_node' from its `parent'.
			-- Do not change `index' of `parent'.
		require
			tree_node_not_void:tree_node /= Void
		local
			tree_node_list: EV_TREE_NODE_LIST
			previous_index: INTEGER
		do
			tree_node_list ?= tree_node.parent
			if tree_node_list /= Void then
				previous_index := tree_node_list.index
				tree_node_list.prune_all (tree_node)
				tree_node_list.go_i_th (previous_index.min (tree_node_list.count))
			end
		ensure
			tree_node_unparented: tree_node.parent = Void
		end
		
	set_split_position (split_area: EV_SPLIT_AREA; position: INTEGER) is
			-- Assign `position' to `split_position' of `split_area', bounded
			-- to the minimum and maximum split positions.
		require
			split_area_not_void: split_area /= Void
		do
			split_area.set_split_position ((position.max (split_area.minimum_split_position)).min (split_area.maximum_split_position))
		end
		
	scaled_pixmap (original_pixmap: EV_PIXMAP; x_dimension, y_dimension: INTEGER): EV_PIXMAP is
			-- `Result' is representation of ``original_pixmap', scaled to fit in `x_dimension', `y_dimension'
			-- with same aspect ratio.
		require
			original_pixmap_not_void: original_pixmap /= Void
			x_dimension_positive: x_dimension > 0
			y_dimension_positive: y_dimension > 0
		local
			x_ratio, y_ratio: REAL
			new_x, new_y: INTEGER
			biggest_ratio: REAL
		do
			x_ratio := original_pixmap.width / x_dimension
			y_ratio := original_pixmap.height / y_dimension
			if x_ratio > 1 and y_ratio < 1 then 
				new_x := x_dimension
				new_y := (original_pixmap.height / x_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio < 1 then
				new_y := x_dimension
				new_x := (original_pixmap.width / y_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio > 1 then
				biggest_ratio := x_ratio.max (y_ratio)
				new_x := (original_pixmap.width / biggest_ratio).truncated_to_integer
				new_y := (original_pixmap.height / biggest_ratio).truncated_to_integer
			end

			Result := clone (original_pixmap)
			if new_x /= 0 and new_y /= 0 then
				Result.stretch (new_x, new_y)
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	select_named_combo_item (combo_box: EV_COMBO_BOX; a_text: STRING) is
			-- Ensure item in `combo_box' with `text' matching `a_text' is
			-- selected. Case insensitive.
		require
			combo_box_not_void: combo_box /= Void
			a_text_not_void: a_text /= Void
		local
			selected: BOOLEAN
			lower_text: STRING
		do
			lower_text := a_text.as_lower
			from
				combo_box.start
			until
				combo_box.off or selected
			loop
				if combo_box.item.text.as_lower.is_equal (lower_text) then
					combo_box.item.enable_select
				end
				combo_box.forth
			end
		end
		
	list_item_with_matching_text (item_list: EV_LIST_ITEM_LIST; a_text:STRING): EV_LIST_ITEM is
			-- `Result' is item contained in `item_list' with
			-- `text' matching `a_text', or `Void' if none.
		local
			lower_text: STRING
		do
			lower_text := a_text.as_lower
			from
				item_list.start
			until
				item_list.off or Result /= Void
			loop
				if item_list.item.text.as_lower.is_equal (lower_text) then
					Result := item_list.item
				end
				item_list.forth
			end
		end
		

feature {NONE} -- Implementation

	expand_node (node: EV_TREE_NODE) is
			-- Expand `node' if permitted.
		do
			if node.is_expandable and not node.is_expanded then
				node.expand
			end
		ensure
			node_expanded: node.is_expandable implies node.is_expanded
		end
		
	collapse_node (node: EV_TREE_NODE) is
			-- Collapse `node' if not empty.
		do
			if node.is_expanded then
				node.collapse
			end
		end

end -- class GB_UTILITIES
