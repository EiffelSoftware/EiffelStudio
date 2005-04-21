indexing
	description: "Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID

inherit
	EV_CELL
		rename
			item as cell_item,
			pointer_motion_actions as cell_pointer_motion_actions,
			pointer_double_press_actions as cell_pointer_double_press_actions,
			pointer_enter_actions as cell_pointer_enter_actions,
			pointer_button_press_actions as cell_pointer_button_press_actions,
			pointer_button_release_actions as cell_pointer_button_release_actions,
			pointer_leave_actions as cell_pointer_leave_actions
		redefine
			implementation,
			create_implementation,
			prunable,
			readable,
			writable,
			is_in_default_state
		end
	
	EV_GRID_ACTION_SEQUENCES
		undefine
			copy, is_equal, default_create
		redefine
			implementation
		end
	
	REFACTORING_HELPER
		undefine
			copy, is_equal, default_create
		end

feature -- Access

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row'.
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row > 0
			a_row_not_greater_than_row_count: a_row <= row_count
		do
			Result := implementation.row (a_row)
		ensure
			row_not_void: Result /= Void
			row_count_enlarged_if_needed: a_row > old row_count implies row_count = a_row
		end

	visible_column (i: INTEGER): EV_GRID_COLUMN is
			-- `i'-th visible column.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_not_greater_than_visible_column_count: i <= visible_column_count
		do
			Result := implementation.visible_column (i)
		ensure
			column_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		do
			Result := implementation.column (a_column)
		ensure
			column_not_void: Result /= Void
			column_count_enlarged_if_needed: a_column > old column_count implies column_count = a_column
		end

	item (a_column: INTEGER; a_row: INTEGER): EV_GRID_ITEM is
			-- Cell at `a_row' and `a_column' position, Void if none.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		do
			Result := implementation.item (a_column, a_row)
		end
		
	item_at_virtual_position (a_virtual_x, a_virtual_y: INTEGER): EV_GRID_ITEM is
			-- Cell at virtual position `a_virtual_x', `a_virtual_y' or
			-- `Void' if none.
		require
			not_destroyed: not is_destroyed
			virtual_x_valid: a_virtual_x >=0 and a_virtual_x <= virtual_width
			virtual_y_valid: a_virtual_y >=0 and a_virtual_y <= virtual_height
		do
			Result := implementation.item_at_virtual_position (a_virtual_x, a_virtual_y)
		end

	selected_columns: ARRAYED_LIST [EV_GRID_COLUMN] is
			-- All columns selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_columns
		ensure
			result_not_void: Result /= Void
		end
		
	selected_rows: ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_rows
		ensure
			result_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
		end

	remove_selection is
			-- Ensure that `selected_items', `selected_rows' and `selected_columns' are empty.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_selection
		ensure
			selected_items_empty: selected_items.is_empty
			selected_rows_empty: selected_rows.is_empty
		end

	is_header_displayed: BOOLEAN is
			-- Is the header displayed in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_header_displayed
		end
		
	is_resizing_divider_enabled: BOOLEAN is
			-- Is a vertical divider displayed during column resizing?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_resizing_divider_enabled
		end
		
	is_resizing_divider_solid: BOOLEAN is
			-- Is resizing divider displayed during column resizing drawn as a solid line?
			-- If `False', a dashed line style is used.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_resizing_divider_solid
		end
		
	is_horizontal_scrolling_per_item: BOOLEAN is
			-- Is horizontal scrolling performed on a per-item basis?
			-- If `True', each change of the horizontal scroll bar increments the horizontal
			-- offset by the current column width.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_horizontal_scrolling_per_item
			
		end
		
	is_vertical_scrolling_per_item: BOOLEAN is
			-- Is vertical scrolling performed on a per-item basis?
			-- If `True', each change of the vertical scroll bar increments the vertical
			-- offset by the current row height.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_vertical_scrolling_per_item
		end
		
	dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM] is
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.
		require
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.dynamic_content_function
		end

	is_content_partially_dynamic: BOOLEAN is
			-- Is the content of `Current' partially dynamic? If `True' then
			-- whenever an item must be re-drawn and it is not already set within `Current',
			-- then it is queried via execution of `dynamic_content_function'. The returned item is added
			-- to `Current' so the query only occurs once.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_content_partially_dynamic
		end
		
	is_content_completely_dynamic: BOOLEAN is
			-- Is the content of `Current' completely dynamic? If `True' then
			-- whenever an item must be re-drawn it is always queried via execution
			-- of `dynamic_content_function' and not added to `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_content_completely_dynamic
		end
		
	is_row_height_fixed: BOOLEAN is
			-- Must all rows in `Current' have the same height?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_row_height_fixed
		end
		
	row_height: INTEGER is
			-- Height of all rows within `Current'. Only has an effect on `Current'
			-- while `is_row_height_fixed', otherwise the individual height of each
			-- row is used directly.
		require
			not_destroyed: not is_destroyed
			is_row_height_fixed: is_row_height_fixed
		do
			Result := implementation.row_height
		ensure
			result_non_negative: result >= 0
		end
		
	subrow_indent: INTEGER is
			-- Number of pixels horizontally by which each subrow is indented
			-- from its `parent_row'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.subrow_indent
		ensure
			result_non_negative: result >= 0
		end
		
	expand_node_pixmap: EV_PIXMAP is
			-- Pixmap displayed within tree structures when a row with one or more
			-- subrows is collapsed. Clicking the area occupied by this pixmap in `Current'
			-- expands the row.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.expand_node_pixmap
		ensure
			result_not_void: Result /= Void
		end
		
	collapse_node_pixmap: EV_PIXMAP is
			-- Pixmap displayed within tree structures when a row with one or more
			-- subrows is expanded. Clicking the area occupied by this pixmap in `Current'
			-- collapses the row.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.collapse_node_pixmap
		ensure
			result_not_void: Result /= Void
		end
		
	are_tree_node_connectors_shown: BOOLEAN is
			-- Are connectors between tree nodes shown in `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.are_tree_node_connectors_shown
		end
		
	virtual_x_position: INTEGER is
			-- Horizontal offset of viewable area in relation to the left edge of
			-- the virtual area in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_x_position
		ensure
			valid_result: Result >= 0 and Result <= virtual_width - viewable_width
		end
		
	virtual_y_position: INTEGER is
			-- Vertical offset of viewable area in relation to the top edge of
			-- the virtual area in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_y_position
		ensure
			valid_result: Result >= 0 and Result <= virtual_height - viewable_height
		end
		
	virtual_width: INTEGER is
			-- Width of virtual area in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_width
		ensure
			result_greater_or_equal_to_viewable_width: Result >= viewable_width
		end
		
	virtual_height: INTEGER is
			-- Height of virtual area in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.virtual_height
		ensure
			result_greater_or_equal_to_viewable_height: Result >= viewable_height
		end
		
	viewable_width: INTEGER is
			-- Width of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.viewable_width
		ensure
			viewable_width_valid: viewable_width >= 0 and viewable_width <= width
		end
		
	viewable_height: INTEGER is
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.viewable_height
		ensure
			viewable_height_valid: viewable_height >= 0 and viewable_height <= height
		end
		
	viewable_x_offset: INTEGER is
			-- Horizontal distance in pixels from the left edge of `Current' to
			-- the left edge of the viewable area (defined by `viewable_width', `viewable_height')
			-- in which all content is displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.viewable_x_offset
		ensure
			viewable_x_offset_valid: Result >=0 and Result <= width
		end
			
	viewable_y_offset: INTEGER is
			-- Vertical distance in pixels from the top edge of `Current' to
			-- the top edge of the viewable area (defined by `viewable_width', `viewable_height')
			-- in which all content is displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.viewable_y_offset
		ensure
			viewable_y_offset_valid: Result >=0 and Result <= height
		end

feature -- Status setting

	enable_tree is
			-- Enable tree functionality for `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tree
		ensure
			tree_enabled: is_tree_enabled
		end
		
	disable_tree is
			-- Disable tree functionality for `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_tree
		ensure
			tree_disabled: not is_tree_enabled
		end	
		
	show_column (a_column: INTEGER) is
			-- Ensure column `a_column' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			implementation.show_column (a_column)
		ensure
			column_displayed: column_displayed (a_column)
		end
		
	hide_column (a_column: INTEGER) is
			-- Ensure column `a_column' is not visible in `Current'.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			implementation.hide_column (a_column)
		ensure
			column_not_displayed: not column_displayed (a_column)
		end
		
	select_column (a_column: INTEGER) is
			-- Ensure all items in `a_column' are selected.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
			column_displayed: column_displayed (a_column)
		do
			implementation.select_column (a_column)
		ensure
			column_selected: column (a_column).is_selected
		end
		
	select_row (a_row: INTEGER) is
			-- Ensure all items in `a_row' are selected.
		require
			not_destroyed: not is_destroyed
			a_row_within_bounds: a_row > 0 and a_row <= row_count
			column_displayed: column_displayed (a_row)
		do
			implementation.select_row (a_row)
		ensure
			row_selected: row (a_row).is_selected
		end

	enable_selection_on_click is
			-- Enable selection handling of items when clicked upon.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_selection_on_click
		ensure
			selection_on_click_enabled:is_selection_on_click_enabled
		end

	disable_selection_on_click is
			-- Disable selection handling when items are clicked upon.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_selection_on_click
		ensure
			selection_on_click_disabled: not is_selection_on_click_enabled
		end

	enable_selection_key_handling is
			-- Enable selection handling of items via the keyboard.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_selection_keyboard_handling
		ensure
			selection_key_handling_enabled: is_selection_keyboard_handling_enabled
		end

	disable_selection_key_handling is
			-- Disable selection handling of items via the keyboard.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_selection_keyboard_handling
		ensure
			selection_key_handling_disabled: not is_selection_keyboard_handling_enabled
		end

	enable_single_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row,
			-- unselecting any previous rows.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_row_selection
		ensure
			single_row_selection_enabled: is_single_row_selection_enabled
		end
		
	enable_multiple_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row.
			-- Multiple rows may be selected via keyboard with Ctrl and Shift keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_row_selection
		ensure
			multiple_row_selection_enabled: is_multiple_row_selection_enabled
		end
		
	enable_single_item_selection is
			-- Set user selection mode so that clicking an item selects the item,
			-- unselecting any previous items.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_item_selection
		ensure
			single_item_selection_enabled: is_single_item_selection_enabled
		end
		
	enable_multiple_item_selection is
			-- Set user selection mode so that clicking an item selects the item.
			-- Multiple items may be selected via keyboard with Ctrl and Shift keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_item_selection
		ensure
			multiple_item_selection_enabled: is_multiple_item_selection_enabled
		end
		
	show_header is
			-- Ensure header displayed.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_header
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_header
		ensure
			header_not_displayed: not is_header_displayed
		end
		
	set_first_visible_row (a_row: INTEGER) is
			-- Set `a_row' as the first row visible in `Current' as long
			-- as there are enough rows after `a_row' to fill the remainder of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_first_visible_row (a_row)
		ensure
			to_implement_assertion ("EV_GRID.set_first_visible_row - Enough following rows implies `first_visible_row' = a_row, Can be calculated from `height' of `Current' and row heights.")
		end
		
	enable_resizing_divider is
			-- Ensure a vertical divider is displayed during column resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_resizing_divider
		ensure
			resizing_divider_enabled: is_resizing_divider_enabled
		end
		
	disable_resizing_divider is
			-- Ensure no vertical divider is displayed during column resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_resizing_divider
		ensure
			resizing_divider_disabled: not is_resizing_divider_enabled
		end
		
	enable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a solid line.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_solid_resizing_divider
		ensure
			solid_resizing_divider: is_resizing_divider_solid
		end
		
	disable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a dashed line.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_solid_resizing_divider
		ensure
			dashed_resizing_divider: not is_resizing_divider_solid
		end
		
	enable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-item basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_horizontal_scrolling_per_item
		ensure
			horizontal_scrolling_performed_per_item: is_horizontal_scrolling_per_item
		end
		
	disable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_horizontal_scrolling_per_item
		ensure
			horizontal_scrolling_performed_per_pixel: not is_horizontal_scrolling_per_item
		end
		
	enable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-item basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_vertical_scrolling_per_item
		ensure
			vertical_scrolling_performed_per_item: is_vertical_scrolling_per_item
		end
		
	disable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_vertical_scrolling_per_item
		ensure
			vertical_scrolling_performed_per_pixel: not is_vertical_scrolling_per_item
		end
		
	set_row_height (a_row_height: INTEGER) is
			-- Set height of all rows within `Current' to `a_row_height
			-- If not `is_row_height_fixed' then set the height individually per row instead.
		require
			not_destroyed: not is_destroyed
			is_row_height_fixed: is_row_height_fixed
			a_row_height_positive: a_row_height >= 1
		do
			implementation.set_row_height (a_row_height)
		ensure
			row_height_set: row_height = a_row_height
		end
		
	enable_complete_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via execution of
			-- `dynamic_content_function'. Contents are requested each time they
			-- are displayed even if already contained in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_complete_dynamic_content
		ensure
			content_completely_dynamic: is_content_completely_dynamic
		end
		
	enable_partial_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via execution of
			-- `dynamic_content_function' only if the item is not already set
			-- in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_partial_dynamic_content
		ensure
			content_partially_dynamic: is_content_partially_dynamic
		end
		
	disable_dynamic_content is
			-- Ensure contents of `Current' are not dynamic and are no longer retrieved as such.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dynamic_content
		ensure
			content_not_dynamic: not is_content_completely_dynamic and not is_content_partially_dynamic
		end
		
	enable_row_height_fixed is
			-- Ensure all rows have the same height.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_row_height_fixed
		ensure
			row_height_fixed: is_row_height_fixed
		end
		
	disable_row_height_fixed is
			-- Permit rows to have varying heights.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_row_height_fixed
		ensure
			row_height_variable: not is_row_height_fixed
		end
		
	set_column_count_to (a_column_count: INTEGER) is
			-- Resize `Current' to have `a_column_count' columns.
		require
			not_destroyed: not is_destroyed
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_column_count_positive: a_column_count >= 1
		do
			implementation.set_column_count_to (a_column_count)
		ensure
			column_count_set: column_count = a_column_count
		end
		
	set_row_count_to (a_row_count: INTEGER) is
			-- Resize `Current' to have `a_row_count' columns.
		require
			not_destroyed: not is_destroyed
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_row_count_positive: a_row_count >= 1
		do
			implementation.set_row_count_to (a_row_count)
		ensure
			row_count_set: row_count = a_row_count
		end
		
	set_dynamic_content_function (a_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]) is
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.
		require
			not_destroyed: not is_destroyed
			a_function_not_void: a_function /= Void
		do
			implementation.set_dynamic_content_function (a_function)
		ensure
			dynamic_content_function_set: dynamic_content_function = a_function
		end
		
	set_subrow_indent (a_subrow_indent: INTEGER) is
			-- Set `subrow_indent' to `a_subrow_indent'.
		require
			not_destroyed: not is_destroyed
			a_subrow_indent_non_negtive: a_subrow_indent >= 0
		do
			implementation.set_subrow_indent (a_subrow_indent)
		ensure
			subrow_indent_set: subrow_indent = a_subrow_indent
		end
		
	set_node_pixmaps (an_expand_node_pixmap, a_collapse_node_pixmap: EV_PIXMAP) is
			-- Assign `an_expand_node_pixmap' to `expand_node_pixmap' and `a_collapse_node_pixmap'
			-- to `collapse_node_pixmap'. These pixmaps are used in rows containing subrows for
			-- expanding/collapsing the row.
		require
			not_destroyed: not is_destroyed
			pixmaps_not_void: an_expand_node_pixmap /= Void and a_collapse_node_pixmap /= Void
			pixmaps_dimensions_identical: an_expand_node_pixmap.width = a_collapse_node_pixmap.width and
				an_expand_node_pixmap.height = a_collapse_node_pixmap.height
		do
			implementation.set_node_pixmaps (an_expand_node_pixmap, a_collapse_node_pixmap)
		ensure
			pixmaps_set: expand_node_pixmap = an_expand_node_pixmap and collapse_node_pixmap = a_collapse_node_pixmap
		end
		
	show_tree_node_connectors is
			-- Ensure connectors are displayed between nodes of tree structure in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_tree_node_connectors
		ensure
			tree_node_connectors_shown: are_tree_node_connectors_shown
		end
		
	hide_tree_node_connectors is
			-- Ensure no connectors are displayed between nodes of tree structure in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_tree_node_connectors
		ensure
			tree_node_connectors_hidden: not are_tree_node_connectors_shown
		end
		
	set_virtual_position (virtual_x, virtual_y: INTEGER) is
			-- Move viewable area of `Current' to virtual position `virtual_x', `virtual_y'.
		require
			not_destroyed: not is_destroyed
			virtual_x_valid: virtual_x >= 0 and virtual_x <= virtual_width - viewable_width
			virtual_y_valid: virtual_y >= 0 and virtual_y <= virtual_height - viewable_height
		do
			implementation.set_virtual_position (virtual_x, virtual_y)
		ensure
			virtual_position_set: virtual_x_position = virtual_x and virtual_y_position = virtual_y
		end
		
	set_tree_node_connector_color (a_color: EV_COLOR) is
			-- Set `a_color' as `tree_node_connector_color'.
		require
			not_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_tree_node_connector_color (a_color)
		ensure
			tree_node_connector_color_set: tree_node_connector_color = a_color
		end

feature -- Status report

	prunable: BOOLEAN is False
			-- May items be removed?
			
	writable: BOOLEAN is False
			-- Is there a current item that may be modified?

	readable: BOOLEAN is False
			-- Is there a current item that may be accessed?

	is_tree_enabled: BOOLEAN is
			-- Is tree functionality enabled?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tree_enabled
		end
		
	column_displayed (a_column: INTEGER): BOOLEAN is
			-- May column `a_column' be displayed when `Current' is?
			-- Will return False if `hide' has been called on column `a_column'.
			-- A value of True does not signify that column `a_column' is visible on screen at that particular time.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			Result := implementation.column_displayed (a_column)
		end
		
	is_single_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, unselecting
			-- any previous rows?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_single_row_selection_enabled
		end

	is_multiple_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, with multiple
			-- row selection permitted?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_multiple_row_selection_enabled
		end
		
	is_single_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, unselecting
			-- any previous items?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_single_item_selection_enabled
		end

	is_multiple_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, with multiple
			-- item selection permitted?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_multiple_item_selection_enabled
		end

	is_selection_on_click_enabled: BOOLEAN is
			-- Will an item be selected if clicked upon?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_selection_on_click_enabled
		end

	is_selection_keyboard_handling_enabled: BOOLEAN is
			-- May items be selected via the keyboard?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_selection_keyboard_handling_enabled
		end

	first_visible_row: INTEGER is
			-- Index of first row visible in `Current' or 0 if `row_count' = 0.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.first_visible_row
		ensure
			not_empty_implies_result_positive: row_count > 0 implies result > 0
			empty_implies_result_zero: row_count = 0 implies result = 0
		end
		
	tree_node_connector_color: EV_COLOR is
			-- Color of connectors drawn between tree nodes within `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tree_node_connector_color
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	insert_new_row (i: INTEGER) is
			-- Insert a new row at index `i'.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			not_inserting_within_existing_subrow_structure: i < row_count and
				row (i - 1).parent_row_root /= Void and row (i).parent_row_root /= Void implies
				row (i - 1).parent_row_root /= row (i).parent_row_root
		do
			implementation.insert_new_row (i)
		ensure
			row_count_set: (i <= old row_count implies row_count = old row_count + 1) or (i = row_count)
		end

	insert_new_row_parented (i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert a new row at index `i' and make that row a subnode of `a_parent_row'.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_less_than_row_count: i <= row_count + 1
			a_parent_row_not_void: a_parent_row /= Void
			a_parent_row_in_current: a_parent_row.parent = Current
			to_implement_assertion ("Ensure `i' is a valid row index to be inserted within `a_parent_row'.")
		do
			implementation.insert_new_row_parented (i, a_parent_row)
		ensure
			row_count_set: (i <= old row_count implies row_count = old row_count + 1) or (i = row_count)
			subrow_count_set: a_parent_row.subrow_count = old a_parent_row.subrow_count + 1
		end

	insert_new_column (a_index: INTEGER) is
			-- Insert a new column at index `a_index'.
		require
			not_destroyed: not is_destroyed
			i_positive: a_index > 0
			to_implement_assertion ("Add preconditions for subnode handling")
		do
			implementation.insert_new_column (a_index)
		ensure
			column_count_set: (a_index < old column_count implies column_count = old column_count + 1) or else (a_index > old column_count implies a_index = column_count) 
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_row_count: i <= row_count
			j_less_than_row_count: j <= row_count
			to_implement_assertion ("Add preconditions for subnode handling")
		do
			implementation.move_row (i, j)
		ensure
			moved: row (j) = old row (i) and then (i /= j implies row (j) /= row (i))
		end

	move_column (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_column_count: i <= column_count
			j_less_than_column_count: j <= column_count
		do
			implementation.move_column (i, j)
		ensure
			moved: column (j) = old column (i) and then (i /= j implies column (j) /= column (i))
		end	

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set grid item at position (`a_column', `a_row') to `a_item'.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_void: a_item /= Void
			valid_tree_structure: is_tree_enabled and row (a_row).parent_row /= Void implies a_column >= row (a_row).parent_row.index_of_first_item
		do
			implementation.set_item (a_column, a_row, a_item)
		ensure
			inserted: item (a_column, a_row) = a_item
		end

	remove_item (a_column, a_row: INTEGER) is
			-- Remove grid item at position (`a_column', `a_row').
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			to_implement_assertion ("Add preconditions for subnode handling")
		do
			implementation.remove_item (a_column, a_row)
		ensure
			item_removed: item (a_column, a_row) = Void
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		do
			implementation.remove_column (a_column)
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row' and all subrows recursively.
			-- If `row (a_row).subrow_count_recursive' is greater than 0 then
			-- all subrows of the row are also removed from `Current'.
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		do
			implementation.remove_row (a_row)
		ensure
			row_count_updated: row_count = old row_count - (old row (a_row).subrow_count_recursive + 1)
			old_row_removed: (old row (a_row)).parent = Void
			to_implement_assertion ("EV_GRID.remove_row		All old recursive subrows removed.")
		end

feature -- Measurements

	column_count: INTEGER is
			-- Number of columns in Current.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_count
		ensure
			result_not_negative: Result >= 0
		end
		
	visible_column_count: INTEGER is
			-- Number of visible columns in Current
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.visible_column_count
		ensure
			result_valid: Result >= 0 and Result <= column_count
		end

	row_count: INTEGER is
			-- Number of rows in Current
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_count
		ensure
			result_not_negative: Result >= 0
		end
		
	tree_node_spacing: INTEGER is
			-- Spacing value used around the expand/collapse node of a 
			-- subrow. For example, to determine the height available for the node image
			-- within a subrow, subtract 2 * tree_node_spacing from the `row_height'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tree_node_spacing
		ensure
			result_positive: Result >= 1
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := not is_horizontal_scrolling_per_item and
				is_vertical_scrolling_per_item and is_header_displayed and
				is_row_height_fixed and subrow_indent = 0 and is_single_item_selection_enabled and is_selection_on_click_enabled and
				are_tree_node_connectors_shown
		end
			
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_IMP} implementation.make (Current)
		end

invariant
	row_count_non_negative: row_count >= 0
	column_count_non_negative: column_count >= 0
	dynamic_modes_mutually_exclusive: not (is_content_completely_dynamic and is_content_partially_dynamic)
	selected_columns_not_void: selected_columns /= Void
	selected_rows_not_void: selected_rows /= Void
	selected_items_not_void: selected_items /= Void
	single_row_selection_enabled_implies_selected_count_no_more_than_one: is_single_row_selection_enabled implies selected_rows.count <= 1
	single_item_selection_enabled_implies_selected_count_no_more_than_one: is_single_item_selection_enabled implies selected_rows.count <= 1
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
