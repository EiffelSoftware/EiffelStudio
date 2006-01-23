indexing
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

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

feature {EV_GRID_COLUMN} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			physical_index := -1
			create header_item.make_with_grid_column (Current)
			set_is_initialized (True)
		end

feature {EV_GRID_I} -- Initialization

	set_parent_i (a_grid_i: EV_GRID_I) is
			-- Make `Current' associated with `a_grid_i'.
		require
			a_grid_i_not_void: a_grid_i /= Void
		do
			parent_i := a_grid_i
		ensure
			parent_i = a_grid_i
		end

	set_physical_index (a_index: INTEGER) is
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

	index_of_first_item: INTEGER is
			-- Return the index of the first non `Void' item within `Current'
			-- or 0 if none.
		local
			counter: INTEGER
			column_count: INTEGER
			a_item: EV_GRID_ITEM_I
			a_parent_i: EV_GRID_I
			a_index: INTEGER
		do
			from
				column_count := count
				a_parent_i := parent_i
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


	is_displayed: BOOLEAN
		-- May `Current' be displayed when its `parent' is?
		-- Will return False if `hide' has been called on `Current'.
		-- A column that `is_displayed' does not necessarily have to be visible on screen at that particular time.

	title: STRING is
			-- Title of Current column. Empty if none.
		require
			is_parented: parent /= Void
		do
			Result := header_item.text
		ensure
			title_not_void: Result /= Void
		end

	item (i: INTEGER): EV_GRID_ITEM is
			-- Item at `i'-th row, Void if none.
		require
			i_positive: i > 0
			i_less_than_count: i <= count
			is_parented: parent /= Void
		do
			Result := parent_i.item (index, i)
		end

	parent: EV_GRID is
			-- Grid to which current column belongs.
		do
			if parent_i /= Void then
				Result := parent_i.interface
			end
		end

	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_item: EV_GRID_ITEM_I
		do
			from
				i := 1
				create Result.make (count)
			until
				i > count
			loop
				a_item := parent_i.item_internal (index, i)
				if a_item /= Void and then a_item.is_selected then
					Result.extend (a_item.interface)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER is
			-- `Result' is width of `Current'.		
		require
			is_parented: parent /= Void
		local
			l_offsets: EV_GRID_ARRAYED_LIST [INTEGER]
		do
			if parent_i.is_header_item_resizing and not parent_i.is_column_resize_immediate then
					-- In this situation, we do not want `Result'
					-- to be the width of the header item as the width must only be updated
					-- after the user has finished dragging the header.
				l_offsets := parent_i.column_offsets
				Result := l_offsets.i_th (index + 1) - l_offsets.i_th (index)
			else
				Result := header_item.width
			end
		ensure
			Result_non_negative: Result >= 0
		end

	virtual_x_position: INTEGER is
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
			-- `Result' is 0 if `parent' is `Void'.
		do
			if parent_i /= Void then
					-- If there is no parent then return 0.

				parent_i.perform_horizontal_computation
					-- Recompute horizontally if required.

				Result := parent_i.column_offsets @ (index)
			end
		ensure
			parent_void_implies_result_zero: parent = Void implies Result = 0
		end

	background_color: EV_COLOR
			-- Color displayed as background of `Current' except where there are items contained that
			-- have a non-`Void' `background_color'. If `Void', `background_color' of `parent' is displayed..

	foreground_color: EV_COLOR
			-- Color displayed for foreground features of `Current' except where there are items contained that
			-- have a non-`Void' `foreground_color'. If `Void', `foreground_color' of `parent' is displayed.

	pixmap: EV_PIXMAP
		-- Pixmap display on column header to left of `title'.

feature -- Status setting

	hide is
			-- Prevent column from being displayed in `parent'.
		require
			is_parented: parent /= Void
		do
			parent.hide_column (index)
		ensure
			not_is_displayed: not is_displayed
		end

	show is
			-- Allow column to be displayed when `parent' is.
			-- Does not signify that the column will be visible on screen but that it will be visible within its parent.
		require
			is_parented: parent /= Void
		do
			parent.show_column (index)
		ensure
			is_displayed: is_displayed
		end

	enable_select is
			-- Select `Current' in `parent_i'.
		do
			internal_update_selection (True)
			set_internal_is_selected (True)
			if parent_i /= Void then
				parent_i.redraw_column (Current)
			end
		end

	disable_select is
			-- Deselect `Current' from `parent_i'.
		do
			internal_update_selection (False)
			set_internal_is_selected (False)
			if parent_i /= Void then
				parent_i.redraw_column (Current)
			end
		end

	ensure_visible is
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			parented: parent /= Void
			shown: is_displayed
		local
			virtual_x: INTEGER
			l_width: INTEGER
			extra_width: INTEGER
			i: INTEGER
		do
				-- It is necessary to perform the recomputation immediately
				-- as this may show the horizontal or vertical scroll bar
				-- which affects the size of the viewable area in which `Current'
				-- is to be displayed.
			parent_i.recompute_horizontal_scroll_bar
			parent_i.recompute_vertical_scroll_bar

			virtual_x := virtual_x_position
			l_width := width
			if virtual_x < parent_i.virtual_x_position then
				parent_i.set_virtual_position (virtual_x, parent_i.virtual_y_position)
			elseif virtual_x + l_width > parent_i.virtual_x_position + parent_i.viewable_width then
				if parent_i.is_horizontal_scrolling_per_item then
						-- In this case, we must ensure that it is always the left item that still matches flush to
						-- the left of the viewable area of `parent_i'.
						-- The only way to determine the extra amount to add in order
						-- for the top row to be flush with the top of the viewable area, is
						-- to loop up until we find the first one that intersects the viewable area.
					from
						i := index
						extra_width := parent_i.viewable_width
					until
						i = 1 or extra_width < 0
					loop
						extra_width := extra_width - parent_i.column (i).width
						i := i - 1
					end
					extra_width := parent_i.column (i + 1).width + extra_width
				end
				if l_width >= parent_i.viewable_width then
						-- In this case, the width of the column is greater than the viewable width
						-- so we simply set it to the left of the viewable area.
					parent_i.set_virtual_position (virtual_x, parent_i.virtual_y_position)
				else
					parent_i.set_virtual_position (virtual_x + l_width + extra_width - parent_i.viewable_width, parent_i.virtual_y_position)
				end
			end
		ensure
			parent_virtual_y_position_unchanged: old parent.virtual_y_position = parent.virtual_y_position
			to_implement_assertion ("old_is_visible_implies_horizontal_position_not_changed")
			column_visible: virtual_x_position >= parent.virtual_x_position and virtual_x_position + width <= parent.virtual_x_position + (parent.viewable_width).max (width)
		end

	required_width_of_item_span (start_row, end_row: INTEGER): INTEGER is
			-- Result is greatest `required_width' of all items from
			-- row index `start_row', `end_row'.
		require
			parented: parent /= Void
			valid_rows: start_row >= 1 and end_row <= parent.row_count and start_row <= end_row
		local
			item_counter: INTEGER
			parent_row_count: INTEGER
			row_data: SPECIAL [EV_GRID_ITEM_I]
			internal_row_data: EV_GRID_ARRAYED_LIST [SPECIAL [EV_GRID_ITEM_I]]
			grid_item_i: EV_GRID_ITEM_I
			row: EV_GRID_ROW_I
		do
			from
				item_counter := start_row
				parent_row_count := parent_i.row_count
				internal_row_data := parent_i.internal_row_data
			until
				item_counter > end_row
			loop
				row_data := internal_row_data @ item_counter

					-- `row_data' may not have a count less than
					-- `column_count' if items are Void in this row.
				if physical_index < row_data.count then
					grid_item_i := row_data @ (physical_index)
					if grid_item_i /= Void then
						Result := Result.max (grid_item_i.required_width + parent_i.item_indent (grid_item_i))
					end
					row := parent_i.row_internal (item_counter)
					if row.subrow_count > 0 and not row.is_expanded then
						item_counter := item_counter + row.subrow_count_recursive
					end
				end
				item_counter := item_counter + 1
			end
		ensure
			result_non_negative: Result >= 0
		end

feature -- Status report

	index: INTEGER
			-- Position of Current in `parent'.

	count: INTEGER is
			-- Number of items in current.
		require
			is_parented: parent /= Void
		do
			Result := parent_i.row_count
		ensure
			count_not_negative: count >= 0
		end

	is_selected: BOOLEAN is
			-- Is objects state set to selected?
		local
			a_item: EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			non_void_item_found: BOOLEAN
			a_parent_i: EV_GRID_I
			a_index: INTEGER
		do
			from
				i := 1
				Result := True
				a_count := count
				a_parent_i := parent_i
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

	is_selectable: BOOLEAN is
			-- May the object be selected.
		do
			Result := parent_i /= Void
		end

feature -- Element change

	set_item (i: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set item at `i'-th row to be `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			i_positive: i > 0
			is_parented: parent /= Void
			valid_tree_structure_on_insertion: a_item /= Void and parent.is_tree_enabled and parent.row (i).parent_row /= Void implies index >= parent.row (i).parent_row.index_of_first_item
			item_may_be_added_to_tree_node: a_item /= Void and parent.row (i).is_part_of_tree_structure implies parent.row (i).is_index_valid_for_item_setting_if_tree_node (index)
			item_may_be_removed_from_tree_node: a_item = Void and then parent.row (i).is_part_of_tree_structure implies parent.row (i).is_index_valid_for_item_removal_if_tree_node (index)
		do
			parent_i.set_item (index, i, a_item)
		ensure
			item_set: item (i) = a_item
		end

	set_title (a_title: like title) is
			-- a_title_not_void: a_title /= Void.
		require
			is_parented: parent /= Void
		do
			header_item.set_text (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			background_color := a_color
			parent_i.redraw_column (Current)
		ensure
			background_color_set: background_color = a_color
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' with `a_color'.
		require
			is_parented: parent /= Void
		do
			foreground_color := a_color
			parent_i.redraw_column (Current)
		ensure
			foreground_color_set: foreground_color = a_color
		end

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
			is_parented: parent /= Void
		do
			header_item.set_width (a_width)
			parent_i.header.item_resize_end_actions.call ([header_item])
		ensure
			width_set: width = a_width
		end

	clear is
			-- Remove all items from `Current'.
		require
			is_parented: parent /= Void
		local
			i: INTEGER
			a_count: INTEGER
			a_parent_i: EV_GRID_I
			a_index: INTEGER
		do
			from
				i := 1
				a_count := count
				a_parent_i := parent_i
				a_index := index
			until
				i > a_count
			loop
				a_parent_i.internal_set_item (a_index, i, Void)
				i := i + 1
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current' to left of `title'.
		require
			pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			header_item.set_pixmap (pixmap)
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		do
			pixmap := Void
			header_item.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

	redraw is
			-- Force all items within `Current' to be re-drawn when next idle.
		require
			parented: parent /= Void
		do
			parent_i.redraw_column (Current)
		end

feature {EV_GRID_I} -- Implementation

	update_for_removal is
			-- Update settings in `Current' to reflect the fact that
			-- it is being removed from `parent_i'.
		require
			is_parented: parent /= Void
		do
			clear
			disable_select
			unparent
		ensure
			parent_i_unset: parent_i = Void
		end

	destroy is
			-- Destroy `Current'.
		do
			if parent_i /= Void then
				parent_i.remove_column (index)
			end
			set_is_destroyed (True)
		end

	set_is_displayed (a_displayed: BOOLEAN) is
			-- Set `is_displayed' to `a_displayed'.
		do
			is_displayed := a_displayed
		ensure
			is_displayed_set: is_displayed = a_displayed
		end

feature {NONE} -- Implementation

	internal_update_selection (a_selection_state: BOOLEAN) is
			-- Set the selection state of all non void items in `Current' to `a_selection_state'.
		local
			a_item: EV_GRID_ITEM_I
			i: INTEGER
			a_count: INTEGER
			a_parent_i: EV_GRID_I
			a_index: INTEGER
			l_is_selected: BOOLEAN
		do
			l_is_selected := is_selected
			a_parent_i := parent_i
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

	call_selection_events (a_selection_state: BOOLEAN) is
			-- Call the selection events of `Current' for selection state `a_selection_state'.
		do
			if a_selection_state then
				if parent_i.column_select_actions_internal /= Void then
					parent_i.column_select_actions_internal.call ([interface])
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			else
				if parent_i.column_deselect_actions_internal /= Void  then
					parent_i.column_deselect_actions_internal.call ([interface])
				end
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call (Void)
				end
			end
		end

feature {EV_GRID_I} -- Implementation

	unparent is
			-- Sets` parent_i' to `Void'.
		do
			parent_i := Void
		ensure
			parent_void: parent = Void
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_COLUMN, EV_GRID_COLUMN_I, EV_GRID_ITEM_I, EV_GRID_ROW_I} -- Implementation

	set_internal_is_selected (a_selected: BOOLEAN) is
			-- Set `internal_is_selected' to `a_selected'.
		do
			internal_is_selected := a_selected
		ensure
			internal_is_selected_set: internal_is_selected = a_selected
		end

	set_index (a_index: INTEGER) is
			-- Set the internal index of row
		require
			a_index_greater_than_zero: a_index > 0
		do
			index := a_index
		ensure
			index_set: index = a_index
			indexes_equivalent: parent_i.columns.i_th (index) = Current
			index_less_than_row_count: index <= parent.column_count
		end

	physical_index: INTEGER
		-- Physical index of column row data stored in `parent_i'.

	parent_i: EV_GRID_I
		-- Grid that `Current' resides in.

	header_item: EV_GRID_HEADER_ITEM
		-- Header item associated with `Current'.

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_COLUMN
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

invariant
	header_item_not_void: is_initialized implies header_item /= Void
	physical_index_set: parent /= Void implies physical_index >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

