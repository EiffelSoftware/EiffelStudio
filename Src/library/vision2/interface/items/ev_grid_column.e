note
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	date: "$Date$"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	{EV_GRID, EV_GRID_I} default_create

feature -- Access

	header_item: EV_GRID_HEADER_ITEM
			-- Header item used for resizing `Current' in grid.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.header_item
		ensure
			result_not_void: Result /= Void
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
			-- A column that `is_show_requested' does not necessarily have to be visible on screen at that particular time.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_displayed
		ensure
			bridge_ok: Result = implementation.is_displayed
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.is_show_requested
		end

	title: STRING_32
			-- Title of Current column. Empty if none.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.title
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): detachable EV_GRID_ITEM
			-- Item at `i'-th row, Void if none.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := implementation.item (i)
		end

	parent: detachable EV_GRID
			-- Grid to which current column belongs.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			-- All items selected in `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER
			-- `Result' is width of `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

	virtual_x_position: INTEGER
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
		end

	virtual_x_position_unlocked: INTEGER
			-- Horizontal offset of unlocked position of `Current', in relation to the
			-- virtual area of `parent' grid in pixels.
			-- If not `is_locked', then `virtual_x_position' = `virtual_y_position_unlocked'.
			-- If `is_locked' then `Result' is the "shadow" position where the column would
			-- be if not locked.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.virtual_x_position_unlocked
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	background_color: detachable EV_COLOR
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.background_color
		end

	foreground_color: detachable EV_COLOR
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.
			-- See header of `EV_GRID' for a description of this behavior.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.foreground_color
		end

	pixmap: detachable EV_PIXMAP
			-- Pixmap display on header of `parent' to left of `title'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.pixmap
		end

	is_locked: BOOLEAN
			-- Is `Current' locked so that it no longer scrolls?
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.is_locked
		end

	locked_position: INTEGER
			-- Locked position of `Current' from left edge of viewable area of `parent'.
			-- `Result' is 0 if not `is_locked'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.locked_position
		ensure
			not_locked_implies_result_zero: not is_locked implies result = 0
		end

feature -- Status setting

	lock
			-- Ensure `is_locked' is `True'.
			-- `Current' is locked at it's current horizontal offset from
			-- the left edge of the viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void then end
			lock_at_position (virtual_x_position - l_parent.virtual_x_position)
		ensure
			is_locked: is_locked
			locked_position_set: attached parent as l_par and then locked_position = virtual_x_position - l_par.virtual_x_position
		end

	lock_at_position (a_position: INTEGER)
			-- Ensure `is_locked' is `True' with the horizontal offset from
			-- the left edge of the viewable area of `parent' set to `a_position'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.lock_at_position (a_position)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = a_position
		end

	unlock
			-- Ensure `is_locked' is `False'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.unlock
		ensure
			not_is_locked: not is_locked
		end

	hide
			-- Prevent column from being shown in `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.hide
		ensure
			not_is_show_requested: not is_show_requested
		end

	show
			-- Allow column to be displayed when `parent' is.
			-- Does not signify that the column will be visible on screen but that it will be visible within its parent.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.show
		ensure
			is_show_requested: is_show_requested
		end

	ensure_visible
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
			is_displayed: is_displayed
		do
			implementation.ensure_visible
		ensure
			parented: attached parent
			parent_virtual_y_position_unchanged: attached parent as l_parent and then attached old parent as l_old_parent and then l_old_parent.virtual_y_position = l_parent.virtual_y_position
			to_implement_assertion ("old_is_visible_implies_horizontal_position_not_changed")
			column_visible: virtual_x_position >= l_parent.virtual_x_position and virtual_x_position + width <= l_parent.virtual_x_position + (l_parent.viewable_width).max (width)
		end

	required_width_of_item_span (start_row, end_row: INTEGER): INTEGER
			-- Result is greatest `required_width' of all items from
			-- row index `start_row', `end_row' that are not hidden (i.e. `is_show_requested' is True).
		require
			not_destroyed: not is_destroyed
			parented: attached parent as l_parent
			valid_rows: start_row >= 1 and end_row <= l_parent.row_count and start_row - 1 <= end_row
		do
			Result := implementation.required_width_of_item_span (start_row, end_row)
		ensure
			result_non_negative: Result >= 0
		end

	resize_to_content
			-- Resize `Current' to greatest `required_width' of all items contained.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
			is_show_requested: is_show_requested
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void then end
			header_item.resize_to_content
			set_width (required_width_of_item_span (1, l_parent.row_count).max (header_item.width))
		ensure
			width_set: attached parent as l_par and then width = required_width_of_item_span (1, l_par.row_count).max (header_item.width)
		end

feature -- Status report

	index: INTEGER
			-- Position of Current in `parent'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			Result := implementation.index
		ensure
			index_positive: Result > 0
			index_less_than_column_count: attached parent as l_parent and then Result <= l_parent.column_count
		end

	count: INTEGER
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

	set_item (i: INTEGER; a_item: EV_GRID_ITEM)
			-- Set item at `i'-th row to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			a_item_not_parented: a_item /= Void implies a_item.parent = Void
			is_parented: attached parent as l_parent
			item_may_be_added_to_tree_node: a_item /= Void and then l_parent.row (i).is_part_of_tree_structure implies l_parent.row (i).is_index_valid_for_item_setting_if_tree_node (index)
			item_may_be_removed_from_tree_node: a_item = Void and then l_parent.row (i).is_part_of_tree_structure implies l_parent.row (i).is_index_valid_for_item_removal_if_tree_node (index)
		do
			implementation.set_item (i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- a_title_not_void: a_title /= Void.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_title (a_title)
		ensure
			title_set: a_title.same_string (title)
		end

	set_background_color (a_color: EV_COLOR)
			-- Set `background_color' with `a_color'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Set `foreground_color' with `a_color'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_set: foreground_color = a_color
		end

	set_width (a_width: INTEGER)
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

	clear
			-- Remove all items from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
			all_items_may_be_removed: all_items_may_be_removed
		do
			implementation.clear
		ensure
			to_implement_assertion ("EV_GRID_COLUMN.clear - All items positions return `Void'.")
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Display image of `a_pixmap' on `Current' to left of `title'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			Implementation.set_pixmap (a_pixmap)
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

	redraw
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			implementation.redraw
		end

feature -- Contract support

	all_items_may_be_removed: BOOLEAN
			-- May `Current' have all of its items removed?
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		local
			i, a_count, a_index: INTEGER
			a_row: EV_GRID_ROW
			l_parent: like parent
		do
			from
				i := 1
				Result := True
				a_count := count
				a_index := index
				l_parent := parent
				check l_parent /= Void then end
			until
				i > a_count or not Result
			loop
				a_row := l_parent.row (i)
				if a_row.is_part_of_tree_structure then
					Result := a_row.is_index_valid_for_item_removal_if_tree_node (a_index)
				end
				i := i + 1
			end
		end

	all_items_may_be_set: BOOLEAN
			-- May `Current' be set with `count' items.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		local
			i, a_count, a_index: INTEGER
			a_row: EV_GRID_ROW
			l_parent: like parent
		do
			from
				i := 1
				l_parent := parent
				check l_parent /= Void then end
				Result := True
				a_count := count
				a_index := index
			until
				i > a_count or not Result
			loop
				a_row := l_parent.row (i)
				if a_row.is_part_of_tree_structure then
					Result := a_row.is_index_valid_for_item_setting_if_tree_node (a_index)
				end
				i := i + 1
			end
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_COLUMN_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_COLUMN_I} implementation.make
		end

invariant
	virtual_position_and_virtual_position_unlocked_equal_when_not_locked: not is_locked implies virtual_x_position = virtual_x_position_unlocked

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end







