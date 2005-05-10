indexing
	description: "Item that can be inserted in a cell of an EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ITEM

inherit
	EV_CONTAINABLE
		redefine
			implementation,
			is_in_default_state
		end
	
	REFACTORING_HELPER
		undefine
			copy, default_create
		end
	
	EV_DESELECTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_GRID_ITEM_ACTION_SEQUENCES
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

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.foreground_color
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color
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

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `background_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_assigned: background_color = a_color
		end
		
feature -- Actions

	activate is
			-- Setup `Current' for interactive in-place editing of `Current'.
			-- Activation is usually achieved by connecting an agent  to 
			-- {EV_GRID}.pointer_double_press_actions' that calls `activate'.
			-- Will call `activate_action' of `Current' to setup the in-place editing.
			-- The default behavior of the activation can be overriden in {EV_GRID}.item_activate_actions,
			-- this is useful for repositioning the popup window used editing `Current'.
			-- See {EV_GRID_EDITABLE_ITEM}.activate_action for an example of what happens on activation.
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

	redraw is
			-- Force `Current' to be re-drawn when next idle.
		do
			implementation.redraw
		end
		
feature -- Status report

	is_parented: BOOLEAN is
			-- Does current item belongs to an EV_GRID?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_parented
		end

feature {NONE} -- Contract Support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- (from EV_ANY)
			-- (export status {NONE})
		do
			Result := Precursor {EV_CONTAINABLE} and Precursor {EV_DESELECTABLE} and
				foreground_color = Void and background_color = Void
		end

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {EV_GRID_I} -- Implementation

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
			-- Used for initializing `popup_window' for in-place editing.
			-- `popup_window' will be shown after `activate_action' has executed.
		require
			parented: is_parented
			popup_window_not_void: popup_window /= Void
			popup_window_not_destroyed: not popup_window.is_destroyed	
		do
			-- By default do nothing, redefined by descendants.
		ensure
			popup_window_not_destroyed: not popup_window.is_destroyed
			popup_window_not_shown: not popup_window.is_show_requested
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
