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
			item as cell_item,
			pointer_motion_actions as cell_pointer_motion_actions,
			pointer_motion_actions_internal as cell_pointer_motion_actions_internal,
			pointer_double_press_actions as cell_pointer_double_press_actions,
			pointer_double_press_actions_internal as cell_pointer_double_press_actions_internal,
			pointer_enter_actions as cell_pointer_enter_actions,
			pointer_button_press_actions as cell_pointer_button_press_actions,
			pointer_button_release_actions as cell_pointer_button_release_actions,
			pointer_leave_actions as cell_pointer_leave_actions,
			pointer_enter_actions_internal as cell_pointer_enter_actions_internal,
			pointer_button_press_actions_internal as cell_pointer_button_press_actions_internal,
			pointer_button_release_actions_internal as cell_pointer_button_release_actions_internal,
			pointer_leave_actions_internal as cell_pointer_leave_actions_internal
		redefine
			interface
		end

	EV_GRID_ACTION_SEQUENCES_I
	
	REFACTORING_HELPER

feature -- Access

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row'.
		require
			a_row_positive: a_row > 0
		do
			Result := row_internal (a_row).interface
		ensure
			row_not_void: Result /= Void
			row_count_enlarged_if_needed: a_row > old row_count implies row_count = a_row
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'.
		require
			a_column_positive: a_column > 0
		do
			Result := column_internal (a_column).interface
		ensure
			column_not_void: Result /= Void
			column_count_enlarged_if_needed: a_column > old column_count implies column_count = a_column
		end

	visible_column (i: INTEGER): EV_GRID_COLUMN is
			-- `i'-th visible column.
		require
			i_positive: i > 0
			i_column_not_greater_than_visible_column_count: i <= visible_column_count
		local
			a_col_i: EV_GRID_COLUMN_I
			visible_counter, counter: INTEGER
		do
			from
				counter := 1
			until
				visible_counter = i
			loop
				a_col_i := column_internal (counter)
				if a_col_i.is_visible then
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
		do
			from
				create Result.make (0)
				temp_columns := columns
				temp_columns.start
			until
				temp_columns.after
			loop
				if temp_columns.item.is_selected then
					Result.extend (temp_columns.item.interface)
				end
				temp_columns.forth
			end
			to_implement ("EV_GRID_I:selected_columns")
		ensure
			result_not_void: Result /= Void
		end
		
	selected_rows: ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows selected in `Current'.
		do
			Result := internal_selected_rows.twin
		ensure
			result_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		local
			i: INTEGER
			sel_rows: like selected_rows
		do
			if is_single_row_selection_enabled or else is_multiple_row_selection_enabled then
				create Result.make (0)
				from
					sel_rows := selected_rows
					i := 1
				until
					i > sel_rows.count
				loop
					Result.append (sel_rows.i_th (i).selected_items)
					i := i + 1
				end
			else
				Result := internal_selected_items.twin
			end
		ensure
			result_not_void: Result /= Void
		end

	remove_selection is
			-- Ensure that `selected_rows' and `selected_items' are empty.
		local
			sel_rows: like selected_rows
			sel_items: like selected_items
			sel_columns: like selected_columns
		do
			if is_single_item_selection_enabled or else is_multiple_item_selection_enabled then
					sel_items := internal_selected_items
					from
						sel_items.start
					until
						sel_items.after
					loop
						sel_items.item.implementation.disable_select_internal
						sel_items.remove
					end				
			end
			sel_rows := internal_selected_rows
			from
				sel_rows.start
			until
				sel_rows.after
			loop
				sel_rows.item.implementation.disable_select_internal
				sel_rows.remove
			end

			sel_columns := selected_columns
			from
				sel_columns.start
			until
				sel_columns.after
			loop
				sel_columns.item.disable_select
				sel_columns.remove
			end
			fixme ("Remove this full redraw and only redraw those items that have actually changed.")
			--redraw_client_area
		ensure
			selected_items_empty: selected_items.is_empty
			selected_rows_empty: selected_rows.is_empty
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
			valid_result: Result >= 0 and Result <= virtual_width - viewable_width
		end
		
	virtual_y_position: INTEGER is
			-- Vertical offset of viewable area in relation to the top edge of
			-- the virtual area in pixels.
		do
			Result := internal_client_y
		ensure
			valid_result: Result >= 0 and Result <= virtual_height - viewable_height
		end
		
	virtual_width: INTEGER is
			-- Width of virtual area in pixels.
		do
			Result := total_header_width.max (viewable_width)
		ensure
			result_greater_or_equal_to_viewable_width: Result >= viewable_width
		end
		
	virtual_height: INTEGER is
			-- Height of virtual area in pixels.
		local
			final_row_height: INTEGER
		do
			perform_vertical_computation
			if is_vertical_scrolling_per_item then
				if rows.is_empty then
					Result := viewable_height
				else
					if is_row_height_fixed then
						final_row_height := row_height
					else
						final_row_height := rows.i_th (rows.count).height
					end
					Result := total_row_height + viewable_height - final_row_height
				end
			else
				Result := total_row_height
			end
			Result := Result.max (viewable_height)
		ensure
			result_greater_or_equal_to_viewable_height: Result >= viewable_height
		end
		
	viewable_width: INTEGER is
			-- Width of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars.
		do
			Result := viewport.width
		ensure
			viewable_width_valid: viewable_width >= 0 and viewable_width <= width
		end
		
	viewable_height: INTEGER is
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
		do
			Result := viewport.height
		ensure
			viewable_height_valid: viewable_height >= 0 and viewable_height <= height
		end
		
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
			Result := header.height
		ensure
			viewable_y_offset_valid: Result >=0 and Result <= height
		end

feature -- Status setting

	activate_window: EV_WINDOW
		-- Window used to edit grid item contents on `activate'.

	currently_active_item: EV_GRID_ITEM
		-- Item that is currently active.

	activate_item (a_item: EV_GRID_ITEM) is
			-- Setup `a_item' for user interactive editing.
		require
			a_item_not_void: a_item /= Void
		local
			x_coord, y_coord: INTEGER
		do
			if currently_active_item /= Void then
					-- If an item is currently active then deactivate it
				deactivate_item (currently_active_item)
			end
			currently_active_item := a_item
			create activate_window
			x_coord := screen_x - virtual_x_position + a_item.virtual_x_position
			y_coord := screen_y - virtual_y_position + a_item.virtual_y_position + viewable_y_offset
			activate_window.set_position (x_coord, y_coord)

			activate_window.set_minimum_size (a_item.column.width -  a_item.horizontal_indent, a_item.row.height)

				-- Prevent the popup window from being resized
			activate_window.disable_user_resize
			
			if active_item_setup_actions_internal /= Void and then not active_item_setup_actions_internal.is_empty then
					-- The user has requested to setup all activatable items themselves
				active_item_setup_actions_internal.call ([a_item, activate_window])
			else
					-- If the active setup action sequence is empty then we call setup on the item itself
				a_item.activate_action (activate_window)
			end
		end

	deactivate_item (a_item: EV_GRID_ITEM) is
			-- Cleanup from previous call to `activate'
		require
			a_item_not_void: a_item /= Void
		do
			if activate_window /= Void and then not activate_window.is_destroyed then
				activate_window.destroy				
			end
			if item_deactivate_actions_internal /= Void then
				item_deactivate_actions_internal.call ([a_item])
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
		do
			is_tree_enabled := True
				
			if row_count > 0 then
					-- The row offsets must always be computed when
					-- in tree mode so when enabling it, recompute unless
					-- there are no rows contained.
				set_vertical_computation_required (1)
			end
		ensure
			tree_enabled: is_tree_enabled
		end	
		
	disable_tree is
			-- Disable tree functionality for `Current'.
		do
			is_tree_enabled := False
			adjust_hidden_node_count (- hidden_node_count)
			set_vertical_computation_required (1)
			redraw_client_area
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
			a_col_i := column_internal (a_column)
			if not a_col_i.is_visible then
				a_col_i.set_is_visible (True)
				visible_column_count := visible_column_count + 1

					-- Now show the header.
				header.go_i_th (previous_visible_column_from_index (a_col_i.index))
				header.put_right (a_col_i.header_item)
				
				recompute_column_offsets
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
			a_col_i := column_internal (a_column)
			if a_col_i.is_visible then
				a_col_i.set_is_visible (False)
				visible_column_count := visible_column_count - 1
			
					-- Now hide the header
				header.prune_all (a_col_i.header_item)
			
				recompute_column_offsets
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
			column_internal (a_column).enable_select
		ensure
			column_selected: column (a_column).is_selected
		end
		
	select_row (a_row: INTEGER) is
			-- Ensure all items in `a_row' are selected.
		require
			a_row_within_bounds: a_row > 0 and a_row <= row_count
			column_displayed: column_displayed (a_row)
		do
			row_internal (a_row).enable_select
		ensure
			row_selected: row (a_row).is_selected
		end
		
	enable_single_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row,
			-- unselecting any previous rows.
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
			-- Set user selection mode so that clicking an item selects the whole row.
			-- Multiple rows may be selected.
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
			-- Set user selection mode so that clicking an item selects the item,
			-- unselecting any previous items.
		local
			sel_items: like selected_items
		do
				-- Store the existing selected items if any so that the selection state may be partially restored
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
			-- Set user selection mode so that clicking an item selects the item.
			-- Multiple items may be selected.
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
		do
			to_implement ("EV_GRID_I.set_first_visible_row")
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
		
	set_row_height (a_row_height: INTEGER) is
			-- Set height of all rows within `Current' to `a_row_height
			-- If not `is_row_height_fixed' then set the height individually per row instead.
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
				fixme ("Remove following line when tested as it should not be required")
--				recompute_vertical_scroll_bar
				is_item_height_changing := False
				set_vertical_computation_required (1)
				redraw_client_area
			end
			
		ensure
			row_height_set: row_height = a_row_height
		end
		
	enable_complete_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions'. Contents are requested each time they
			-- are displayed even if already contained in `Current'.
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
		do
			is_row_height_fixed := False
			set_vertical_computation_required (1)
			redraw_client_area
		end
		
	set_column_count_to (a_column_count: INTEGER) is
			-- Resize `Current' to have `a_column_count' columns.
		require
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_column_count_positive: a_column_count >= 1
		local
			add_columns: BOOLEAN
		do
			from
				add_columns := a_column_count > columns.count
			until
				columns.count = a_column_count
			loop
				if add_columns then
					add_column_at (columns.count + 1, True)
				else
					remove_column (columns.count)
				end
			end
			recompute_horizontal_scroll_bar
			redraw_client_area
		ensure
			column_count_set: column_count = a_column_count
		end
		
	set_row_count_to (a_row_count: INTEGER) is
			-- Resize `Current' to have `a_row_count' columns.
		require
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
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
			virtual_x_valid: virtual_x >= 0 and virtual_x <= virtual_width - viewable_width
			virtual_y_valid: virtual_y >= 0 and virtual_y <= virtual_height - viewable_height
		local
			row_index: INTEGER
			visible_row_index: INTEGER
			items: ARRAYED_LIST [INTEGER]
		do
			perform_vertical_computation
			internal_set_virtual_y_position (virtual_y)
			internal_set_virtual_x_position (virtual_x)
			if is_vertical_scrolling_per_item then
				vertical_scroll_bar.change_actions.block
				items := drawer.items_spanning_vertical_span (viewport_y_offset, viewable_height)
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
				fixme ("Implement")
			else
				horizontal_scroll_bar.change_actions.block
				horizontal_scroll_bar.set_value (virtual_x)
				horizontal_scroll_bar.change_actions.resume
			end
--			set_vertical_computation_required
		ensure
			virtual_position_set: virtual_x_position = virtual_x and virtual_y_position = virtual_y
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
			a_col_i := column (a_column).implementation
			Result := a_col_i.is_visible
		end
		
	is_single_row_selection_enabled: BOOLEAN
			-- Does clicking an item select the whole row, unselecting
			-- any previous rows?

	is_multiple_row_selection_enabled: BOOLEAN
			-- Does clicking an item select the whole row, with multiple
			-- row selection permitted?
		
	is_single_item_selection_enabled: BOOLEAN
			-- Does clicking an item select the item, unselecting
			-- any previous items?

	is_multiple_item_selection_enabled: BOOLEAN
			-- Does clicking an item select the item, with multiple
			-- item selection permitted?
		
	first_visible_row: INTEGER is
			-- Index of first row visible in `Current' or 0 if `row_count' = 0.
		do
			to_implement ("EV_GRID_I.first_visible_row")
		ensure
			not_empty_implies_result_positive: row_count > 0 implies result > 0
			empty_implies_result_zero: row_count = 0 implies result = 0
		end

feature -- Element change

	insert_new_row (a_index: INTEGER) is
			-- Insert a new row at index `a_index'.
		require
			i_positive: a_index > 0
		do
			add_row_at (a_index, False)
		ensure
			row_count_set: (a_index <= old row_count implies (row_count = old row_count + 1)) or a_index = row_count
		end

	insert_new_row_parented (i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert `a_row' between rows `i' and `i+1'.
		require
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
			a_parent_row_not_void: a_parent_row /= Void
		do
			insert_new_row (i)
			a_parent_row.add_subrow (row (i))
		ensure
			row_count_set: row_count = old row_count + 1
			subrow_count_set: a_parent_row.subrow_count = old a_parent_row.subrow_count + 1
		end

	insert_new_column (a_index: INTEGER) is
			-- Insert a new column at index `a_index'.
		require
			i_positive: a_index > 0
		local
			a_column: EV_GRID_COLUMN_I
		do
			if a_index > column_count then
					-- If `a_index' is greater than existing count than we just query the column
				a_column := column_internal (a_index)
			else
				add_column_at (a_index, False)
			end
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_row_count: i <= row_count
			j_less_than_row_count: j <= row_count
		local
			a_row: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
				--Retrieve row at position `i' and remove from list
			a_row := row_internal (i)
			rows.go_i_th (i)
			rows.remove
			
				-- Insert retrieved row at position `j'
			rows.go_i_th (j)
			rows.put_left (a_row)
			
			internal_row_data.go_i_th (i)
			a_row_data := internal_row_data.item
			internal_row_data.remove
			
			internal_row_data.go_i_th (j)
			internal_row_data.put_left (a_row_data)
			
			update_grid_row_indices (i.min (j))
			
			redraw_client_area

			fixme ("EV_GRID_I: move_row redraw")
		ensure
			moved: row (j) = old row (i) and then (i /= j implies row (j) /= row (i))
		end

	move_column (i, j: INTEGER) is
			-- Move row at index `i' to index `j'.
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_column_count: i <= column_count
			j_less_than_column_count: j <= column_count
		local
			a_col: EV_GRID_COLUMN_I
			header_item: EV_HEADER_ITEM
		do
				--Retrieve column at position `i' and remove from list
			a_col := column_internal (i)
			columns.go_i_th (i)
			columns.remove
			
				-- Insert retrieved column at position `j'
			columns.go_i_th (j)
			columns.put_left (a_col)

			update_grid_column_indices (i.min (j))
			
			recompute_column_offsets
			redraw_client_area
			
				-- Now actually move the header items.
			header.go_i_th (i)
			header_item := header.item
			header.remove
			header.go_i_th (j)
			header.put_left (header_item)
		ensure
			moved: column (j) = old column (i) and then (i /= j implies column (j) /= column (i))
		end

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Replace grid item at position (`a_column', `a_row') with `a_item'.
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_void: a_item /= Void
		do
			internal_set_item (a_column, a_row, a_item)
		ensure
			inserted: item (a_column, a_row) = a_item
		end

	remove_item (a_column, a_row: INTEGER) is
			-- Remove grid item at position (`a_column', `a_row').
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
		do
			internal_set_item (a_column, a_row, Void)
		ensure
			item_removed: item (a_column, a_row) = Void
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
			a_physical_index: INTEGER
		do
			a_col_i := column_internal (a_column)
			a_physical_index := a_col_i.physical_index
			
				-- Remove association of column with `Current'
			a_col_i.remove_parent_i
			
			columns.go_i_th (a_column)
			columns.remove

			update_grid_column_indices (a_column)
			
			if a_col_i.is_visible then
				visible_column_count := visible_column_count - 1
			end
			
			to_implement ("EV_GRID_I:remove_column removal of header, redraw and blanking of items")
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		local
			a_row_i, removed_row: EV_GRID_ROW_I
		do
				-- Retrieve row from the grid
			a_row_i := row_internal (a_row)
			
				-- Remove row and its corresponding data from `rows' and `internal_row_data'
			rows.go_i_th (a_row)
			removed_row := rows.item
			if removed_row /= Void then
				removed_row.remove_parent_i
			end
			rows.remove
			
			internal_row_data.go_i_th (a_row)
			internal_row_data.remove
			
			update_grid_row_indices (a_row)

			to_implement ("EV_GRID_I.remove_row redraw plus subnode removal handling")
		ensure
			row_count_updated: row_count = old row_count - 1
			old_row_removed: (old row (a_row)).parent = Void
		end

feature -- Measurements

	visible_column_count: INTEGER
			-- Number of visible columns in Current.

	column_count: INTEGER is
			-- Number of columns in Current.
		do
			if columns /= Void then
				Result := columns.count
			end
		end

	row_count: INTEGER is
			-- Number of rows in Current.
		do
			if internal_row_data /= Void then
				Result := internal_row_data.count
			end
		end
		
	visible_row_count: INTEGER is
			-- Number of visible rows in `Current'. When `is_tree_enabled',
			-- a number of rows may be within a collapsed parent row, so these
			-- are ignored
		do
			Result := row_count - hidden_node_count
		end

feature {NONE} -- Implementation

	internal_row_data: EV_GRID_ARRAYED_LIST [SPECIAL [EV_GRID_ITEM_I]]
		-- Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `visible_physical_column_indexes'

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_ITEM_I} -- Implementation

	row_list: SPECIAL [SPECIAL [EV_GRID_ITEM_I]] is
		-- Memory Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `visible_physical_column_indexes'
		do
			fixme ("Remove me and have `area' called directly from grid drawer ")
			Result := internal_row_data.area
		end

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
			col_count := column_count
			create Result.make (col_count)
			from
				i := 1
			until
				i > col_count
			loop
				a_col := column_internal (i)
				Result.put (a_col.physical_index, i - 1)
						-- SPECIAL is zero based
				i := i + 1
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
			a_column: EV_GRID_COLUMN
		do
			from
				i := a_index - 1
			until
				found or else i = 0
			loop
				a_column := column (i)
				found := a_column.implementation.is_visible
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
		
	invalid_row_index: INTEGER
		-- Index of invalid row from which vertical row computation
		-- must begin. This is used by `perform_vertical_computation' to ensure
		-- that we only recompute those rows that are strictly necessary.
		
	set_vertical_computation_required (an_invalid_row_index: INTEGER) is
			-- Assign `True' to `vertical_computation_required'.
		require
			valid_row_index: an_invalid_row_index >= 1 and an_invalid_row_index <= row_count
		do
			vertical_computation_required := True
			invalid_row_index := invalid_row_index.min (an_invalid_row_index)
		ensure
			vertical_computation_required: vertical_computation_required
			invalid_row_index_set: invalid_row_index = invalid_row_index.min (old invalid_row_index)
		end
		
	perform_vertical_computation is
			-- Re-compute vertical row offsets and other such values
			-- required before drawing may be performed, only if required.
		do
			if vertical_computation_required then
				vertical_computation_required := False
				if row_count > 0 then
						-- Do nothing if `Current' is empty.
					recompute_row_offsets (invalid_row_index)
						-- Restore to an arbitarily large index.
					invalid_row_index := invalid_row_index.max_value;
					((create {EV_ENVIRONMENT}).application).do_once_on_idle (agent recompute_vertical_scroll_bar)
				end
			end
		ensure
			vertical_computation_not_required: not vertical_computation_required
		end

	recompute_row_offsets (an_index: INTEGER) is
			-- Recompute contents of `row_offsets' from row index
			-- `an_index' to `row_count'.
		require
			an_index_valid: an_index >= 0 and an_index <= row_count
			pop: rows.count >= an_index
		local
			i, j, k: INTEGER
			current_item: EV_GRID_ROW_I
			old_i: INTEGER
			internal_index: INTEGER
			visible_count: INTEGER
			row_index: INTEGER
			l_row_count: INTEGER
			l_parent_row_i: EV_GRID_ROW_I
		do			
			if not is_tree_enabled then
				internal_index := an_index
			else
				fixme ("[
					We always recompute from the first item for now as otherwise we must ensure that we find the top level
					tree node that is the first expanded if the row is current hidden and start from there
				]")
				from
					l_parent_row_i := row_internal (an_index)
				until
					l_parent_row_i.parent_row_i = Void
				loop
					l_parent_row_i := l_parent_row_i.parent_row_i
				end
				internal_index := l_parent_row_i.index
				internal_index := 1
			end
			if not is_row_height_fixed or is_tree_enabled then
					-- Only perform recomputation if the rows do not all have the same height
					-- or there is tree functionality enabled. Otherwise, we do not need to
					-- use `row_offsets' and we can perform a shortcut.
				if row_offsets = Void then
					create row_offsets.make
					create row_indexes_to_visible_indexes.make
					create visible_indexes_to_row_indexes.make
					row_offsets.extend (0)
					rows.start
				else
					i := row_offsets @ (internal_index)
					rows.go_i_th (internal_index)
					row_indexes_to_visible_indexes.go_i_th (internal_index)
					visible_indexes_to_row_indexes.go_i_th (internal_index)
				end
				
				if row_offsets.count < rows.count + 1 then
					row_offsets.resize (rows.count + 1)
					row_indexes_to_visible_indexes.resize (rows.count + 1)
					visible_indexes_to_row_indexes.resize (rows.count + 1)
				end
				from
					row_index := internal_index
					l_row_count := rows.count
				until
					row_index > l_row_count
				loop
					current_item := rows.i_th (row_index)
					old_i := i
					if current_item /= Void and not is_row_height_fixed then
						i := i + current_item.height
					else
							-- Use the default height here.
						i := i + row_height
					end
					if current_item.subrow_count > 0 and not current_item.is_expanded then
						from
							j := row_index + 1
							k := j + current_item.subnode_count_recursive
						until
							j = k
						loop
							row_offsets.put_i_th (old_i, j)
							j := j + 1
						end
						row_indexes_to_visible_indexes.put_i_th (visible_count, row_index)
						row_index := (k - 1)
						i := old_i
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
			
		ensure
			offsets_consistent_when_not_fixed: not is_row_height_fixed implies row_offsets.count = rows.count + 1
		end
		
	total_row_height: INTEGER is
			-- `Result' is total height of all rows contained in `Current'.
		do
			if is_row_height_fixed and not is_tree_enabled then
				Result := row_count * row_height
			else
				Result := row_offsets.last
			end
		ensure
			result_positive: result >= 0
		end
		
	redraw_item (an_item: EV_GRID_ITEM_I) is
			-- Redraw area of `an_item' if visible.
		require
			an_item_not_void: an_item /= Void
		local
			a1, a2: INTEGER
		do
			fixme ("Do we need to check if item is visible? There may be no effect to simply invalidate the area...")
			a1 := an_item.virtual_x_position - (internal_client_x - viewport_x_offset)
			a2 := an_item.virtual_y_position - (internal_client_y - viewport_y_offset)
			drawable.redraw_rectangle (a1, a2, an_item.column.width, an_item.row.height)
		end

	redraw_client_area is
			-- Redraw complete visible client area of `Current'.
		do
			drawable.redraw
		end
		
	item_indent (an_item: EV_GRID_ITEM_I): INTEGER is
			-- `Result' is indent of `an_item' in pixels.
			-- May be 0 for items that are not tree nodes.
		require
			an_item_not_void: an_item /= Void
			an_item_parented_in_current: an_item.parent_i = Current
		local
			a_subrow_indent: INTEGER
			first_tree_node_indent: INTEGER
			node_pixmap_width: INTEGER
			total_tree_node_width: INTEGER
			node_index: INTEGER
			pointed_row_i: EV_GRID_ROW_I
		do
			pointed_row_i := an_item.row_i
			node_pixmap_width := expand_node_pixmap.width
			total_tree_node_width := node_pixmap_width + 2 * tree_node_spacing
			a_subrow_indent := (tree_node_spacing * 2) + node_pixmap_width + subrow_indent
			first_tree_node_indent := total_tree_node_width + 2 * tree_node_spacing
			node_index := an_item.column_i.index.min (pointed_row_i.index_of_first_item)
			if node_index = an_item.column_i.index then
				Result := a_subrow_indent * (pointed_row_i.indent_depth_in_tree - 1) + first_tree_node_indent
				if pointed_row_i.subrow_count = 0 then
						-- If the item's row has no subrows then
						-- reduce `Result' to account for this.
					Result := Result - a_subrow_indent
					if pointed_row_i.parent_row_i /= Void and then pointed_row_i.index_of_first_item /= pointed_row_i.parent_row_i.index_of_first_item then
						Result := 0
					end
				end
			end
			if pointed_row_i.parent_row_i = Void then
				if is_tree_enabled and an_item.column.index = 1 then
					Result := first_tree_node_indent
				else
					Result := 0
				end
			end
			
				-- Not a postcondition as `node_index' is a local.
			check
				result_zero_when_item_not_in_subrow_or_first: an_item.row_i.parent_row_i = Void and node_index > pointed_row_i.index_of_first_item implies Result = 0
				result_positive_when_in_subrow: an_item.row_i.parent_row_i /= Void implies Result >= 0
				result_zero_when_node_index_differs_from_parent: an_item.row_i.parent_row_i /= Void and an_item.row_i.index_of_first_item /= an_item.row_i.parent_row_i.index_of_first_item and an_item.row_i.subrow_count = 0 implies Result = 0
			end
		end

feature {EV_GRID_DRAWER_I, EV_GRID_COLUMN_I, EV_GRID_ROW_I, EV_GRID_ITEM_I, EV_GRID} -- Implementation

	column_offsets: ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each column in pixels.
		-- For example, if there are 5 columns, each with a width of 80 pixels,
		-- `column_offsets' contains 0, 80, 160, 240, 320, 400 (Note this is 6 items).
		
	row_offsets: EV_GRID_ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each row in pixels.
		-- For example, if there are 5 rows, each with a height of 16 pixels,
		-- `row_offsets' contains 0, 16, 32, 48, 64, 80 (Note this is 6 items)
		-- For non-expanded tree node rows (which are therefore hidden), the offset is the same as the parent offset.
		
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
			
	internal_client_width: INTEGER
		-- Width of client area in which items are displayed.
		
	internal_client_height: INTEGER
		-- Height of client area in which items are displayed.
		
	viewport_x_offset: INTEGER
		-- `x_offset' of `viewport', used to prevent the need to always query the viewport.
	
	viewport_y_offset: INTEGER
		-- `x_offset' of `viewport', used to prevent the need to always query the viewport.
		
	viewport: EV_VIEWPORT
		-- Viewport containing `header' and `drawable', permitting the header to be offset
		-- correctly in relation to the horizontal scroll bar.
		-- Note that when querying the current position, use `viewport_x_offset' and `viewport_y_offset'
		-- for speed.
		
	header: EV_HEADER
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
			
	build_expand_node_pixmap is
			-- Construct the default `expand_node_pixmap'.
		local
			start_offset, end_offset, middle_offset: INTEGER
		do
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create expand_node_pixmap
			expand_node_pixmap.set_size (tree_node_button_dimension, tree_node_button_dimension)
			expand_node_pixmap.set_foreground_color (white)
			expand_node_pixmap.clear
			expand_node_pixmap.set_foreground_color (black)
			expand_node_pixmap.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			expand_node_pixmap.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
			expand_node_pixmap.draw_segment (middle_offset, start_offset, middle_offset, end_offset)
		ensure
			expand_node_pixmap_not_void: expand_node_pixmap /= Void
		end
		
	build_collapse_node_pixmap is
			-- Construct the default `collapse_node_pixmap'.
		local
			start_offset, end_offset, middle_offset: INTEGER
		once
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create collapse_node_pixmap
			collapse_node_pixmap.set_size (tree_node_button_dimension, tree_node_button_dimension)
			collapse_node_pixmap.set_foreground_color (white)
			collapse_node_pixmap.clear
			collapse_node_pixmap.set_foreground_color (black)
			collapse_node_pixmap.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			collapse_node_pixmap.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
		ensure
			collapse_node_pixmap_not_void: collapse_node_pixmap /= Void	
		end
		
	tree_node_button_dimension: INTEGER is 9	
		-- Dimension of the expand/collapse node used in the tree.
		
	white: EV_COLOR is
			-- Once access to the color white.
		do
			Result := (create {EV_STOCK_COLORS}).white
		end
		
	black: EV_COLOR is
			-- Once acces to the color black.
		do
			Result := (create {EV_STOCK_COLORS}).black
		end

feature {EV_GRID_ITEM_I} -- Implementation

	selection_color: EV_COLOR is
			-- Color used for selected items.
		once
			create Result.make_with_8_bit_rgb (0, 0, 128)
		end
		
feature {EV_GRID_ROW_I, EV_GRID_COLUMN_I} -- Implementation
	
	recompute_vertical_scroll_bar is
			-- Recompute dimensions of `vertical_scroll_bar'.
		local
			l_total_row_height: INTEGER
			l_client_height: INTEGER
			average_row_height: INTEGER
			previous_scroll_bar_value: INTEGER
		do
				-- Retrieve the final row offset as this is the virtual height required for all rows.
			if row_offsets = Void and not is_row_height_fixed then
				fixme ("Ensure that `row_offsets' does not need special `Void' handling.")
				l_total_row_height := 0
			else
				l_total_row_height := total_row_height
			end
			if l_total_row_height /= last_computed_row_height or has_vertical_scrolling_per_item_just_changed then
				l_client_height := viewport.height
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
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, visible_row_count - 1))
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
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, l_total_row_height - l_client_height))
						vertical_scroll_bar.set_leap (height)
						if has_vertical_scrolling_per_item_just_changed then
								-- If we are just switching from per item to per pixel vertical
								-- scrolling, we can set the position of the scroll bar exactly to match it's
								-- previous position.
							vertical_scroll_bar.set_value (row_offsets @ (previous_scroll_bar_value + 1))
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
			last_computed_row_height := l_total_row_height
		end
		
	recompute_horizontal_scroll_bar is
			-- Recompute horizontal scroll bar positioning.
		local
			l_total_header_width: INTEGER
			l_client_width: INTEGER
			average_column_width: INTEGER
			previous_scroll_bar_value: INTEGER
		do
				-- Retrieve the 
			l_total_header_width := total_header_width
			
			l_client_width := internal_client_width
				-- Note that `width' was not used as we want it to represent only the width of
				-- the "client area" which is `viewport'.
			
				
			if l_total_header_width > l_client_width then
					-- The headers are wider than the visible client area.
				if not horizontal_scroll_bar.is_show_requested then
						-- Show `horizontal_scroll_bar' if not already shown.
					horizontal_scroll_bar.show
					update_scroll_bar_spacer
				end
					-- Update the range and leap of `horizontal_scroll_bar' to reflect the relationship between
					-- `l_total_header_width' and `l_client_width'. Note that the behavior depends on the state of
					-- `is_horizontal_scrolling_per_item'.
				if has_horizontal_scrolling_per_item_just_changed then
					previous_scroll_bar_value := horizontal_scroll_bar.value
				end
				if is_horizontal_scrolling_per_item then					
					horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, column_count - 1))
					average_column_width := (l_total_header_width // column_count)
					horizontal_scroll_bar.set_leap (l_client_width // average_column_width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per pixel to per item horizontal
							-- scrolling, we must approximate the previous position of the scroll bar.
						horizontal_scroll_bar.set_value (previous_scroll_bar_value // average_column_width)
					end
				else
					horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, l_total_header_width - l_client_width))
					horizontal_scroll_bar.set_leap (width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per item to per pixel horizontal
							-- scrolling, we can set the position of the scroll bar exactly to match it's
							-- previous position.
						horizontal_scroll_bar.set_value (column_offsets @ (previous_scroll_bar_value + 1))
					end
				end
			else
					-- The headers are not as wide as the visible client area.
				if horizontal_scroll_bar.is_show_requested then
						-- Hide `horizontal_scroll_bar' as it is not required.
					horizontal_scroll_bar.hide
					update_scroll_bar_spacer
				end
			end
			
			if viewport_x_offset > 0 and (l_total_header_width - viewport_x_offset < internal_client_width) then
					-- If `header' and `drawable' currently have a position that starts before the client area of
					-- `viewport' and the total header width is small enough so that at the current position, `header' and
					-- `drawable' do not reach to the very left-hand edge of the `viewport', update the horizontal offset
					-- so that they do reach the very left-hand edge of `viewport'
				viewport_x_offset := (l_total_header_width - internal_client_width).max (0)
				viewport.set_x_offset (viewport_x_offset)
				
				header_viewport.set_x_offset ((l_total_header_width - internal_client_width).max (0))
			end
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
			set_background_color ((create {EV_STOCK_COLORS}).white)
			is_horizontal_scrolling_per_item := False
			is_vertical_scrolling_per_item := True
			is_header_displayed := True
			row_height := 16
			is_row_height_fixed := True
			subrow_indent := 0
			viewport_x_offset := 0
			viewport_y_offset := 0
			are_tree_node_connectors_shown := True
			build_expand_node_pixmap
			build_collapse_node_pixmap
			invalid_row_index := invalid_row_index.max_value
			
			create internal_row_data.make
			create columns.make
			create rows.make
			
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
			
			
			create header
				-- Now connect events to `header' which are used to update the "physical size" of
				-- Current in response to their re-sizing.
			header.item_resize_actions.extend (agent header_item_resizing)
			header.item_resize_end_actions.extend (agent header_item_resize_ended)

			header_viewport.extend (header)
			header_viewport.set_minimum_height (default_header_height.max (header.minimum_height))
			header.set_minimum_width (maximum_header_width)
			header_viewport.set_item_size (maximum_header_width, default_header_height.max (header.minimum_height))
			viewport.extend (drawable)
			extend (horizontal_box)
			viewport.resize_actions.extend (agent viewport_resized)
			
				-- Now connect all of the events to `drawable' which will be used to propagate events to the `interface'.
			drawable.pointer_motion_actions.extend (agent pointer_motion_received (?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_press_actions.extend (agent pointer_button_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_double_press_actions.extend (agent pointer_double_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_release_actions.extend (agent pointer_button_release_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_enter_actions.extend (agent pointer_enter_received)
			drawable.pointer_leave_actions.extend (agent pointer_leave_received)
			drawable.key_press_actions.extend (agent key_press_received (?))
			drawable.key_press_string_actions.extend (agent key_press_string_received (?))
			drawable.key_release_actions.extend (agent key_release_received (?))
			drawable.focus_in_actions.extend (agent focus_in_received)
			drawable.focus_out_actions.extend (agent focus_out_received)
			drawable.resize_actions.extend (agent resize_received (?, ?, ?, ?))

			
			drawable.expose_actions.force_extend (agent drawer.redraw_area_in_drawable_coordinates)
			update_scroll_bar_spacer
			
			enable_selection_on_click
			enable_single_item_selection
		end
		
	recompute_column_offsets is
			-- Recompute contents of `column_offsets'.
		local
			i: INTEGER
			temp_columns: like columns
			column_index: INTEGER
			l_column_count: INTEGER
		do
			temp_columns := columns
			create column_offsets.make (column_count)
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
		ensure
			counts_equal: column_offsets.count = column_count + 1
		end

	header_item_resizing (header_item: EV_HEADER_ITEM) is
			-- Respond to `header_item' being resized.
		require
			header_item_not_void: header_item /= Void
		do
				-- Update horizontal scroll bar size and position.
			recompute_horizontal_scroll_bar
			
			if is_resizing_divider_enabled then
					-- Draw a resizing line if enabled.
				draw_resizing_line (header.item_x_offset (header_item) + header_item.width)
			end
		end
		
	total_header_width: INTEGER is
			-- `Result' is total width of all header items contained within `header'.
		do
			if column_count >= 1 then
				Result := header.item_x_offset (header.last) + header.last.width
			end
		ensure
			result_non_negative: Result >= 0
		end
		
	header_item_resize_ended (header_item: EV_HEADER_ITEM) is
			-- Resizing has completed on `header_item'.
		require
			header_item_not_void: header_item /= Void
		do
			if is_resizing_divider_enabled then
				remove_resizing_line
			end
			fixme ("Only invalidate to the right hand side of the resized header item")
			recompute_column_offsets
			redraw_client_area
		end
		
	screen: EV_SCREEN is
			-- Once access to object of type EV_SCREEN.
		once
			create Result
		end
		
	draw_resizing_line (position: INTEGER) is
			-- Draw a resizing line at horizontal position relative to `drawable'.
			-- Clip line to drawable width.
		do
			if (position - viewport_x_offset > internal_client_width) or
				(position - viewport_x_offset < 0) then
				remove_resizing_line
			else
				
					-- Draw line representing position in current divider style.
				if is_resizing_divider_solid then
					screen.disable_dashed_line_style
				else
					screen.enable_dashed_line_style
				end
				screen.set_invert_mode
				screen.draw_segment (drawable.screen_x + position, drawable.screen_y + resizing_line_border, drawable.screen_x + position, drawable.screen_y + viewport.height - resizing_line_border)
				if last_dashed_line_position > 0 then
					screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + viewport.height - resizing_line_border)
				end
				last_dashed_line_position := drawable.screen_x + position
			end
		end
		
	remove_resizing_line is
			-- Remove resizing line drawn on `drawable'.
		do
			fixme ("Must remove resizing line if the area in which it was previously drawn has been re-drawn by `Current'")
				-- Remove line representing position in current divider style.
			if is_resizing_divider_solid then
				screen.disable_dashed_line_style
			else
				screen.enable_dashed_line_style
			end
			screen.set_invert_mode
			screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + viewport.height - resizing_line_border)
			last_dashed_line_position := - 1
		ensure
			last_position_negative: last_dashed_line_position = -1
		end
		
	last_dashed_line_position: INTEGER
		-- Last horizontal coordinate of dashed line drawn when slider is moved.
	
	last_computed_row_height: INTEGER
		
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
		end
		
	internal_set_virtual_y_position (a_y_position: INTEGER) is
			-- Set virtual y position of `Current' to `a_y_position'.
		require
			a_y_position_non_negative: a_y_position >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			internal_client_y := a_y_position
				-- Store the virtual client y position internally.

			buffer_space := (buffered_drawable_size - viewport.height)
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
			internal_client_x := a_x_position
				-- Store the virtual client x position internally.
				
			buffer_space := (buffered_drawable_size - internal_client_width)
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
				-- quick retrieval later. This reduces the dependncies on
				-- `viewport' within other code.
			internal_client_width := a_width
			internal_client_height := a_height
			
			if not header.is_empty then
					-- Update horizontal scroll bar size and position.
				recompute_horizontal_scroll_bar
			end
			if row_count /= 0 then
				--recompute_vertical_scroll_bar
				set_vertical_computation_required (1)
			end
		ensure
			client_dimensions_set: internal_client_width = viewport.width and internal_client_height = viewport.height
			viewport_item_at_least_as_big_as_viewport: viewport.item.width >= internal_client_width and
				viewport.item.height >= internal_client_height
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
		
	drawer: EV_GRID_DRAWER_I
		-- Drawer which is able to redraw `Current'.
		
	default_header_height: INTEGER is 16
		-- Default height applied to `header'.
	
	default_minimum_size: INTEGER is 50
		-- Default minimum size dimensions for `Current'.
		
	resizing_line_border: INTEGER is 4
		-- Distance that resizing line is displayed from top and bottom edges of `drawable'.
		
	buffered_drawable_size: INTEGER is 2000
		-- Default size of `drawable' used for scrolling purposes.
		
feature {NONE} -- Event handling		

	pointer_button_press_received (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A pointer button press has been received by `drawable' so propagate to the interface.
		local
			pointed_item: EV_GRID_ITEM_I
			node_pixmap_width: INTEGER
			current_item_x_position: INTEGER
			current_subrow_indent: INTEGER
			node_x_position_click_edge: INTEGER
			pointed_row_i: EV_GRID_ROW_I
			pointed_item_interface: EV_GRID_ITEM
		do
			drawable.set_focus
			pointed_item := drawer.item_at_position_strict (a_x, a_y)
			
				-- We fire the pointer button press actions before the node or selection actions which may occur
				-- as a result of this press.
			if pointer_button_press_actions_internal /= Void and then not pointer_button_press_actions_internal.is_empty then
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_button_press_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end

			pointed_item := drawer.item_at_position (a_x, a_y)
			if pointed_item /= Void then
				pointed_row_i := pointed_item.row_i
				node_pixmap_width := expand_node_pixmap.width
				current_subrow_indent := item_indent (pointed_item)
				current_item_x_position := (column_offsets @ (pointed_item.column.index)) - (internal_client_x - viewport_x_offset)
				node_x_position_click_edge := current_subrow_indent - node_pixmap_width - 3 * tree_node_spacing + current_item_x_position
				
				if a_button = 1 and a_x >= node_x_position_click_edge then
					if pointed_row_i.subrow_count >0 and then current_subrow_indent > 0 and a_x < current_subrow_indent + current_item_x_position then		

						if pointed_row_i.is_expanded then
							pointed_row_i.collapse
						else
							pointed_row_i.expand
						end
					elseif is_selection_on_click_enabled then
						handle_newly_selected_item (pointed_item.interface)
					end
				end
			end
		end
		
	client_x_to_virtual_x (client_x: INTEGER): INTEGER is
			-- Convert `client_x' in client coordinates to a virtual grid coordinate.
		require
			client_x_positive: client_x >= 0
		do
			Result := client_x + internal_client_x - viewport_x_offset
		ensure
			result_positive: Result >= 0
		end
		
	client_y_to_virtual_y (client_y: INTEGER): INTEGER is
			-- Convert `client_y' in client coordinates to a virtual grid coordinate.
		require
			client_y_positive: client_y >= 0
		do
			Result := client_y + internal_client_y - viewport_y_offset
		ensure
			result_positive: Result >= 0
		end

	pointer_motion_received (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if pointer_motion_actions_internal /= Void and then not pointer_motion_actions_internal.is_empty then
				if a_x >= 0 and then a_y >= 0 then
					pointed_item := drawer.item_at_position_strict (a_x, a_y)
				end
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_motion_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), pointed_item_interface])
			end
		end

	pointer_double_press_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_double_press_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if pointer_double_press_actions_internal /= Void and then not pointer_double_press_actions_internal.is_empty then
				pointed_item := drawer.item_at_position_strict (a_x, a_y)
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_double_press_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end
		end

	pointer_button_release_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `drawable'.
		local
			pointed_item: EV_GRID_ITEM_I
			pointed_item_interface: EV_GRID_ITEM
		do
			if pointer_button_release_actions_internal /= Void and then not pointer_button_release_actions_internal.is_empty then
				pointed_item := drawer.item_at_position_strict (a_x, a_y)
				if pointed_item /= Void then
					pointed_item_interface := pointed_item.interface
				end
				pointer_button_release_actions_internal.call ([client_x_to_virtual_x(a_x), client_y_to_virtual_y (a_y), a_button, pointed_item_interface])
			end
		end

	pointer_enter_received is
			-- Called by `pointer_enter_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.pointer_enter_received")
		end

	pointer_leave_received is
			-- Called by `pointer_leave_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.pointer_leave_received")
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

		do
			if look_right then
				item_offset := 1
			else
				item_offset := -1
			end

			from
				item_index := starting_index + item_offset
			until
				Result /= Void or else item_index = 0 or else item_index > grid_row.count
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
			is_viewable: BOOLEAN
			a_parent_row: EV_GRID_ROW
		do
			if look_down then
				item_offset := 1
			else
				item_offset := -1
			end

			from
				item_index := starting_index + item_offset
			until
				Result /= Void or else item_index = 0 or else item_index > grid_column.count
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
					from
						is_viewable := True
						a_parent_row := Result.row.parent_row
					until
						a_parent_row = Void or else not is_viewable
					loop
						if not a_parent_row.is_expanded then
							is_viewable := False
						end
						a_parent_row := a_parent_row.parent_row
					end
					if not is_viewable then
						Result := Void
					end
				end
				item_index := item_index + item_offset
			end
		end		

	key_press_received (a_key: EV_KEY) is
			-- Called by `key_press_actions' of `drawable'.
		local
			prev_sel_item, a_sel_item: EV_GRID_ITEM
			a_sel_row: EV_GRID_ROW
			sel_items: like selected_items
			in_row_selection: BOOLEAN
		do
				-- Handle the selection events
			sel_items := selected_items
			in_row_selection := is_single_row_selection_enabled or else is_multiple_row_selection_enabled
					-- We always want to find an item above or below for row selection
			if not sel_items.is_empty then
				prev_sel_item := sel_items.last
				a_sel_row := prev_sel_item.row
				inspect
					a_key.code
				when {EV_KEY_CONSTANTS}.Key_down then
					a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, True, in_row_selection)
				when {EV_KEY_CONSTANTS}.Key_up then
					a_sel_item := find_next_item_in_column (prev_sel_item.column, prev_sel_item.row.index, False, in_row_selection)
				when {EV_KEY_CONSTANTS}.Key_right then
					if not in_row_selection then
							-- Key right shouldn't affect row selection
						a_sel_item := find_next_item_in_row (prev_sel_item.row, prev_sel_item.column.index, True)
					end
				when {EV_KEY_CONSTANTS}.Key_left then
					if not in_row_selection then
							-- Key left shouldn't affect row selection
						a_sel_item := find_next_item_in_row (prev_sel_item.row, prev_sel_item.column.index, False)
					end
				else
					-- Do nothing
				end
				if a_sel_item /= Void then
					handle_newly_selected_item (a_sel_item)
				end	
			end
		end

	handle_newly_selected_item (a_item: EV_GRID_ITEM) is
			-- Handle selection for newly selected `a_item'.
		local
			start_item: EV_GRID_ITEM
			start_row_index, end_row_index, start_column_index, end_column_index: INTEGER
			col_counter, row_counter: INTEGER
			current_item: EV_GRID_ITEM
		do
			if (create {EV_ENVIRONMENT}).application.shift_pressed and then is_multiple_item_selection_enabled then
				start_item := selected_items.last
				if start_item /= Void and then start_item /= a_item then
					start_row_index := start_item.row.index
					end_row_index := a_item.row.index
					start_column_index := start_item.column.index
					end_column_index := a_item.column.index
					from
						col_counter := start_column_index.min (end_column_index)
					until
						col_counter > start_column_index.max (end_column_index)
					loop
						from
							row_counter := start_row_index.min (end_row_index)
						until
							row_counter > start_row_index.max (end_row_index)
						loop
							current_item := item (col_counter, row_counter)
							if current_item /= Void then
								current_item.enable_select
							end
							row_counter := row_counter + 1
						end
						col_counter := col_counter + 1
					end
				internal_selected_items.prune_all (start_item)
				internal_selected_items.extend (start_item)
				end
			elseif not (create {EV_ENVIRONMENT}).application.ctrl_pressed then
					-- If the ctrl key is not pressed then we remove selection
				remove_selection
			end
			a_item.enable_select
			
			fixme ("When in per row selection mode, this appears to always force the last column to be visible.")
			a_item.ensure_visible
		end

	key_press_string_received (a_keystring: STRING) is
			-- Called by `key_press_string_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.key_press_string_received")
		end

	key_release_received (a_key: EV_KEY) is
			-- Called by `key_release_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.key_release_received")
		end

	focus_in_received is
			-- Called by `focus_in_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.focus_in_received")
		end

	focus_out_received is
			-- Called by `focus_out_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.focus_out_received")
		end

	resize_received (a_x, a_y, a_width, a_height: INTEGER) is
			-- Called by `resize_actions' of `drawable'.
		do
			to_implement ("EV_GRID_I.resize_received")
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
			a_column_i := (create {EV_GRID_COLUMN}).implementation
			
			if a_index > columns.count then
				if replace_existing_item then
					columns.resize (a_index)
				else
						-- Resize to new count minus 1 as we are inserting a new item, when item is inserted then count will be increased
					columns.resize (a_index - 1)
				end
			end

			columns.go_i_th (a_index)
			if replace_existing_item then
				replaced_column := columns.item
				if replaced_column /= Void then
					replaced_column.remove_parent_i
				end
				columns.replace (a_column_i)
				a_column_i.set_internal_index (a_index)
			else
				columns.put_left (a_column_i)
				update_grid_column_indices (a_index)
			end

				-- Set column's internal data
			a_column_i.set_physical_index (physical_column_count)
			a_column_i.set_parent_i (Current)
			physical_column_count := physical_column_count + 1

			show_column (a_index)
			header_item_resizing (header.last)
			header_item_resize_ended (header.last)
		ensure
			column_count_set: not replace_existing_item implies ((a_index < old column_count implies (column_count = old column_count + 1)) or column_count = a_index)
		end

	add_row_at (a_index: INTEGER; replace_existing_item: BOOLEAN) is
			-- Add a new row at index `a_index'.
			-- If `replace_existing_item' then replace value at `a_index', else insert at `a_index'.
		require
			i_positive: a_index > 0
		local
			row_i, replaced_row: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			row_i := (create {EV_GRID_ROW}).implementation
			
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
			if replace_existing_item then
				internal_row_data.replace (a_row_data)
				replaced_row := rows.item
				if replaced_row /= Void then
					replaced_row.remove_parent_i
				end
				rows.replace (row_i)
				row_i.set_internal_index (a_index)
			else
				internal_row_data.put_left (a_row_data)
				rows.put_left (row_i)
					-- Update the index of `row_i' and subsequent rows in `rows'
				update_grid_row_indices (a_index)
			end

				-- Set grid of `grid_row' to `Current'
			row_i.set_parent_i (Current)

			set_vertical_computation_required (a_index)
		end

	update_grid_row_indices (a_index: INTEGER) is
			-- Recalculate subsequent row indexes starting from `a_index'.
		require
			valid_index: to_implement_assertion ("Add assertion for `a_index' values.")
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
					row_i.set_internal_index (i)
				end
				i := i + 1
			end
		end

	update_grid_column_indices (a_index: INTEGER) is
			-- Recalculate subsequent column indexes starting from `a_index'.
		require
			valid_index: to_implement_assertion ("Add assertion for `a_index' values.")
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
					column_i.set_internal_index (i)
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

	column_internal (a_column: INTEGER): EV_GRID_COLUMN_I is
			-- Column number `a_column', returns a new column if it doesn't exist.
		require
			a_column_positive: a_column > 0
		local
			temp_columns: like columns
		do
			temp_columns := columns
			if a_column > temp_columns.count then
				from
				until
					temp_columns.count = a_column
				loop
					add_column_at (temp_columns.count + 1, True)
				end
			end
			Result := temp_columns @ a_column
		ensure
			column_not_void: Result /= Void
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

feature {EV_GRID_ROW_I} -- Implementation

	internal_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
		-- List of selected rows.

	internal_selected_items: ARRAYED_LIST [EV_GRID_ITEM]
		-- List of selected items, only used when in item selection modes.

feature {EV_GRID_ROW_I, EV_GRID_COLUMN_I, EV_GRID_ITEM_I, EV_GRID_DRAWER_I} -- Implementation

	update_row_selection_status (a_row_i: EV_GRID_ROW_I) is
			-- Update the selection status for `a_row' in `Current'.
		local
			row_has_selection: BOOLEAN
			row_interface: EV_GRID_ROW
		do
			row_interface := a_row_i.interface
			if internal_selected_rows.has (row_interface) then
				internal_selected_rows.prune_all (row_interface)
				row_has_selection := True
			end
			if is_single_row_selection_enabled then
					-- Deselect existing rows and then remove from list
				remove_selection			
			end
				-- Add to last position in grid's selected rows
			internal_selected_rows.extend (row_interface)

			if row_select_actions_internal /= Void and then not row_has_selection then
				row_select_actions_internal.call ([row_interface])
			end
		end

	update_item_selection_status (a_item_i: EV_GRID_ITEM_I) is
			-- Update the selection status for `a_item_i' in `Current'.
		require
			a_item_i_not_void: a_item_i /= Void
		local
			item_has_selection: BOOLEAN
			item_interface: EV_GRID_ITEM
		do
			item_interface := a_item_i.interface
			if internal_selected_items.has (item_interface) then
				internal_selected_items.prune_all (item_interface)
				item_has_selection := True
			end
			if is_single_item_selection_enabled then
					-- Deselect existing items and then remove from list
				remove_selection			
			end
				-- Add to last position in grid's selected items
			internal_selected_items.extend (item_interface)

			if item_select_actions_internal /= Void and then not item_has_selection then
				item_select_actions_internal.call ([item_interface])
			end
		end

	internal_set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Replace grid item at position (`a_column', `a_row') with `a_item', `a_item' may be Void, as called by `remove_item'.
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
		local
			a_grid_col_i: EV_GRID_COLUMN_I
			a_grid_row_i: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			a_grid_col_i := column_internal (a_column)
			a_grid_row_i := row_internal (a_row)
			a_row_data := internal_row_data @ a_row
			if a_row_data.count < a_grid_col_i.physical_index + 1 then
				enlarge_row (a_row, a_grid_col_i.physical_index + 1)
			end
			
			if a_item /= Void then
				a_item.implementation.set_parents (Current, a_grid_col_i, a_grid_row_i)
				internal_row_data.i_th (a_row).put (a_item.implementation, a_grid_col_i.physical_index)
				if a_grid_row_i.parent_row_i /= Void then
						-- The row in which we are setting an item is already a subrow of another
						-- row, so we must update the internal settings for the tree.
						-- fixme ("EV_GRID_I.internal_set_item Should refactor `internal_set_parent_row' so that the parent row is not set and only the calculations are performed.)
					a_grid_row_i.internal_set_parent_row (a_grid_row_i.parent_row_i)
				end
			else
				internal_row_data.i_th (a_row).put (Void, a_grid_col_i.physical_index)
			end
			
			if a_item /= Void then
				redraw_item (a_item.implementation)
			else
					-- We no longer have access to the item so we calculate the redraw area based on the rows and columns.
				drawable.redraw_rectangle (a_grid_col_i.virtual_x_position - (internal_client_x - viewport_x_offset), a_grid_row_i.virtual_y_position - (internal_client_y - viewport_y_offset), a_grid_col_i.width, a_grid_row_i.height)
			end
		end

	item_internal (a_column: INTEGER; a_row: INTEGER): EV_GRID_ITEM_I is
			-- Cell at `a_row' and `a_column' position, if `create_item_if_void' then a new item will be created if Void.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			grid_row_i: EV_GRID_ROW_I
			grid_row: SPECIAL [EV_GRID_ITEM_I]
			a_grid_column_i: EV_GRID_COLUMN_I
			grid_item_i: EV_GRID_ITEM_I
			col_index: INTEGER
		do
				-- Retrieve column from grid
			a_grid_column_i := column_internal (a_column)
			col_index := a_grid_column_i.physical_index
			
			grid_row_i := row_internal (a_row)
			grid_row :=  internal_row_data @ a_row

			if col_index < grid_row.count then
				grid_item_i := grid_row @ (col_index)
				Result := grid_item_i
			end
		end

feature {EV_ANY_I, EV_GRID_ROW, EV_GRID_COLUMN, EV_GRID} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	row_count_non_negative: row_count >= 0
	column_count_non_negative: column_count >= 0
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
	single_item_selection_enabled_implies_only_single_item_selected: is_single_item_selection_enabled implies selected_items.count <= 1
	single_item_selected_enabled_implies_no_rows_selected: is_single_item_selection_enabled implies selected_rows.count = 0
	single_row_selection_enabled_implies_only_single_row_selected: is_single_row_selection_enabled implies selected_rows.count <= 1
	visible_column_count_not_greater_than_column_count: visible_column_count <= column_count
	hidden_node_count_zero_when_tree_disabled: not is_tree_enabled implies hidden_node_count = 0
	hidden_node_count_positive_when_tree_enabled: is_tree_enabled implies hidden_node_count >= 0
	hidden_node_count_no_greated_than_rows_less_one: is_tree_enabled and row_count > 0 implies hidden_node_count <= row_count - 1
	tree_disabled_implies_visible_rows_equal_hidden_rows: not is_tree_enabled implies row_count = visible_row_count
	internal_viewport_positions_equal_to_viewports: viewport.x_offset = viewable_x_offset and viewport.y_offset = viewport_y_offset
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

