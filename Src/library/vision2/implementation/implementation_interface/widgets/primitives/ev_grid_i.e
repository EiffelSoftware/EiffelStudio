indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		Implementation Interface.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRID_I

inherit
	EV_CELL_I
		rename
			item as cell_item
		redefine
			interface,
			drop_actions,
			has_focus,
			set_focus,
			set_pebble,
			set_pebble_function,
			conforming_pick_actions,
			pick_actions,
			pick_ended_actions,
			set_accept_cursor,
			set_deny_cursor
		end

	EV_GRID_ACTION_SEQUENCES_I
	
	REFACTORING_HELPER

feature -- Access

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			if drop_actions_internal = Void then
				create drop_actions_internal
			end
			Result := drop_actions_internal
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits here is picked.
		do
			Result := drawable.conforming_pick_actions
		end

	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			Result := drawable.pick_actions
		end

	pick_ended_actions: EV_PND_FINISHED_ACTION_SEQUENCE is
			-- Actions to be performed when a transport from `Current' ends.
			-- If transport completed successfully, then event data
			-- is target. If cancelled, then event data is Void.
		do
			Result := drawable.pick_ended_actions
		end

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row at index `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_row_count: a_row <= row_count
		do
			Result := row_internal (a_row).interface
		ensure
			row_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column at index `a_column'.
		require
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		do
			Result := (columns @ (a_column)).interface
		ensure
			column_not_void: Result /= Void
		end

	visible_column (i: INTEGER): EV_GRID_COLUMN is
			-- `i'-th visible column.
		require
			i_positive: i > 0
			i_column_not_greater_than_visible_column_count: i <= visible_column_count
		local
			visible_counter, counter: INTEGER
			a_col_i: EV_GRID_COLUMN_I
		do
			from
				counter := 1
			until
				visible_counter = i
			loop
				a_col_i := columns @ (counter)
				if a_col_i.is_displayed then
					visible_counter := visible_counter + 1
				end
				counter := counter + 1
			end
			Result := a_col_i.interface
		ensure
			column_not_void: Result /= Void
		end

	item (a_column: INTEGER; a_row: INTEGER;): EV_GRID_ITEM is
			-- Cell at `a_column' and `a_row' position, Void if none.
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		local
			item_i: EV_GRID_ITEM_I
		do
			item_i := item_internal (a_column, a_row)
			if item_i /= Void then
				Result := item_i.interface
			end
		end
		
	item_at_virtual_position (a_virtual_x, a_virtual_y: INTEGER): EV_GRID_ITEM is
			-- Cell at virtual position `a_virtual_x', `a_virtual_y' or
			-- `Void' if none.
		require
			virtual_x_valid: a_virtual_x >=0 and a_virtual_x <= virtual_width
			virtual_y_valid: a_virtual_y >=0 and a_virtual_y <= virtual_height
		local
			item_i: EV_GRID_ITEM_I
		do
			item_i := drawer.item_at_virtual_position (a_virtual_x, a_virtual_y)
			if item_i /= Void then
				Result := item_i.interface
			end
		end

	selected_columns: ARRAYED_LIST [EV_GRID_COLUMN] is
			-- All columns selected in `Current'.
		local
			temp_columns: like columns
			cursor: CURSOR
		do
			from
				create Result.make (10)
				temp_columns := columns
				cursor := temp_columns.cursor
				temp_columns.start
			until
				temp_columns.after
			loop
				if temp_columns.item.is_selected then
					Result.extend (temp_columns.item.interface)
				end
				temp_columns.forth
			end
			temp_columns.go_to (cursor)
		ensure
			result_not_void: Result /= Void
		end
		
	selected_rows: ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows selected in `Current'.
		local
			i: INTEGER
			a_count: INTEGER
			a_row: EV_GRID_ROW_I
		do
			if is_row_selection_enabled then
				Result := internal_selected_rows.linear_representation
				if last_selected_row /= Void then
					Result.prune (last_selected_row.interface)
					Result.extend (last_selected_row.interface)
				end
			else
				create Result.make (10)	
				from
					i := 1
					a_count := row_count
				until
					i > a_count
				loop
					a_row := rows @ i
					if a_row /= Void and then a_row.is_selected then
						Result.extend (a_row.interface)
					end
					i := i + 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		local
			i: INTEGER
			sel_rows: like selected_rows
			a_count: INTEGER
		do
			if is_row_selection_enabled then
				create Result.make (10)
				from
					sel_rows := selected_rows
					a_count := sel_rows.count
					i := 1
				until
					i > a_count
				loop
					Result.append (sel_rows.i_th (i).selected_items)
					i := i + 1
				end
			else
				Result := internal_selected_items.linear_representation
				if last_selected_item /= Void then
					Result.prune (last_selected_item.interface)
					Result.extend (last_selected_item.interface)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	remove_selection is
			-- Ensure that `selected_rows' and `selected_items' are empty.
		local
			sel_rows: like selected_rows
			sel_items: like selected_items
		do
			sel_rows := internal_selected_rows.linear_representation
			from
				sel_rows.start
			until
				sel_rows.after
			loop
				sel_rows.item.disable_select
				sel_rows.forth
			end				
			sel_items := selected_items
			from
				sel_items.start
			until
				sel_items.after
			loop
				sel_items.item.disable_select
				sel_items.forth
			end
		ensure
			selected_items_empty: selected_items.is_empty
			selected_rows_empty: selected_rows.is_empty
			selected_columns_empty: selected_columns.is_empty
		end
		
	is_header_displayed: BOOLEAN
			-- Is the header displayed in `Current'.
			
	is_resizing_divider_enabled: BOOLEAN
			-- Is a vertical divider displayed during column resizing?
			
	is_resizing_divider_solid: BOOLEAN
			-- Is resizing divider displayed during column resizing drawn as a solid line?
			-- If `False', a dashed line style is used.
			
	is_horizontal_scrolling_per_item: BOOLEAN
			-- Is horizontal scrolling performed on a per-item basis?
			-- If `True', each change of the horizontal scroll bar increments the horizontal
			-- offset by the current column width.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		
	is_vertical_scrolling_per_item: BOOLEAN
			-- Is vertical scrolling performed on a per-item basis?
			-- If `True', each change of the vertical scroll bar increments the vertical
			-- offset by the current row height.
			-- If `False', the scrolling is smooth on a per-pixel basis.
			
	is_vertical_overscroll_enabled: BOOLEAN
			-- Does the virtual height of `Current' include the
			-- position of the final row plus the `viewable_height'.
			-- If `True', this enables vertical scrolling until the last row
			-- is at the very top of the viewable area. If `False', scrolling
			-- may be performed until the last row is at the bottom of the viewable
			-- area.
		
	is_horizontal_overscroll_enabled: BOOLEAN
			-- Does the virtual width of `Current' include the
			-- position of the final column plus the `viewable_width'.
			-- If `True', this enables horizontal scrolling until the last column
			-- is at the very left of the viewable area. If `False', scrolling
			-- may be performed until the last column is at the left of the viewable
			-- area.
			
	is_content_partially_dynamic: BOOLEAN
			-- Is the content of `Current' partially dynamic? If `True' then
			-- whenever an item must be re-drawn and it is not already set within `Current',
			-- then it is queried via `content_requested_actions'. The returned item is added
			-- to `Current' so the query only occurs once.
		
	is_content_completely_dynamic: BOOLEAN
			-- Is the content of `Current' completely dynamic? If `True' then
			-- whenever an item must be re-drawn it is always queried via `content_requested_actions'
			-- and not added to `Current'.
		
	is_row_height_fixed: BOOLEAN
			-- Must all rows in `Current' have the same height?

	is_column_resize_immediate: BOOLEAN
			-- Is the user resizing of a reflected immediately in `Current'?
			-- If `False', the column width is only updated upon completion of the resize.
		
	row_height: INTEGER
			-- Height of all rows within `Current'. Only has an effect on `Current'
			-- while `is_row_height_fixed', otherwise the individual height of each
			-- row is used directly.
			
	dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.
			
	subrow_indent: INTEGER
			-- Number of pixels horizontally by which each subrow is indented
			-- from its `parent_row'.
			
	are_tree_node_connectors_shown: BOOLEAN
			-- Are connectors between tree nodes shown in `Current'?
			
	virtual_x_position: INTEGER is
			-- Horizontal offset of viewable area in relation to the left edge of
			-- the virtual area in pixels.
		do
			Result := internal_client_x
		ensure
			valid_result: Result >= 0 and Result <= maximum_virtual_x_position
		end
		
	virtual_y_position: INTEGER is
			-- Vertical offset of viewable area in relation to the top edge of
			-- the virtual area in pixels.
		do
			Result := internal_client_y
		ensure
			valid_result: Result >= 0 and Result <= maximum_virtual_y_position
		end
		
	maximum_virtual_x_position: INTEGER is
			-- Maximum permitted virtual x position based on current dimensions and properties.
			-- Properties that affect this value are `is_vertical_scrolling_per_item' and
			-- `is_vertical_scrolling_per_item'.
		do
			Result := (virtual_width - viewable_width).max (0)
		ensure
			result_non_negative: Result >= 0
		end
		
	maximum_virtual_y_position: INTEGER is
			-- Maximum permitted virtual y position based on current properties.
			-- Properties that affect this value are `is_horizontal_scrolling_per_item' and
			-- `is_horizontal_scrolling_per_item'.
		do
			Result := (virtual_height - viewable_height).max (0)
		ensure
			result_non_negative: Result >= 0
		end
		
	pixels_displayed_after_final_row: INTEGER is
			-- Height in pixels displayed after the final row of `Current'.
			-- If `is_vertical_overdraw_enabled' this is `viewable_height' less the final row height.
			-- If not `is_vertical_overdraw_enabled' and `is_vertical_scrolling_per_item' this is
			-- the number of pixels required to ensure the first visible row is flush to the top of the
			-- viewable area of `Current'.
		local
			final_row_height: INTEGER
			virtual_y_position_of_last_row: INTEGER
			row_index: INTEGER
			l_calculation: INTEGER
		do
			if is_vertical_overscroll_enabled then
				if is_row_height_fixed then
					final_row_height := row_height
				else
					final_row_height := rows.i_th (row_count).height
				end
				l_calculation := final_row_height
			elseif is_vertical_scrolling_per_item then
				row_index := last_first_row_in_per_item_scrolling
				if row_index <= row_count and row_index > 0 then
					if is_row_height_fixed and not is_tree_enabled then
						virtual_y_position_of_last_row := (row_index - 1) * row_height
					else
						virtual_y_position_of_last_row := rows.i_th (row_index).virtual_y_position
					end
					l_calculation := total_row_height - virtual_y_position_of_last_row
				end
			elseif is_vertical_scrolling_per_item = False then
				l_calculation := viewable_height
			end			
				-- We perform `max' as if the viewable height is less than the
				-- final row height then there are no extra pixels to be displayed.
			Result := (viewable_height - l_calculation).max (0)
		ensure		
			result_non_negative: Result >= 0
			result_no_more_than_viewable_height: Result <= viewable_height
			no_rows_contained_implies_result_is_viewable_height: row_count = 0 implies Result = viewable_height
			valid_result_with_rows_with_overdraw_with_fixed_row_height: row_count > 0 and is_row_height_fixed and is_vertical_overscroll_enabled implies
				Result = viewable_height - row_height
			valid_result_with_rows_with_overdraw_with_variable_row_height: row_count > 0 and not is_row_height_fixed and is_vertical_overscroll_enabled implies
				Result = viewable_height - row (row_count).height
			valid_result_with_rows_when_per_pixel_scrolling_with_no_overdraw: row_count > 0 and is_vertical_scrolling_per_item = False and
				is_vertical_overscroll_enabled = False implies Result = 0
			valid_result_with_fixed_height_rows_when_per_item_scrolling_and_no_overdraw: row_count > 0 and is_row_height_fixed and is_vertical_scrolling_per_item and
				is_vertical_scrolling_per_item and row (row_count).virtual_y_position + row_height > viewable_height and not is_vertical_overscroll_enabled implies Result <= row_height
		end
		
	pixels_displayed_after_final_column: INTEGER is
			-- Width in pixels displayed after the final column of `Current'.
			-- If `is_horizontal_overdraw_enabled' this is `viewable_width' less the final column width.
			-- If not `is_horizontal_overdraw_enabled' and `is_horizontal_scrolling_per_item' this is
			-- the number of pixels required to ensure the first visible column is flush to the left of the
			-- viewable area of `Current'.
		local
			final_column_width: INTEGER
			virtual_x_position_of_last_column: INTEGER
		do
			if is_horizontal_overscroll_enabled then
					final_column_width := columns.i_th (column_count).width
				
					-- We perform `max' as if the viewable width is less than the
					-- final column width then there are no extra pixels to be displayed.
				Result := (viewable_width - final_column_width).max (0)
			elseif is_horizontal_scrolling_per_item then
				virtual_x_position_of_last_column := columns.i_th (last_first_column_in_per_item_scrolling).virtual_x_position
				Result := (viewable_width - (virtual_width - virtual_x_position_of_last_column)).max (0)
			end
		end
		
	virtual_width: INTEGER is
			-- Width of virtual area in pixels.
		do
			if columns.count > 0 then
				perform_horizontal_computation
				Result := column_offsets.last + pixels_displayed_after_final_column
			end
			Result := Result.max (viewable_width)
		ensure
			result_non_negative: Result >= 0
		end
		
	virtual_height: INTEGER is
			-- Height of virtual area in pixels.
		do
			if row_count > 0 then
				perform_vertical_computation
				Result := total_row_height + pixels_displayed_after_final_row
			end
			Result := Result.max (viewable_height)
		ensure
			result_non_negative: Result >= 0
		end

	viewable_width: INTEGER
			-- Width of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars. Is equivalent to `viewport.width' and
			-- by storing this, multiple queries are far quicker as the grid is only resized periodically
			-- and we no longer have to call EiffelVision for the value.

	viewable_height: INTEGER
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
			-- Is equivalent to `viewport.height' and by storing this, multiple queries are far quicker
			-- as the grid is only resized periodically and we no longer have to call EiffelVision for the value.

	viewable_x_offset: INTEGER is
			-- Horizontal distance in pixels from the left edge of `Current' to
			-- the left edge of the viewable area (defined by `viewable_width', `viewable_height')
			-- in which all content is displayed.
		do
				-- Always 0 at the moment as nothing affects this value.
			Result := 0
		ensure
			viewable_x_offset_valid: Result >=0 and Result <= width
		end
			
	viewable_y_offset: INTEGER is
			-- Vertical distance in pixels from the top edge of `Current' to
			-- the top edge of the viewable area (defined by `viewable_width', `viewable_height')
			-- in which all content is displayed.
		do
			if is_header_displayed then
				Result := header.height
			end
		ensure
			viewable_y_offset_valid: Result >=0 and Result <= height
		end
		
	has_focus: BOOLEAN is
			-- Does `Current' have focus?
		do
			Result := drawable.has_focus
		end
		

feature -- Pick and Drop

	item_accepts_pebble (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
			-- Do any actions accept `a_pebble' for `a_item'.
		require
			a_pebble_not_void: a_pebble /= Void
		local
			cur: CURSOR
			a_tuple: TUPLE [EV_GRID_ITEM, ANY]
			a_action: like item_drop_actions
		do
			if item_drop_actions_internal /= Void then
				from
					a_action := item_drop_actions_internal
					cur := a_action.cursor
					a_tuple := [a_item, a_pebble]
					a_action.start
				until
					a_action.after or Result
				loop
					Result := a_action.item.valid_operands (a_tuple)
					if
						Result and then
						item_veto_pebble_function /= Void and then
						item_veto_pebble_function.valid_operands (a_tuple)
					then
						Result := Result and then item_veto_pebble_function.item (a_tuple)
					end
					a_action.forth
				end
				a_action.go_to (cur)
			end
		end

	item_veto_pebble_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM, ANY], BOOLEAN]
		-- User item veto function.

	set_item_veto_pebble_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM, ANY], BOOLEAN]) is
			-- Assign `a_function' to `item_veto_pebble_function'.
		do
			item_veto_pebble_function := a_function
		ensure
			item_veto_pebble_function_set: item_veto_pebble_function = a_function
		end

	set_item_accept_cursor_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]) is
			-- Assign `a_function' to `item_accept_cursor_function'.
		do
			item_accept_cursor_function := a_function
		ensure
			item_accept_cursor_function_set: item_accept_cursor_function = a_function
		end

	item_accept_cursor_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]
			-- Function used to retrieve the PND accept cursor for a particular item.

	set_item_deny_cursor_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]) is
			-- Assign `a_function' to `item_deny_cursor_function'.
		do
			item_deny_cursor_function := a_function
		ensure
			item_deny_cursor_function_set: item_deny_cursor_function = a_function
		end

	item_deny_cursor_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]
			-- Function used to retrieve the PND deny cursor for a particular item.

	drop_action_intermediary (a_pebble: ANY) is
			-- A PND drop has occured on a grid item.
		local
			a_item: EV_GRID_ITEM
			l_drop_actions_internal: EV_PND_ACTION_SEQUENCE
		do
			a_item := item_target

				-- Call appropriate drop actions for grid and item.
			if item_accepts_pebble (a_item, a_pebble) then
				item_drop_actions_internal.call ([a_item, a_pebble])
			end

			if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (a_pebble) then
				drop_actions_internal.call ([a_pebble])
			end

			if a_item /= Void then
				l_drop_actions_internal := a_item.implementation.drop_actions_internal
				if l_drop_actions_internal /= Void and then l_drop_actions_internal.accepts_pebble (a_pebble) then
					l_drop_actions_internal.call ([a_pebble])
				end
			end
		end

	item_target: EV_GRID_ITEM is
			-- Item currently at pointer position.
		local
			a_pointer_position: EV_COORDINATE
			a_x, a_y: INTEGER
			a_item: EV_GRID_ITEM_I
		do
			a_pointer_position := internal_screen.pointer_position
			a_x := a_pointer_position.x - drawable.screen_x
			a_y := a_pointer_position.y - drawable.screen_y
			if a_x > 0 and then a_y > 0 then
				a_item := drawer.item_at_position_strict (a_x, a_y)
				if a_item /= Void then
					Result := a_item.interface
				end
			end
		end

	veto_pebble_function_intermediary (a_pebble: ANY): BOOLEAN is
			-- Intermediary function used for pebble vetoing.
		do
			Result := (drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (a_pebble)) or else 
				(item_drop_actions_internal /= Void and then item_accepts_pebble (item_target, a_pebble))
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			Precursor {EV_CELL_I} (a_cursor)
			drawable.set_accept_cursor (a_cursor)
		end

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that doesn't accept `pebble' during pick and drop.
		do
			Precursor {EV_CELL_I} (a_cursor)
			drawable.set_deny_cursor (a_cursor)
		end

	set_item_pebble_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY]) is
			-- Set `a_function' to compute `pebble'.
			-- It will be called once each time a pick on the item area of the grid occurs, the result
			-- will be assigned to `pebble' for the duration of transport.
			-- When a pick occurs on an item, the item itself is passed.
			-- If a pick occurs and no item is present, then Void is passed.
			-- To handle this data use `a_function' of type
			-- FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY] and return the
			-- pebble as a function of EV_GRID_ITEM.
		do
			if item_pebble_function = Void then
					-- Intermediary only needs to be set once
				drawable.set_pebble_function (agent user_pebble_function_intermediary)
			end
			item_pebble_function := a_function
		end

	user_pebble_function_intermediary (a_x, a_y: INTEGER): ANY is
			-- Intermediary function used for grid item pick and drop.
		local
			item_imp: EV_GRID_ITEM_I
			item_int: EV_GRID_ITEM
			a_cursor: EV_CURSOR
		do
				-- Find item if any at (a_x, a_y) then call user pebble function.
			if a_x >= 0 and then a_y >= 0 then
				item_imp := drawer.item_at_position_strict (a_x, a_y)
				if item_imp /= Void then
					item_int := item_imp.interface
				end
			end
				-- Call user pebble agent passing in grid item if found
			if item_pebble_function /= Void then
				Result := item_pebble_function.item ([item_int])
			end

			if Result /= Void then
				if item_accept_cursor_function /= Void then
					a_cursor := item_accept_cursor_function.item ([item_int])
					if a_cursor /= Void then
						drawable.set_accept_cursor (a_cursor)
					end
				end
				if item_deny_cursor_function /= Void then
					a_cursor := item_deny_cursor_function.item ([item_int])
					if a_cursor /= Void then		
						drawable.set_deny_cursor (a_cursor)
					end
				end
			end
		end

	are_column_separators_enabled: BOOLEAN
			-- Is a vertical separator displayed in color `separator_color' after each column?

	are_row_separators_enabled: BOOLEAN
			-- Is a horizontal separator displayed in color `separator_color' after each row?

	separator_color: EV_COLOR
			-- Color used to display column and row separators.

feature -- Status setting
		
	item_pebble_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY]
		-- User pebble function

	activate_window: EV_POPUP_WINDOW
		-- Window used to edit grid item contents on `activate'.

	currently_active_item: EV_GRID_ITEM
		-- Item that is currently active.

	activate_item (a_item: EV_GRID_ITEM) is
			-- Setup `a_item' for user interactive editing.
		require
			a_item_not_void: a_item /= Void
		local
			x_coord, y_coord: INTEGER
			a_screen_x, a_screen_y: INTEGER
			boundary_x, item_width, item_height: INTEGER
		do
			if currently_active_item /= Void and then currently_active_item.parent = interface then
					-- If an item is currently active and present in the grid then deactivate it.
				currently_active_item.deactivate
			end
			currently_active_item := a_item
			create activate_window

			a_screen_x := screen_x

			a_screen_y := screen_y

			x_coord := a_screen_x - virtual_x_position + a_item.virtual_x_position
			y_coord := a_screen_y - virtual_y_position + a_item.virtual_y_position + viewable_y_offset

			boundary_x := a_screen_x + width
			if vertical_scroll_bar.is_displayed then
				boundary_x := boundary_x - vertical_scroll_bar.width
			end

			if is_row_height_fixed then
				item_height := row_height
			else
				item_height := a_item.row.height
			end

				-- Set default size and position.
			activate_window.set_position (x_coord, y_coord)

			item_width := a_item.column.width - a_item.horizontal_indent

			if x_coord + item_width > boundary_x then
					-- If column extends beyond the visible part of the grid, the size of the activate_window is clipped.
				item_width := boundary_x - x_coord
			end

			activate_window.set_size (item_width, item_height)

				-- Call the `activate_action' on the grid and item to initialize `activate_action'
			a_item.activate_action (activate_window)

			if item_activate_actions_internal /= Void and then not item_activate_actions_internal.is_empty then
					-- The user has requested to override the default `activate' behavior for `a_item'.
				item_activate_actions_internal.call ([a_item, activate_window])
			end
			if a_item.implementation.activate_actions_internal /= Void then
				a_item.implementation.activate_actions_internal.call ([activate_window])
			end

			if not activate_window.is_destroyed and then not activate_window.is_empty and then not activate_window.is_show_requested then
				-- If some processing has been performed on `activate_window' then show it.
				activate_window.show
			end
		end

	deactivate_item (a_item: EV_GRID_ITEM) is
			-- Cleanup from previous call to `activate'.
		require
			a_item_not_void: a_item /= Void
		do
				-- Call deactivation events.
			if item_deactivate_actions_internal /= Void then
				item_deactivate_actions_internal.call ([a_item])
			end
			if a_item.implementation.deactivate_actions_internal /= Void then
				a_item.implementation.deactivate_actions_internal.call (Void)
			end
			
				-- Destroy `activate_window'
			if activate_window /= Void and then not activate_window.is_destroyed then
				activate_window.destroy
			end

			if a_item.parent = interface then
					-- Redraw item if still existant in Current
				a_item.redraw
			end
			activate_window := Void
			currently_active_item := Void
		end

	enable_selection_on_click is
			-- Enable selection handling of items when clicked upon.
		do
			is_selection_on_click_enabled := True
		ensure
			selection_on_click_enabled: is_selection_on_click_enabled
		end

	disable_selection_on_click is
			-- Disable selection handling when items are clicked upon.
		do
			is_selection_on_click_enabled := False
		ensure
			selection_on_click_disabled: not is_selection_on_click_enabled
		end

	enable_selection_keyboard_handling is
			-- Enable selection handling of items via the keyboard.
		do
			is_selection_keyboard_handling_enabled := True
		ensure
			selection_keyboard_handling_enabled: is_selection_keyboard_handling_enabled
		end

	disable_selection_keyboard_handling is
			-- Disable selection handling of items via the keyboard.
		do
			is_selection_keyboard_handling_enabled := False
		ensure
			selection_keyboard_handling_disabled: not is_selection_keyboard_handling_enabled
		end

	enable_tree is
			-- Enable tree functionality for `Current'.
		require
			not_is_content_completely_dynamic: not is_content_completely_dynamic
		do
			is_tree_enabled := True
				-- The row offsets must always be computed when
				-- in tree mode so when enabling it, recompute.
			set_vertical_computation_required (1)
			redraw_client_area
		ensure
			tree_enabled: is_tree_enabled
		end	
		
	disable_tree is
			-- Disable tree functionality for `Current'.
			-- All subrows of rows contained are unparented,
			-- which flattens the tree structure.
		local
			current_row: EV_GRID_ROW_I
			cursor: CURSOR
		do
			is_tree_enabled := False
			adjust_hidden_node_count (- hidden_node_count)
			set_vertical_computation_required (1)
			redraw_client_area
				-- Now reset all rows.
			from
				rows.start
				cursor := rows.cursor
			until
				rows.off
			loop
				current_row := rows.item
				if current_row /= Void then
					current_row.reset_tree_structure
				end
				rows.forth
			end
			rows.go_to (cursor)
		ensure
			tree_disabled: not is_tree_enabled
		end	
		
	show_column (a_column: INTEGER) is
			-- Ensure column `a_column' is visible in `Current'.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := columns @ (a_column)
			if not a_col_i.is_displayed then
				a_col_i.set_is_displayed (True)
				visible_column_count := visible_column_count + 1

					-- Now show the header.
				header.go_i_th (previous_visible_column_from_index (a_col_i.index))
				header.put_right (a_col_i.header_item)
				
				set_horizontal_computation_required (a_column)
				redraw_client_area
			end
		ensure
			column_displayed: column_displayed (a_column)
		end
		
	hide_column (a_column: INTEGER) is
			-- Ensure column `a_column' is not visible in `Current'.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := columns @ (a_column)
			if a_col_i.is_displayed then
				a_col_i.set_is_displayed (False)
				visible_column_count := visible_column_count - 1
			
					-- Now hide the header
				header.prune_all (a_col_i.header_item)
			
				set_horizontal_computation_required (a_column)
				redraw_client_area
			end
		ensure
			column_not_displayed: not column_displayed (a_column)
		end
		
	select_column (a_column: INTEGER) is
			-- Ensure all items in `a_column' are selected.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
			column_displayed: column_displayed (a_column)
		do
			(columns @ (a_column)).enable_select
		ensure
			column_selected: column (a_column).is_selected
		end
		
	select_row (a_row: INTEGER) is
			-- Ensure all items in `a_row' are selected.
		require
			a_row_within_bounds: a_row > 0 and a_row <= row_count
		do
			row_internal (a_row).enable_select
		ensure
			row_selected: row (a_row).is_selected
		end
		
	enable_single_row_selection is
			-- Allow the user to select a single row via clicking or navigating using the keyboard arrow keys.
		local
			a_row: EV_GRID_ROW_I
			sel_rows: like selected_rows
			a_item: EV_GRID_ITEM
			sel_items: like selected_items
		do
			if is_multiple_row_selection_enabled or is_single_row_selection_enabled then
				sel_rows := selected_rows
				if not sel_rows.is_empty then
					a_row := selected_rows.first.implementation
				end
			else
				sel_items := selected_items
				if not sel_items.is_empty then
					a_item := sel_items.first
				end
			end
			remove_selection
			is_single_item_selection_enabled := False
			is_multiple_item_selection_enabled := False
			is_multiple_row_selection_enabled := False
			is_single_row_selection_enabled := True
			
			if a_row /= Void then
				a_row.enable_select
			elseif a_item /= Void then
				a_item.enable_select
			end
		ensure
			single_row_selection_enabled: is_single_row_selection_enabled
		end
		
	enable_multiple_row_selection is
			-- Allow the user to select more than one row via clicking or navigating using the keyboard arrow keys.
			-- Multiple rows may be selected via Ctrl and Shift keys.
		local
			sel_items: like selected_items
		do
			sel_items := selected_items
			remove_selection
			is_single_item_selection_enabled := False
			is_multiple_item_selection_enabled := False
			is_multiple_row_selection_enabled := True
			is_single_row_selection_enabled := False
			from
				sel_items.start
			until
				sel_items.after
			loop
				if not sel_items.item.row.is_selected then
					sel_items.item.row.enable_select
				end
				sel_items.forth
			end
		ensure
			multiple_row_selection_enabled: is_multiple_row_selection_enabled
		end
		
	enable_single_item_selection is
			-- Allow the user to select a single item via clicking or navigating using the keyboard arrow keys.
		local
			sel_items: like selected_items
		do
				-- Store the existing selected items if any so that the selection state may be partially restored.
			sel_items := selected_items
			remove_selection
			is_single_item_selection_enabled := True
			is_multiple_item_selection_enabled := False
			is_multiple_row_selection_enabled := False
			is_single_row_selection_enabled := False

			if not sel_items.is_empty then
				sel_items.first.enable_select
			end
		ensure
			single_item_selection_enabled: is_single_item_selection_enabled
		end
		
	enable_multiple_item_selection is
			-- Allow the user to select more than one item via clicking or navigating using the keyboard arrow keys.
			-- Multiple items may be selected via Ctrl and Shift keys.
		local
			sel_items: like selected_items
		do
			sel_items := selected_items
			remove_selection
			is_single_item_selection_enabled := False
			is_multiple_item_selection_enabled := True
			is_multiple_row_selection_enabled := False
			is_single_row_selection_enabled := False
			from
				sel_items.start
			until
				sel_items.after
			loop
				sel_items.item.enable_select
				sel_items.forth
			end
		ensure
			multiple_item_selection_enabled: is_multiple_item_selection_enabled
		end

	enable_always_selected is
			-- Ensure that the user may not completely remove the selection from `Current'.
		do
			is_always_selected := True
		end

	disable_always_selected is
			-- Allow the user to completely remove the selection from the grid by clicking on an item,
			-- clicking on a Void area or by Ctrl clicking the selected item itself.
		do
			is_always_selected := False
		end

	is_always_selected: BOOLEAN
			-- Ensure that the user may not completely remove the selection from `Current'.

	show_header is
			-- Ensure header displayed.
		do
			is_header_displayed := True
			header_viewport.show
		ensure
			header_displayed: is_header_displayed
		end

	hide_header is
			-- Ensure header is hidden.
		do
			is_header_displayed := False
			header_viewport.hide
		ensure
			header_not_displayed: not is_header_displayed
		end
		
	set_first_visible_row (a_row: INTEGER) is
			-- Set `a_row' as the first row visible in `Current' as long
			-- as there are enough rows after `a_row' to fill the remainder of `Current'.
		require
			valid_row_index: a_row >= 1 and a_row <= row_count			
		do
			set_virtual_position (virtual_x_position, (row (a_row).virtual_y_position).min (virtual_height - viewable_height))
			redraw_client_area
		ensure
			-- Enough following rows implies `first_visible_row' = a_row.
			-- Can be calculated from `height' of `Current' and row heights.
		end
		
	enable_resizing_divider is
			-- Ensure a vertical divider is displayed during column resizing.
		do
			is_resizing_divider_enabled := True
		ensure
			resizing_divider_enabled: is_resizing_divider_enabled
		end
		
	disable_resizing_divider is
			-- Ensure no vertical divider is displayed during column resizing.
		do
			is_resizing_divider_enabled := False
		ensure
			resizing_divider_disabled: not is_resizing_divider_enabled
		end
		
	enable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a solid line.
		do
			is_resizing_divider_solid := True
		ensure
			solid_resizing_divider: is_resizing_divider_solid
		end
		
	disable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a dashed line.
		do
			is_resizing_divider_solid := False
		ensure
			dashed_resizing_divider: not is_resizing_divider_solid
		end
		
	enable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-item basis.
		do
			is_horizontal_scrolling_per_item := True
			has_horizontal_scrolling_per_item_just_changed := True
			recompute_horizontal_scroll_bar
			has_horizontal_scrolling_per_item_just_changed := False
		ensure
			horizontal_scrolling_performed_per_item: is_horizontal_scrolling_per_item
		end
		
	disable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-pixel basis.
		do
			is_horizontal_scrolling_per_item := False
			has_horizontal_scrolling_per_item_just_changed := True
			recompute_horizontal_scroll_bar
			has_horizontal_scrolling_per_item_just_changed := False
		ensure
			horizontal_scrolling_performed_per_pixel: not is_horizontal_scrolling_per_item
		end
	
	has_horizontal_scrolling_per_item_just_changed: BOOLEAN
			-- Has the horizontal scrolling method just been changed between
			-- per item and per pixel? This is used to adjust the scroll bar's position
			-- to approximate it's original position during the recomputation of it's
			-- settings in `recompute_horizontal_scroll_bar'.
	
	has_vertical_scrolling_per_item_just_changed: BOOLEAN
			-- Has the vertical scrolling method just been changed between
			-- per item and per pixel? This is used to adjust the scroll bar's position
			-- to approximate it's original position during the recomputation of it's
			-- settings in `recompute_vertical_scroll_bar'.
			
	is_item_height_changing: BOOLEAN
			-- Is height of items in `Current' changing?

	enable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-item basis.
		do
			is_vertical_scrolling_per_item := True
			has_vertical_scrolling_per_item_just_changed := True
			recompute_vertical_scroll_bar
			has_vertical_scrolling_per_item_just_changed := False
		ensure
			vertical_scrolling_performed_per_item: is_vertical_scrolling_per_item
		end
		
	disable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-pixel basis.
		do
			is_vertical_scrolling_per_item := False
			has_vertical_scrolling_per_item_just_changed := True
			recompute_vertical_scroll_bar
			has_vertical_scrolling_per_item_just_changed := False
		ensure
			vertical_scrolling_performed_per_pixel: not is_vertical_scrolling_per_item
		end
		
	enable_vertical_overscroll is
			-- Ensure `is_vertical_overscroll_enabled' is `True'.
		do
			is_vertical_overscroll_enabled := True
			recompute_vertical_scroll_bar
			redraw_client_area
		ensure
			is_vertical_overscroll_enabled: is_vertical_overscroll_enabled
		end
		
	disable_vertical_overscroll is
			-- Ensure `is_vertical_overscroll_enabled' is `False'.
		require
			dynamic_content_not_enabled_with_variable_row_heights:
				not ((is_content_completely_dynamic or is_content_partially_dynamic) and not is_row_height_fixed)
		do
			is_vertical_overscroll_enabled := False
			recompute_vertical_scroll_bar
			restrict_virtual_y_position_to_maximum
			redraw_client_area
		ensure
			not_is_vertical_overscroll_enabled: not is_vertical_overscroll_enabled
		end
		
	enable_horizontal_overscroll is
			-- Ensure `is_horizontal_overscroll_enabled' is `True'.
		do
			is_horizontal_overscroll_enabled := True
			recompute_horizontal_scroll_bar
			redraw_client_area
		ensure
			is_horizontal_overscroll_enabled: is_horizontal_overscroll_enabled
		end
		
	disable_horizontal_overscroll is
			-- Ensure `is_horizontal_overscroll_enabled' is `False'.
		do
			is_horizontal_overscroll_enabled := False
			recompute_horizontal_scroll_bar
			restrict_virtual_x_position_to_maximum
			redraw_client_area
		ensure
			not_is_horizontal_overscroll_enabled: not is_horizontal_overscroll_enabled
		end
		
	set_row_height (a_row_height: INTEGER) is
			-- Set height of all rows within `Current' to `a_row_height
			-- If not `is_row_height_fixed' then use the height individually per row instead.
		require
			is_row_height_fixed: is_row_height_fixed
			a_row_height_positive: a_row_height >= 1
		do
			if is_row_height_fixed or is_tree_enabled then
				-- Note that if we are not using fixed row heights then
				-- there is no need to perform anything here. This is because the
				-- size is dependent on the rows and `row_height' is currently ignored.
				
				row_height := a_row_height
				is_item_height_changing := True
				is_item_height_changing := False
				set_vertical_computation_required (1)
				restrict_virtual_y_position_to_maximum
				redraw_client_area
			end
			
		ensure
			row_height_set: row_height = a_row_height
		end
		
	enable_complete_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions'. Contents are requested each time they
			-- are displayed even if already contained in `Current'.
		require
			not_is_tree_enabled: not is_tree_enabled
			not_row_height_variable_and_vertical_overscroll_enabled:
				not (not is_row_height_fixed and is_vertical_overscroll_enabled)
			not_row_height_variable_and_vertical_scrolling_per_pixel:
				not (not is_row_height_fixed and is_vertical_scrolling_per_item)
		do
			is_content_completely_dynamic := True
			is_content_partially_dynamic := False
		ensure
			content_completely_dynamic: is_content_completely_dynamic
		end
		
	enable_partial_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions' only if the item is not already set
			-- in `Current'.
		require
			not_row_height_variable_and_vertical_overscroll_enabled:
				not (not is_row_height_fixed and is_vertical_overscroll_enabled)
			not_row_height_variable_and_vertical_scrolling_per_pixel:
				not (not is_row_height_fixed and is_vertical_scrolling_per_item)
		do
			is_content_partially_dynamic := True
			is_content_completely_dynamic := False
		ensure
			content_partially_dynamic: is_content_partially_dynamic
		end
		
	disable_dynamic_content is
			-- Ensure contents of `Current' are not dynamic and are no longer retrieved as such.
		do
			is_content_partially_dynamic := False
			is_content_completely_dynamic := False
		ensure
			content_not_dynamic: not is_content_completely_dynamic and not is_content_partially_dynamic
		end
		
	enable_row_height_fixed is
			-- Ensure all rows have the same height.
		do
			is_row_height_fixed := True
			set_vertical_computation_required (1)
			redraw_client_area
		end
		
	disable_row_height_fixed is
			-- Permit rows to have varying heights.
		require
			not_dynamic_content_enabled_with_height_not_bounded:
				not ((is_content_completely_dynamic or is_content_partially_dynamic) and is_vertical_overscroll_enabled = False)
		do
			is_row_height_fixed := False
			set_vertical_computation_required (1)
			redraw_client_area
		end
		
	set_column_count_to (a_column_count: INTEGER) is
			-- Resize `Current' to have `a_column_count' columns.
		require
			a_column_count_not_negative: a_column_count >= 0
		local
			add_columns: BOOLEAN
			temp_column_count: INTEGER
			a_columns: like columns
		do
			from
				add_columns := a_column_count > columns.count
				a_columns := columns
				temp_column_count := a_columns.count
			until
				temp_column_count = a_column_count
			loop
				if add_columns then
					add_column_at (temp_column_count + 1, True)
					temp_column_count := temp_column_count + 1
				else
					remove_column (temp_column_count)
					temp_column_count := temp_column_count - 1
				end
			end
		ensure
			column_count_set: column_count = a_column_count
		end
		
	set_row_count_to (a_row_count: INTEGER) is
			-- Resize `Current' to have `a_row_count' columns.
		require
			a_row_count_positive: a_row_count >= 1
		do
			resize_row_lists (a_row_count)
			set_vertical_computation_required (1)
			redraw_client_area
		ensure
			row_count_set: row_count = a_row_count
		end
		
	set_dynamic_content_function (a_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]) is
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.
		require
			a_function_not_void: a_function /= Void
		do
			dynamic_content_function := a_function
		ensure
			dynamic_content_function_set: dynamic_content_function = a_function
		end
		
	set_subrow_indent (a_subrow_indent: INTEGER) is
			-- Set `subrow_indent' to `a_subrow_indent'.
		require
			a_subrow_indent_non_negtive: a_subrow_indent >= 0
		do
			subrow_indent := a_subrow_indent
			redraw_client_area
		ensure
			subrow_indent_set: subrow_indent = a_subrow_indent
		end
		
	set_node_pixmaps (an_expand_node_pixmap, a_collapse_node_pixmap: EV_PIXMAP) is
			-- Assign `an_expand_node_pixmap' to `expand_node_pixmap' and `a_collapse_node_pixmap'
			-- to `collapse_node_pixmap'. These pixmaps are used in rows containing subrows for
			-- expanding/collapsing the row.
		require
			pixmaps_not_void: an_expand_node_pixmap /= Void and a_collapse_node_pixmap /= Void
			pixmaps_dimensions_identical: an_expand_node_pixmap.width = a_collapse_node_pixmap.width and
				an_expand_node_pixmap.height = a_collapse_node_pixmap.height
		do
			expand_node_pixmap := an_expand_node_pixmap
			collapse_node_pixmap := a_collapse_node_pixmap
			redraw_client_area
			node_pixmap_width := expand_node_pixmap.width
			total_tree_node_width := node_pixmap_width + 2 * tree_node_spacing
			first_tree_node_indent := total_tree_node_width + 2 * tree_node_spacing
			tree_subrow_indent := (tree_node_spacing * 2) + node_pixmap_width + subrow_indent
		ensure
			pixmaps_set: expand_node_pixmap = an_expand_node_pixmap and collapse_node_pixmap = a_collapse_node_pixmap
		end
		
	show_tree_node_connectors is
			-- Ensure connectors are displayed between nodes of tree structure in `Current'.
		do
			are_tree_node_connectors_shown := True
			redraw_client_area
		ensure
			tree_node_connectors_shown: are_tree_node_connectors_shown
		end
		
	hide_tree_node_connectors is
			-- Ensure no connectors are displayed between nodes of tree structure in `Current'.
		do
			are_tree_node_connectors_shown := False
			redraw_client_area
		ensure
			tree_node_connectors_hidden: not are_tree_node_connectors_shown
		end
		
	set_virtual_position (virtual_x, virtual_y: INTEGER) is
			-- Move `Current' to virtual position `virtual_x', `virtual_y'.
		require
			virtual_x_valid: virtual_x >= 0 and virtual_x <= maximum_virtual_x_position
			virtual_y_valid: virtual_y >= 0 and virtual_y <= maximum_virtual_y_position
		local
			row_index: INTEGER
			visible_row_index: INTEGER
			items: ARRAYED_LIST [INTEGER]
		do
			perform_horizontal_computation
			perform_vertical_computation
			internal_set_virtual_y_position (virtual_y)
			internal_set_virtual_x_position (virtual_x)
			if is_vertical_scrolling_per_item then
				vertical_scroll_bar.change_actions.block
				items := drawer.items_spanning_vertical_span (internal_client_y, viewable_height)
				if items.count > 0 then
					row_index := items.first
					if row_indexes_to_visible_indexes = Void then
						visible_row_index := row_index - 1
					else
						visible_row_index := row_indexes_to_visible_indexes @ row_index
					end
					vertical_scroll_bar.set_value (visible_row_index)
				else
					if row_count > 0 then
						vertical_scroll_bar.set_value (visible_row_count - 1)
					end
				end	
				vertical_scroll_bar.change_actions.resume
			else
				vertical_scroll_bar.change_actions.block
				vertical_scroll_bar.set_value (virtual_y)
				vertical_scroll_bar.change_actions.resume
			end
			if is_horizontal_scrolling_per_item then
				fixme (Once "Implement")
			else
				horizontal_scroll_bar.change_actions.block
				horizontal_scroll_bar.set_value (virtual_x)
				horizontal_scroll_bar.change_actions.resume
			end
			if virtual_position_changed_actions_internal /= Void then
				virtual_position_changed_actions_internal.call ([virtual_x_position, virtual_y_position])
			end
		ensure
			virtual_position_set: virtual_x_position = virtual_x and virtual_y_position = virtual_y
		end
		
	set_tree_node_connector_color (a_color: EV_COLOR) is
			-- Set `a_color' as `tree_node_connector_color'.
		require
			a_color_not_void: a_color /= Void
		do
			tree_node_connector_color := a_color
			if is_tree_enabled then
				redraw_client_area
			end
		ensure
			tree_node_connector_color_set: tree_node_connector_color = a_color
		end

	enable_columns_drawn_above_rows is
			-- Ensure `are_columns_drawn_above_rows' is `True'.
		do
			are_columns_drawn_above_rows := True
			redraw_client_area
		ensure	
			columns_drawn_above_rows: are_columns_drawn_above_rows
		end
		
	disable_columns_drawn_above_rows is
			-- Ensure `are_columns_drawn_above_rows' is `False'.
		do
			are_columns_drawn_above_rows := False
			redraw_client_area
		ensure	
			columns_drawn_below_rows: not are_columns_drawn_above_rows
		end


	enable_column_resize_immediate is
			-- Ensure `is_column_resize_immediate' is `True'.
		do
			is_column_resize_immediate := True
		ensure
			is_column_resize_immediate: is_column_resize_immediate
		end

	disable_column_resize_immediate is
			-- Ensure `is_column_resize_immediate' is `False'.
		do
			is_column_resize_immediate := False
		ensure
			not_is_column_resize_immediate: not is_column_resize_immediate
		end

	enable_column_separators is
			-- Ensure `are_column_separators_enabled' is `True'.
		do
			are_column_separators_enabled := True
			redraw_client_area
		ensure	
			column_separators_enabled: are_column_separators_enabled
		end
		
	disable_column_separators is
			-- Ensure `are_column_separators_enabled' is `False'.
		do
			are_column_separators_enabled := False
			redraw_client_area
		ensure	
			column_separators_disabled: not are_column_separators_enabled
		end
		
	enable_row_separators is
			-- Ensure `are_row_separators_enabled' is `True'.
		do
			are_row_separators_enabled := True
			redraw_client_area
		ensure	
			row_separators_enabled: are_row_separators_enabled
		end
		
	disable_row_separators is
			-- Ensure `are_row_separators_enabled' is `False'.
		do
			are_row_separators_enabled := False
			redraw_client_area
		ensure	
			row_separators_disabled: not are_row_separators_enabled
		end

	set_separator_color (a_color: EV_COLOR) is
			-- Set `a_color' as `separator_color'.
		require
			a_color_not_void: a_color /= Void
		do
			separator_color := a_color
			redraw_client_area
		ensure
			separator_color_set: separator_color = a_color
		end
		
	set_focus is
			-- Grab keyboard focus.
		do
			drawable.set_focus
		end

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		do
			Precursor {EV_CELL_I} (a_pebble)
			drawable.set_pebble (a_pebble)
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, ANY]) is
			-- Assign `a_function' to `pebble_function'.
		do
			Precursor {EV_CELL_I} (a_function)
			drawable.set_pebble_function (a_function)
		end
		
	set_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `focused_selection_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			focused_selection_color_set: focused_selection_color = a_color
		end
		
	set_non_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `non_focused_selection_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			non_focused_selection_color_set: non_focused_selection_color = a_color
		end
		
	redraw is
			-- Force `Current' to be re-drawn when next idle.
		do
			redraw_client_area
		end
		
	enable_full_redraw_on_virtual_position_change is
			-- Ensure `is_full_redraw_on_virtual_position_change_enabled' is `True'.
		do
			is_full_redraw_on_virtual_position_change_enabled := True
		ensure
			is_full_redraw_on_virtual_position_change_enabled: is_full_redraw_on_virtual_position_change_enabled
		end

	disable_full_redraw_on_virtual_position_change is
			-- Ensure `is_full_redraw_on_virtual_position_change_enabled' is `False'.
		do
			is_full_redraw_on_virtual_position_change_enabled := False
		ensure
			not_is_full_redraw_on_virtual_position_change_enabled: not is_full_redraw_on_virtual_position_change_enabled
		end
		
	lock_update is
			-- Ensure `is_locked' is `True', thereby preventing graphical
			-- updates until `unlock_update' is called.
		do
			is_locked := True
		ensure
			is_locked: is_locked
		end
		
	unlock_update is
			-- Ensure `is_locked' is `False', thereby ensuring graphical
			-- updates occur as normal. The complete client area
			-- is refreshed to synchronize the display with the contents.
		do
			is_locked := False
			redraw_client_area
		ensure
			not_is_locked: not is_locked
		end

feature -- Status report

	is_selection_on_click_enabled: BOOLEAN
			-- Will an item be selected if clicked upon by the user?

	is_selection_keyboard_handling_enabled: BOOLEAN
			-- May an item be selected via the keyboard?

	is_tree_enabled: BOOLEAN
			-- Is tree functionality enabled?
		
	column_displayed (a_column: INTEGER): BOOLEAN is
			-- May column `a_column' be displayed when `Current' is?
			-- Will return False if `hide' has been called on column `a_column'.
			-- A value of True does not signify that column `a_column' is visible on screen at that particular time.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := columns @ (a_column)
			Result := a_col_i.is_displayed
		end

	is_row_selection_enabled: BOOLEAN is
			-- Is `Current' in either single or multiple row selection mode?
		do
			Result := is_single_row_selection_enabled or else is_multiple_row_selection_enabled
		end

	is_multiple_selection_enabled: BOOLEAN is
			-- Is `Current' in either multiple item or row selection mode?
		do
			Result := is_multiple_item_selection_enabled or else is_multiple_row_selection_enabled
		end

	is_single_row_selection_enabled: BOOLEAN
			-- Does clicking or keyboard navigating via arrow keys select a row, unselecting
			-- any previously selected row?

	is_multiple_row_selection_enabled: BOOLEAN
			-- Does clicking or keyboard navigating via arrow keys select a row, with multiple
			-- row selection permitted via the use of Ctrl and Shift keys?
		
	is_single_item_selection_enabled: BOOLEAN
			-- Does clicking or keyboard navigating via arrow keys select an item, unselecting
			-- any previously selected items?

	is_multiple_item_selection_enabled: BOOLEAN
			-- Does clicking or keyboard navigating via arrow keys select an item, with multiple
			-- item selection permitted via the use of Ctrl and Shift keys?
		
	first_visible_row: EV_GRID_ROW is
			-- First row visible in `Current' or Void if `row_count' = 0
			-- If `is_vertical_scrolling_per_item', the first visible row may be only partially visible.
		require
			is_displayed: is_displayed
		local
			l_visible_row_indexes: ARRAYED_LIST [INTEGER]
		do
			l_visible_row_indexes := visible_row_indexes
			if l_visible_row_indexes /= Void and then l_visible_row_indexes.count > 0 then
				Result := rows.i_th (l_visible_row_indexes.first).interface
			end
		ensure
			has_rows_implies_result_not_void: row_count > 0 implies result /= Void
			no_rows_implies_result_void: row_count = 0 implies result = Void
		end

	first_visible_column: EV_GRID_COLUMN is
			-- First column visible in `Current' or Void if `column_count' = 0
			-- If `is_horizontal_scrolling_per_item', the first visible column may be only partially visible.
		require
			is_displayed: is_displayed
		local
			l_visible_column_indexes: ARRAYED_LIST [INTEGER]
		do
			l_visible_column_indexes := visible_column_indexes
			if l_visible_column_indexes /= Void and then l_visible_column_indexes.count > 0 then
				Result := (columns @ (visible_column_indexes.first)).interface
			end
		ensure
			has_columns_implies_result_not_void: column_count > 0 implies result /= Void
			no_columns_implies_result_void: column_count = 0 implies result = Void
		end

	last_visible_row: EV_GRID_ROW is
			-- Last row visible in `Current' or Void if `row_count' = 0
			-- The last visible row may be only partially visible.
		require
			is_displayed: is_displayed
		local
			l_visible_row_indexes: ARRAYED_LIST [INTEGER]
		do
			l_visible_row_indexes := visible_row_indexes
			if l_visible_row_indexes /= Void and then l_visible_row_indexes.count > 0then
				Result := rows.i_th (l_visible_row_indexes.last).interface
			end
		ensure
			has_rows_implies_result_not_void: row_count > 0 implies result /= Void
			no_rows_implies_result_void: row_count = 0 implies result = Void
		end

	last_visible_column: EV_GRID_COLUMN is
			-- Last column visible in `Current' or Void if `column_count' = 0
			-- The last visible column may be only partially visible.
		require
			is_displayed: is_displayed
		local
			l_visible_column_indexes: ARRAYED_LIST [INTEGER]
		do
			l_visible_column_indexes := visible_column_indexes
			if l_visible_column_indexes /= Void and then l_visible_column_indexes.count > 0 then
				Result := (columns @ (visible_column_indexes.last)).interface
			end
		ensure
			has_columns_implies_result_not_void: column_count > 0 implies result /= Void
			no_columns_implies_result_void: column_count = 0 implies result = Void
		end

	visible_row_indexes: ARRAYED_LIST [INTEGER] is
			-- All rows that are currently visible in `Current'.
		require
			is_displayed: is_displayed
		do
			perform_vertical_computation
			Result := drawer.items_spanning_vertical_span (virtual_y_position, viewable_height)
		ensure	
			result_not_void: Result /= Void
		end

	visible_column_indexes: ARRAYED_LIST [INTEGER] is
			-- All columns that are currently visible in `Current'.
		require
			is_displayed: is_displayed
		do
			perform_horizontal_computation
			Result := drawer.items_spanning_horizontal_span (virtual_x_position, viewable_width)
		ensure	
			result_not_void: Result /= Void
		end
		
	tree_node_connector_color: EV_COLOR
			-- Color of connectors drawn between tree nodes within `Current'.

	displayed_background_color (a_column, a_row: INTEGER): EV_COLOR is
			-- `Result' is background color to be displayed for item at position `a_column', `a_row'
			-- on parts of the cell space in which the item is not displayed. i.e. for the background
			-- area of a tree structure.
		require
			valid_column: a_column >= 1 and a_column <= column_count
			valid_row: a_row >= 1 and a_row <= row_count
		do
			if are_columns_drawn_above_rows then
				Result := (columns @ (a_column)).background_color
				if Result = Void then
					Result := row_internal (a_row).background_color
					if result = Void then
						Result := background_color
					end
				end
			else
				Result := row_internal (a_row).background_color
				if Result = Void then
					Result := (columns @ (a_column)).background_color
					if result = Void then
						Result := background_color
					end
				end
			end
		ensure	
			result_not_void: Result /= Void
		end

	are_columns_drawn_above_rows: BOOLEAN
			-- For drawing purposes, are columns drawn above rows?
			-- If `True', for all cells within `Current' whose `column' and `row' have non-Void
			-- foreground or background colors, the column colors are given priority.
			-- If `False', the colors of the row are given priority.
				
feature -- Element change

	insert_new_row (i: INTEGER) is
			-- Insert a new row at index `i'.
		require
			i_positive: i > 0
			not_inserting_within_existing_subrow_structure: i = 1 or else (i < row_count and
				row (i - 1).parent_row_root /= Void and row (i).parent_row_root /= Void implies
				row (i - 1).parent_row_root /= row (i).parent_row_root)
		do
			add_row_at (i, False)
		ensure
			row_count_set: (i <= old row_count implies row_count = old row_count + 1) or (row_count = i)
		end

	insert_new_row_parented (i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert `a_row' between rows `i' and `i+1'.
		require
			i_positive: i > 0
			i_less_than_row_count: i <= row_count + 1
			a_parent_row_not_void: a_parent_row /= Void
			i_valid_for_parent: i > a_parent_row.index and i <= a_parent_row.index + a_parent_row.subrow_count_recursive + 1
		do
			add_row_at (i, False)
			a_parent_row.implementation.add_subrow_internal (row (i), a_parent_row.subrow_count + 1,True)
		ensure
			row_count_set: row_count = old row_count + 1
			subrow_count_set: a_parent_row.subrow_count = old a_parent_row.subrow_count + 1
		end

	insert_new_column (a_index: INTEGER) is
			-- Insert a new column at index `a_index'.
		require
			i_positive: a_index > 0
		do
			add_column_at (a_index, False)
		ensure
			column_count_set: (a_index <= old column_count implies column_count = old column_count + 1) or (column_count = a_index)
		end

	move_rows (i, j, n: INTEGER) is
			-- Move `n' rows starting at index `i' to index `j'.
		require
			i_positive: i > 0
			j_positive: j > 0
			n_positive: n > 0
			i_less_than_row_count: i <= row_count
			j_valid: j <= row_count
			n_valid: i + n <= row_count + 1
			row_at_i_has_no_parent_row: row (i).parent_row = Void
			end_row_last_in_tree_structure: i + n <= row_count implies row (i + n).parent_row = Void
		do
				-- Only move if the row move is not overlapping.
			if j < i or else j >= i + n then
				rows.move_items (i, j, n)
				internal_row_data.move_items (i, j, n)
					-- Update the changed indexes.
				update_grid_row_indices (i.min (j))
				set_vertical_computation_required (i.min (j))
				redraw_client_area
			end
		end

	move_columns (i, j, n: INTEGER) is
			-- Move `n' columns at index `i' to index `j'.
		require
			i_positive: i > 0
			j_positive: j > 0
			i_not_greater_than_column_count: i <= column_count
			j_not_greater_than_column_count: j <= column_count
			n_valid: i + n <= row_count + 1
		local
			header_item: EV_HEADER_ITEM
			min_index: INTEGER
			a_duplicate: ARRAYED_LIST [EV_HEADER_ITEM]
			a_counter: INTEGER
			a_insertion_index: INTEGER
		do
			if j < i or else j >= i + n then
				columns.move_items (i, j, n)
					-- Move items within header control.
				from
					create a_duplicate.make (n)
					a_counter := 1
					header.go_i_th (i)
				until
					a_counter > n
				loop
					header_item := header.item
					a_duplicate.put_front (header_item)
					header.remove
					a_counter := a_counter + 1
				end
				
				from
					if j > (i + n - 1) then
						a_insertion_index := j - n
					else
						a_insertion_index := j - 1
					end
					header.go_i_th (a_insertion_index)
					a_duplicate.start
				until
					a_duplicate.after
				loop
					header.put_right (a_duplicate.item)
					a_duplicate.forth
				end

				min_index := i.min (j)
				update_grid_column_indices (min_index)
	
					-- Flag `physical_column_indexes' for recalculation
				physical_column_indexes_dirty := True
	
				update_index_of_first_item_dirty_row_flags (min_index)
				
				set_horizontal_computation_required (min_index)
				redraw_client_area			
			end
		ensure
			columns_moved: (j < i implies column (j) = old column (i) and then column (j + n - 1) = old column (i + n - 1)) or (j >= i + n implies column (j - n + 1) = old column (i) and then column (j - n + n) = old column (i + n - 1))
			column_count_unchanged: column_count = old column_count
		end

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set grid item at position (`a_column', `a_row') to `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_parented: a_item /= Void implies a_item.parent = Void
			valid_tree_structure_on_item_insertion: a_item /= Void and is_tree_enabled and then a_row <= row_count and row (a_row).parent_row /= Void implies a_column >= row (a_row).parent_row.index_of_first_item
			item_may_be_added_if_row_is_a_subrow: a_item /= Void and then a_row <= row_count and then row (a_row).is_part_of_tree_structure implies row (a_row).is_index_valid_for_item_setting_if_tree_node (a_column)
			item_may_be_removed_if_row_is_a_subrow: a_item = Void and then a_row <= row_count and then row (a_row).is_part_of_tree_structure implies row (a_row).is_index_valid_for_item_removal_if_tree_node (a_column)
		do
			internal_set_item (a_column, a_row, a_item)
		ensure
			item_set: item (a_column, a_row) = a_item
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := columns @ a_column
			
				-- Remove association of column with `Current'
			a_col_i.update_for_removal
			
			columns.go_i_th (a_column)
			columns.remove

			update_grid_column_indices (a_column)
			
			if a_col_i.is_displayed then
				visible_column_count := visible_column_count - 1
			end

			update_index_of_first_item_dirty_row_flags (a_column)

				-- Flag `physical_column_indexes' for recalculation
			physical_column_indexes_dirty := True

			header.go_i_th (a_column)
			header.remove

			set_horizontal_computation_required (a_column)
			redraw_client_area
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row' and all subrows recursively.
			-- If `row (a_row).subrow_count_recursive' is greater than 0 then
			-- all subrows of the row are also removed from `Current'.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		local
			a_row_i: EV_GRID_ROW_I
			subrow_count_recursive: INTEGER
			l_row_index: INTEGER
		do
				-- Retrieve row from the grid
			a_row_i := row_internal (a_row)

				-- Firstly handle subnode removal recursively
			subrow_count_recursive := a_row_i.subrow_count_recursive
			from
				l_row_index := a_row + subrow_count_recursive
			until
				l_row_index = a_row
			loop
				internal_remove_row (row_internal (l_row_index))
				l_row_index := l_row_index - 1
			end

			internal_remove_row (a_row_i)
			
				-- Note that we must tell the computation to start from the 
				-- previous row as if we are removing the final item then
				-- the index is invalid.
			set_vertical_computation_required ((a_row - 1).max (1))
			redraw_client_area
		ensure
			row_count_updated: row_count = old row_count - (old row (a_row).subrow_count_recursive + 1)
			old_row_removed: (old row (a_row)).parent = Void
			node_counts_correct_in_parent: old (row_internal (a_row).parent_row_i) /= Void implies (old row_internal (a_row).parent_row_i).node_counts_correct
			to_implement_assertion ("EV_GRID.remove_row		All old recursive subrows removed.")
		end
		
	internal_remove_row (a_row: EV_GRID_ROW_I) is
			-- Perform internal settings required for removal of `a_row'.
			require
			a_row_not_void: a_row /= Void
		local
			l_row_index: INTEGER
		do
				-- Remove row and its corresponding data from `rows' and `internal_row_data'				
			l_row_index := a_row.index

				-- Unset internal data.
			a_row.update_for_removal
			rows.go_i_th (l_row_index)
			rows.remove
			internal_row_data.go_i_th (l_row_index)
			internal_row_data.remove

			update_grid_row_indices (l_row_index)
		ensure
			node_counts_correct_in_parent: old (a_row.parent_row_i) /= Void implies (old a_row.parent_row_i).node_counts_correct
		end

	clear is
			-- Remove all items from `Current'.
		require
			is_parented: parent /= Void
		local
			i, a_row_count: INTEGER
			temp_rows: like rows
			current_row: EV_GRID_ROW_I
		do
			from
				i := 1
				a_row_count := row_count
				temp_rows := rows
			until
				i > a_row_count
			loop
				current_row := temp_rows.i_th (i)
				if current_row /= Void then
					current_row.clear
				end
				i := i + 1
			end
		ensure
			to_implement_assertion ("EV_GRID_I.clear - All items positions return `Void'.")
		end

	wipe_out is
			-- Remove all columns and rows from `Current'.
		require
			is_parented: parent /= Void
		local
			current_row_data: SPECIAL [EV_GRID_ITEM_I]
			current_item: EV_GRID_ITEM_I
			current_row: EV_GRID_ROW_I
			current_column: EV_GRID_COLUMN_I
			i, j: INTEGER
			l_row_count, l_column_count: INTEGER
			current_column_count: INTEGER
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			if is_row_selection_enabled then
					-- In this case, it is possible that an empty row is selected
					-- so just by iterating the items, the row is not unselected
					-- correctly.
				l_selected_rows := selected_rows
				from
					l_selected_rows.start
				until
					l_selected_rows.after
				loop
					l_selected_rows.item.disable_select
					l_selected_rows.forth
				end
			end
			from
				i := 1
				l_row_count := row_count
				l_column_count := columns.count
			until
				i > l_row_count
			loop
				current_row_data := internal_row_data.i_th (i)
				if current_row_data /= Void then
					from
						j := 0
						current_column_count := current_row_data.count
					until
						j = current_column_count
					loop
						current_item := current_row_data.item (j)
						if current_item /= Void then
							if current_item.internal_is_selected then
								current_item.disable_select_internal
							end
							current_item.unparent
						end
						j := j + 1
					end
				end
				i := i + 1
			end
			from
				i := 1
			until
				i > l_row_count
			loop
				current_row := rows.i_th (i)
				if current_row /= Void then
					current_row.unparent
				end
				i := i + 1
			end
			from
				i := 1
			until
				i > l_column_count
			loop
				current_column := columns.i_th (i)
					
					-- Now remove associated header item
				header.go_i_th (1)
				header.remove
				current_column.unparent
				i := i + 1
			end
			internal_row_data.wipe_out
			rows.wipe_out
			columns.wipe_out
			set_vertical_computation_required (1)
			set_horizontal_computation_required (1)
			recompute_vertical_scroll_bar
			recompute_horizontal_scroll_bar
			redraw_client_area
			create physical_column_indexes_internal.make (0)
		ensure
			columns_removed: column_count = 0
			rows_removed: row_count = 0
		end

feature -- Measurements

	visible_column_count: INTEGER
			-- Number of visible columns in Current.

	column_count: INTEGER is
			-- Number of columns in Current.
		do
			Result := columns.count
		end

	row_count: INTEGER is
			-- Number of rows in Current.
		do
			Result := internal_row_data.count
		end
		
	visible_row_count: INTEGER is
			-- Number of visible rows in `Current'. When `is_tree_enabled',
			-- a number of rows may be within a collapsed parent row, so these
			-- are ignored
		do
			Result := row_count - hidden_node_count
		end

feature {EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_COLUMN_I} -- Implementation

	internal_row_data: EV_GRID_ARRAYED_LIST [SPECIAL [EV_GRID_ITEM_I]]
		-- Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `visible_physical_column_indexes'.
		-- IMPORTANT: When an individual row's data is resized, the SPECIAL object corresponding to the data may be changed
		-- and so locals to the special should always reset themselves to the new object should any operations be
		-- performed on to the row that could trigger a resize.

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_ITEM_I} -- Implementation

	physical_column_indexes: SPECIAL [INTEGER] is
			-- Zero-based physical data indexes of the columns needed for `row_data' lookup whilst rendering cells
			-- A call to insert_new_column (2) on an empty grid will result in a `physical_index' of 0 as this is the first column added (zero-based indexing for `row_list')
			-- A following call to `insert_new_column (1) will result in a `physical_index' of 1 as this is the second column added
			-- If both columns were visible this query returns <<0, 1>>, so to draw the data for the appropriate columns to the screen, the indexes 0 and 1 need to be
			-- used to query the value returned from `row_list' @ i
			-- (`row_list' @ (i - 1)) @ (physical_column_indexes @ (j - 1)) returns the 'j'-th column value for the `i'-th row in the grid.
		local
			a_col: EV_GRID_COLUMN_I
			i, col_count: INTEGER
		do
			if physical_column_indexes_dirty then
					-- `Result' needs to be recalculated
				col_count := columns.count
				create Result.make (col_count)
				from
					i := 1
				until
					i > col_count
				loop
					a_col := columns @ i
					Result.put (a_col.physical_index, i - 1)
							-- SPECIAL is zero based
					i := i + 1
				end			
				physical_column_indexes_internal := Result
				physical_column_indexes_dirty := False
			else
				Result := physical_column_indexes_internal
			end

		ensure
			result_not_void: Result /= Void
			result_count_equals_column_count: Result.count = column_count
		end

	previous_visible_column_from_index (a_index: INTEGER): INTEGER is
			-- Return the index of the previous visible column's logical index from index `a_index'.
		require
			a_index_valid: a_index > 0 and then a_index <= column_count
		local
			i: INTEGER
			found: BOOLEAN
			a_column: EV_GRID_COLUMN_I
		do
			from
				i := a_index - 1
			until
				found or else i = 0
			loop
				a_column := columns @ i
				found := a_column.is_displayed
				if not found then
					i := i - 1
				end
			end
			Result := i
		ensure
			index_valid: Result >= 0 and then Result < column_count
		end

	rows: EV_GRID_ARRAYED_LIST [EV_GRID_ROW_I]
		-- Arrayed list returning the appropriate EV_GRID_ROW.
		
	columns: EV_GRID_ARRAYED_LIST [EV_GRID_COLUMN_I]
		-- Arrayed list returning the appropriate EV_GRID_COLUMN.

	physical_column_count: INTEGER
		-- Number of physical columns stored in `row_list'.
		
	vertical_computation_required: BOOLEAN
		-- Do the row offsets and vertical scroll bar position need to
		-- be re-computed before the next drawing cycle?

	horizontal_computation_required: BOOLEAN
		-- Do the column offsets and horizontal scroll bar position need to be
		-- re-computed before the next drawing cycle?
		
	invalid_row_index: INTEGER
		-- Index of invalid row from which vertical row computation
		-- must begin. This is used by `perform_vertical_computation' to ensure
		-- that we only recompute those rows that are strictly necessary.

	invalid_column_index: INTEGER
		-- Index of invalid column from which horizontal column computation
		-- must begin. This is used by `perform_horizontal_computation' to ensure
		-- that we only recompute those columns that are strictly necessary.

	set_vertical_computation_required (an_invalid_row_index: INTEGER) is
			-- Assign `True' to `vertical_computation_required'.
			-- `an_invalid_row_index' specifies the index from which the computation
			-- is to be performed when actually performed. It may be `row_count' + 1 to
			-- handle the case where the grid is empty and an operation is performed
			-- that requires a later recompute.
		require
			valid_row_index: an_invalid_row_index >= 1 and an_invalid_row_index <= row_count + 1
		do
			vertical_computation_required := True
			invalid_row_index := invalid_row_index.min (an_invalid_row_index)
		ensure
			vertical_computation_required: vertical_computation_required
			invalid_row_index_set: invalid_row_index = invalid_row_index.min (old invalid_row_index)
		end

	set_horizontal_computation_required (an_invalid_column_index: INTEGER) is
			-- Assign `True' to `horizontal_computation_required'.
			-- `an_invalid_row_index' specifies the index from which the computation
			-- is to be performed when actually performed. It may be `column_count' + 1 to
			-- handle the case where the grid is empty and an operation is performed
			-- that requires a later recompute.
		require
			valid_column_index: an_invalid_column_index >= 1 and an_invalid_column_index <= column_count + 1
		do
			horizontal_computation_required := True
			invalid_column_index := invalid_column_index.min (an_invalid_column_index)
		ensure
			horizontal_computation_required: horizontal_computation_required
			invalid_column_index_set: invalid_column_index = invalid_column_index.min (old invalid_column_index)
		end
		
	perform_vertical_computation is
			-- Re-compute vertical row offsets and other such values
			-- required before drawing may be performed, only if required.
		do
			if vertical_computation_required then
				vertical_computation_required := False
				recompute_row_offsets (invalid_row_index.min (row_count).max (1))
					-- Restore to an arbitarily large index.
				invalid_row_index := invalid_row_index.max_value
				if vertical_redraw_triggered_by_viewport_resize then
					recompute_vertical_scroll_bar
				end
				if row_count > 0 and not vertical_computation_added_to_once_idle_actions then
						-- Do nothing if `Current' is empty or the agent is already contained
						-- in the do once on idle actions.
					((create {EV_ENVIRONMENT}).application).do_once_on_idle (agent recompute_vertical_scroll_bar_from_once_idle_actions)
					vertical_computation_added_to_once_idle_actions := True
				end
				vertical_redraw_triggered_by_viewport_resize := False
			end
		end

	perform_horizontal_computation is
			-- Recompute horizontal column offsets and other
			-- such values required before drawing may be performed, only if required.
		do
			if horizontal_computation_required then
				horizontal_computation_required := False
					-- Do nothing if `Current' is empty.
				if not is_header_item_resizing or is_column_resize_immediate then
					recompute_column_offsets (invalid_column_index.min (column_count).max (1))
				end
					-- Restore to an arbitarily large index.
				invalid_column_index := invalid_column_index.max_value
				if horizontal_redraw_triggered_by_viewport_resize then
					recompute_horizontal_scroll_bar
				end
				if columns.count > 0 and not horizontal_computation_added_to_once_idle_actions then
						-- Do nothing if `Current' is empty or the agent is already contained
						-- in the do once on idle actions.
					((create {EV_ENVIRONMENT}).application).do_once_on_idle (agent recompute_horizontal_scroll_bar_from_once_idle_actions)
					horizontal_computation_added_to_once_idle_actions := True
				end
				horizontal_redraw_triggered_by_viewport_resize := False
			end
		end

	horizontal_computation_added_to_once_idle_actions: BOOLEAN
		-- Is an agent contained in the idle actions which recomputes the horizontal scroll bar?

	vertical_computation_added_to_once_idle_actions: BOOLEAN
		-- Is an agent contained in the idle actions which recomputes the vertical scroll bar?

	recompute_vertical_scroll_bar_from_once_idle_actions is
			-- A wrapper for the idle actions to call `recompute_vertical_scroll_bar'
			-- and reset `vertical_computation_added_to_once_idle_actions'.
		do
			recompute_vertical_scroll_bar
			vertical_computation_added_to_once_idle_actions := False
		ensure
			reset: vertical_computation_added_to_once_idle_actions = False
		end

	recompute_horizontal_scroll_bar_from_once_idle_actions is
			-- A wrapper for the idle actions to call `recompute_horizontal_scroll_bar'
			-- and reset `horizontal_computation_added_to_once_idle_actions'.
		do
			recompute_horizontal_scroll_bar
			horizontal_computation_added_to_once_idle_actions := False
		ensure
			reset: horizontal_computation_added_to_once_idle_actions = False
		end

	recompute_column_offsets (an_index: INTEGER) is
			-- Recompute contents of `column_offsets' from column index
			-- `an_index' to `column_count'.
		require
			an_index_valid_when_columns_contained: column_count > 0 implies an_index >= 1 and an_index <= column_count
			an_index_valid_when_no_columns_contained: column_count = 0 implies an_index = 1
		local
			i: INTEGER
			temp_columns: like columns
			column_index: INTEGER
			l_column_count: INTEGER
		do
			temp_columns := columns
			create column_offsets
			column_offsets.extend (0)
			l_column_count := temp_columns.count
			from
				column_index := 1
			until
				column_index > l_column_count
			loop
				if column_displayed (column_index) then
					i := i + temp_columns.i_th (column_index).width
				end
				column_offsets.extend (i)
				column_index := column_index + 1
			end
				-- Now move the virtual position so that it is restricted to the maximum
				-- column position. This is used so that when removing columns, `virtual_y_position' remains valid.
			restrict_virtual_x_position_to_maximum

			if virtual_size_changed_actions_internal /= Void then
				virtual_size_changed_actions_internal.call ([virtual_width, virtual_height])
			end
		ensure
			counts_equal: column_offsets.count = column_count + 1
		end

	recompute_row_offsets (an_index: INTEGER) is
			-- Recompute contents of `row_offsets' from row index
			-- `an_index' to `row_count'.
		require
			an_index_valid_when_rows_contained: row_count > 0 implies an_index >= 1 and an_index <= row_count
			an_index_valid_when_no_rows_contained: row_count = 0 implies an_index = 1
		local
			i, j, k: INTEGER
			current_item: EV_GRID_ROW_I
			old_i: INTEGER
			index: INTEGER
			visible_count: INTEGER
			row_index: INTEGER
			l_row_count: INTEGER
			l_parent_row_i: EV_GRID_ROW_I
			just_looped: BOOLEAN
			original_row_index: INTEGER
		do
			original_row_index := rows.index
			if not is_tree_enabled then
				index := an_index
			else
				if row_count > 0 then
						-- We only find the parent row when `Current' is
						-- not empty.
					from
						l_parent_row_i := row_internal (an_index)
					until
						l_parent_row_i.parent_row_i = Void
					loop
						l_parent_row_i := l_parent_row_i.parent_row_i
					end
					index := l_parent_row_i.index
				else
						-- `Current' is empty, so simply keep the same index.
					index := an_index
				end
			end
			if not is_row_height_fixed or is_tree_enabled then
					-- Only perform recomputation if the rows do not all have the same height
					-- or there is tree functionality enabled. Otherwise, we do not need to
					-- use `row_offsets' and we can perform a shortcut.
				if row_offsets = Void then
					create row_offsets
					create row_indexes_to_visible_indexes
					create visible_indexes_to_row_indexes
					row_offsets.extend (0)
					rows.start
				else
					i := row_offsets @ (index)
					rows.go_i_th (index)
					if index > 1 then
						if index < row_count then
							visible_count := row_indexes_to_visible_indexes.i_th (index)
						else
							check
								index_is_row_count: index = row_count
							end
								-- In this situation, we are adding a new row that has not already
								-- been computed. Now we set the visible count to the previous (and last)
								-- item and add one. Without this, we are unable to determine the
								-- visible row count.
							visible_count := row_indexes_to_visible_indexes.i_th (index - 1) + 1
						end
					else
							-- In this case, the feature has already been called when there are
							-- no rows in the grid. So, we reset these attributes to the start.
						visible_count := 0
					end
				end
				if row_offsets.count < rows.count + 1 then
					row_offsets.resize (rows.count + 1)
					row_indexes_to_visible_indexes.resize (rows.count + 1)
					visible_indexes_to_row_indexes.resize (rows.count + 1)
				end
				from
					row_index := index
					l_row_count := rows.count
				until
					row_index > l_row_count
				loop
					current_item := rows.i_th (row_index)
		
					if not just_looped then
						old_i := i
						if current_item /= Void and not is_row_height_fixed then
							i := i + current_item.height
						else
								-- Use the default height here.
							i := i + row_height
						end
					else
						just_looped := False
					end
					if current_item /= Void and then current_item.subrow_count > 0 and not current_item.is_expanded then
						from
							j := row_index + 1
							k := j + current_item.subrow_count_recursive
						until
							j = k
						loop
							row_offsets.put_i_th (old_i, j)
							j := j + 1
						end
						row_indexes_to_visible_indexes.put_i_th (visible_count, row_index)
						row_index := (k - 1)
						just_looped := True
					else
						row_offsets.put_i_th (i, row_index + 1)
						row_indexes_to_visible_indexes.put_i_th (visible_count, row_index)
						visible_indexes_to_row_indexes.put_i_th (row_index, visible_count + 1)
						row_index := row_index + 1
						visible_count := visible_count + 1
					end
				end				
			else
				row_offsets := Void
			end
				-- Now move the virtual position so that it is restricted to the maximum
				-- row position. This is used so that when removing rows,  `virtual_x_position' remains valid.
			restrict_virtual_y_position_to_maximum

			if virtual_size_changed_actions_internal /= Void then
				virtual_size_changed_actions_internal.call ([virtual_width, virtual_height])
			end
			rows.go_i_th (original_row_index)
		ensure
			offsets_consistent_when_not_fixed: not is_row_height_fixed implies row_offsets.count >= rows.count + 1
			row_index_not_changed: old rows.index = rows.index
		end

	restrict_virtual_y_position_to_maximum is
			-- Ensure `virtual_y_position' is within the maximum permitted.
			-- Useful for situations where rows are removed.
		do
			if internal_client_y > maximum_virtual_y_position then
				set_virtual_position (virtual_x_position, maximum_virtual_y_position)
			end
		ensure
			virtual_y_position_valid: virtual_y_position <= maximum_virtual_y_position
		end

	restrict_virtual_x_position_to_maximum is
			-- Ensure `virtual_x_position' is within the maximum permitted.
			-- Useful for situations where columns are removed.
		do
			if internal_client_x > maximum_virtual_x_position then
				set_virtual_position (maximum_virtual_x_position, virtual_y_position)
			end
		ensure
			virtual_x_position_valid: virtual_x_position <= maximum_virtual_x_position
		end
		
	total_column_width: INTEGER is
			-- `Result' is total width of all columns contained in `Current'.
		do
			if columns.count > 0 then
				Result := column_offsets.i_th (columns.count + 1)
			end
		ensure
			result_positive: result >= 0
		end
		
	total_row_height: INTEGER is
			-- `Result' is total height of all rows contained in `Current'.
		do
			if row_count > 0 then
				if is_row_height_fixed and not is_tree_enabled then
					Result := row_count * row_height
				else
					Result := row_offsets.i_th (row_count + 1)
				end
			end
		ensure
			result_positive: result >= 0
		end

	item_indent (an_item: EV_GRID_ITEM_I): INTEGER is
			-- `Result' is indent of `an_item' in pixels.
			-- May be 0 for items that are not tree nodes.
		require
			an_item_not_void: an_item /= Void
			an_item_parented_in_current: an_item.parent_i = Current
		do
			Result := item_cell_indent (an_item.column.index, an_item.row.index)
		end

	item_cell_indent (column_index, row_index: INTEGER): INTEGER is
			-- `Result' is indent for cell item at position `column_index', `row_index'.
			-- May be 0 for items that are not tree nodes.
		require
			valid_column_index: column_index >= 0 and column_index <= column_count
			valid_row_index: row_index >= 1 and row_index <= row_count
		local
			node_index: INTEGER
			pointed_row_i: EV_GRID_ROW_I
			index_of_first_item: INTEGER
			current_row: EV_GRID_ROW_I
			found_row: EV_GRID_ROW_I
			current_index_of_first_item: INTEGER
			current_row_index_of_first_item: INTEGER
			last_current_row: EV_GRID_ROW_I
		do
			if is_tree_enabled then
				pointed_row_i := row_internal (row_index)
				index_of_first_item := pointed_row_i.index_of_first_item
				node_index := column_index.min (index_of_first_item)
				if index_of_first_item /= column_index and index_of_first_item /= 0 then
					Result := 0
				elseif index_of_first_item = 1 then
						-- As we are in the first column, we know the indent must always be the depth of this item in the tree
						-- so we can avoid iterating upwards to find the index of the row which switches columns.
					Result := (pointed_row_i.indent_depth_in_tree - 1) * tree_subrow_indent + first_tree_node_indent
				else
						-- We must calculate where the column switch occurs.
					from
						current_row := pointed_row_i
						current_row_index_of_first_item := current_row.index_of_first_item
						found_row := pointed_row_i
						current_index_of_first_item := pointed_row_i.index_of_first_item
					until
						current_row = Void or else (current_row_index_of_first_item /= 0 and current_row_index_of_first_item < current_index_of_first_item)
					loop
						last_current_row := current_row
						current_row := current_row.parent_row_i
						if current_row /= Void then
							current_row_index_of_first_item := current_row.index_of_first_item
							if ((current_row_index_of_first_item /= 0 and current_row_index_of_first_item >= current_index_of_first_item) or (current_row_index_of_first_item = 0 and current_index_of_first_item = 0)) then
								found_row := current_row
								current_index_of_first_item := found_row.index_of_first_item
							end
						end
					end
					if current_row = Void and node_index = 1 then
							-- In this case we have iterated to the top level in the tree and the top row is empty.
							-- We must set `found_row' to `last_current_row' which is the top level row in the tree structure.
							-- We only perform this code if `node_index' is 1 as otherwise the original item started in a column
							-- greater than 1 and no rows with non-Void items were found, so the indent must not be calculated from
							-- the top row as the item is at the first indent position in its column.
						check
							last_current_row_not_void: last_current_row /= Void
						end
						found_row := last_current_row
					end
					check
						correct: found_row /= current_row and current_row /= Void implies found_row.index_of_first_item >= 1
					end
					if pointed_row_i /= found_row then
						if found_row.index_of_first_item <= 1 then
							Result := (pointed_row_i.indent_depth_in_tree - found_row.indent_depth_in_tree) * tree_subrow_indent + first_tree_node_indent
						else
							Result := (pointed_row_i.indent_depth_in_tree - found_row.indent_depth_in_tree + 1) * tree_subrow_indent
						end
					else
						if node_index = 1 or node_index = 0 then
							Result := first_tree_node_indent
						elseif pointed_row_i.subrow_count > 0 then
							Result := tree_subrow_indent
						end
					end
				end
			end
		end

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_ITEM_I, EV_GRID_ITEM} -- Implementation
		
	redraw_item (an_item: EV_GRID_ITEM_I) is
			-- Redraw area of `an_item' if visible.
		require
			an_item_not_void: an_item /= Void
		local
			item_height: INTEGER
			row_i: EV_GRID_ROW_I
			column_i: EV_GRID_COLUMN_I
			l_indent: INTEGER
		do
				-- Increase the number of times that `redraw_item' has been called
				-- since the last refresh.
			redraw_item_counter := redraw_item_counter + 1
			if redraw_item_counter < maximum_items_redrawn_between_refresh then
					-- Only perform the exact item calculation if our threshold
					-- for individual item redrawing has not been met.
					
				row_i := an_item.row_i
				column_i := an_item.column_i
				if row_i.parent_row_i /= Void then
					l_indent := item_cell_indent (column_i.index, row_i.index)
				end
				if is_row_height_fixed then
					item_height := row_height
				else
					item_height := an_item.row.height
				end
				
					-- Note that we calculate the virtual x offset of the item ourselves, which
					-- prevents `item_indent' being called twice, once in the virtual x offset calculation
					-- and once for calculating the width of the item to draw.
				drawable.redraw_rectangle (column_i.virtual_x_position + l_indent - (internal_client_x - viewport_x_offset), an_item.virtual_y_position - (internal_client_y - viewport_y_offset), column_i.width - l_indent, item_height)
			elseif redraw_item_counter = maximum_items_redrawn_between_refresh then
					-- The threshold has been met, so invalidate the complete client area.
					
				redraw_client_area
			end
		end
		
	maximum_items_redrawn_between_refresh: INTEGER is 500
		-- The maximum number of items for which `redraw_item' works on an individual item
		-- basis, before the complete client area is invalidated. By performing this, the
		-- calculation of the items exact position may be by-passed, ensuring large performance
		-- gains while adding many items.
		
	redraw_item_counter: INTEGER
		-- A counter to hold the number of times `redraw_item' has been called
		-- since the last redraw.
	
	reset_redraw_item_counter is
			-- Reset `redraw_item_counter' to 0.
		do
			redraw_item_counter := 0
		ensure
			redraw_item_counter_zero: redraw_item_counter = 0
		end
		

	redraw_client_area is
			-- Redraw complete visible client area of `Current'.
		do
			drawable.redraw
		end

	redraw_column (a_column: EV_GRID_COLUMN_I) is
			-- Redraw area of `a_column' if visible.
		require
			a_column_not_void: a_column /= Void
		local
			col_x1: INTEGER
		do
			col_x1 := a_column.virtual_x_position 
			drawable.redraw_rectangle (col_x1, viewport_y_offset, a_column.width, viewable_height)
		end

	redraw_from_column_to_end (a_column: EV_GRID_COLUMN_I) is
			-- Redraw client area from `virtual_x_position' of `a_column' to the right
			-- of the client area. Complete height of client area is invalidated.
		require
			a_column_not_void: a_column /= Void
		local
			l_virtual_x_position: INTEGER
		do
			l_virtual_x_position := a_column.virtual_x_position
			drawable.redraw_rectangle (l_virtual_x_position - (internal_client_x - viewport_x_offset), viewport_y_offset, viewable_width + internal_client_x - l_virtual_x_position, viewable_height)
		end

	redraw_row (a_row: EV_GRID_ROW_I) is
			-- Redraw area of `a_row' if visible.
		require
			a_row_not_void: a_row /= Void
		local
			row_y1: INTEGER
		do
			row_y1 := a_row.virtual_y_position - (internal_client_y - viewport_y_offset)
			if is_row_height_fixed then
				drawable.redraw_rectangle (viewport_x_offset, row_y1, viewable_width, row_height)
			else
				drawable.redraw_rectangle (viewport_x_offset, row_y1, viewable_width, a_row.height)
			end
		end

	redraw_from_row_to_end (a_row: EV_GRID_ROW_I) is
			-- Redraw client area from `virtual_y_position' of `a_row' down to the bottom of the client
			-- area (As virtual position of a row is at its top, `a_row' is invalidated).
			-- Complete width of client area is invalidated.
		require
			a_row_not_void: a_row /= Void
		local
			row_virtual_y_position: INTEGER
		do
			row_virtual_y_position := a_row.virtual_y_position
			drawable.redraw_rectangle (viewport_x_offset, row_virtual_y_position - (internal_client_y - viewport_y_offset), viewable_width, viewable_height + internal_client_y - row_virtual_y_position)
		end


feature {EV_GRID_DRAWER_I, EV_GRID_COLUMN_I, EV_GRID_ROW_I, EV_GRID_ITEM_I, EV_GRID} -- Implementation

	column_offsets: EV_GRID_ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each column in pixels.
		-- For example, if there are 5 columns, each with a width of 80 pixels,
		-- `column_offsets' contains 0, 80, 160, 240, 320, 400 (Note this is 6 items).
		
	row_offsets: EV_GRID_ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each row in pixels.
		-- For example, if there are 5 rows, each with a height of 16 pixels,
		-- `row_offsets' contains 0, 16, 32, 48, 64, 80 (Note this is 6 items)
		-- For non-expanded tree node rows (which are therefore hidden), the offset is the same as the parent offset.
		-- Note that we do not reduce `row_offsets' so you should always use `row_count' + 1 to access the final
		-- current element, instead of `row_offsets.count'.
		
	row_indexes_to_visible_indexes: EV_GRID_ARRAYED_LIST [INTEGER]
		-- Visible index of a row, based on its row index.
		-- For example, if the first node is a non expanded tree that has 10 subrows, the contents
		-- would be 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 1, 2, 3...
		-- Note that the visible index is 0 based.
	
	visible_indexes_to_row_indexes: EV_GRID_ARRAYED_LIST [INTEGER]
		-- Row index of each visible row in `Current' in order.
		-- For example, if the first node is a non exapnded tree that has 10 subrows, the contents
		-- would be 1, 11, 12, 13, 14, ...
		-- Note that the row indexes are 1 based.

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.
		
	internal_client_x: INTEGER
		-- X coordinate of client area relative to the left edge of the virtual
		-- area which `Current' comprises.

	internal_client_y: INTEGER
		-- Y coordinate of client area relative to the top edge of the virtual
		-- area which `Current' comprises.
					
	viewport_x_offset: INTEGER
		-- `x_offset' of `viewport', used to prevent the need to always query the viewport.
	
	viewport_y_offset: INTEGER
		-- `x_offset' of `viewport', used to prevent the need to always query the viewport.
		
	viewport: EV_VIEWPORT
		-- Viewport containing `header' and `drawable', permitting the header to be offset
		-- correctly in relation to the horizontal scroll bar.
		-- Note that when querying the current position, use `viewport_x_offset' and `viewport_y_offset'
		-- for speed.
		
	header: EV_GRID_HEADER
		-- Header displayed at top of `Current'.
		
	hidden_node_count: INTEGER
		-- Total number of tree rows within `Current' that are not visible,
		-- due to their parent row being collapsed. This is required for correctly
		-- computing the vertical scroll bar.
		
	adjust_hidden_node_count (adjustment: INTEGER) is
			-- Adjust `hidden_node_count' by `adjustment'.
		do
			hidden_node_count := hidden_node_count + adjustment
		ensure
			hidden_node_count_set: hidden_node_count = old hidden_node_count + adjustment
		end
		
	tree_node_spacing: INTEGER is 3
			-- Spacing value used around the expand/collapse node of a 
			-- subrow. For example, to determine the height available for the node image
			-- within a subrow, subtract 2 * tree_node_spacing from the `row_height'.
			
	expand_node_pixmap: EV_PIXMAP
		-- Pixmap used within `Current' to indicate that a tree node may be expanded.
		
	collapse_node_pixmap: EV_PIXMAP
		-- Pixmap used within `Current' to indicate that a tree node may be collapsed.
			
	initial_expand_node_pixmap: EV_PIXMAP is
			-- Construct the default `expand_node_pixmap'.
		local
			start_offset, end_offset, middle_offset: INTEGER
		do
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create Result
			Result.set_size (tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (white)
			Result.clear
			Result.set_foreground_color (tree_node_connector_color)
			Result.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (black)
			Result.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
			Result.draw_segment (middle_offset, start_offset, middle_offset, end_offset)
		ensure
			result_not_void: Result /= Void
		end
		
	initial_collapse_node_pixmap: EV_PIXMAP is
			-- Construct the default `collapse_node_pixmap'.
		local
			start_offset, end_offset, middle_offset: INTEGER
		do
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create Result
			Result.set_size (tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (white)
			Result.clear
			Result.set_foreground_color (tree_node_connector_color)
			Result.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (black)
			Result.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
		ensure
			result_not_void: Result /= Void
		end
		
	tree_node_button_dimension: INTEGER is 9	
		-- Dimension of the expand/collapse node used in the tree.
		
	white: EV_COLOR is
			-- Once access to the color white.
		once
			Result := (create {EV_STOCK_COLORS}).white.twin
		end
		
	black: EV_COLOR is
			-- Once acces to the color black.
		once
			Result := (create {EV_STOCK_COLORS}).black.twin
		end
		
	node_pixmap_width: INTEGER
		-- Width of node pixmaps.

	total_tree_node_width: INTEGER
		-- Total width of each tree node within `Current'.

	first_tree_node_indent: INTEGER 
		-- Indent applied to first indent in first column of `Current'.

	tree_subrow_indent: INTEGER
		-- Indent used for all indents except the first indent in the first column of `Current'.

feature {EV_GRID_ITEM_I, EV_GRID, EV_GRID_DRAWER_I} -- Implementation

	focused_selection_color: EV_COLOR is
			-- Color used to show selection within items while focused.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	non_focused_selection_color: EV_COLOR is
			-- Color used to show selection within items while not focused.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while focused.
		deferred
		end

	non_focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while not focused.
		deferred
		end
		
	is_full_redraw_on_virtual_position_change_enabled: BOOLEAN
			-- Is complete client area invalidated as a result of virtual position changing?
			-- Note that enabling this causes a large performance penalty in redrawing during
			-- scrolling, but may be used to achieve effects not otherwise possible unless the
			-- entire client area is invalidated.
			
	is_locked: BOOLEAN
			-- Are all graphical updates to `Current' supressed until
			-- `unlock_update' is called.

feature {EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_ITEM_I} -- Implementation
	
	recompute_vertical_scroll_bar is
			-- Recompute dimensions of `vertical_scroll_bar'.
		local
			l_total_row_height: INTEGER
			l_client_height: INTEGER
			average_row_height: INTEGER
			previous_scroll_bar_value: INTEGER
			row_index: INTEGER
		do
				-- Retrieve the final row offset as this is the virtual height required for all rows.
			if row_offsets = Void and not is_row_height_fixed then
				l_total_row_height := 0
			else
				l_total_row_height := total_row_height
			end
			l_client_height := viewable_height
				-- Note that `height' was not used as we want it to represent only the height of
				-- the "client area" which is `viewport'.
			
				
			if l_total_row_height > l_client_height then
					-- The rows are higher than the visible client area.
				if not vertical_scroll_bar.is_show_requested then
						-- Show `vertical_scroll_bar' if not already shown.
					vertical_scroll_bar.show
					update_scroll_bar_spacer
				end
					-- Update the range and leap of `vertical_scroll_bar' to reflect the relationship between
					-- `l_total_row_height' and `l_client_height'. Note that the behavior depends on the state of
					-- `is_vertical_scrolling_per_item'.
				if has_vertical_scrolling_per_item_just_changed or is_item_height_changing then
					previous_scroll_bar_value := vertical_scroll_bar.value
				end
				if is_vertical_scrolling_per_item then	
					if is_vertical_overscroll_enabled then
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, visible_row_count - 1))
					else
						-- We must now calculate the index of the row that ensures the final row that is visible in `Current'
						-- at the bottom of the viewable area.
						if row_indexes_to_visible_indexes /= Void then
							row_index := row_indexes_to_visible_indexes.i_th (last_first_row_in_per_item_scrolling) + 1
						else
							row_index := last_first_row_in_per_item_scrolling
						end
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, row_index - 1))
					end
					average_row_height := (l_total_row_height // visible_row_count)
					vertical_scroll_bar.set_leap ((l_client_height // average_row_height).max (1))
					if has_vertical_scrolling_per_item_just_changed then
							-- If we are just switching from per pixel to per item vertical
							-- scrolling, we must approximate the previous position of the scroll bar.
						vertical_scroll_bar.set_value (previous_scroll_bar_value // average_row_height)
					end
					if is_item_height_changing then
							-- The `value' of the scroll bar should not have changed.
						check
							scroll_bar_not_moved: vertical_scroll_bar.value = previous_scroll_bar_value
						end
							-- We call the change actions explicitly, so that it behaves as if the value had just
							-- changed, which ensures that the currently scrolled to item is still displayed at the top.
						vertical_scroll_bar.change_actions.call ([previous_scroll_bar_value])
					end
				else
					vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, maximum_virtual_y_position))
					vertical_scroll_bar.set_leap (height)
					if has_vertical_scrolling_per_item_just_changed then
							-- If we are just switching from per item to per pixel vertical
							-- scrolling, we can set the position of the scroll bar exactly to match it's
							-- previous position.
						if is_tree_enabled or not is_row_height_fixed then
							vertical_scroll_bar.set_value ((row_offsets @ (previous_scroll_bar_value + 1)).min (vertical_scroll_bar.value_range.upper))
						else
								-- Must restrict to the maximum permitted value, as the virtual area
								-- is smaller when per pixel scrolling is set as you cannot scroll past the final item.
							vertical_scroll_bar.set_value ((previous_scroll_bar_value * row_height).min (vertical_scroll_bar.value_range.upper))
						end
					end
				end
			else
					-- The rows are not as high as the visible client area.
				if vertical_scroll_bar.is_show_requested then
						-- Hide `vertical_scroll_bar' as it is not required.
					vertical_scroll_bar.hide
					update_scroll_bar_spacer
				end
			end
		end
		
	last_first_row_in_per_item_scrolling: INTEGER is
			-- Return the index of the row which should be displayed
			-- as the first row of the grid to ensure we do not scroll past
			-- the final row.
		local
			row_index, l_viewable_height: INTEGER
			l_row_height: INTEGER
			cursor: CURSOR
		do
			if is_row_height_fixed and not is_tree_enabled then
					-- In this situation, we can simply calculate the
					-- final row as they all have the same height.
				row_index := (visible_row_count - (viewable_height - (viewable_height \\ row_height)) // row_height + 1)
			else
					-- Must now iterate backwards to find the first row as each has
					-- a different height.
				from
					l_viewable_height := viewable_height
					visible_indexes_to_row_indexes.go_i_th (visible_row_count)
					cursor := visible_indexes_to_row_indexes.cursor
				until
					visible_indexes_to_row_indexes.off or l_viewable_height <= 0
				loop
					if is_row_height_fixed then
						l_row_height := row_height
					else
						l_row_height := row (visible_indexes_to_row_indexes.item).height
					end
					l_viewable_height := l_viewable_height - l_row_height
					if l_viewable_height > 0 then
						visible_indexes_to_row_indexes.back
					end
				end
				if visible_indexes_to_row_indexes.off then
					row_index := 1
				else
					visible_indexes_to_row_indexes.forth
					row_index := visible_indexes_to_row_indexes.item
				end
				visible_indexes_to_row_indexes.go_to (cursor)
			end
			Result := row_index.max (1).min (row_count)
		ensure
			valid_result: Result >= 1 and Result <= row_count
		end
		
	last_first_column_in_per_item_scrolling: INTEGER is
			-- Return the index of the column which should be displayed
			-- as the first column of the grid to ensure we do not scroll past
			-- the final column.
		local
			l_viewable_width: INTEGER
			l_column: EV_GRID_COLUMN_I
		do
				-- Must now iterate backwards to find the first column
			from
				l_viewable_width := viewable_width
				columns.go_i_th (column_count)
			until
				columns.off or l_viewable_width <= 0
			loop
				l_column := columns.item
				if l_column.is_displayed then
					l_viewable_width := l_viewable_width - l_column.width
				end
				if l_viewable_width > 0 then
					columns.back
				end
			end
			if columns.off then
				Result := 1
			else
				Result := columns.index + 1
			end
		ensure
			valid_result: Result >= 1 and Result <= column_count
		end
		
feature {ANY}
		
	recompute_horizontal_scroll_bar is
			-- Recompute horizontal scroll bar positioning.
		local
			l_total_column_width: INTEGER
			l_client_width: INTEGER
			average_column_width: INTEGER
			previous_scroll_bar_value: INTEGER
			column_index: INTEGER
		do
				-- Retrieve the 
			l_total_column_width := total_column_width
			
			l_client_width := viewable_width
				-- Note that `width' was not used as we want it to represent only the width of
				-- the "client area" which is `viewport'.
			
				
			if l_total_column_width > l_client_width then
					-- The headers are wider than the visible client area.
				if not horizontal_scroll_bar.is_show_requested then
						-- Show `horizontal_scroll_bar' if not already shown.
					horizontal_scroll_bar.show
					update_scroll_bar_spacer
				end
					-- Update the range and leap of `horizontal_scroll_bar' to reflect the relationship between
					-- `l_total_column_width' and `l_client_width'. Note that the behavior depends on the state of
					-- `is_horizontal_scrolling_per_item'.
				if has_horizontal_scrolling_per_item_just_changed then
					previous_scroll_bar_value := horizontal_scroll_bar.value
				end
				if is_horizontal_scrolling_per_item then
					if is_horizontal_overscroll_enabled then
						horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, column_count - 1))
					else
						-- We must now calculate the index of the row that ensures the final row that is visible in `Current'
						-- at the bottom of the viewable area.
						column_index := last_first_column_in_per_item_scrolling
						horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, column_index - 1))
					end
					average_column_width := (l_total_column_width // columns.count)
					horizontal_scroll_bar.set_leap (l_client_width // average_column_width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per pixel to per item horizontal
							-- scrolling, we must approximate the previous position of the scroll bar.
						horizontal_scroll_bar.set_value (previous_scroll_bar_value // average_column_width)
					end
				else
					horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, maximum_virtual_x_position))
					horizontal_scroll_bar.set_leap (width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per item to per pixel horizontal
							-- scrolling, we can set the position of the scroll bar exactly to match it's
							-- previous position.

							-- Must restrict to the maximum permitted value, as the virtual area
							-- is smaller when per pixel scrolling is set as you cannot scroll past the final item.
						horizontal_scroll_bar.set_value ((column_offsets @ (previous_scroll_bar_value + 1)).min (horizontal_scroll_bar.value_range.upper))
					end
				end
			else
					-- The headers are not as wide as the visible client area.
				if horizontal_scroll_bar.is_show_requested then
					check
						viewport_x_position_is_zero: viewport_x_offset = 0
					end
					horizontal_scroll_bar.hide
					update_scroll_bar_spacer
				end
			end
			
			if viewport_x_offset > 0 and (l_total_column_width - viewport_x_offset < viewable_width) then
					-- If `header' and `drawable' currently have a position that starts before the client area of
					-- `viewport' and the total header width is small enough so that at the current position, `header' and
					-- `drawable' do not reach to the very left-hand edge of the `viewport', update the horizontal offset
					-- so that they do reach the very left-hand edge of `viewport'
				viewport_x_offset := (l_total_column_width - viewable_width).max (0)
				viewport.set_x_offset (viewport_x_offset)
				
				header_viewport.set_x_offset ((l_total_column_width - viewable_width).max (0))
			end
		end

feature {EV_GRID_DRAWER_I} -- Drawing implementation

	redraw_resizing_line is
			-- Redraw resizing line drawn on `Current' at last drawn position.
			-- This must be called at the end of a redraw from EV_GRID_DRAWER_I
			-- as after the contents have been re-drawn the resizing line must still
			-- be displayed as otherwise when we move and invert the old position
			-- we will be effectively drawing a line which remains persistently in the client area.
		do
			if is_resizing_divider_solid then
				drawable.disable_dashed_line_style
			else
				drawable.enable_dashed_line_style
			end
			drawable.set_invert_mode
			drawable.draw_segment (last_dashed_line_position, resizing_line_border, last_dashed_line_position, viewable_height - resizing_line_border)
			drawable.set_copy_mode
		end
	
feature {NONE} -- Drawing implementation

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		local
			vertical_box, l_vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			set_minimum_size (default_minimum_size, default_minimum_size)
			is_horizontal_scrolling_per_item := False
			is_vertical_scrolling_per_item := True
			is_column_resize_immediate := True
			is_header_displayed := True
			row_height := default_row_height
			is_row_height_fixed := True
			subrow_indent := 0
			viewport_x_offset := 0
			viewport_y_offset := 0
			are_tree_node_connectors_shown := True
			are_columns_drawn_above_rows := True
			is_horizontal_overscroll_enabled := False
			is_vertical_overscroll_enabled := False
			create tree_node_connector_color.make_with_8_bit_rgb (150, 150, 150)
			invalid_row_index := invalid_row_index.max_value

				-- Flag `physical_column_indexes' for recalculation
			physical_column_indexes_dirty := True
			
			create internal_row_data
			create columns
			create rows
			
			create internal_selected_rows.make (0)
			create internal_selected_items.make (0)
			
			create drawer.make_with_grid (Current)
			create drawable
			drawable.set_minimum_size (buffered_drawable_size, buffered_drawable_size)
			create vertical_scroll_bar
			vertical_scroll_bar.hide
			vertical_scroll_bar.set_leap (default_scroll_bar_leap)
			vertical_scroll_bar.change_actions.extend (agent vertical_scroll_bar_changed)
			create horizontal_scroll_bar
			horizontal_scroll_bar.set_step (default_scroll_bar_leap)
			horizontal_scroll_bar.change_actions.extend (agent horizontal_scroll_bar_changed)
			create horizontal_box
			create vertical_box
			horizontal_box.extend (vertical_box)
			create l_vertical_box
			horizontal_box.extend (l_vertical_box)
			l_vertical_box.extend (vertical_scroll_bar)
			horizontal_box.disable_item_expand (l_vertical_box)
			create scroll_bar_spacer
			l_vertical_box.extend (scroll_bar_spacer)
			l_vertical_box.disable_item_expand (scroll_bar_spacer)
			
			create header_viewport
			vertical_box.extend (header_viewport)
			vertical_box.disable_item_expand (header_viewport)
			create viewport
			vertical_box.extend (viewport)
			vertical_box.extend (horizontal_scroll_bar)
			vertical_box.disable_item_expand (horizontal_scroll_bar)
			horizontal_scroll_bar.hide
			create vertical_box
			
			
			create header.make_with_grid (Current)
				-- Now connect events to `header' which are used to update the "physical size" of
				-- Current in response to their re-sizing.
			header.item_resize_start_actions.extend (agent header_item_resize_started)
			header.item_resize_actions.extend (agent header_item_resizing)
			header.item_resize_end_actions.extend (agent header_item_resize_ended)

			header_viewport.extend (header)
			header_viewport.set_minimum_height (header.height)
			header.set_minimum_width (maximum_header_width)
			header_viewport.set_item_size (maximum_header_width, header.height)
			viewport.extend (drawable)
			extend (horizontal_box)
			viewport.resize_actions.extend (agent viewport_resized)
			
				-- Now connect all of the events to `drawable' which will be used to propagate events to the `interface'.
			drawable.pointer_motion_actions.extend (agent pointer_motion_received (?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_press_actions.extend (agent pointer_button_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_double_press_actions.extend (agent pointer_double_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_release_actions.extend (agent pointer_button_release_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_enter_actions.extend (agent pointer_enter_received_on_drawable)
			drawable.pointer_leave_actions.extend (agent pointer_leave_received_on_drawable)
			drawable.key_press_actions.extend (agent key_press_received (?))
			drawable.key_press_string_actions.extend (agent key_press_string_received (?))
			drawable.key_release_actions.extend (agent key_release_received (?))
			drawable.focus_in_actions.extend (agent focus_in_received)
			drawable.focus_out_actions.extend (agent focus_out_received)
			drawable.mouse_wheel_actions.extend (agent mouse_wheel_received)


				-- Events must be connected to all widgets that comprise `Current' in order to propagate the events correctly.
				-- Note that not all events must be connected, only those that are not dependent on the widget having the
				-- focus, such as mouse events. For those that rely on the focus, only `drawable' will be able to receive the
				-- focus so is the only widget to which they must be connected.
			header.pointer_motion_actions.extend (agent pointer_motion_received_header (?, ?, ?, ?, ?, ?, ?))
			header.pointer_button_press_actions.extend (agent pointer_button_press_received_header (?, ?, ?, ?, ?, ?, ?, ?))
			header.pointer_double_press_actions.extend (agent pointer_double_press_received_header (?, ?, ?, ?, ?, ?, ?, ?))
			header.pointer_button_release_actions.extend (agent pointer_button_release_received_header (?, ?, ?, ?, ?, ?, ?, ?))
			header.pointer_enter_actions.extend (agent pointer_enter_received)
			header.pointer_leave_actions.extend (agent pointer_leave_received)
			
			vertical_scroll_bar.pointer_motion_actions.extend (agent pointer_motion_received_vertical_scroll_bar (?, ?, ?, ?, ?, ?, ?))
			vertical_scroll_bar.pointer_button_press_actions.extend (agent pointer_button_press_received_vertical_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			vertical_scroll_bar.pointer_double_press_actions.extend (agent pointer_double_press_received_vertical_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			vertical_scroll_bar.pointer_button_release_actions.extend (agent pointer_button_release_received_vertical_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			vertical_scroll_bar.pointer_enter_actions.extend (agent pointer_enter_received)
			vertical_scroll_bar.pointer_leave_actions.extend (agent pointer_leave_received)

			horizontal_scroll_bar.pointer_motion_actions.extend (agent pointer_motion_received_horizontal_scroll_bar (?, ?, ?, ?, ?, ?, ?))
			horizontal_scroll_bar.pointer_button_press_actions.extend (agent pointer_button_press_received_horizontal_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			horizontal_scroll_bar.pointer_double_press_actions.extend (agent pointer_double_press_received_horizontal_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			horizontal_scroll_bar.pointer_button_release_actions.extend (agent pointer_button_release_received_horizontal_scroll_bar (?, ?, ?, ?, ?, ?, ?, ?))
			horizontal_scroll_bar.pointer_enter_actions.extend (agent pointer_enter_received)
			horizontal_scroll_bar.pointer_leave_actions.extend (agent pointer_leave_received)

			scroll_bar_spacer.pointer_motion_actions.extend (agent pointer_motion_received_scroll_bar_spacer (?, ?, ?, ?, ?, ?, ?))
			scroll_bar_spacer.pointer_button_press_actions.extend (agent pointer_button_press_received_scroll_bar_spacer (?, ?, ?, ?, ?, ?, ?, ?))
			scroll_bar_spacer.pointer_double_press_actions.extend (agent pointer_double_press_received_scroll_bar_spacer (?, ?, ?, ?, ?, ?, ?, ?))
			scroll_bar_spacer.pointer_button_release_actions.extend (agent pointer_button_release_received_scroll_bar_spacer (?, ?, ?, ?, ?, ?, ?, ?))
			scroll_bar_spacer.pointer_enter_actions.extend (agent pointer_enter_received)
			scroll_bar_spacer.pointer_leave_actions.extend (agent pointer_leave_received)

			
			drawable.expose_actions.force_extend (agent drawer.redraw_area_in_drawable_coordinates)
				-- Now ensure grid can be tabbed to as any other standard widget.
			drawable.enable_tabable_to	
			drawable.enable_tabable_from

			update_scroll_bar_spacer
			
			enable_selection_on_click
			enable_single_item_selection

				-- Enable PND
			drawable.drop_actions.set_veto_pebble_function (agent veto_pebble_function_intermediary)
			drawable.drop_actions.extend (agent drop_action_intermediary)

			item_counter := 1
			row_counter := 1
			set_background_color ((create {EV_STOCK_COLORS}).white.twin)
			set_foreground_color ((create {EV_STOCK_COLORS}).black.twin)
			set_separator_color ((create {EV_STOCK_COLORS}).black.twin)
			set_node_pixmaps (initial_expand_node_pixmap, initial_collapse_node_pixmap)
		end

	header_item_resizing (header_item: EV_HEADER_ITEM) is
			-- Respond to `header_item' being resized.
		require
			header_item_not_void: header_item /= Void
			is_header_item_resizing: is_header_item_resizing
		local
			header_index: INTEGER
		do
				-- Update horizontal scroll bar size and position.
			recompute_horizontal_scroll_bar

				-- Now perform appropriate redrawing as required.
			if is_column_resize_immediate then
				header_index := header.index_of (header_item, 1)
				set_horizontal_computation_required (header_index)
				if are_column_separators_enabled and (last_width_of_header_during_resize = 0 and header_item.width > 0) or
					last_width_of_header_during_resize_internal > 0 and header_item.width = 0 then
						-- In this situation, we must draw the first column to the left of the one being
						-- resized that has a width greater than 0 as the column border must be updated
						-- in this column.
					if header_index > 1 then
						from
							header_index := header_index - 1
						until
							header_index = 1 or (columns @ (header_index)).width > 0
						loop
							header_index := header_index - 1
						end
					end
					redraw_from_column_to_end (columns @ (header_index))
				else
					redraw_from_column_to_end (columns @ (header_index))
				end
			else	
				if is_resizing_divider_enabled then
						-- Draw a resizing line if enabled.
					draw_resizing_line (header.item_x_offset (header_item) + header_item.width)
				end
			end
			last_width_of_header_during_resize_internal := header_item.width
		end

	last_width_of_header_during_resize: INTEGER is
		-- The last width of the header item that is currently being
		-- resized. Used to determine if we must refresh the column to
		-- the left of the current one as it could cause the border to
		-- need to be drawn on the previous column if it is the final
		-- column that current has a width greater than 0.
		require
			is_header_item_resizing: is_header_item_resizing
		do
			Result := last_width_of_header_during_resize_internal
		ensure
			result_non_negative: Result >= 0
		end
		
	last_width_of_header_during_resize_internal: INTEGER
		-- Storage for `last_width_of_header_during_resize'.

	header_item_resize_started (header_item: EV_HEADER_ITEM) is
			-- Resizing has started on `header_item'.
		require
			header_item_not_void: header_item /= Void
		do
			is_header_item_resizing := True
		end
		
	header_item_resize_ended (header_item: EV_HEADER_ITEM) is
			-- Resizing has completed on `header_item'.
		require
			header_item_not_void: header_item /= Void
		local
			header_index: INTEGER
		do
			header_index := header.index_of (header_item, 1)
			is_header_item_resizing := False
			if is_resizing_divider_enabled then
				remove_resizing_line
			end
			set_horizontal_computation_required (header_index)
			redraw_from_column_to_end (columns @ header_index)
		end
				
	draw_resizing_line (position: INTEGER) is
			-- Draw a resizing line at horizontal position relative to `drawable'.
			-- Clip line to drawable width.
		do
			if (position - viewport_x_offset > viewable_width) or
				(position - viewport_x_offset < 0) then
				remove_resizing_line
			else
					-- Draw line representing position in current divider style.
				if is_resizing_divider_solid then
					drawable.disable_dashed_line_style
				else
					drawable.enable_dashed_line_style
				end
				drawable.set_invert_mode
				drawable.draw_segment (position, resizing_line_border, position, viewable_height - resizing_line_border)
				if last_dashed_line_position > 0 then
					drawable.draw_segment (last_dashed_line_position, resizing_line_border, last_dashed_line_position, viewable_height - resizing_line_border)
				end
				last_dashed_line_position := position
				drawable.set_copy_mode
			end
		end
		
	remove_resizing_line is
			-- Remove resizing line drawn on `drawable'.
		do
				-- Remove line representing position in current divider style.
			if is_resizing_divider_solid then
				drawable.disable_dashed_line_style
			else
				drawable.enable_dashed_line_style
			end
			drawable.set_invert_mode
			drawable.draw_segment (last_dashed_line_position, resizing_line_border, last_dashed_line_position, viewable_height - resizing_line_border)
			last_dashed_line_position := - 1
			drawable.set_copy_mode
		ensure
			last_position_negative: last_dashed_line_position = -1
		end
		
	last_dashed_line_position: INTEGER
		-- Last horizontal coordinate of dashed line drawn when slider is moved.
		
	vertical_scroll_bar_changed (a_value: INTEGER) is
			-- Respond to a change in value from `vertical_scroll_bar'.
		require
			a_value_non_negative: a_value >= 0
		do
			if is_vertical_scrolling_per_item then
				if is_row_height_fixed then
					internal_set_virtual_y_position (row_height * a_value)
				else
					internal_set_virtual_y_position (row_offsets.i_th (visible_indexes_to_row_indexes @ (a_value + 1)))
				end
			else
				internal_set_virtual_y_position (a_value)
			end
			if virtual_position_changed_actions_internal /= Void then
				virtual_position_changed_actions_internal.call ([virtual_x_position, virtual_y_position])
			end
		end
		
	horizontal_scroll_bar_changed (a_value: INTEGER) is
			-- Respond to a change in value from `horizontal_scroll_bar'.
		require
			a_value_non_negative: a_value >= 0
		do
			if is_horizontal_scrolling_per_item then
				internal_set_virtual_x_position (column_offsets.i_th (a_value + 1))
			else
				internal_set_virtual_x_position (a_value)
			end
			if virtual_position_changed_actions_internal /= Void then
				virtual_position_changed_actions_internal.call ([virtual_x_position, virtual_y_position])
			end
		end
		
	internal_set_virtual_y_position (a_y_position: INTEGER) is
			-- Set virtual y position of `Current' to `a_y_position'.
		require
			a_y_position_non_negative: a_y_position >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if is_full_redraw_on_virtual_position_change_enabled then
				redraw_client_area
			end
			internal_client_y := a_y_position
				-- Store the virtual client y position internally.

			buffer_space := (buffered_drawable_size - viewable_height)
			current_buffer_position := viewport_y_offset

				-- Calculate if the buffer must be flipped. If so, redraw the complete client area,
				-- otherwise, simply move the position in `viewport'.
			if (internal_client_y > last_vertical_scroll_bar_value) and ((internal_client_y - last_vertical_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport_y_offset := 0
				viewport.set_y_offset (viewport_y_offset)
				redraw_client_area
			elseif (internal_client_y < last_vertical_scroll_bar_value) and ((internal_client_y - last_vertical_scroll_bar_value) + (current_buffer_position)) < 0 then
				viewport_y_offset := buffer_space
				viewport.set_y_offset (viewport_y_offset)
				redraw_client_area
			else
				viewport_y_offset := current_buffer_position + internal_client_y - last_vertical_scroll_bar_value
				viewport.set_y_offset (viewport_y_offset)
			end
			
				-- Store the last scrolled to position.
			last_vertical_scroll_bar_value := internal_client_y
		ensure
			internal_position_set: internal_client_y = a_y_position
		end
		
	internal_set_virtual_x_position (a_x_position: INTEGER) is
			-- Set virtual x position of `Current' to `a_x_position'.
		require
			a_x_position_non_negative: a_x_position >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if is_full_redraw_on_virtual_position_change_enabled then
				redraw_client_area
			end
			internal_client_x := a_x_position
				-- Store the virtual client x position internally.
				
			buffer_space := (buffered_drawable_size - viewable_width)
			current_buffer_position := viewport_x_offset
			
				-- Calculate if the buffer must be flipped. If so, redraw the complete client area,
				-- otherwise, simply move the position in `viewport'.
			if (internal_client_x > last_horizontal_scroll_bar_value) and ((internal_client_x - last_horizontal_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport_x_offset := 0
				viewport.set_x_offset (viewport_x_offset)
				redraw_client_area
			elseif (internal_client_x < last_horizontal_scroll_bar_value) and ((internal_client_x - last_horizontal_scroll_bar_value) + (current_buffer_position)) < 0 then
				viewport_x_offset := buffer_space
				viewport.set_x_offset (viewport_x_offset)
				redraw_client_area
			else
				viewport_x_offset := current_buffer_position + internal_client_x - last_horizontal_scroll_bar_value
				viewport.set_x_offset (viewport_x_offset)
			end
			header_viewport.set_x_offset (internal_client_x)
			
				-- Store the last scrolled to position.
			last_horizontal_scroll_bar_value := internal_client_x	
		ensure
			internal_position_set: internal_client_x = a_x_position
		end
		
	last_horizontal_scroll_bar_value: INTEGER
		-- Last value of `horizontal_scroll_bar' used within `horizontal_scroll_bar_changed'
		-- to determine how far the scroll bar has moved and whether or not the position of the virtual drawable
		-- needs to be "flipped". Although removing this computation may initially appear to work, there are
		-- drawing issues in the case that two consecutive scroll bar positions are greater than the excess space for
		-- virtual drawing.
		
	last_vertical_scroll_bar_value: INTEGER
		-- Last value of `vertical_scroll_bar' used within `vertical_scroll_bar_changed'. See
		-- comment of `last_horizontal_scroll_bar_value' for details of it's use.
		

	update_scroll_bar_spacer is
			-- Update `scroll_bar_spacer' so that it has the appropriate minimum dimensions
			-- given the visible state of `horizontal_scroll_bar' and `vertical_scroll_bar
			-- which results in the two scroll bars being positioned correctly in relation
			-- to each other.
		do
			if horizontal_scroll_bar.is_show_requested and vertical_scroll_bar.is_show_requested then
				scroll_bar_spacer.set_minimum_size (vertical_scroll_bar.width, horizontal_scroll_bar.height)
			else
				scroll_bar_spacer.set_minimum_size (0, 0)
			end
		end
		
	viewport_resized (an_x, a_y, a_width, a_height: INTEGER) is
			-- Respond to resizing of `Viewport' to width and height `a_width', `a_height'.
		require
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		do
			
				-- Set the internal client dimensions for
				-- quick retrieval later. This reduces the dependencies on
				-- `viewport' within other code.
			viewable_width := a_width
			viewable_height := a_height


				-- We set the computation required to the final column and row as this
				-- triggers re-computation of the scroll bars, with the minimal recompute performed.
			if not header.is_empty then
					-- Update horizontal scroll bar size and position.
				set_horizontal_computation_required (columns.count)
			end
			if row_count /= 0 then
				set_vertical_computation_required (row_count)
			end
				-- Flag that we have triggered a recompute/redraw as the result of
				-- the viewport resizing. In this situation, extra procssing is performed
				-- to ensure that the scroll bars update correctly.
			horizontal_redraw_triggered_by_viewport_resize := True
			vertical_redraw_triggered_by_viewport_resize := True

				-- Now flag to redraw the complete client area.
				-- On Windows, the complete client area is redrawn each time a move occurs
				-- and on Gtk this does not happen. By calling `redraw_client_area', we ensure the
				-- behavior is the same on both platforms.
			redraw_client_area
		ensure
			viewable_dimensions_set: viewable_width = a_width and viewable_height = a_height
			viewport_item_at_least_as_big_as_viewport: viewport.item.width >= viewable_width and
				viewport.item.height >= viewable_height
		end
		
	vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Vertical scroll bar of `Current'.
	
	horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
		-- Horizontal scroll bar of `Current'.
		
	header_viewport: EV_VIEWPORT
		
	scroll_bar_spacer: EV_CELL
		-- A spacer to separate the corners of the scroll bars.
	
	fixed: EV_FIXED
		-- Main widget contained in `Current' used to manipulate the individual widgets required.

	default_header_height: INTEGER is 16
		-- Default height applied to `header'.
	
	default_minimum_size: INTEGER is 50
		-- Default minimum size dimensions for `Current'.
		
	resizing_line_border: INTEGER is 4
		-- Distance that resizing line is displayed from top and bottom edges of `drawable'.
		
	buffered_drawable_size: INTEGER is 2000
		-- Default size of `drawable' used for scrolling purposes.

	horizontal_redraw_triggered_by_viewport_resize: BOOLEAN

	vertical_redraw_triggered_by_viewport_resize: BOOLEAN

feature {EV_GRID_DRAWABLE_ITEM_I} -- Implementation

	drawer: EV_GRID_DRAWER_I
		-- Drawer which is able to redraw `Current'.
		
feature {EV_GRID_COLUMN_I, EV_GRID_DRAWER_I} -- Implementation

	is_header_item_resizing: BOOLEAN
		-- Is a header item currently in the process of resizing?

feature {NONE} -- Event handling	

		-- First we define a number of functions for conversion of coordinates.

	client_x_to_virtual_x (client_x: INTEGER): INTEGER is
			-- Convert `client_x' in client coordinates of `drawable' to a virtual grid coordinate.
		do
			Result := client_x + internal_client_x - viewport_x_offset
		end
		
	client_y_to_virtual_y (client_y: INTEGER): INTEGER is
			-- Convert `client_y' in client coordinates of `drawable' to a virtual grid coordinate.
		do
			Result := client_y + internal_client_y - viewport_y_offset
		end

	client_x_to_x (client_x: INTEGER): INTEGER is
			-- Convert `client_x' in client coordinates of `drawable' to an absolute grid coordinate.
		do
			Result := client_x + viewable_x_offset - viewport_x_offset
		end

	client_y_to_y (client_y: INTEGER): INTEGER is
			-- Convert `client_y' in client coordinates of `drawable' to an absolute grid coordinate.
		do
			Result := client_y + viewable_y_offset - viewport_y_offset
		end
		
	pointer_button_press_received (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A pointer button press has been received by `drawable' so propagate to the interface.
		local
			pointed_item: EV_GRID_ITEM_I
			current_item_x_position: INTEGER
			current_subrow_indent: INTEGER
			node_x_position_click_edge: INTEGER
			pointed_row_i: EV_GRID_ROW_I
			pointed_item_interface: EV_GRID_ITEM
			ignore_selection_handling: BOOLEAN
			selected_item: EV_GRID_ITEM
			selected_item_i: EV_GRID_ITEM_I
			item_coordinates: EV_COORDINATE
		do
			pointed_item := drawer.item_at_position_strict (a_x, a_y)


				-- We fire the pointer button press actions before the node or selection actions which may occur
				-- as a result of this press.
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				pointer_button_press_actions_internal.call ([client_x_to_x (a_x), client_y_to_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, client_x_to_x (a_screen_x), client_y_to_y (a_screen_y)])
			end
			if pointer_button_press_item_actions_internal /= Void and then not pointer_button_press_item_actions_internal.is_empty then
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_button_press_item_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end
			if pointed_item /= Void and then pointed_item.pointer_button_press_actions_internal /= Void and then not pointed_item.pointer_button_press_actions_internal.is_empty then
				pointed_item.pointer_button_press_actions_internal.call ([client_x_to_virtual_x(a_x) - pointed_item.virtual_x_position, client_y_to_virtual_y (a_y) - pointed_item.virtual_y_position, a_button, 0.0, 0.0, 0.0, a_screen_x, a_screen_y])
			end


			item_coordinates := drawer.item_coordinates_at_position (a_x, a_y)
			if item_coordinates /= Void then
				pointed_row_i := row_internal (item_coordinates.y)
				current_subrow_indent := item_cell_indent (item_coordinates.x, item_coordinates.y) --item_indent (pointed_item)
				current_item_x_position := (column_offsets @ (item_coordinates.x)) - (internal_client_x - viewport_x_offset)
				node_x_position_click_edge := current_subrow_indent + current_item_x_position
				if pointed_row_i.subrow_count /= 0 or pointed_row_i.is_ensured_expandable then
						-- We only include the dimensions of the node pixmap for our calculations if
						-- one is displayed.
					 node_x_position_click_edge := current_subrow_indent + current_item_x_position - (node_pixmap_width + (3 * tree_node_spacing))
				end
				
				if a_x >= node_x_position_click_edge then
					if a_button = 1 and then (pointed_row_i.subrow_count > 0 or pointed_row_i.is_ensured_expandable) and then current_subrow_indent > 0 and a_x < current_subrow_indent + current_item_x_position then		
						ignore_selection_handling := True
						if pointed_row_i.is_expanded then
							pointed_row_i.collapse
						else
							pointed_row_i.expand
						end
					elseif is_selection_on_click_enabled then
						selected_item_i := item_internal (item_coordinates.x, item_coordinates.y)
						if selected_item_i /= Void then
							selected_item := selected_item_i.interface
						end
					end
				end
			end
			if not ignore_selection_handling and then is_selection_on_click_enabled then
				handle_newly_selected_item (selected_item)
			end
		end

	pointer_button_press_received_header (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A pointer button press has been received by `header' so propagate to the interface.
		do
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				pointer_button_press_actions_internal.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_press_received_vertical_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `vertical_scroll_bar'.
		do
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				pointer_button_press_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_press_received_horizontal_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `horizontal_scroll_bar'.
		do
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				pointer_button_press_actions_internal.call ([a_x + viewable_x_offset, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_press_received_scroll_bar_spacer (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `scroll_bar_spacer'.
		do
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				pointer_button_press_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_motion_received (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if a_x >= 0 and then a_y >= 0 then
				pointed_item := drawer.item_at_position_strict (a_x, a_y)
			end
				-- Now handle the tooltips for items.
			if pointed_item /= Void and then pointed_item.tooltip /= Void and then not drawable.tooltip.is_equal (pointed_item.tooltip) then
				drawable.set_tooltip (pointed_item.tooltip)
			elseif pointed_item = Void or else pointed_item /= Void and then pointed_item.tooltip = Void then
				drawable.remove_tooltip
			end

				-- Now handle the enter and leave actions. Note that these are fired before the motion events.
			if not pointer_enter_called then
				if pointer_enter_actions_internal /= Void and then not pointer_enter_actions_internal.is_empty then
					pointer_enter_actions_internal.call (Void)
				end
			end
			if pointed_item /= Void then
				if pointed_item /= last_pointed_item then
					if last_pointed_item /= Void then
						if pointer_leave_item_actions_internal /= Void and then not pointer_leave_item_actions_internal.is_empty then
							pointer_leave_item_actions_internal.call ([False, last_pointed_item.interface])
						end
						if last_pointed_item.pointer_leave_actions_internal /= Void and then not last_pointed_item.pointer_leave_actions_internal.is_empty then
							last_pointed_item.pointer_leave_actions_internal.call (Void)
						end
					end
					if not pointer_enter_called then
						if pointer_enter_item_actions_internal /= Void and then not pointer_enter_item_actions_internal.is_empty then
							pointer_enter_item_actions_internal.call ([not pointer_enter_called, pointed_item.interface])
						end
					end
					if pointed_item.pointer_enter_actions_internal /= Void and then not pointed_item.pointer_enter_actions_internal.is_empty then
						pointed_item.pointer_enter_actions_internal.call (Void)
					end
					last_pointed_item := pointed_item
				end
				if pointed_item.pointer_motion_actions_internal /= Void and then not pointed_item.pointer_motion_actions_internal.is_empty then
					pointed_item.pointer_motion_actions_internal.call ([client_x_to_virtual_x(a_x) - pointed_item.virtual_x_position, client_y_to_virtual_y (a_y) - pointed_item.virtual_y_position, 0.0, 0.0, 0.0, a_screen_x, a_screen_y])
				end
			else
				if not pointer_enter_called then
					if pointer_enter_item_actions_internal /= Void and then not pointer_enter_item_actions_internal.is_empty then
						pointer_enter_item_actions_internal.call ([True, Void])
					end
				end
				if last_pointed_item /= Void then
					if pointer_leave_item_actions_internal /= Void and then not pointer_leave_item_actions_internal.is_empty then
						pointer_leave_item_actions_internal.call ([False, last_pointed_item.interface])
					end
					if last_pointed_item.pointer_leave_actions_internal /= Void and then not last_pointed_item.pointer_leave_actions_internal.is_empty then
						last_pointed_item.pointer_leave_actions_internal.call (Void)
					end
					last_pointed_item := Void
				end
			end
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				pointer_motion_actions_internal.call ([client_x_to_x (a_x), client_y_to_y (a_y) , a_x_tilt, a_y_tilt, a_pressure, client_x_to_x (a_screen_x), client_y_to_y (a_screen_y)])
			end
			if pointer_motion_item_actions_internal /= Void and then not pointer_motion_item_actions_internal.is_empty then
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_motion_item_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), pointed_item_interface])
			end
			pointer_enter_called := True
		end

	last_pointed_item: EV_GRID_ITEM_I
		-- The last item that was pointed to in `pointer_motion_received', which may be `Void'.
		-- This is used to implement the pointer enter and pointer leave actions at the item level.

	pointer_motion_received_header (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `header'.
		do
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				pointer_motion_actions_internal.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_motion_received_vertical_scroll_bar (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `vertical_scroll_bar'.
		do
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				pointer_motion_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_motion_received_horizontal_scroll_bar (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `horizontal_scroll_bar'.
		do
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				pointer_motion_actions_internal.call ([a_x + viewable_x_offset, a_y + viewable_y_offset + viewable_height, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_motion_received_scroll_bar_spacer (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `scroll_bar_spacer'.
		do
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				pointer_motion_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y + viewable_y_offset + viewable_height, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_double_press_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_double_press_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointer_double_press_actions_internal.call ([client_x_to_x (a_x), client_y_to_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, client_x_to_x (a_screen_x), client_y_to_y (a_screen_y)])
			end

			pointed_item := drawer.item_at_position_strict (a_x, a_y)
			if pointer_double_press_item_actions_internal /= Void and then not pointer_double_press_item_actions_internal.is_empty then
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_double_press_item_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end
			if pointed_item /= Void and then pointed_item.pointer_double_press_actions_internal /= Void and then not pointed_item.pointer_double_press_actions_internal.is_empty then
				pointed_item.pointer_double_press_actions_internal.call ([client_x_to_virtual_x(a_x) - pointed_item.virtual_x_position, client_y_to_virtual_y (a_y) - pointed_item.virtual_y_position, a_button, 0.0, 0.0, 0.0, a_screen_x, a_screen_y])
			end
		end

	pointer_double_press_received_header (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A pointer button double press has been received by `header' so propagate to the interface.
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointer_double_press_actions_internal.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_double_press_received_vertical_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_double_press_actions' of `vertical_scroll_bar'.
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointer_double_press_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_button, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_double_press_received_horizontal_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_double_press_actions' of `horizontal_scroll_bar'.
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointer_double_press_actions_internal.call ([a_x + viewable_x_offset, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_double_press_received_scroll_bar_spacer (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_double_press_actions' of `scroll_bar_spacer'.
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointer_double_press_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_release_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointer_button_release_actions_internal.call ([client_x_to_x (a_x) , client_y_to_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, client_x_to_x (a_screen_x), client_y_to_y (a_screen_y)])
			end

			pointed_item := drawer.item_at_position_strict (a_x, a_y)
			if pointer_button_release_item_actions_internal /= Void and then not pointer_button_release_item_actions_internal.is_empty then
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_button_release_item_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end
			if pointed_item /= Void and then pointed_item.pointer_button_release_actions_internal /= Void and then not pointed_item.pointer_button_release_actions_internal.is_empty then
				pointed_item.pointer_button_release_actions_internal.call ([client_x_to_virtual_x(a_x) - pointed_item.virtual_x_position, client_y_to_virtual_y (a_y) - pointed_item.virtual_y_position, a_button, 0.0, 0.0, 0.0, a_screen_x, a_screen_y])
			end
		end

	pointer_button_release_received_header (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A pointer button double press has been received by `header' so propagate to the interface.
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointer_button_release_actions_internal.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_release_received_vertical_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `vertical_scroll_bar'.
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointer_button_release_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_button, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_release_received_horizontal_scroll_bar (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `horizontal_scroll_bar'.
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointer_button_release_actions_internal.call ([a_x + viewable_x_offset, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	pointer_button_release_received_scroll_bar_spacer (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `scroll_bar_spacer'.
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointer_button_release_actions_internal.call ([a_x + viewable_x_offset + viewable_width, a_y + viewable_y_offset + viewable_height, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end
		
	pointer_enter_called: BOOLEAN
		-- Have the pointer enter actions already been called for the grid?

	pointer_enter_received is
			-- Called by `pointer_enter_actions' of widgets comprising `Current'.
		do
			if not pointer_enter_called then
				if pointer_enter_actions_internal /= Void and then not pointer_enter_actions_internal.is_empty then
					pointer_enter_actions_internal.call (Void)
				end
				if pointer_enter_item_actions_internal /= Void and then not pointer_enter_item_actions_internal.is_empty then
					pointer_enter_item_actions_internal.call ([True, Void])
				end
				pointer_enter_called := True
			end
		end

	pointer_enter_received_on_drawable is
			-- Called by `pointer_enter_actions' of `drawable'.
		do
			-- The handling you may expect here is performed within the motion event on `drawable'
			-- as we have retreived the item there, and this saves us from retreiving it twice.
		end

	pointer_leave_received is
			-- Called by `pointer_leave_actions' of widgets comprising `Current'.
		local
			pointed_widget: EV_WIDGET
			screen: EV_SCREEN
			pointed_item: EV_GRID_ITEM
		do
			create screen
			pointed_widget := screen.widget_at_position (screen.pointer_position.x, screen.pointer_position.y)
			if pointed_widget /= drawable and pointed_widget /= horizontal_scroll_bar and pointed_widget /= vertical_scroll_bar and pointed_widget /= header then
				if pointer_leave_actions_internal /= Void then
					pointer_leave_actions.call (Void)
				end
				if pointer_leave_item_actions_internal /= Void then
					if last_pointed_item /= Void then
						pointed_item := last_pointed_item.interface
					end
					pointer_leave_item_actions_internal.call ([True, pointed_item])
				end

					-- Reset `pointer_enter_called' as we are no longer within `Current'.
				pointer_enter_called := False
			end
		end
		
	pointer_leave_received_on_drawable is
			-- Called by `pointer_leave_actions' of `drawable'.
		local
			pointed_widget: EV_WIDGET
			screen: EV_SCREEN
			pointed_item: EV_GRID_ITEM
		do
			create screen
			pointed_widget := screen.widget_at_position (screen.pointer_position.x, screen.pointer_position.y)
			if pointed_widget /= horizontal_scroll_bar and pointed_widget /= vertical_scroll_bar and pointed_widget /= header then
				if pointer_leave_actions_internal /= Void then
					pointer_leave_actions.call (Void)
				end
				if last_pointed_item /= Void then
					pointed_item := last_pointed_item.interface
				end
				if pointer_leave_item_actions_internal /= Void then
					pointer_leave_item_actions_internal.call ([True, pointed_item])
				end

					-- Reset `pointer_enter_called' as we are no longer within `Current'.
				pointer_enter_called := False
			elseif last_pointed_item /= Void then
					-- If there was a pointed item, fire its leave actions.
				if pointer_leave_item_actions_internal /= Void and then not pointer_leave_item_actions_internal.is_empty then
					pointer_leave_item_actions_internal.call ([False, last_pointed_item.interface])
				end
				if last_pointed_item.pointer_leave_actions_internal /= Void and then not last_pointed_item.pointer_leave_actions_internal.is_empty then
					last_pointed_item.pointer_leave_actions_internal.call (Void)
				end
				last_pointed_item := Void
			end
		end

	find_next_item_in_row (grid_row: EV_GRID_ROW; starting_index: INTEGER; look_right: BOOLEAN): EV_GRID_ITEM is
			-- Find the next item horizontally in `grid_row' starting at index `starting_index', if 'look_right' then the the item to the right is found, else it looks to the left.
			-- Result is Void if no item is found.
		require
			grid_row_not_void: grid_row /= Void
			starting_index_valid: starting_index > 0 and then starting_index <= grid_row.count
		local
			item_offset: INTEGER
			item_index: INTEGER
			last_index: INTEGER
		do
			if look_right then
				item_offset := 1
				last_index := grid_row.count + 1
			else
				item_offset := -1
				last_index := 0
			end

			from
				item_index := starting_index + item_offset
			until
				Result /= Void or else item_index = last_index
			loop
				Result := grid_row.item (item_index)
				item_index := item_index + item_offset
			end
		end

	find_next_item_in_column (grid_column: EV_GRID_COLUMN; starting_index: INTEGER; look_down: BOOLEAN; look_left_right_if_void: BOOLEAN): EV_GRID_ITEM is
			-- Find the next item vertically in `grid_column' starting a index `starting_index' if 'look_down' then the the item below is found, else it looks above.
			-- If `look_left_right_if_void', if a Void item is found it will search along the current row starting to the left of `starting_index', then to the right if none found.
			-- Result is Void if no item is found.
		require
			column_not_void: grid_column /= Void
			starting_index_valid: starting_index > 0 and then starting_index <= grid_column.count
		local
			item_offset: INTEGER
			item_index: INTEGER
			last_index: INTEGER
		do
			if look_down then
				item_offset := 1
				last_index := grid_column.count + 1
			else
				item_offset := -1
				last_index := 0
			end

			from
				item_index := starting_index + item_offset
			until
				Result /= Void or else item_index = last_index
			loop
				Result := grid_column.item (item_index)
				if Result = Void and then look_left_right_if_void then
					-- There is no item in the column so we first look left, then right
					Result := find_next_item_in_row (row (item_index), grid_column.index, False)
					if Result = Void then
						Result := find_next_item_in_row (row (item_index), grid_column.index, True)
					end
				end
				if Result /= Void then
					if not is_item_navigatable_to (Result) then
						Result := Void
					end
				end
				item_index := item_index + item_offset
			end
		end	

	is_item_navigatable_to (a_item: EV_GRID_ITEM): BOOLEAN is
			-- Is `a_item' currently navigatable via the keyboard?
		local
			a_parent_row: EV_GRID_ROW
		do
			from
				Result := True
				a_parent_row := a_item.row.parent_row
			until
				a_parent_row = Void or else not Result
			loop
				if not a_parent_row.is_expanded then
					Result := False
				end
				a_parent_row := a_parent_row.parent_row
			end		
		end

	key_press_received (a_key: EV_KEY) is
			-- Called by `key_press_actions' of `drawable'.
		local
			prev_sel_item, a_sel_item: EV_GRID_ITEM
			a_sel_row: EV_GRID_ROW
			sel_items: like selected_items
			items_spanning: ARRAYED_LIST [INTEGER]
		do
			if key_press_actions_internal /= Void and then not key_press_actions_internal.is_empty then
				key_press_actions_internal.call ([a_key])
			end
			
			if is_selection_keyboard_handling_enabled then
					-- Handle the selection events
				sel_items := selected_items
						-- We always want to find an item above or below for row selection
				if not sel_items.is_empty then
					prev_sel_item := sel_items.last
					a_sel_row := prev_sel_item.row
					inspect
						a_key.code
					when {EV_KEY_CONSTANTS}.Key_down then					
						a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, True, is_row_selection_enabled or else ((a_sel_row.subrow_count > 0 or else a_sel_row.parent_row /= Void) and then a_sel_row.index_of_first_item = prev_sel_item.column.index))
					when {EV_KEY_CONSTANTS}.Key_up then
						a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, False, is_row_selection_enabled or else ((a_sel_row.subrow_count > 0 or else a_sel_row.parent_row /= Void) and then a_sel_row.index_of_first_item = prev_sel_item.column.index))
					when {EV_KEY_CONSTANTS}.Key_right then
						if not is_row_selection_enabled then
								-- Key right shouldn't affect row selection
							if prev_sel_item /= Void and then not is_item_navigatable_to (prev_sel_item) then
								a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, False, True)
							else
								a_sel_item := find_next_item_in_row (prev_sel_item.row, prev_sel_item.column.index, True)
							end
						else
							items_spanning := drawer.items_spanning_horizontal_span (virtual_x_position + width, 0)
							if not items_spanning.is_empty then
								(columns @ (items_spanning @ 1)).ensure_visible
							end
						end
					when {EV_KEY_CONSTANTS}.Key_left then
						if not is_row_selection_enabled then
								-- Key left shouldn't affect row selection
							if prev_sel_item /= Void and then not is_item_navigatable_to (prev_sel_item) then
								a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, False, True)
							else
								a_sel_item := find_next_item_in_row (prev_sel_item.row, prev_sel_item.column.index, False)
							end
	
						else
							if virtual_x_position > 0 then
								items_spanning := drawer.items_spanning_horizontal_span (virtual_x_position - 1, 0)
								if not items_spanning.is_empty then
									(columns @ (items_spanning @ 1)).ensure_visible
								end
							end
						end
					else
						-- Do nothing
					end
					if a_sel_item /= Void then
						handle_newly_selected_item (a_sel_item)
					end
				end
			end
		end

	handle_newly_selected_item (a_item: EV_GRID_ITEM) is
			-- Handle selection for newly selected `a_item'.
		local
			start_item: EV_GRID_ITEM
			start_row_index, end_row_index, start_column_index, end_column_index: INTEGER
			a_col_counter, a_row_counter: INTEGER
			current_item: EV_GRID_ITEM
			l_remove_selection: BOOLEAN
			is_ctrl_pressed, is_shift_pressed: BOOLEAN
			a_application: EV_APPLICATION
			l_selected_items: ARRAYED_LIST [EV_GRID_ITEM]
		do
			a_application := (create {EV_ENVIRONMENT}).application
			is_ctrl_pressed := a_application.ctrl_pressed
			is_shift_pressed := a_application.shift_pressed
			if not (a_item = Void and is_always_selected) then
					-- If we are `is_item_always_selected' mode then clicking on Void items should have no effect
				l_remove_selection := True
			end
			if is_multiple_selection_enabled then
				if is_shift_pressed then
					l_selected_items := selected_items
					if not l_selected_items.is_empty then
						start_item := l_selected_items.last
					end
					if a_item /= Void and then start_item /= Void and then start_item /= a_item then
						start_row_index := start_item.row.index
						end_row_index := a_item.row.index
						start_column_index := start_item.column.index
						end_column_index := a_item.column.index
						from
							a_col_counter := start_column_index.min (end_column_index)
						until
							a_col_counter > start_column_index.max (end_column_index)
						loop
							from
								a_row_counter := start_row_index.min (end_row_index)
							until
								a_row_counter > start_row_index.max (end_row_index)
							loop
								current_item := item (a_col_counter, a_row_counter)
								if current_item /= Void then
									current_item.enable_select
								end
								a_row_counter := a_row_counter + 1
							end
							a_col_counter := a_col_counter + 1
						end
						last_selected_item := a_item.implementation
					end
					l_remove_selection := False
				elseif is_ctrl_pressed then
					-- If the ctrl key is pressed and we are in a multiple selection mode then we do nothing.
					l_remove_selection := False
				end
			end

			if l_remove_selection and then
				(a_item = Void or
				(a_item /= Void and then not a_item.is_selected) or
				(not is_row_selection_enabled and then selected_items.count > 1) or
				(is_row_selection_enabled and then selected_rows.count > 1)) then
					remove_selection
			end

			if a_item /= Void then
				if not a_item.is_selected then
					a_item.enable_select
					if is_row_selection_enabled then
						a_item.row.ensure_visible
					else
						a_item.ensure_visible
					end
				elseif is_ctrl_pressed and then not is_always_selected then
						-- Allow for removal of item selection by Ctrl clicking
					a_item.disable_select
				end
			end
		end

	key_press_string_received (a_keystring: STRING) is
			-- Called by `key_press_string_actions' of `drawable'.
		do
			if key_press_string_actions_internal /= Void and then not key_press_string_actions_internal.is_empty then
				key_press_string_actions_internal.call ([a_keystring])
			end
		end

	key_release_received (a_key: EV_KEY) is
			-- Called by `key_release_actions' of `drawable'.
		do
			if key_release_actions_internal /= Void and then not key_release_actions_internal.is_empty then
				key_release_actions_internal.call ([a_key])
			end
		end

	focus_in_received is
			-- Called by `focus_in_actions' of `drawable'.
		do
			redraw_client_area
			if focus_in_actions_internal /= Void and then not focus_in_actions_internal.is_empty then
				focus_in_actions_internal.call (Void)
			end
		end

	focus_out_received is
			-- Called by `focus_out_actions' of `drawable'.
		do
			redraw_client_area
			if focus_out_actions_internal /= Void and then not focus_out_actions_internal.is_empty then
				focus_out_actions_internal.call (Void)
			end
		end

	mouse_wheel_received (a_value: INTEGER) is
			-- Called by `mouse_wheel_actions' of `drawable'.
		do
			if mouse_wheel_actions_internal /= Void and then not mouse_wheel_actions_internal.is_empty then
				mouse_wheel_actions_internal.call ([a_value])
			end
		end

feature {EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_DRAWER_I} -- Implementation

	add_row_at (a_index: INTEGER; replace_existing_item: BOOLEAN) is
			-- Add a new row at index `a_index'.
			-- If `replace_existing_item' then replace value at `a_index', else insert at `a_index'.
		require
			i_positive: a_index > 0
		local
			row_i, replaced_row: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			row_i := interface.new_row.implementation
			
			create a_row_data.make (0)
			if a_index > row_count then
				if replace_existing_item then
						-- We are inserting at a certain value so we resize to one less
					resize_row_lists (a_index)
				else
					resize_row_lists (a_index - 1)
				end
			end

			rows.go_i_th (a_index)
			internal_row_data.go_i_th (a_index)

				-- Set grid of `grid_row' to `Current'
			row_i.set_parent_i (Current, row_counter)

			if replace_existing_item then
				internal_row_data.replace (a_row_data)
				replaced_row := rows.item
				if replaced_row /= Void then
					replaced_row.update_for_removal
				end
				rows.replace (row_i)
				row_i.set_index (a_index)
			else
				internal_row_data.put_left (a_row_data)
				rows.put_left (row_i)
					-- Update the index of `row_i' and subsequent rows in `rows'
				update_grid_row_indices (a_index)
			end
			set_vertical_computation_required (a_index)
		end
		
	row_internal (a_row: INTEGER): EV_GRID_ROW_I is
			-- Row `a_row', creates a new one if it doesn't exist.
		require
			a_row_positive: a_row > 0
		local
			temp_rows: like rows
		do
			temp_rows := rows
			if a_row <= temp_rows.count then
				Result := temp_rows @ a_row
			end
			if Result = Void then
				add_row_at (a_row, True)
				Result := temp_rows @ a_row
			end
		ensure
			row_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	add_column_at (a_index: INTEGER; replace_existing_item: BOOLEAN) is
			-- Add a new column at index `a_index'.
			-- If `replace_existing_item' then replace value at `a_index', else insert at `a_index'.
		require
			i_positive: a_index > 0
		local
			a_column_i, replaced_column: EV_GRID_COLUMN_I
		do
			a_column_i := interface.new_column.implementation
			
			if a_index > columns.count then
				if replace_existing_item then
					columns.resize (a_index)
				else
						-- Resize to new count minus 1 as we are inserting a new item, when item is inserted then count will be increased
					columns.resize (a_index - 1)
				end
			end

				-- Set column's internal data
			a_column_i.set_physical_index (physical_column_count)
			physical_column_count := physical_column_count + 1

			a_column_i.set_parent_i (Current)

			columns.go_i_th (a_index)
			if replace_existing_item then
				replaced_column := columns.item
				if replaced_column /= Void then
					replaced_column.update_for_removal
				end
				columns.replace (a_column_i)
				a_column_i.set_index (a_index)
			else
				columns.put_left (a_column_i)
				update_grid_column_indices (a_index)
			end

				-- Flag `physical_column_indexes' for recalculation
			physical_column_indexes_dirty := True

			update_index_of_first_item_dirty_row_flags (a_index)

			show_column (a_index)
			header_item_resize_ended (header.last)
		ensure
			column_count_set: not replace_existing_item implies ((a_index < old column_count implies (column_count = old column_count + 1)) or column_count = a_index)
		end

	update_index_of_first_item_dirty_row_flags (a_index: INTEGER) is
			-- Update the `index_of_first_item_dirty' flags for each row in the list.
		require
			a_index_valid: a_index > 0 and then a_index <= column_count + 1
		local
			i: INTEGER
			a_row_count: INTEGER
			row_i: EV_GRID_ROW_I
		do
			from
				i := 1
				a_row_count := row_count
			until
				i > a_row_count
			loop
				row_i := rows @ i
				if row_i /= Void then
					row_i.flag_index_of_first_item_dirty_if_needed (a_index)
				end
				i := i + 1
			end			
		end

	update_grid_row_indices (a_index: INTEGER) is
			-- Recalculate subsequent row indexes starting from `a_index'.
		require
			valid_index: a_index > 0 and then a_index <= row_count + 1
		local
			i, a_row_count: INTEGER
			row_i: EV_GRID_ROW_I
			temp_rows: like rows
		do
				-- Set subsequent indexes to their new values
			temp_rows := rows
			from
				i := a_index
				a_row_count := temp_rows.count
			until
				i > a_row_count
			loop
				row_i := temp_rows @ i
				if row_i /= Void then
					row_i.set_index (i)
				end
				i := i + 1
			end
		end

	update_grid_column_indices (a_index: INTEGER) is
			-- Recalculate subsequent column indexes starting from `a_index'.
		require
			valid_index: a_index > 0 and then a_index <= column_count + 1
		local
			i, a_column_count: INTEGER
			column_i: EV_GRID_COLUMN_I
			temp_columns: like columns
		do
				-- Set subsequent indexes to their new values
			temp_columns := columns
			from
				i := a_index
				a_column_count := temp_columns.count
			until
				i > a_column_count
			loop
				column_i := temp_columns @ i
				if column_i /= Void then
					column_i.set_index (i)
				end
				i := i + 1
			end
		end

	resize_row_lists (new_count: INTEGER) is
			-- Resize the row lists so count equals `new_count'.
		require
			valid_new_count: new_count >= 0
		do
			internal_row_data.resize (new_count)
			rows.resize (new_count)
		ensure
			rows_count_resized: rows.count = new_count
			internal_row_data_count_resized: internal_row_data.count = new_count
			counts_equal: rows.count = internal_row_data.count
		end
		
	maximum_header_width: INTEGER is 10000
		-- Maximium width of `header'.
		
	default_scroll_bar_leap: INTEGER is 1

	enlarge_row (a_index, new_count: INTEGER) is
			-- Enlarge the row at index `a_index' to `new_count'.
		require
			row_exists: internal_row_data @ (a_index) /= Void
			row_can_expand: (internal_row_data @ (a_index)).count < new_count
		local
			a_row: SPECIAL [EV_GRID_ITEM_I]
		do
			a_row := internal_row_data @ a_index
			a_row := a_row.aliased_resized_area (new_count)
			internal_row_data.put_i_th (a_row, a_index)
		end

	physical_column_indexes_dirty: BOOLEAN
		-- Does `physical_column_indexes' need recalculating?

	physical_column_indexes_internal: SPECIAL [INTEGER]
		-- Internal storage for `physical_column_indexes' to avoid unnecessary recalculation on each query.

	default_row_height: INTEGER is
			-- Default height of a row, based on the height of the default font.
		once
			Result := (create {EV_LABEL}).minimum_height
			if (create {PLATFORM}).is_windows then
				Result := Result + 3
			else
					-- This matches the gtk default row height used for all GtkTreeView variants.
				Result := Result + 6
			end
		ensure
			result_positive: result > 0
		end

feature {EV_GRID_ROW_I, EV_GRID_ITEM_I} -- Implementation

	internal_selected_rows: HASH_TABLE [EV_GRID_ROW, EV_GRID_ROW_I]
		-- Hash table of selected rows.

	internal_selected_items: HASH_TABLE [EV_GRID_ITEM, EV_GRID_ITEM_I]
		-- Hash table of selected items.

feature {EV_GRID_ROW_I} -- Implementation

	add_row_to_selected_rows (a_row: EV_GRID_ROW_I) is
			-- Add `a_row' to `internal_selected_rows'.
		require
			a_row_not_void: a_row /= Void
			not_has_a_row: not internal_selected_rows.has (a_row)
			row_selected: a_row.internal_is_selected
		do
			internal_selected_rows.put (a_row.interface, a_row)
			last_selected_row := a_row
		ensure
			row_added: internal_selected_rows.has (a_row)
		end

	last_selected_row: EV_GRID_ROW_I
		-- Row that was selected previously.

	remove_row_from_selected_rows (a_row: EV_GRID_ROW_I) is
			-- Remove`a_row' from `internal_selected_rows'.
		require
			a_row_not_void: a_row /= Void
			has_a_row: internal_selected_rows.has (a_row)
			row_deselected: not a_row.internal_is_selected
		do
			internal_selected_rows.remove (a_row)
			if a_row = last_selected_row then
				last_selected_row := Void
			end
		ensure
			row_removed: not internal_selected_rows.has (a_row)
		end

feature {EV_GRID_ITEM_I} -- Implementation

	add_item_to_selected_items (a_item: EV_GRID_ITEM_I) is
			-- Add `a_item' to `internal_selected_items'.
		require
			a_item_not_void: a_item /= Void
			not_has_a_item: not internal_selected_items.has (a_item)
			item_selected: a_item.internal_is_selected
		do
			internal_selected_items.put (a_item.interface, a_item)
			last_selected_item := a_item
		ensure
			item_added: internal_selected_items.has (a_item)
		end

	last_selected_item: EV_GRID_ITEM_I
		-- Item that was previously selected by the user, used from Ctrl-Shift selection handling.

	remove_item_from_selected_items (a_item: EV_GRID_ITEM_I) is
			-- Remove`a_item' from `internal_selected_items'.
		require
			a_item_not_void: a_item /= Void
			has_a_item: internal_selected_items.has (a_item)
			item_deselected: not a_item.internal_is_selected
		do
			internal_selected_items.remove (a_item)
			if a_item = last_selected_item then
				last_selected_item := Void
			end
		ensure
			item_removed: not internal_selected_items.has (a_item)
		end
		
	string_size (s: STRING; f: EV_FONT; tuple: TUPLE [INTEGER, INTEGER]) is
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		require
			s_not_void: s /= Void
			f_not_void: f /= Void
		deferred
		end

feature {EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_ITEM_I, EV_GRID_DRAWER_I} -- Implementation

	internal_set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set grid item at position (`a_column', `a_row') to `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		local
			a_grid_col_i: EV_GRID_COLUMN_I
			a_grid_row_i: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
			a_existing_item: EV_GRID_ITEM_I
			column_physical_index: INTEGER
			item_implementation: EV_GRID_ITEM_I
			grid_row_parent_i: EV_GRID_ROW_I
		do
			if a_column > columns.count then
					-- Create new columns needed.
				set_column_count_to (a_column)
			end
			a_grid_col_i := columns @ (a_column)
			column_physical_index := a_grid_col_i.physical_index

			if a_row > row_count then
					-- Create new rows needed.
				set_row_count_to (a_row)
			end
			a_grid_row_i := row_internal (a_row)
			a_row_data := internal_row_data @ a_row
			
			if a_row_data.count < column_physical_index + 1 then
				enlarge_row (a_row, column_physical_index + 1)
			else
					-- There is an item already present, if non void then mark it as removed from grid
				a_existing_item := a_row_data @ column_physical_index
				if a_existing_item /= Void then
					a_existing_item.disable_select_internal
					a_existing_item.update_for_removal
				end
			end

			if a_item /= Void then
				item_implementation := a_item.implementation
				item_implementation.set_parents (Current, a_grid_col_i, a_grid_row_i, item_counter)
					-- Increase item counter
				item_counter := item_counter + 1
				internal_row_data.i_th (a_row).put (item_implementation, column_physical_index)
				a_grid_row_i.flag_index_of_first_item_dirty_if_needed (a_column)
				grid_row_parent_i := a_grid_row_i.parent_row_i
				if grid_row_parent_i /= Void then
						-- The row in which we are setting an item is already a subrow of another
						-- row, so we must update the internal settings for the tree.
					a_grid_row_i.update_depths_in_tree
				end
				redraw_item (item_implementation)
			else
					-- Set `last_pointed_item' to `Void' if it is being removed from `Current'
					-- to prevent memory leaks.
				if last_pointed_item /= Void and then last_pointed_item = item_internal (a_column, a_row) then
					last_pointed_item := Void
				end
				internal_row_data.i_th (a_row).put (Void, column_physical_index)
				a_grid_row_i.flag_index_of_first_item_dirty_if_needed (a_column)
					-- Update the row for the removal.
				a_grid_row_i.update_for_item_removal (a_column)
					-- We no longer have access to the item so we calculate the redraw area based on the rows and columns.
				drawable.redraw_rectangle (a_grid_col_i.virtual_x_position - (internal_client_x - viewport_x_offset), a_grid_row_i.virtual_y_position - (internal_client_y - viewport_y_offset), a_grid_col_i.width, a_grid_row_i.height)
			end

			fixme (Once "EV_GRID_I.internal_set_item Adding or removing items may require the complete row to be redrawn if the row is a subrow.")
		end

	item_counter: INTEGER
		-- Item counter used to identify individual items for hashing.

	row_counter: INTEGER
		-- Row counter used to identify individual rows for hashing.

	item_internal (a_column: INTEGER; a_row: INTEGER): EV_GRID_ITEM_I is
			-- Cell at `a_row' and `a_column' position.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			grid_row_i: EV_GRID_ROW_I
			row_data: SPECIAL [EV_GRID_ITEM_I]
			a_grid_column_i: EV_GRID_COLUMN_I
			col_index: INTEGER
		do
				-- Retrieve column from grid
			a_grid_column_i := columns @ (a_column)
			col_index := a_grid_column_i.physical_index
			
				-- Retrieve row to ensure that the row exists.
			grid_row_i := row_internal (a_row)

				-- Gain access to the internal row data
				-- for retrieval of item.
			row_data :=  internal_row_data @ a_row

				-- `row_data' may not have a count less than
				-- `column_count' if items are Void in this row.
			if col_index < row_data.count then
				Result := row_data @ (col_index)
			end
		end

feature {EV_ANY_I, EV_GRID_ROW, EV_GRID_COLUMN, EV_GRID} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	drawer_not_void: is_initialized implies drawer /= Void
	drawable_not_void: is_initialized implies drawable /= Void
	header_positioned_corrently: is_initialized implies header_viewport.x_offset >= 0 and header_viewport.y_offset = 0
	internal_client_y_valid_while_vertical_scrollbar_hidden: is_initialized and then not vertical_scroll_bar.is_show_requested implies internal_client_y = 0
	internal_client_y_valid_while_vertical_scrollbar_shown: is_initialized and then vertical_scroll_bar.is_show_requested implies internal_client_y >= 0
	internal_client_x_valid_while_horizontal_scrollbar_hidden: is_initialized and then not horizontal_scroll_bar.is_show_requested implies internal_client_x = 0
	internal_client_x_valid_while_horizontal_scrollbar_shown: is_initialized and then horizontal_scroll_bar.is_show_requested implies internal_client_x >= 0
	row_heights_fixed_implies_row_offsets_void: is_row_height_fixed and not is_tree_enabled implies row_offsets = Void
	row_lists_count_equal: is_initialized implies internal_row_data.count = rows.count
	dynamic_modes_mutually_exclusive: not (is_content_completely_dynamic and is_content_partially_dynamic)
	visible_column_count_not_greater_than_column_count: is_initialized implies visible_column_count <= column_count
	hidden_node_count_zero_when_tree_disabled: not is_tree_enabled implies hidden_node_count = 0
	hidden_node_count_positive_when_tree_enabled: is_tree_enabled implies hidden_node_count >= 0
	hidden_node_count_no_greated_than_rows_less_one: is_initialized and then is_tree_enabled and row_count > 0 implies hidden_node_count <= row_count - 1
	tree_disabled_implies_visible_rows_equal_hidden_rows: is_initialized and then not is_tree_enabled implies row_count = visible_row_count
	internal_viewport_positions_equal_to_viewports: is_initialized implies (viewport.x_offset = viewport_x_offset and viewport.y_offset = viewport_y_offset)
	tree_node_connector_color_not_void: is_initialized implies tree_node_connector_color /= Void
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

