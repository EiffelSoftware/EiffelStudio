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
			-- `i'-th child of Current
		require
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
			a_row_not_void: a_row /= Void
			is_parented: parent /= Void
		do
			Result := implementation.has_subrow (a_row)
		ensure
			has_subrow_same_parent: Result implies
				((a_row.parent /= Void and parent /= Void) and then a_row.parent = parent)
		end

	parent_row: EV_GRID_ROW is
			-- Parent of Current if any, Void otherwise
		do
			Result := implementation.parent_row
		ensure
			has_parent: Result /= Void implies Result.has_subrow (Current)
		end

	parent: EV_GRID is
			-- Grid to which current row belongs
		do
			Result := implementation.parent
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th column
		require
			i_within_bounds: i > 0 and i <= count
			is_parented: parent /= Void
		do
			Result := implementation.item (i)
		ensure
			item_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
		end
		
	is_expanded: BOOLEAN is
			-- Are subrows of `Current' displayed?
		do
			Result := implementation.is_expanded
		end
		
	height: INTEGER is
			-- Height of `Current' when displayed in a `parent'
			-- that has `is_row_height_fixed' set to `False'.
			-- Note that `height' is ignored if the parent has
			-- `is_row_height_fixed' set to `True' and then all rows
			-- are displayed with identical heights set to `parent.row_height'.
		require
			is_parented: parent /= Void
		do
			Result := implementation.height
		ensure
			result_not_negative: Result >= 0
		end

feature -- Status report

	subrow_count: INTEGER is
			-- Number of children
		require
			is_parented: parent /= Void
		do
			Result := implementation.subrow_count
		ensure
			subrow_count_non_negative: subrow_count >= 0
			subrow_count_in_range: subrow_count <= (parent.row_count - index)
		end

	index: INTEGER is
			-- Position of Current in `parent'
		require
			is_parented: parent /= Void
		do
			Result := implementation.index
		ensure
			index_positive: Result > 0
			index_less_than_row_count: Result <= parent.row_count
		end

	count: INTEGER is
			-- Number of items in current
		do
			Result := implementation.count
		ensure
			count_not_negative: count >= 0
		end
		
feature -- Status setting

	expand is
			-- Display all subrows of `Current'.
		require
			has_subrows: subrow_count > 0
			is_parented: parent /= Void
		do
			implementation.expand
		ensure
			is_expanded: is_expanded
		end
		
	collapse is
			-- Hide all subrows of `Current'.
		require
			is_parented: parent /= Void
		do
			implementation.collapse
		ensure
			not_is_expanded: not is_expanded
		end
		
	set_height (a_height: INTEGER) is
			-- Assign `a_height' to `height'.
		require
			is_parented: parent /= Void
		do
			implementation.set_height (a_height)
		ensure
			height_set: height = a_height
		end

feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th column to be `a_item'
		require
			i_positive: i > 0
			a_item_not_void: a_item /= Void
			is_parented: parent /= Void
		do
			implementation.set_item (i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	add_subrow (a_row: EV_GRID_ROW) is
			-- Make `a_row' a child of Current
		require
			is_parented: parent /= Void
			a_row_not_void: a_row /= Void
			a_row_is_parented: a_row.parent /= Void
			a_row_is_not_current: a_row /= Current
			a_row_is_not_a_subrow: a_row.parent_row = Void
			current_is_parented: parent /= Void
			same_parent: a_row.parent = parent
			parent_enabled_as_tree: parent.is_tree_enabled
			a_row_is_below_current: a_row.index > index
			valid_parent: parent.row (a_row.index - 1) = Current or
				True -- for (i in index .. a_row.index - 1) there exists i where
				-- parent.row (i).parent_row = Current
		do
			implementation.add_subrow (a_row)
		ensure
			added: a_row.parent_row = Current
			subrow (subrow_count) = a_row
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `a_color' to all items in Current
		require
			is_parented: parent /= Void
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			--color_set: forall (item(i).background_color  = a_color)
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
