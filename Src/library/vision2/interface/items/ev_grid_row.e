indexing
	description: "Representation of a row of an EV_GRID"
	date: "$Date$"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	revision: "$Revision$"

class
	EV_GRID_ROW

inherit
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end

	EV_GRID_ROW_ACTION_SEQUENCES
		undefine
			default_create, copy, is_equal
		redefine
			implementation
		end

	EV_DESELECTABLE
		redefine
			implementation
		end

create
	{EV_GRID} default_create

feature -- Access

	is_part_of_tree_structure: BOOLEAN is
			-- Is `Current' part of a tree structure within `parent_i'?
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := parent_row /= Void or else subrow_count > 0
		ensure
			result_valid: Result = (parent_row /= Void or else subrow_count > 0)
		end

	subrow (i: INTEGER): EV_GRID_ROW is
			-- `i'-th child of Current.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			i_positive: i > 0
			i_less_than_subrow_count: i <= subrow_count
		do
			Result := implementation.subrow (i)
		ensure
			subrow_not_void: Result /= Void
			subrow_valid: (Result.parent /= Void) and then has_subrow (Result) and then Result.parent_row = Current
		end

	has_subrow (a_row: EV_GRID_ROW): BOOLEAN is
			-- Is `a_row' a child of Current?
		require
			not_destroyed: not is_destroyed
			a_row_not_void: a_row /= Void
			is_parented: parent /= Void
		do
			Result := implementation.has_subrow (a_row)
		ensure

			has_subrow_same_parent: Result implies
				((a_row.parent /= Void and parent /= Void) and then a_row.parent = parent)
		end

	parent_row: EV_GRID_ROW is
			-- Parent row of Current if any, Void otherwise.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.parent_row
		ensure
			result_void_when_tree_node_enabled: (parent = Void) or
				(parent /= Void and then not parent.is_tree_enabled) implies Result = Void
			has_parent: Result /= Void implies Result.has_subrow (Current)
		end

	parent: EV_GRID is
			-- Grid to which current row belongs.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent
		end

	parent_row_root: EV_GRID_ROW is
			-- Parent row which is the root of the tree structure
			-- in which `Current' is contained. May be `Current' if
			-- `Current' is the root node of a tree structure.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.parent_row_root
		ensure
			result_consistent_with_parent_tree_properties: (parent = Void or else not parent.is_tree_enabled) = (Result = Void)
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th column, Void if none.
		require
			not_destroyed: not is_destroyed
			i_within_bounds: i > 0 and i <= count
			is_parented: parent /= Void
		do
			Result := implementation.item (i)
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
			valid_count: Result.count <= count
		end

	is_expanded: BOOLEAN is
			-- Are subrows of `Current' displayed?
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.is_expanded
		ensure
			-- not_expanded_when_empty: (subrow_count = 0) implies not Result
			-- This does not hold if you `query' is expanded while
			-- within the `expand_actions' with a row that is ensured exandable
			-- and add no items.
		end

	height: INTEGER is
			-- Height of `Current' when displayed in a `parent'
			-- that has `is_row_height_fixed' set to `False'.
			-- Note that `height' is ignored if the parent has
			-- `is_row_height_fixed' set to `True' and then all rows
			-- are displayed with identical heights set to `parent.row_height'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.height
		ensure
			result_not_negative: Result >= 0
		end

	virtual_y_position: INTEGER is
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.virtual_y_position
		ensure
			parent_void_implies_result_zero: parent = Void implies result = 0
		end

	virtual_y_position_unlocked: INTEGER is
			-- Vertical offset of unlocked position of `Current', in relation to the
			-- virtual area of `parent' grid in pixels.
			-- If not `is_locked', then `virtual_y_position' = `unlocked_virtual_y_position'.
			-- If `is_locked' then `Result' is the "shadow" position where the row would
			-- be if not locked.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.virtual_y_position_unlocked
		ensure
			parent_void_implies_result_zero: parent = Void implies result = 0
		end

	index_of_first_item: INTEGER is
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.index_of_first_item
		ensure
			valid_result: Result >= 0 and Result <= count
		end

	is_expandable: BOOLEAN is
			-- May `Current' be expanded?
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.is_expandable
		end

	background_color: EV_COLOR is
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.background_color
		end

	foreground_color: EV_COLOR is
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.foreground_color
		end

feature -- Status report

	subrow_count: INTEGER is
			-- Number of children.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.subrow_count
		ensure
			subrow_count_non_negative: subrow_count >= 0
			subrow_count_in_range: subrow_count <= (parent.row_count - index)
		end

	subrow_count_recursive: INTEGER is
			-- Number of child rows and their child rows recursively.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.subrow_count_recursive
		ensure
			subrow_count_recursive_greater_or_equal_to_subrow_count: subrow_count_recursive >= subrow_count
			subrow_count_recursive_in_range: subrow_count_recursive <= (parent.row_count - index)
		end

	index: INTEGER is
			-- Position of Current in `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.index
		ensure
			index_positive: Result > 0
			index_less_than_row_count: Result <= parent.row_count
		end

	count: INTEGER is
			-- Number of items in current.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.count
		ensure
			count_not_negative: count >= 0
		end

	is_locked: BOOLEAN is
			-- Is `Current' locked so that it no longer scrolls?
		do
			Result := implementation.is_locked
		end

	locked_position: INTEGER is
			-- Locked position of `Current' from top edge of viewable area of `parent'.
			-- `Result' is 0 if not `is_locked'.
		do
			Result := implementation.locked_position
		ensure
			not_locked_implies_result_zero: not is_locked implies result = 0
		end

feature -- Status setting

	lock is
			-- Ensure `is_locked' is `True'.
			-- `Current' is locked at it's current vertical offset from
			-- the top edge of the viewable area of `parent'.
		do
			lock_at_position (virtual_y_position - parent.virtual_y_position)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = virtual_y_position - parent.virtual_y_position
		end

	lock_at_position (a_position: INTEGER) is
			-- Ensure `is_locked' is `True' with the vertical offset from
			-- the top edge of the viewable area of `parent' set to `a_position'.
		do
			implementation.lock_at_position (a_position)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = a_position
		end

	unlock is
			-- Ensure `is_locked' is `False'.
		do
			implementation.unlock
		ensure
			not_is_locked: not is_locked
		end

	expand is
			-- Display all subrows of `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			is_expandable: is_expandable
		do
			implementation.expand
		ensure
			is_expanded: is_expanded or subrow_count = 0
		end

	collapse is
			-- Hide all subrows of `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.collapse
		ensure
			not_is_expanded: not is_expanded
		end

	set_height (a_height: INTEGER) is
			-- Assign `a_height' to `height'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_height (a_height)
		ensure
			height_set: height = a_height
		end

	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			implementation.ensure_visible
		ensure
			parent_virtual_x_position_unchanged: old parent.virtual_x_position = parent.virtual_x_position
			to_implement_assertion ("old_is_visible_implies_vertical_position_not_changed")
			row_visible_when_heights_fixed_in_parent: parent.is_row_height_fixed implies  virtual_y_position >= parent.virtual_y_position and virtual_y_position + parent.row_height <= parent.virtual_y_position + (parent.viewable_height).max (parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not parent.is_row_height_fixed implies virtual_y_position >= parent.virtual_y_position and virtual_y_position + height <= parent.virtual_y_position + (parent.viewable_height).max (height)
		end

	ensure_expandable is
			-- Ensure `Current' displays an expand pixmap to simulate a `row_count' greater than 0.
			-- May be used for dynamic behavior by filling subrows upon firing of `grid.row_expand_actions'.
			-- If no items are added to `Current' during the firing of `grid.row_expand_actions' then
			-- `Current' is no longer expandable. This may be re-instated by calling `ensure_expandable' again
			-- from `grid.row_expand_actions'. Note that once a subrow is added to `Current' after a call to
			-- `ensure_expandable', it is no longer be displayed as expandable if all subrows are then removed.
			-- In this case, you must explicitly call `ensure_expandable' again after removing all subrows.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
			parent_tree_enabled: parent.is_tree_enabled
		do
			implementation.ensure_expandable
		ensure
			is_expandable: is_expandable
		end

	ensure_non_expandable is
			-- Restore expanded state of `Current' after a call to `ensure_expandable'. Note that if a row
			-- has one or more subrows, it is always drawn as expanded, hence the "no_subrows_contained" precondition.
		require
			not_destroyed: not is_destroyed
			no_subrows_contained: subrow_count = 0
			parented: parent /= Void
		do
			implementation.ensure_non_expandable
		ensure
			not_is_expandable: not is_expandable
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' with `a_color'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_set: foreground_color = a_color
		end

	redraw is
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			implementation.redraw
		end

feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th column to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			is_parented: parent /= Void
			is_index_valid_for_item_insertion_if_subrow: a_item /= Void and then is_part_of_tree_structure implies is_index_valid_for_item_setting_if_tree_node (i)
			is_index_valid_for_item_removal_if_subrow: a_item = Void and then is_part_of_tree_structure implies is_index_valid_for_item_removal_if_tree_node (i)
		do
			implementation.set_item (i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	add_subrow (a_row: EV_GRID_ROW) is
			-- Make `a_row' a child row of Current.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= Current
			a_row_is_not_a_subrow: a_row.parent_row = Void
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			a_row_is_below_current: a_row.index > index
			all_rows_between_row_and_current_are_subrows:
				a_row.index = index + subrow_count_recursive + 1
			row_not_empty_implies_row_index_of_first_item_greater_or_equal_to_index_of_first_item:
				a_row.index_of_first_item > 0 implies a_row.index_of_first_item >= index_of_first_item
		do
			implementation.add_subrow (a_row)
		ensure
			added: a_row.parent_row = Current
			subrow (subrow_count) = a_row
		end

	insert_subrow (subrow_index: INTEGER) is
			-- Add a new row to `parent' as a subrow of `Current'
			-- with index in subrows of `Current' given by `subrow_index'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			parent_enabled_as_tree: parent.is_tree_enabled
			valid_subrow_index: subrow_index >= 1 and subrow_index <= subrow_count + 1
		do
			implementation.insert_subrows (1, subrow_index)
		ensure
			subrow_count_increased: subrow_count = old subrow_count + 1
			parent_row_count_increased: parent.row_count = old parent.row_count + 1
		end

	insert_subrows (rows_to_insert, subrow_index: INTEGER) is
			-- Add `rows_to_insert' rows to `parent' as a subrow of `Current'
			-- with index in subrows of `Current' given by `subrow_index'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			parent_enabled_as_tree: parent.is_tree_enabled
			rows_to_insert_positive: rows_to_insert >= 1
			valid_subrow_index: subrow_index >= 1 and subrow_index <= subrow_count + 1
		do
			implementation.insert_subrows (rows_to_insert, subrow_index)
		ensure
			subrow_count_increased: subrow_count = old subrow_count + rows_to_insert
			parent_row_count_increased: parent.row_count = old parent.row_count + rows_to_insert
		end

	remove_subrow (a_row: EV_GRID_ROW) is
			-- Ensure that `a_row' is no longer a child row of `Current'.
			-- Does not remove `a_row' from `parent_i'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= Current
			a_row_is_a_subrow: a_row.parent_row = Current
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			row_is_final_subrow_in_tree_structure:
				a_row.index  + a_row.subrow_count_recursive = parent_row_root.index + parent_row_root.subrow_count_recursive
		do
			implementation.remove_subrow (a_row)
		ensure
			removed: a_row.parent_row = Void
			subrow_count_decreased: subrow_count = old subrow_count - 1
		end

	clear is
			-- Remove all items from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.clear
		ensure
			cleared: index_of_first_item = 0
		end

feature -- Contract support

	is_index_valid_for_item_setting_if_tree_node (a_index: INTEGER): BOOLEAN is
			-- May an item be set in `Current' at index `a_index' if `Current' is a tree node.
		require
			is_part_of_tree_structure: is_part_of_tree_structure
			index_valid: a_index > 0
		local
			a_ancestor_index_of_first_item, a_subrow_index_of_first_item, i: INTEGER
			a_parent_row: like parent_row
		do
			if index_of_first_item > 0 and then a_index >= index_of_first_item then
					-- If we are adding to the right of an existing item then `a_index' is valid.
				Result := True
			else
				from
					a_parent_row := parent_row
				until
					a_ancestor_index_of_first_item > 0 or else a_parent_row = Void
				loop
					a_ancestor_index_of_first_item := a_parent_row.index_of_first_item
					a_parent_row := a_parent_row.parent_row
				end

				if a_index >= a_ancestor_index_of_first_item then
					Result := True
					if index_of_first_item = 0 then
						-- Loop through subnodes if any to make sure that `a_index' doesn't break tree structure.
						from
							i := 1
						until
							i > subrow_count or else not Result
						loop
							a_subrow_index_of_first_item := subrow (i).index_of_first_item
							if a_subrow_index_of_first_item > 0 and then a_subrow_index_of_first_item < a_index then
								Result := False
							end
							i := i + 1
						end
					end
				end
			end
		end

	is_index_valid_for_item_removal_if_tree_node (a_index: INTEGER): BOOLEAN is
			-- May an item be removed from `Current' at index `a_index' if `Current' is a tree node.
		require
			is_part_of_tree_structure: is_part_of_tree_structure
			index_valid: a_index > 0 and then a_index <= count
		local
			a_index_of_next_item, i, a_subnode_first_item_index: INTEGER
		do
			Result := True
			if a_index = index_of_first_item then
				-- The tree structure would be changed, find the next item if any and check if it is a valid index
				from
					i := a_index + 1
				until
					a_index_of_next_item /= 0 or else i > count
				loop
					if item (i) /= Void then
						a_index_of_next_item := i
					end
					i := i + 1
				end

				if a_index_of_next_item > 0 then
					-- A next item has been found, we now check this against any subrows to see if removing this index
					-- is valid.
					from
						i := 1
					until
						not Result or else i > subrow_count
					loop
						a_subnode_first_item_index := subrow (i).index_of_first_item
						if a_subnode_first_item_index > 0 and then a_subnode_first_item_index < a_index_of_next_item then
							Result := False
						end
						i := i + 1
					end
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_ROW_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_ROW_I} implementation.make (Current)
		end

invariant
	no_subrows_implies_not_expanded: subrow_count = 0 implies not is_expanded
	tree_disabled_in_parent_implies_no_subrows: parent /= Void and then not parent.is_tree_enabled implies subrow_count = 0
	virtual_position_and_virtual_position_unlocked_equal_when_not_locked: not is_locked implies virtual_y_position = virtual_y_position_unlocked

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end

