indexing
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN

inherit
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end
	
	EV_DESELECTABLE
		redefine
			implementation
		end

	EV_GRID_COLUMN_ACTION_SEQUENCES
		undefine
			default_create, copy, is_equal
		redefine
			implementation
		end
		
create
	{EV_GRID_I} default_create

feature -- Access

	header_item: EV_GRID_HEADER_ITEM is
			-- Header item used for resizing `Current' in grid.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.header_item
		ensure
			result_not_void: Result /= Void
		end

	is_displayed: BOOLEAN is
			-- May `Current' be displayed when its `parent' is?
			-- Will return False if `hide' has been called on `Current'.
			-- A column that `is_displayed' does not necessarily have to be visible on screen at that particular time.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.is_displayed
		end

	title: STRING is
			-- Title of Current column. Empty if none.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.title
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th row, Void if none.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := implementation.item (i)
		end

	parent: EV_GRID is
			-- Grid to which current column belongs.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent
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
		end

	width: INTEGER is
			-- `Result' is width of `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end
		
	virtual_x_position: INTEGER is
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.virtual_x_position
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
			to_implement_assertion ("valid_result: Result >= 0 and Result <= virtual_width - viewable_width")
		end

	background_color: EV_COLOR is
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color
		end

	foreground_color: EV_COLOR is
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.foreground_color
		end

	pixmap: EV_PIXMAP is
			-- Pixmap display on header of `parent' to left of `title'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmap
		end
		
feature -- Status setting

	hide is
			-- Prevent column from being shown in `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.hide
		ensure
			not_is_displayed: not is_displayed
		end

	show is
			-- Allow column to be displayed when `parent' is.
			-- Does not signify that the column will be visible on screen but that it will be visible within its parent.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.show
		ensure
			is_displayed: is_displayed
		end
		
	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
			shown: is_displayed
		do
			implementation.ensure_visible
		ensure
			parent_virtual_y_position_unchanged: old parent.virtual_y_position = parent.virtual_y_position
			to_implement_assertion ("old_is_visible_implies_horizontal_position_not_changed")
			column_visible: virtual_x_position >= parent.virtual_x_position and virtual_x_position + width <= parent.virtual_x_position + (parent.viewable_width).max (width)
		end

feature -- Status report

	index: INTEGER is
			-- Position of Current in `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.index
		ensure
			index_positive: Result > 0
			index_less_than_column_count: Result <= parent.column_count
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
			
feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th row to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			is_parented: parent /= Void
			valid_tree_structure_on_insertion: a_item /= Void and parent.is_tree_enabled and parent.row (i).parent_row /= Void implies index >= parent.row (i).parent_row.index_of_first_item
			to_implement_assertion	("Add preconditions for subnode handling of `Void' items.")
		do
			implementation.set_item (i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_title (a_title)
		ensure
			title_set: title.is_equal (a_title)
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
		
	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			not_destroyed: not is_destroyed
			width_non_negative: a_width >= 0
			is_parented: parent /= Void
		do
			implementation.set_width (a_width)
		ensure
			width_set: width = a_width
		end

	clear is
			-- Remove all items from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.clear
		ensure
			to_implement_assertion ("EV_GRID_COLUMN.clear - All items positions return `Void'.")
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current' to left of `title'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			Implementation.set_pixmap (a_pixmap)
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end
		
	redraw is
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			implementation.redraw
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_COLUMN_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_COLUMN_I} implementation.make (Current)
		end

invariant
	is_selected_implies_selected_items_count_equals_count: is_selected implies selected_items.count = count

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

