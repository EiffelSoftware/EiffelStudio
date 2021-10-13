note
	description: "Column of an EV_GRID, containing EV_GRID_ITEMs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN_I

inherit
	REFACTORING_HELPER

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_GRID_COLUMN_ACTION_SEQUENCES_I
		export
			{EV_GRID_I}
				deselect_actions_internal
		end

create
	make

feature {EV_ANY} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			physical_index := -1
			create header_item
			header_item.set_column (Current)
			set_is_initialized (True)
		end

feature {EV_GRID_I} -- Initialization

	set_parent_i (a_grid_i: EV_GRID_I)
			-- Make `Current' associated with `a_grid_i'.
		require
			a_grid_i_not_void: a_grid_i /= Void
		do
			parent_i := a_grid_i
		ensure
			parent_i = a_grid_i
		end

	set_physical_index (a_index: INTEGER)
			-- Set the physical index of the column.
		require
			valid_index: a_index >= 0
			physical_index_not_set: physical_index = -1
		do
			physical_index := a_index
		ensure
			physical_index_set: physical_index = a_index
		end

feature -- Access

	index_of_first_item: INTEGER
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		local
			counter: INTEGER
			column_count: INTEGER
			a_item: detachable EV_GRID_ITEM_I
			a_parent_i: EV_GRID_I
			a_index: INTEGER
		do
			from
				column_count := count
				a_parent_i := attached_parent_i
				counter := 1
				a_index := index
			until
				a_item /= Void or else counter = column_count
			loop
				a_item := a_parent_i.item_internal (a_index, counter)
				counter := counter + 1
			end
			if a_item /= Void then
				Result := counter - 1
			end
		ensure
			valid_result: Result >= 0 and Result <= count
		end

	is_show_requested: BOOLEAN
		-- May `Current' be displayed when its `parent' is?
		-- Will return False if `hide' has been called on `Current'.

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
			-- A column that `is_displayed' does not necessarily have to be visible on screen at that particular time.
		do
			Result := is_show_requested and then parent_i /= Void and then attached_parent_i.is_displayed
		end

	title: STRING_32
			-- Title of Current column. Empty if none.
		require
			is_parented: parent /= Void
		do
			Result := header_item.text
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): detachable EV_GRID_ITEM
			-- Item at `i'-th row, Void if none.
		require
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := attached_parent_i.item (index, i)
		end

	parent: detachable EV_GRID
			-- Grid to which current column belongs.
		do
			if parent_i /= Void then
				Result := attached_parent_i.interface
			end
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_item: detachable EV_GRID_ITEM_I
		do
			from
				i := 1
				create Result.make (count)
			until
				i > count
			loop
				a_item := attached_parent_i.item_internal (index, i)
				if a_item /= Void and then a_item.is_selected then
					Result.extend (a_item.attached_interface)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER
			-- `Result' is width of `Current'.		
		require
			is_parented: parent /= Void
		local
			l_offsets: EV_GRID_ARRAYED_LIST [INTEGER]
		do
			if attached_parent_i.is_header_item_resizing and not attached_parent_i.is_column_resize_immediate then
					-- In this situation, we do not want `Result'
					-- to be the width of the header item as the width must only be updated
					-- after the user has finished dragging the header.
				l_offsets := attached_parent_i.column_offsets
				Result := l_offsets.i_th (index + 1) - l_offsets.i_th (index)
			else
				Result := header_item.width
			end
		ensure
			Result_non_negative: Result >= 0
		end

	minimum_width: INTEGER
			-- Minimum width of current column.
		do
			if
				attached parent_i as l_parent and then
				l_parent.is_header_displayed
			then
				Result := header_item.minimum_width
			end
		end

	virtual_x_position: INTEGER
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		do
			if is_locked and then attached locked_column as l_locked_column then
				Result := attached_parent_i.internal_client_x + l_locked_column.offset
			else
				Result := virtual_x_position_unlocked
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	virtual_x_position_unlocked: INTEGER
			-- Horizontal offset of unlocked position of `Current', in relation to the
			-- virtual area of `parent' grid in pixels.
			-- If not `is_locked', then `virtual_x_position' = `virtual_y_position_unlocked'.
			-- If `is_locked' then `Result' is the "shadow" position where the column would
			-- be if not locked.
		do
			if parent_i /= Void then
					-- If there is no parent then return 0.
				attached_parent_i.perform_horizontal_computation
					-- Recompute horizontally if required.
				Result := attached_parent_i.column_offsets @ (index)
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	background_color: detachable EV_COLOR
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed.

	foreground_color: detachable EV_COLOR
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.

	pixmap: detachable EV_PIXMAP
		-- Pixmap display on column header to left of `title'.

	is_locked: BOOLEAN
			-- Is `Current' locked so that it no longer scrolls?
			-- Note that this could be implemented as a function
			-- "Result := parent_i.locked_columns.item (index) /= Void" but this has not been done
			-- so for performance reasons.

	locked_position: INTEGER
			-- Locked position of `Current' from left edge of viewable area of `parent'.
			-- `Result' is 0 if not `is_locked'.
		do
			if is_locked and then attached locked_column as l_locked_column then
				Result := l_locked_column.offset
			end
		ensure
			not_locked_implies_result_zero: not is_locked implies Result = 0
		end

feature -- Status setting

	lock_at_position (a_position: INTEGER)
			-- Ensure `is_locked' is `True' with the horizontal offset from
			-- the left edge of the viewable area of `parent' set to `a_position'.
		local
			l_parent_i: like parent_i
			l_locked_column: like locked_column
		do
			if is_locked then
				unlock
			end
			is_locked := True

			l_parent_i := parent_i
			check l_parent_i /= Void then end

			create l_locked_column.make (l_parent_i, a_position, Current)
			locked_column := l_locked_column
			l_locked_column.set_locked_index (l_parent_i.locked_indexes.count + 1)
			l_parent_i.locked_indexes.extend (l_locked_column)
			l_parent_i.reposition_locked_column (Current)
			l_parent_i.redraw_column (Current)
			if l_parent_i.item_pebble_function /= Void then
				l_locked_column.drawing_area.set_pebble_function (agent l_parent_i.user_pebble_function_intermediary_locked (?, ?, l_locked_column))
			end
			l_locked_column.drawing_area.drop_actions.set_veto_pebble_function (agent l_parent_i.veto_pebble_function_intermediary)
			l_locked_column.drawing_area.drop_actions.extend (agent l_parent_i.drop_action_intermediary)
			l_locked_column.drawing_area.set_accept_cursor (l_parent_i.attached_interface.accept_cursor)
			l_locked_column.drawing_area.set_deny_cursor (l_parent_i.attached_interface.deny_cursor)
		ensure
			is_locked: is_locked
			locked_position_set: locked_position = a_position
		end

	unlock
			-- Ensure `is_locked' is `False'.
		do
			is_locked := False
			attached_parent_i.unlock_column (Current)
			locked_column := Void
		ensure
			not_is_locked: not is_locked
		end

	hide
			-- Prevent column from being displayed in `parent'.
		require
			is_parented: parent /= Void
		do
			if attached parent as l_parent then
				l_parent.hide_column (index)
			end
		ensure
			not_is_displayed: not is_show_requested
		end

	show
			-- Allow column to be displayed when `parent' is.
			-- Does not signify that the column will be visible on screen but that it will be visible within its parent.
		require
			is_parented: parent /= Void
		do
			if attached parent as l_parent then
				l_parent.show_column (index)
			end
		ensure
			is_displayed: is_show_requested
		end

	ensure_visible
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
			shown: is_displayed
		local
			virtual_x: INTEGER
			l_width: INTEGER
			extra_width: INTEGER
			i: INTEGER
			l_parent_i: like parent_i
		do
				-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			l_parent_i := parent_i
			check l_parent_i /= Void then end
			l_parent_i.recompute_horizontal_scroll_bar
			l_parent_i.recompute_vertical_scroll_bar

			virtual_x := virtual_x_position
			l_width := width
			if virtual_x < l_parent_i.virtual_x_position then
				l_parent_i.set_virtual_position (virtual_x, l_parent_i.virtual_y_position)
			elseif virtual_x + l_width > l_parent_i.virtual_x_position + l_parent_i.viewable_width then
				if l_parent_i.is_horizontal_scrolling_per_item then
						-- In this case, we must ensure that it is always the left item that still matches flush to
						-- the left of the viewable area of `parent_i'.
						-- The only way to determine the extra amount to add in order
						-- for the top row to be flush with the top of the viewable area, is
						-- to loop up until we find the first one that intersects the viewable area.
					from
						i := index
						extra_width := l_parent_i.viewable_width
					until
						i = 1 or extra_width < 0
					loop
						extra_width := extra_width - l_parent_i.column (i).width
						i := i - 1
					end
					extra_width := l_parent_i.column (i + 1).width + extra_width
				end
				if l_width >= l_parent_i.viewable_width then
						-- In this case, the width of the column is greater than the viewable width
						-- so we simply set it to the left of the viewable area.
					l_parent_i.set_virtual_position (virtual_x, l_parent_i.virtual_y_position)
				else
					l_parent_i.set_virtual_position (virtual_x + l_width + extra_width - l_parent_i.viewable_width, l_parent_i.virtual_y_position)
				end
			end
		ensure
			parent_attached: attached parent as l_par
			parent_virtual_y_position_unchanged: attached old parent as l_old_parent and then l_old_parent.virtual_y_position = l_par.virtual_y_position
			to_implement_assertion ("old_is_visible_implies_horizontal_position_not_changed")
			column_visible: virtual_x_position >= l_par.virtual_x_position and virtual_x_position + width <= l_par.virtual_x_position + (l_par.viewable_width).max (width)
		end

	required_width_of_item_span (start_row, end_row: INTEGER): INTEGER
			-- Result is greatest `required_width' of all items from
			-- row index `start_row', `end_row' that are not hidden (i.e. `is_show_requested' is True).
		require
			parented: attached parent as l_parent
			valid_rows: start_row >= 1 and end_row <= l_parent.row_count and start_row - 1 <= end_row
		local
			item_counter: INTEGER
			parent_row_count: INTEGER
			row_data: detachable SPECIAL [detachable EV_GRID_ITEM_I]
			internal_row_data: EV_GRID_ARRAYED_LIST [detachable SPECIAL [detachable EV_GRID_ITEM_I]]
			grid_item_i: detachable EV_GRID_ITEM_I
			row: EV_GRID_ROW_I
			l_parent_i: like parent_i
		do
			from
				l_parent_i := parent_i
				check l_parent_i /= Void then end
				item_counter := start_row
				parent_row_count := l_parent_i.row_count
				internal_row_data := l_parent_i.internal_row_data
			until
				item_counter > end_row
			loop
				row_data := internal_row_data @ item_counter

					-- `row_data' may not have a count less than
					-- `column_count' if items are Void in this row.
				if row_data /= Void and then physical_index < row_data.count then
					row := l_parent_i.row_internal (item_counter)
					if row.is_show_requested then
						grid_item_i := row_data @ (physical_index)
						if grid_item_i /= Void then
							Result := Result.max (grid_item_i.attached_interface.required_width + l_parent_i.item_indent (grid_item_i))
						end
					end
					if row.subrow_count > 0 and not row.is_expanded then
						item_counter := item_counter + row.subrow_count_recursive
					end
				end
				item_counter := item_counter + 1
			end
		ensure
			result_non_negative: Result >= 0
		end

	enable_select
			-- Select `Current' in `parent_i'.
		do
			internal_update_selection (True)
			set_internal_is_selected (True)
			if parent_i /= Void then
				attached_parent_i.redraw_column (Current)
			end
		end

	disable_select
			-- Deselect `Current' from `parent_i'.
		do
			internal_update_selection (False)
			set_internal_is_selected (False)
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_column (Current)
			end
		end

feature -- Status report

	locked_column: detachable EV_GRID_LOCKED_COLUMN_I
		-- Locked column information for `Current'.
		-- `Void' if not locked.

	index: INTEGER
			-- Position of Current in `parent'.

	count: INTEGER
			-- Number of items in current.
		require
			is_parented: parent /= Void
		do
			if attached parent_i as l_parent_i then
				Result := l_parent_i.row_count
			end
		ensure
			count_not_negative: count >= 0
		end

	is_selected: BOOLEAN
			-- Is objects state set to selected?
		local
			a_item: detachable EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			non_void_item_found: BOOLEAN
			a_parent_i: detachable EV_GRID_I
			a_index: INTEGER
		do
			from
				i := 1
				Result := True
				a_count := count
				a_parent_i := parent_i
				check a_parent_i /= Void then end
				a_index := index
			until
				not Result or else i > a_count
			loop
				a_item := a_parent_i.item_internal (a_index, i)
				if a_item /= Void then
					non_void_item_found := True
					Result := a_item.is_selected
				end
				i := i + 1
			end
			if not non_void_item_found then
					-- If no non-void items are present then we check internal flag.
				Result := internal_is_selected
			end
		end

	internal_is_selected: BOOLEAN

	is_selectable: BOOLEAN
			-- May the object be selected.
		do
			Result := parent_i /= Void
		end

feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM)
			-- Set item at `i'-th row to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			i_positive: i > 0
			a_item_not_parented: a_item /= Void implies a_item.parent = Void
			is_parented: attached parent as l_parent
			valid_tree_structure_on_insertion: a_item /= Void and then l_parent.is_tree_enabled and then attached l_parent.row (i).parent_row as l_parent_row implies index >= l_parent_row.index_of_first_item
			item_may_be_added_to_tree_node: a_item /= Void and l_parent.row (i).is_part_of_tree_structure implies l_parent.row (i).is_index_valid_for_item_setting_if_tree_node (index)
			item_may_be_removed_from_tree_node: a_item = Void and then l_parent.row (i).is_part_of_tree_structure implies l_parent.row (i).is_index_valid_for_item_removal_if_tree_node (index)
		local
			l_parent_i: like parent_i
		do
			l_parent_i := parent_i
			check l_parent_i /= Void then end
			l_parent_i.set_item (index, i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- a_title_not_void: a_title /= Void.
		require
			is_parented: parent /= Void
		do
			header_item.set_text (a_title)
		ensure
			title_set: a_title.same_string (title)
		end

	set_background_color (a_color: EV_COLOR)
			-- Set `background_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			background_color := a_color
			if attached parent_i as l_parent_i then

			end
			attached_parent_i.redraw_column (Current)
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Set `foreground_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			foreground_color := a_color
			attached_parent_i.redraw_column (Current)
		ensure
			foreground_color_set: foreground_color = a_color
		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
			a_width_greater_or_equal_minimum: a_width >= minimum_width
			is_parented: parent /= Void
		local
			l_width: INTEGER
		do
			l_width := width
			if a_width /= l_width and then attached parent_i as l_parent_i then
				header_item.set_width (a_width)
				l_parent_i.header.item_resize_end_actions.call ([header_item])
					-- We need to recompute content of grid next time
				l_parent_i.set_horizontal_computation_required (index)
				l_parent_i.redraw
				if is_locked then
					l_parent_i.reposition_locked_column (Current)
				end
			end
		ensure
			width_set: width = a_width
		end

	clear
			-- Remove all items from `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_count: INTEGER
			a_parent_i: detachable EV_GRID_I
			a_index: INTEGER
		do
			from
				i := 1
				a_count := count
				a_parent_i := parent_i
				check a_parent_i /= Void then end
				a_index := index
			until
				i > a_count
			loop
				a_parent_i.internal_set_item (a_index, i, Void)
				i := i + 1
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Display image of `a_pixmap' on `Current' to left of `title'.
		require
			pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			header_item.set_pixmap (a_pixmap)
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap
			-- Remove image displayed on `Current'.
		do
			pixmap := Void
			header_item.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

	redraw
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			parented: parent /= Void
		do
			if attached parent_i as l_parent_i then
				l_parent_i.redraw_column (Current)
			end
		end

feature {EV_GRID_I} -- Implementation

	update_for_removal
			-- Update settings in `Current' to reflect the fact that
			-- it is being removed from `parent_i'.
		require
			is_parented: parent /= Void
		do
			if is_locked then
				unlock
			end
			clear
			disable_select
			set_is_show_requested (False)
			unparent
		ensure
			parent_i_unset: parent_i = Void
		end

	destroy
			-- Destroy `Current'.
		do
			if attached parent_i as l_parent_i then
				l_parent_i.remove_column (index)
			end
			set_is_destroyed (True)
		end

	set_is_show_requested (a_displayed: BOOLEAN)
			-- Set `is_show_requested' to `a_displayed'.
		do
			is_show_requested := a_displayed
		ensure
			is_displayed_set: is_show_requested = a_displayed
		end

feature {NONE} -- Implementation

	internal_update_selection (a_selection_state: BOOLEAN)
			-- Set the selection state of all non void items in `Current' to `a_selection_state'.
		local
			a_item: detachable EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			a_parent_i: detachable EV_GRID_I
			a_index: INTEGER
			l_is_selected: BOOLEAN
		do
			l_is_selected := is_selected
			a_parent_i := parent_i
			check a_parent_i /= Void then end
			from
				i := 1
				a_count := count
				a_index := index
			until
				i > a_count
			loop
				a_item := a_parent_i.item_internal (a_index, i)
				if a_item /= Void then
					if a_selection_state then
						a_item.enable_select_internal
					else
						a_item.disable_select_internal
					end
				end
				i := i + 1
			end
				-- Call the grid column events.
			if (a_selection_state and then not l_is_selected) or else l_is_selected then
				call_selection_events (l_is_selected)
			end
		end

feature {EV_GRID_I} -- Implementation

	call_selection_events (a_selection_state: BOOLEAN)
			-- Call the selection events of `Current' for selection state `a_selection_state'.
		do
			if a_selection_state then
				if attached_parent_i.column_select_actions_internal /= Void then
					attached_parent_i.column_select_actions.call ([attached_interface])
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			else
				if attached_parent_i.column_deselect_actions_internal /= Void  then
					attached_parent_i.column_deselect_actions.call ([attached_interface])
				end
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call (Void)
				end
			end
		end

feature {EV_GRID_I} -- Implementation

	unparent
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
		ensure
			parent_void: parent = Void
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_COLUMN, EV_GRID_COLUMN_I, EV_GRID_ITEM_I, EV_GRID_ROW_I} -- Implementation

	set_internal_is_selected (a_selected: BOOLEAN)
			-- Set `internal_is_selected' to `a_selected'.
		do
			internal_is_selected := a_selected
		ensure
			internal_is_selected_set: internal_is_selected = a_selected
		end

	set_index (a_index: INTEGER)
			-- Set the internal index of row
		require
			a_index_greater_than_zero: a_index > 0
		do
			index := a_index
		ensure
			index_set: index = a_index
			indexes_equivalent: attached_parent_i.columns.i_th (index) = Current
			index_less_than_row_count: index <= attached_parent.column_count
		end

	physical_index: INTEGER
		-- Physical index of column row data stored in `parent_i'.

	parent_i: detachable EV_GRID_I
		-- Grid that `Current' resides in.

	header_item: EV_GRID_HEADER_ITEM
		-- Header item associated with `Current'.

	attached_parent: attached like parent
			-- Attached parent
		require
			parent /= Void
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void then end
			Result := l_parent
		end

	attached_parent_i: attached like parent_i
			-- Attached parent_i
		require
			parent_i /= Void
		local
			l_parent_i: like parent_i
		do
			l_parent_i := parent_i
			check l_parent_i /= Void then end
			Result := l_parent_i
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_COLUMN note option: stable attribute end
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

invariant
	header_item_not_void: is_initialized implies header_item /= Void
	physical_index_set: parent /= Void implies physical_index >= 0

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







