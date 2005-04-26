indexing
	description: "Representation of a row of an EV_GRID"
	date: "$Date$"
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
		end
	
	EV_DESELECTABLE
		redefine
			implementation
		end

create
	{EV_GRID_I} default_create

feature -- Access

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
			not_expanded_when_empty: subrow_count = 0 implies not is_expanded
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
			to_implement_assertion ("valid_result: Result >= 0 and Result <= virtual_height - viewable_height")
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
		
feature -- Status setting

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
			-- from `grid.row_expand_actions'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.ensure_expandable
		ensure
			is_expandable: is_expandable
		end

feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th column to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			is_parented: parent /= Void
			valid_tree_structure: a_item /= Void and parent.is_tree_enabled and parent_row /= Void implies i >= parent_row.index_of_first_item
			to_implement_assertion	("Add preconditions for subnode handling of `Void' items.")
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
			implementation.insert_subrow (subrow_index)
		ensure
			subrow_count_increased: subrow_count = old subrow_count + 1
			parent_row_count_increased: parent.row_count = old parent.row_count + 1
		end

	remove_subrow (a_row: EV_GRID_ROW) is
			-- Ensure that `a_row' is no longer a child row of `Current'
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

	set_background_color (a_color: EV_COLOR) is
			-- Set `a_color' to all items in Current.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			--color_set: forall (item(i).background_color  = a_color)
		end

	clear is
			-- Remove all items from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.clear
		ensure
			to_implement_assertion ("EV_GRID_ROW.clear - All items positions return `Void'.")
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
	is_selected_implies_selected_items_count_equals_count: is_selected implies selected_items.count = count
	tree_disabled_in_parent_implies_no_subrows: parent /= Void and then not parent.is_tree_enabled implies subrow_count = 0

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
