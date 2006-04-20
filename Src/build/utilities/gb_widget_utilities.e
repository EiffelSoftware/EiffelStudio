indexing	
	description: "Objects that provide useful facilities for widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_WIDGET_UTILITIES
	
inherit
	EV_FONT_CONSTANTS

feature -- Basic operations

	parent_window (containable: EV_CONTAINABLE): EV_WINDOW is
			-- `Result' is window parent of `containable'.
			-- `Void' if none.
		require
			containable_not_void: containable /= Void
		local
			window: EV_WINDOW
			parent_containable: EV_CONTAINABLE
		do
			window ?= containable
			if window = Void then
				if containable.parent /= Void then
					parent_containable ?= containable.parent
					if parent_containable /= Void then
						Result := parent_window (parent_containable)
					end
				end	
			else
				Result := window
			end	
		end
		
	parent_dialog (widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: widget /= Void
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
		require
			object_not_void: ev_object /= Void
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

	expand_tree_recursive (tree_node_list: EV_TREE_NODE_LIST) is
			-- Ensure that every node of `tree_node_list' is expanded.
		require
			tree_node_list_not_void: tree_node_list /= Void
		do
			tree_node_list.recursive_do_all (agent expand_node)
		end
		
	collapse_tree_recursive (tree: EV_TREE) is
			-- Ensure that every node of `tree' is not epanded.
		require
			tree_not_void: tree /= Void
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

			Result := original_pixmap.twin
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
		
	tree_item_matching_path (tree_list: EV_TREE_NODE_LIST; texts: ARRAYED_LIST [STRING]): EV_TREE_ITEM is
			-- `Result' is tree item in `tree_list' that is reachable by stepping down a level for each 
			-- matched item in `texts'.
		require
			tree_list_not_void: tree_list /= Void
			texts_not_void: texts /= Void
			texts_not_empty: not texts.is_empty
		local
			text_cursor, tree_cursor: CURSOR
		do
			text_cursor := texts.cursor
			tree_cursor := tree_list.cursor
			texts.start
			Result := internal_tree_item_matching_path (tree_list, texts)
			texts.go_to (text_cursor)
			tree_list.go_to (tree_cursor)
		ensure
			texts_unchanged: old texts.is_equal (texts) and old texts.index = texts.index
			tree_list_unchanged: old tree_list.index = tree_list.index
		end

	reparent (original_widget, new_widget: EV_WIDGET) is
			-- Replace `original_widget' with `new_widget' within parent of `original_widget'.
		require
			original_widget_parented: original_widget.parent /= Void
			new_widget_not_parented: new_widget.parent = Void
		local
			cell: EV_CELL
			widget_list: EV_WIDGET_LIST
			split_area: EV_SPLIT_AREA
			table: EV_TABLE
			row, column, row_span, column_span: INTEGER
		do
			cell ?= original_widget.parent
			if cell /= Void then
				cell.wipe_out
				cell.extend (new_widget)
			else
				widget_list ?= original_widget.parent
				if widget_list /= Void then
					widget_list.go_i_th (widget_list.index_of (original_widget, 1))
					widget_list.remove
					widget_list.put_left (new_widget)
				else
					split_area ?= original_widget.parent
					if split_area /= Void then
						if split_area.first = original_widget then
							split_area.prune_all (original_widget)
							split_area.set_first (new_widget)
						else
							split_area.prune_all (original_widget)
							split_area.set_second (new_widget)
						end
					else
						table ?= original_widget.parent
						row := table.item_row_position (original_widget)
						column := table.item_column_position (original_widget)
						row_span := table.item_row_span (original_widget)
						column_span := table.item_column_span (original_widget)
						table.prune_all (original_widget)
						table.put_at_position (new_widget, column, row, column_span, row_span)
					end
				end
			end
		ensure
			new_widget_parented_correctly: new_widget.parent /= Void and old original_widget.parent = new_widget.parent
			original_widget_not_parented: original_widget.parent = Void
		end
		
	path_of_tree_node (root_node: EV_TREE_NODE): ARRAYED_LIST [STRING] is
			-- Result is `text' of all parents of `Current' from the top down to
			-- and including `node'.
		require
			node_not_void: root_node /= Void
		local
			temp_result: ARRAYED_LIST [STRING]
			node: EV_TREE_NODE
		do
			create temp_result.make (4)
				-- Firstly iterate upwards from `Current' to find all of the
				-- parents in order.
			from
				node := root_node
			until
				node = Void
			loop
				temp_result.extend (node.text)
				node ?= node.parent
			end
			
				-- Now build `result' by reversing the structure recently traversed.
				-- This is because we wish the higher level nodes to appear first.
			create Result.make (temp_result.count)
			from
				temp_result.go_i_th (temp_result.count)
			until
				temp_result.off
			loop
				Result.extend (temp_result.item)
				temp_result.back
			end
			check
				results_consistent: temp_result.count = result.count
			end
		ensure
			result_not_void: Result /= Void
			node_not_parented_implies_result_has_single_item: root_node.parent = Void implies Result.count = 1
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
		
	internal_tree_item_matching_path (tree_list: EV_TREE_NODE_LIST; texts: ARRAYED_LIST [STRING]): EV_TREE_ITEM is
			-- `Result' is tree item in `tree_list' that is reachable by stepping down a level for each 
			-- matched item in `texts'.
		require
			tree_list_not_void: tree_list /= Void
			texts_not_void: texts /= Void
			texts_not_empty: not texts.is_empty
		local
			current_text: STRING
			tree_cursor: CURSOR
		do
			tree_cursor := tree_list.cursor
			current_text := texts.item
			from
				tree_list.start
			until
				tree_list.off or Result /= Void
			loop
				if tree_list.item.text.is_equal (current_text) then
					if texts.index = texts.count then
						Result ?= tree_list.item
					else
						texts.forth
						Result ?= internal_tree_item_matching_path (tree_list.item, texts)
					end
				end
				tree_list.forth
			end
			tree_list.go_to (tree_cursor)
		ensure
			tree_list_unchanged: old tree_list.index = tree_list.index
		end
		
	add_to_tree_node_alphabetically (tree_node_list: EV_TREE_NODE_LIST; tree_node: EV_TREE_NODE) is
			-- Add `tree_node' to `tree_node_list' at a position so that it is ordered alphabetically
			-- by its `text'.
		require
			tree_node_list_not_void: tree_node_list /= Void
			tree_node_not_void: tree_node /= Void
			tree_node_not_parented: tree_node.parent = Void
			tree_node_has_text: not tree_node.text.is_empty
		local
			l_text: STRING
		do
				-- Note that we always go from the final position to the start. This is because if we are building
				-- a tree that is already in order we do not have to iterate all of the items  in a node to find
				-- out that it needs to be the final node. This will optimize the loading in Build as it should
				-- be saved in order.

			l_text := tree_node.text.as_lower
			from
				tree_node_list.go_i_th (tree_node_list.count)
			until
				tree_node_list.off or else tree_node_list.item.text.as_lower < l_text 
			loop
				tree_node_list.back
			end
			tree_node_list.put_right (tree_node)
		ensure
			contained: tree_node_list.has (tree_node)
			tree_node_contents_alphabetical (tree_node_list)
		end
		
	add_to_list_alphabetically (list: EV_LIST_ITEM_LIST; list_item: EV_LIST_ITEM) is
			-- Add `tree_node' to `tree_node_list' at a position so that it is ordered alphabetically
			-- by its `text'.
		require
			list_not_void: list /= Void
			list_item_not_parented: list_item.parent = Void
			list_item_has_text: not list_item.text.is_empty
		local
			l_text: STRING
		do
				-- Note that we always go from the final position to the start. This is because if we are building
				-- a tree that is already in order we do not have to iterate all of the items  in a node to find
				-- out that it needs to be the final node. This will optimize the loading in Build as it should
				-- be saved in order.

			l_text := list_item.text.as_lower
			from
				list.go_i_th (list.count)
			until
				list.off or else list.item.text.as_lower < l_text 
			loop
				list.back
			end
			list.put_right (list_item)
		ensure
			contained: list.has (list_item)
		end
		
	tree_node_contents_alphabetical (tree_node_list: EV_TREE_NODE_LIST): BOOLEAN is
			-- Are the `text' of all items contained ordered alphabetically?
		require
			tree_node_list_not_void: tree_node_list /= Void
		local
			l_cursor: CURSOR
			current_item_text, last_item_text: STRING
		do
			Result := True
			l_cursor := tree_node_list.cursor
			from
				tree_node_list.start
			until
				tree_node_list.off
			loop
				current_item_text := tree_node_list.item.text.as_lower
				if last_item_text /= Void then
					if last_item_text > current_item_text then
						Result := False
					end
				end
				last_item_text := current_item_text.twin
				tree_node_list.forth
			end
			tree_node_list.go_to (l_cursor)
		ensure
			index_not_changed: old tree_node_list.index = tree_node_list.index
		end
		
	insert_into_window (ev_any: EV_ANY; window: EV_TITLED_WINDOW) is
			-- Insert `ev_any' into `window' with the minimum parenting structure
			-- required to bridge the interface if `ev_any' is not a widget.
		require
			ev_any_not_void: ev_any /= Void
			window_not_void: window /= Void
				-- Not really complete, but better than no check.
				-- We really need to check the type of the incoming object.
			window_empty: window.is_empty or window.menu_bar = Void
		local
			widget: EV_WIDGET
			an_item: EV_ITEM
			tool_bar_item: EV_TOOL_BAR_ITEM
			tool_bar: EV_TOOL_BAR
			tree_item: EV_TREE_ITEM
			tree: EV_TREE
			list_item: EV_LIST_ITEM
			list: EV_LIST
			menu_item: EV_MENU_ITEM
			a_menu_bar: EV_MENU_BAR
			containable: EV_CONTAINABLE
		do
			an_item ?= ev_any
			a_menu_bar ?= ev_any
			
			if an_item /= Void then
				tool_bar_item ?= ev_any
				if tool_bar_item /= Void then
					create tool_bar
					tool_bar.extend (tool_bar_item)	
					window.extend (tool_bar)
				end
				tree_item ?= an_item
				if tree_item /= Void then
					create tree
					tree.extend (tree_item)
					window.extend (tree)
				end
				list_item ?= an_item
				if list_item /= Void then
					create list
					list.extend (list_item)
					window.extend (list)
				end
				menu_item ?= an_item
				if menu_item /= Void then
					create a_menu_bar
					window.set_menu_bar (a_menu_bar)
					a_menu_bar.extend (menu_item)
				end
				-- A menu bar is not a widget or an item, so we must handle it specially.
			elseif a_menu_bar /= Void then
				window.set_menu_bar (a_menu_bar)
			else
				widget ?= ev_any
				check
					was_widget: widget /= Void
				end
				window.extend (widget)
			end
			containable ?= ev_any
			check
				ev_any_was_containable: containable /= Void
				parent_within_window_structure: parent_window (containable) = window
			end
		end
		
	build_string_from_font (font: EV_FONT): STRING is
			-- `Result' is string representation of `font'.
		require
			font_not_void: font /= Void
		do
			Result := font_constant_to_string (font.family) + ";"
			Result.append (font_constant_to_string (font.weight) + ";")
			Result.append (font_constant_to_string (font.shape) + ";")
			Result.append (font.height_in_points.out + ";")
			from
				font.preferred_families.start
			until
				font.preferred_families.off
			loop
				Result.append (font.preferred_families.item.out)
				font.preferred_families.forth
			end
		end
		
	font_constant_to_string (constant: INTEGER): STRING is
			-- `Result' is font `constant' converted to STRING representation.
		require
			valid_constant: valid_family (constant) or valid_shape (constant) or valid_weight (constant)
		do
			Result := font_string_lookup.item (constant)
		ensure
			Result_not_void: Result /= Void
		end
		
	string_to_font_constant (string: STRING): INTEGER is
			-- `Result' is string representation of font constant converted to INTEGER.
		require
			string_not_void: string /= Void
			valid_string: font_integer_lookup.has (string)
		do
			Result := font_integer_lookup.item (string)
		ensure
			valid_constant: valid_family (Result) or valid_shape (Result) or valid_weight (Result)
		end
		
	font_integer_lookup: HASH_TABLE [INTEGER, STRING] is
			-- `Result' is a lookup table for all INTEGER font constant values by STRING.
		once
			create Result.make (11)
			Result.put (1, "FamilyScreen")
			Result.put (2, "FamilyRoman")
			Result.put (3, "FamilySans")
			Result.put (4, "FamilyTypewriter")
			Result.put (5, "FamilyModern")
			Result.put (6, "WeightThin")
			Result.put (7, "WeightRegular")
			Result.put (8, "WeightBold")
			Result.put (9, "WeightBlack")
			Result.put (10, "ShapeRegular")
			Result.put (11, "ShapeItalic")
		ensure
			result_not_void: Result /= Void
		end
		
	font_string_lookup: HASH_TABLE [STRING, INTEGER] is
			-- `Result' is a lookup table for all STRING font constant values by INTEGER.
		once
			create Result.make (11)
			Result.put ("FamilyScreen", 1)
			Result.put ("FamilyRoman", 2)
			Result.put ("FamilySans", 3)
			Result.put ("FamilyTypewriter", 4)
			Result.put ("FamilyModern", 5)
			Result.put ("WeightThin", 6)
			Result.put ("WeightRegular", 7)
			Result.put ("WeightBold", 8)
			Result.put ("WeightBlack", 9)
			Result.put ("ShapeRegular", 10)
			Result.put ("ShapeItalic", 11)
		ensure
			result_not_void: Result /= Void
		end
		
	build_string_from_color (color: EV_COLOR): STRING is
			-- `Result' is string representation of `color'.
		require
			color_not_void: color /= Void
		do
			create Result.make (0)
			Result := Result + add_leading_zeros (color.red_8_bit.out, 3)
			Result := Result + add_leading_zeros (color.green_8_bit.out, 3)
			Result := Result + add_leading_zeros (color.blue_8_bit.out, 3)
		end
		
	build_color_from_string (a_string: STRING): EV_COLOR is
			-- `Result' is an EV_COLOR built from contents of `a_string'.
		require
			a_string_not_void: a_string /= Void
			string_correct_length: a_string.count = 9
			a_string_is_integer: a_string.is_integer
		do
			create Result
			Result.set_rgb_with_8_bit (a_string.substring (1, 3).to_integer,
				a_string.substring (4, 6).to_integer,
				a_string.substring (7, 9).to_integer)
		ensure
			Result_not_void: Result /= Void
		end
		
	build_font_from_string (a_string: STRING): EV_FONT is
			-- `Result' is an EV_FONT built from contents of `a_string'.
		require
			a_string_not_void: a_string /= Void
			correct_separators: a_string.occurrences (';') = 4
		local
			internal_string: STRING
		do
			internal_string := a_string.twin
			create Result
			Result.set_family (string_to_font_constant (get_next_part_of_multi_part_string (a_string)))
			Result.set_weight (string_to_font_constant (get_next_part_of_multi_part_string (a_string)))
			Result.set_shape (string_to_font_constant (get_next_part_of_multi_part_string (a_string)))
			Result.set_height_in_points (get_next_part_of_multi_part_string (a_string).to_integer)
			Result.preferred_families.extend (a_string)
		ensure
			Result_not_void: Result /= Void
		end
		
	get_next_part_of_multi_part_string (a_string: STRING): STRING is
			-- `Result' is substring from position 1 to the position up to the first
			-- occurance of a ';' character. Prune all characters up to and including
			-- the `;' from `a_string
		require
			a_string_not_void: a_string /= Void
			a_string_has_separators: a_string.occurrences (';') > 0
		local
			next_separator_index: INTEGER
		do
			next_separator_index := a_string.index_of (';', 1)
			Result := a_string.substring (1, next_separator_index - 1)
			a_string.remove_head (next_separator_index)
		ensure
			result_not_void: Result /= Void
			counts_consistent: old a_string.count = a_string.count + Result.count + 1
		end
		
	add_leading_zeros (original_string: STRING count: INTEGER): STRING is
			-- `Result' is `a_string' with leading zeros added so that it it `count' characters long.
		require
			original_string_not_void: original_string /= Void
			count_positive: count > 0
			original_string_length_valid: original_string.count <= count
		do
			from
				Result := original_string.twin
			until
				Result.count = count
			loop
				Result.insert_character ('0', 1)
			end
		ensure
			Result_not_void: Result /= Void
			Result_correct_length: Result.count = count
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


end -- class GB_UTILITIES
