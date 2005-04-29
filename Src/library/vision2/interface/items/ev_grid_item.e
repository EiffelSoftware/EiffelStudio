indexing
	description: "Item that can be inserted in a cell of an EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ITEM

inherit
	EV_CONTAINABLE
		redefine
			implementation
		end
	
	REFACTORING_HELPER
		undefine
			copy, default_create
		end
	
	EV_DESELECTABLE
		undefine
			is_in_default_state
		redefine
			implementation
		end

	EV_COLORIZABLE
		redefine
			implementation
		end

create
	default_create

feature -- Access

	column: EV_GRID_COLUMN is
			-- Column to which current item belongs.
		require
			not_destroyed: not is_destroyed
			is_parented: is_parented
		do
			Result := implementation.column
		ensure
			column_not_void: Result /= Void
		end

	parent: EV_GRID is
			-- Grid in which `Current' is contained if any.
		do
			Result := implementation.parent
		end

	row: EV_GRID_ROW is
			-- Row to which current item belongs.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.row
		ensure
			row_not_void: Result /= Void
		end
		
	virtual_x_position: INTEGER is
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.virtual_x_position
		ensure
			valid_result: parent /= Void implies Result >= 0 and Result <= parent.virtual_width - column.width + horizontal_indent
		end
		
	virtual_y_position: INTEGER is
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.virtual_y_position
		ensure
			valid_result_when_parent_row_height_fixed: parent /= Void implies Result >= 0 and Result <= parent.virtual_height - parent.row_height
			valid_result_when_parent_row_height_not_fixed: parent /= Void implies Result >= 0 and Result <= parent.virtual_height - row.height
		end
		
	horizontal_indent: INTEGER is
			-- Horizontal distance in pixels from left edge of `Current' to left edge of `column'.
			-- This may not be set, but the value is determined by the current tree structure
			-- of `parent' and `row'.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.horizontal_indent
		ensure
			not_parent_tree_enabled_implies_result_zero: not parent.is_tree_enabled implies Result = 0
			parent_tree_enabled_implies_result_greater_or_equal_to_zero: parent.is_tree_enabled implies Result >= 0
		end

	width: INTEGER is
			-- Width of `Current' in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

	height: INTEGER is
			-- Height of `Current' in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.height
		ensure
			Result_non_negative: Result >= 0
		end
		
feature -- Status setting

	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			implementation.ensure_visible
		ensure
			to_implement_assertion ("old_is_visible_implies_positions_not_changed")
			row_visible_when_heights_fixed_in_parent: parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + parent.row_height <= parent.virtual_y_position + (parent.viewable_height).max (parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not parent.is_row_height_fixed implies row.virtual_y_position >= parent.virtual_y_position and virtual_y_position + row.height <= parent.virtual_y_position + (parent.viewable_height).max (row.height)
			column_visible: column.virtual_x_position >= parent.virtual_x_position and column.virtual_x_position + column.width <= parent.virtual_x_position + (parent.viewable_width).max (column.width)
		end
		
feature -- Actions

	activate is
			-- Setup `Current' for user interactive editing.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			implementation.activate
		end
        
	deactivate is
			-- Cleanup from previous call to `activate'.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			implementation.deactivate
		end

	refresh is
			--
		do
			implementation.refresh
		end
		

feature -- Status report

	is_parented: BOOLEAN is
			-- Does current item belongs to an EV_GRID?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_parented
		end

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {EV_GRID_I} -- Implementation

	activate_action (popup_window: EV_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		require
			parented: is_parented
			popup_window_not_void: popup_window /= Void
			popup_window_not_destroyed: not popup_window.is_destroyed	
		do
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_ITEM_I} implementation.make (Current)
		end

invariant
	parented_implies_height_equals_row_height: parent /= Void implies height = row.height
	parented_and_parent_has_no_tree_implies_width_equals_column_width: parent /= Void and then not parent.is_tree_enabled implies width = column.width
	parented_and_row_is_subrow_implies_width_equals_column_width_less_indent: parent /= Void and row.parent_row /= Void implies width = column.width - horizontal_indent

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
