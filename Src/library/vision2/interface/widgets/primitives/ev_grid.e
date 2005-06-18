indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.

		Item Insertion:
		--------------------------------------------------------------------------------

		Dynamic Modes:
		--------------------------------------------------------------------------------

		Size and Position:

		The grid is comprised of the following graphical elements:
		1. A header displayed at the top of `Current' which may be hidden/shown via
		`show_header' and hide_header'.
		2. A viewable area in which the contents of `Current' are displayed, displayed
		immediately below the header. The size of this
		area is given by `viewable_width' and `viewable_height' with its position
		relative to the top left corner of `Current' given by `viewable_x_offset',
		`viewable_y_offset'. Note that `viewable_y_offset' changes based on the visible
		state of the header.
		3. A horizontal scroll bar displayed below the viewable area, only shown if the
		virtual width of `Current' is greater than `viewable_width'.
		4. A vertical scroll bar displayed to the right of viewable area and header,
		only shown if the virtual height of `Current' is greater than `viewable_height'.

		The virtual size of the grid represents the complete screen area in pixels
		required to display the contents of `Current' and may be queried via
		`virtual_width' and `virtual_height'. If the contents of the grid are smaller
		than the viewable area, then the virtual size is equal to the viewable area,
		otherwise an area of the virtual size is displayed within viewable area, with
		the coordinates of this area (relative to the top left corner) within the
		virtual size given by `virtual_x' and `virtual_y'. As the scroll bars are moved,
		`virtual_x' and `virtual_y' are directly manipulated, although you may set the
		virtual position explicitly via calls to `set_virtual_x' and `set_virtual_y'.

		You may query the virtual position of an item within the virtual area of
		`Current' via `virtual_x_position' and `virtual_y_position' directly on the
		item. You may also query the dimensions of an item via `width' and `height'. It
		is important to note that for an item that is part of a tree structure, the
		`width' may not be equal to `column.width' and the `virtual_x_position' may not
		be equal to `column.virtual_x_position'. This is because items in tree
		structures are indented to provide space for the expand/collapse icons as
		necessary. The number of pixels that the item is indented for this purpose may
		be queried directly from the item via a call
		to `horizontal_indent'.

		You may query the virtual y position of a row within `Current' via
		`virtual_y_position' directly on the row.
		You may query the virtual x position of a column within `Current' via
		`virtual_x_position' directly on the column.

		As items, columns or rows are added and removed from `Current', the virtual size
		may change. The virtual position may only change if in this situation, you are
		removing rows or columns that cause the virtual size to reduce and the virtual
		position is no longer valid. The grid will automatically adjust the virtua 
		position so that the contents of the viewable area are completely contained
		within the new virtual position.

		The `height' of the rows displayed in `Current' is dependent on
		`is_row_height_fixed'. If `True',  then all rows are displayed at the same
		height, goverened by `row_height'. If `False', then the height of the row is
		goverened by its `height' property which may differ on an individual row basis.
		The width of columns is always unique and based on their `width' property.

		To determine if a particular item is located at a virtual position, use
		`item_at_virtual_position'. You may determine the first and last visible rows
		via `first_visible_row' and `last_visible_row', while `first_visible_column' and
		`last_visible_column' give the first and last columns visible in `Current'. For
		more precise information regarding exactly which rows and columns are displayed,
		you may query `visible_row_indexes' and `visible_column_indexes'. Note that if a
		tree is enabled via `enable_tree', then the contents of `visible_row_indexes'
		and `visible_column_indexes' may not be contiguous.

		To optimize performance, `Current'  only performs recomputation of the virtual
		positions of items as strictly necessary, which is normally once just before a
		redraw. As you may query virtual position information whenever you wish,
		`Current' may be forced to perform its recomputation of virtual positions as a
		result of your query. Each time that you modify something in the grid that may
		affect a virtual position of an item, the grid must recompute the virtual
		positions again as required. Therefore, for your code to be optimal, it may be
		necessary to take this into account. The worst possible case scenario is if you
		are to iterate from the start of the grid to the end of the grid and modify the
		state of each item or row during the iteration before querying a virtual position
		of an object in the grid past the current iteration position. In this situation,
		it is recommended that you perform a two-pass operation. First perform all of the
		modifications to the items and then perform all of the queries to virtual
		positions. The grid is optimized for additions in order so if you are repeatedly
		adding items and querying their virtual positions, then the performance is far
		better than if you are continuously inserting items at the start of the grid and
		querying their virtual positions. Although it is important to be aware of this
		behavior, you will find that in almost all cases, you have do perform no special
		optimizations to get good performance within `Current'. This also aplies to
		removal of rows. If you have many rows to remove, start with the final rows and
		iterate towards the first for increased performance.

		The re-drawing of `Current' is performed on idle, so if you are performing heavy
		computation and the grid is not updating, call `process_events' from
		EV_APPLICATION in order to force a re-draw.
		--------------------------------------------------------------------------------
		Appearance:

		Each of the items contained within the grid are sized based on the column and
		row that they occupy. If `is_row_height_fixed' is `True' then the height of the
		rows is dependent on `row_height' of `Current', otherwise it is dependent on
		`height' of the row and each row may occupy a different height. For the first
		non-`Void' item of each row, the position of the item is `item.horizontal_indent'
		pixels greater than the column in which it is contained. The appearance of each
		item is dependent on the actual type of the item, but there are a number of
		ways in which you may modify this at the grid level.

		`post_draw_overlay_function' is available, which permits you to draw directly on
		top of items immediately after they are dwan by the implementation. This is
		useful for adding custom borders to your items.
		`pre_draw_overlay_function' is available, which permits you to draw on top of the
		background of items, but before any features of that item have been drawn. For
		example, for grid label items, the background is cleared, then the function is
		called and then the `text' and `pixmap' are drawn. Note that for drawable items,
		which do not re-draw their background automatically, nothing is drawn before the
		`pre_draw_overlay_function' is called.

		When items are selected in a focused grid, they become highlighted in
		`focused_selection_color' and if the grid does not have the focus,
		`non_focused_selection_color' is used instead. It is recommended that you use
		these colors for your own drawable items to maintain consistency within the grid.
		The selection colors may be modified via `set_focused_selection_color' and
		`set_non_focused_selection_color'.

		Seperators between items may be enabled on the grid via `enable_column_separators'
		and `enable_row_separators' which ensure a single line is drawn between each row
		and column in `separator_color'. Use `set_separator_color' to modify this color.

		The tree structure of `Current' is drawn using `expand_node_pixmap' and
		`collapse_node_pixmap' to illustrate the expanded state of rows with subrows. You
		may use your own pixmaps by calling `set_expand_node_pixmap' and
		`set_collapse_node_pixmap'. The indent applied to each subrow is based on the
		current width of the node pixmaps + `subrow_indent'. You may increase this indent
		by calling `set_subrow_indent'. The nodes in the tree are connected via lines drawn
		in the color `tree_node_connector_color' which may be modified via
		`set_tree_node_connector_color'. These connecting lines may also be hidden via a
		call to `hide_tree_node_connectors'.

		During a column resize in `Current', the contents of the grid are immediately
		refreshed. This behavior may be disabled via a call to `disable_column_resize_immedite'
		and may be necessary if running the grid on older systems as it is less processor
		intensive. When not `is_column_resize_immediate', the column resizing is only performed
		when the user completes the resize, but a divider may be shown in `Current' which indicates
		its new width during the resizing, by calling `enable_resizing_divider'. This divider
		may be solid or dashed, based on the state of `is_resizing_divider_solid', settable via
		`enable_resizing_divider_solid' or `disable_resizing_divider_solid'.

		--------------------------------------------------------------------------------

		Selection:
		--------------------------------------------------------------------------------

		Item Activation:
		--------------------------------------------------------------------------------
		Event Handling:

		The standard set of widget events are inherited from EV_CELL with an additional
		set of events that are applicable to both `Current' and the items contained are
		inherited from EV_GRID_ACTION_SEQUENCES. For example,
		`pointer_button_press_actions' is inherited from EV_CELL, while
		`pointer_button_press_item_actions' is inherited from EV_GRID_ACTION_SEQUENCES
		and has an EV_GRID_ITEM as event data specifying the applicable item (if any).
		The coordinates of the item specific versions use virtual coordinates of
		`Current' as their coordinate information, wheras those inherited from EV_CELL
		use client coordinates as for any other EV_WIDGET. The order of event execution
		for multiple action sequences that may be triggered by a single event are as
		follows:
		1. The standard inherited widget events are fired. i.e.
			"grid.pointer_button_press_actions" The x and y coordinate event data is
			relative to the upper left corner of `Current'.
		2. The grid item specific versions of these events are fired. i.e.
			"grid.pointer_button_press_item_actions" The x and y coordinate event data is
			relative to the upper left corner of the "item" area of `Current', in virtual
			grid coordinates. These events are only fired while the mouse pointer is above
			the "item" area (does not include header and scroll bars).
		3. The events are fired on the item themselves. i.e.
			"item.pointer_button_press_actions" The x and y coordinate event data is
			relative to the upper left corner of the item.

		The grid specific versions of particular events permit you to perform handling
		for all of your items in a common place and are always fired before the specific
		item versions. For example, if you connect to both EV_GRID.row_expand_actions
		and EV_GRID_ROW.expand_actions, the grid version is fired first, immediately by
		the row version. The action sequences are fired one immediately after the other
		and both are always fired even if you change states of the target object within
		the first action sequence.
		--------------------------------------------------------------------------------

		Color Handling:

		Colors applied to items within `Current' are determined on a three level basis.
		The base level is `Current' whose `foreground_color' and `background_color' may
		never be Void.
		The second level are the columns and rows of `Current' whose `foreground_color'
		and `background_color' are `Void' by default.
		The final level is comprised of the items of `Current' themselves whose
		`foreground_color' and `background_color' are `Void' by default.
		As `Current' performs a  re-draw of an item "cell" contained within, the
		following rules are applied in order to determine the displayed colors:
		1. If there is an item in the "cell" which has a non-Void `foreground_color' or
		`background_color' then these colors are applied to the contents of that "cell",
		otherwise, step 2 is applied.
		2. If the column or row at that position has non-Void `foreground_color' or
		`background_color' then these colors are applied to the contents of that "cell",
		otherwise step 3 is applied.
		3. As the colors of the item, row and column were all `Void', the `foreground'
		and `background_color' of `Current' is applied to the contents of that "cell".
		Note that for areas of an items "cell" that are not filled by item item itself,
		such as the area of a tree structure, step 1 is ignored and the color
		calculations begin at step 2.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID

inherit
	EV_CELL
		rename
			item as cell_item,
			wipe_out as cell_wipe_out
		redefine
			implementation,
			create_implementation,
			prunable,
			readable,
			writable,
			is_in_default_state
		end

	EV_GRID_TYPES
		undefine
			copy, is_equal, default_create
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
			selected_columns_empty: selected_columns.is_empty
		end

	header: EV_GRID_HEADER is
			-- Header control used for resizing columns of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.header
		ensure
			result_not_void: Result /= Void
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
			-- Note that if `is_column_resize_immediate' is `True', `Result'
			-- is ignored by `Current' and no resizing divider is displayed.
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

	is_column_resize_immediate: BOOLEAN is
			-- Is the user resizing of a column reflected immediately in `Current'?
			-- If `True', the column width is updated continuosly and the state of `is_resizing_divider_enabled'
			-- is ignored with no divider displayed.
			-- If `False', the column width is only updated upon completion of the resize.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_column_resize_immediate
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

	item_pebble_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY] is
			-- Returns data to be transported by pick and drop mechanism.
			-- It will be called once each time a pick on the item area of the grid occurs, the result
			-- will be assigned to `pebble' for the duration of transport.
			-- When a pick occurs on an item, the item itself is passed.
			-- If a pick occurs and no item is present, then Void is passed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_pebble_function
		end

	item_veto_pebble_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM, ANY], BOOLEAN] is
			-- Function used to determine whether dropping is allowed on a particular item.
			-- When called during PND transport, the grid item currently under the pebble
			-- and the pebble itself are passed to the function.  A return value of True means
			-- that the pebble is allowed to be dropped onto the item, a return value of False
			-- disallows any PND transport.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_veto_pebble_function
		end

	item_accept_cursor_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR] is
			-- Function used to retrieve the PND accept cursor for a particular item.
			-- Called directly after `item_pebble_function' has executed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_accept_cursor_function
		end

	item_deny_cursor_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR] is
			-- Function used to retrieve the PND deny cursor for a particular item.
			-- Called directly after `item_pebble_function' has executed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_deny_cursor_function
		end	

	are_column_separators_enabled: BOOLEAN is
			-- Is a vertical separator displayed in color `separator_color' between each column?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.are_column_separators_enabled
		end

	are_row_separators_enabled: BOOLEAN is
			-- Is a horizontal separator displayed in color `separator_color' between each row?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.are_row_separators_enabled
		end

	separator_color: EV_COLOR is
			-- Color used to display column and row separators.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.separator_color
		ensure
			result_not_void: Result /= Void
		end
		
	focused_selection_color: EV_COLOR is
			-- Color used to show selection within items while focused.
		require
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.focused_selection_color
		ensure
			result_not_void: Result /= Void
		end

	non_focused_selection_color: EV_COLOR is
			-- Color used to show selection within items while not focused.
		require
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.non_focused_selection_color
		ensure
			result_not_void: Result /= Void
		end
		
	is_full_redraw_on_virtual_position_change_enabled: BOOLEAN is
			-- Is complete client area invalidated as a result of virtual position changing?
			-- Note that enabling this causes a large performance penalty in redrawing during
			-- scrolling, but may be used to achieve effects not otherwise possible unless the
			-- entire client area is invalidated.
		require
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.is_full_redraw_on_virtual_position_change_enabled
		end
		
feature -- Status setting

	set_item_veto_pebble_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM, ANY], BOOLEAN]) is
			-- Assign `a_function' to `item_veto_pebble_function'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_item_veto_pebble_function (a_function)
		ensure
			item_veto_pebble_function_set: item_veto_pebble_function = a_function
		end

	set_item_pebble_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], ANY]) is
			-- Assign `a_function' to `item_pebble_function'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_item_pebble_function (a_function)
		ensure
			item_pebble_function_set: item_pebble_function = a_function
		end

	set_item_accept_cursor_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]) is
			-- Assign `a_function' to `item_accept_cursor_function'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_item_accept_cursor_function (a_function)
		ensure
			item_accept_cursor_function_set: item_accept_cursor_function = a_function
		end

	set_item_deny_cursor_function (a_function: FUNCTION [ANY, TUPLE [EV_GRID_ITEM], EV_CURSOR]) is
			-- Assign `a_function' to `item_deny_cursor_function'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_item_deny_cursor_function (a_function)
		ensure
			item_deny_cursor_function_set: item_deny_cursor_function = a_function
		end

	enable_tree is
			-- Enable tree functionality for `Current'.
		require
			not_destroyed: not is_destroyed
			not_is_content_completely_dynamic: not is_content_completely_dynamic
		do
			implementation.enable_tree
		ensure
			tree_enabled: is_tree_enabled
		end
		
	disable_tree is
			-- Disable tree functionality for `Current'.
			-- All subrows of rows contained are unparented,
			-- which flattens the tree structure.
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
			-- Allow the user to select a single row via clicking or navigating using the keyboard arrow keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_row_selection
		ensure
			single_row_selection_enabled: is_single_row_selection_enabled
		end
		
	enable_multiple_row_selection is
			-- Allow the user to select more than one row via clicking or navigating using the keyboard arrow keys.
			-- Multiple rows may be selected via Ctrl and Shift keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_row_selection
		ensure
			multiple_row_selection_enabled: is_multiple_row_selection_enabled
		end
		
	enable_single_item_selection is
			-- Allow the user to select a single item via clicking or navigating using the keyboard arrow keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_item_selection
		ensure
			single_item_selection_enabled: is_single_item_selection_enabled
		end
		
	enable_multiple_item_selection is
			-- Allow the user to select more than one item via clicking or navigating using the keyboard arrow keys.
			-- Multiple items may be selected via Ctrl and Shift keys.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_item_selection
		ensure
			multiple_item_selection_enabled: is_multiple_item_selection_enabled
		end

	enable_always_selected is
			-- Ensure that the user may not completely remove the selection from `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_always_selected
		ensure
			item_is_always_selected_enabled: is_always_selected
		end

	disable_always_selected is
			-- Allow the user to completely remove the selection from `Current' via clicking on an item,
			-- clicking on a Void area or by Ctrl clicking the selected item itself.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_always_selected
		ensure
			not_is_item_always_selected_enabled: not is_always_selected
		end

	is_always_selected: BOOLEAN is
			-- May the user completely remove the selection from the grid.
			-- If `True' then the user of the grid may only deselect items by selecting other items.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_always_selected
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
			-- If not `is_row_height_fixed' then use the height individually per row instead.
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
			not_is_tree_enabled: not is_tree_enabled
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

	enable_columns_drawn_above_rows is
			-- Ensure `are_columns_drawn_above_rows' is `True'.
			
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_columns_drawn_above_rows
		ensure	
			columns_drawn_above_rows: are_columns_drawn_above_rows
		end

	disable_columns_drawn_above_rows is
			-- Ensure `are_columns_drawn_above_rows' is `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_columns_drawn_above_rows
		ensure	
			columns_drawn_below_rows: not are_columns_drawn_above_rows
		end

	enable_column_resize_immediate is
			-- Ensure `is_column_resize_immediate' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_column_resize_immediate
		ensure
			is_column_resize_immediate: is_column_resize_immediate
		end

	disable_column_resize_immediate is
			-- Ensure `is_column_resize_immediate' is `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_column_resize_immediate
		ensure
			not_is_column_resize_immediate: not is_column_resize_immediate
		end

	enable_column_separators is
			-- Ensure `are_column_separators_enabled' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_column_separators
		ensure	
			column_separators_enabled: are_column_separators_enabled
		end

	disable_column_separators is
			-- Ensure `are_column_separators_enabled' is `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_column_separators
		ensure	
			column_separators_disabled: not are_column_separators_enabled
		end

	enable_row_separators is
			-- Ensure `are_row_separators_enabled' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_row_separators
		ensure	
			row_separators_enabled: are_row_separators_enabled
		end
		
	disable_row_separators is
			-- Ensure `are_row_separators_enabled' is `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_row_separators
		ensure	
			row_separators_disabled: not are_row_separators_enabled
		end

	set_separator_color (a_color: EV_COLOR) is
			-- Set `a_color' as `separator_color'.
		require
			not_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_separator_color (a_color)
		ensure
			separator_color_set: separator_color = a_color
		end

	set_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `focused_selection_color'.
		require
			not_is_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_focused_selection_color (a_color)
		ensure
			focused_selection_color_set: focused_selection_color = a_color
		end
		
	set_non_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `non_focused_selection_color'.
		require
			not_is_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_non_focused_selection_color (a_color)
		ensure
			non_focused_selection_color_set: non_focused_selection_color = a_color
		end
		
	redraw is
			-- Force `Current' to be re-drawn when next idle.
		require
			not_destroyed: not is_destroyed
		do
			implementation.redraw
		end
		
	enable_full_redraw_on_virtual_position_change is
			-- Ensure `is_full_redraw_on_virtual_position_change_enabled' is `True'.
		require
			not_is_destroyed: not is_destroyed
		do
			implementation.enable_full_redraw_on_virtual_position_change
		ensure
			is_full_redraw_on_virtual_position_change_enabled: is_full_redraw_on_virtual_position_change_enabled
		end
		
	disable_full_redraw_on_virtual_position_change is
			-- Ensure `is_full_redraw_on_virtual_position_change_enabled' is `False'.
		require
			not_is_destroyed: not is_destroyed
		do
			implementation.disable_full_redraw_on_virtual_position_change
		ensure
			not_is_full_redraw_on_virtual_position_change_enabled: not is_full_redraw_on_virtual_position_change_enabled
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
			-- Does clicking or keyboard navigating via arrow keys select the whole row, unselecting
			-- any previously rows?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_single_row_selection_enabled
		end

	is_multiple_row_selection_enabled: BOOLEAN is
			-- Does clicking or keyboard navigating via arrow keys select the whole row, with multiple
			-- row selection permitted via the use of Ctrl and Shift keys?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_multiple_row_selection_enabled
		end
		
	is_single_item_selection_enabled: BOOLEAN is
			-- Does clicking or keyboard navigating via arrow keys select an item, unselecting
			-- any previously selected items?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_single_item_selection_enabled
		end

	is_multiple_item_selection_enabled: BOOLEAN is
			-- Does clicking or keyboard navigating via arrow keys select an item, with multiple
			-- item selection permitted via the use of Ctrl and Shift keys?
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

	first_visible_row: EV_GRID_ROW is
			-- First row visible in `Current' or Void if `row_count' = 0
			-- If `is_vertical_scrolling_per_item', the first visible row may be only partially visible.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.first_visible_row
		ensure
			has_rows_implies_result_not_void: row_count > 0 implies result /= Void
			no_rows_implies_result_void: row_count = 0 implies result = Void
		end

	first_visible_column: EV_GRID_COLUMN is
			-- First column visible in `Current' or Void if `column_count' = 0
			-- If `is_horizontal_scrolling_per_item', the first visible column may be only partially visible.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.first_visible_column
		ensure
			has_columns_implies_result_not_void: column_count > 0 implies result /= Void
			no_columns_implies_result_void: column_count = 0 implies result = Void
		end

	last_visible_row: EV_GRID_ROW is
			-- Last row visible in `Current' or Void if `row_count' = 0
			-- The last visible row may be only partially visible.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.last_visible_row
		ensure
			has_rows_implies_result_not_void: row_count > 0 implies result /= Void
			no_rows_implies_result_void: row_count = 0 implies result = Void
		end

	last_visible_column: EV_GRID_COLUMN is
			-- Index of last column visible in `Current' or 0 if `column_count' = 0.
			-- The last visible column may be only partially visible.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.last_visible_column
		ensure
			has_columns_implies_result_not_void: column_count > 0 implies result /= Void
			no_columns_implies_result_void: column_count = 0 implies result = Void
		end

	visible_row_indexes: ARRAYED_LIST [INTEGER] is
			-- Indexes of all rows that are currently visible in `Current'.
			-- `Result' may not be contiguous if `is_tree_enabled' and one or more of the
			-- visible rows have subrows and are not expanded.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.visible_row_indexes
		ensure	
			result_not_void: Result /= Void
			tree_not_enabled_implies_visible_rows_contiguous: not is_tree_enabled implies Result.last - Result.first = Result.count - 1
		end

	visible_column_indexes: ARRAYED_LIST [INTEGER] is
			-- All columns that are currently visible in `Current'.
			-- `Result' may not be contiguous if one or more columns are hidden.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
		do
			Result := implementation.visible_column_indexes
		ensure	
			result_not_void: Result /= Void
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

	are_columns_drawn_above_rows: BOOLEAN is
			-- For drawing purposes, are columns drawn above rows?
			-- If `True', for all cells within `Current' whose `column' and `row' have non-Void
			-- foreground or background colors, the column colors are given priority.
			-- If `False', the colors of the row are given priority.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.are_columns_drawn_above_rows
		end

feature -- Element change

	insert_new_row (i: INTEGER) is
			-- Insert a new row at index `i'.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			not_inserting_within_existing_subrow_structure: i = 1 or else (i < row_count and
				row (i - 1).parent_row_root /= Void and row (i).parent_row_root /= Void implies
				row (i - 1).parent_row_root /= row (i).parent_row_root)
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
			new_column_insertable: a_index <= column_count implies column ((a_index - 1).max (1)).all_items_may_be_set
		do
			implementation.insert_new_column (a_index)
		ensure
			column_count_set: (a_index < old column_count implies column_count = old column_count + 1) or else (a_index > old column_count implies a_index = column_count) 
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			i_not_greater_than_row_count: i <= row_count
			j_valid: j <= row_count
			row_at_i_not_a_subnode: row (i).parent_row = Void
			row_after_i_not_a_subnode: i < row_count implies row (i + 1).parent_row = Void
		do
			implementation.move_rows (i, j, 1)
		ensure
			moved: row (j) = old row (i) and then (i /= j implies row (j) /= row (i))
			row_count_unchanged: row_count = old row_count
		end

	move_rows (i, j, n: INTEGER) is
			-- Move `n' rows starting at index `i' to index `j'.
			-- Rows will not move if overlapping (`j' >= `i' and `j' < `i' + `n').
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			n_positive: n > 0
			i_not_greater_than_row_count: i <= row_count
			j_valid: j <= row_count
			n_valid: i + n <= row_count + 1
			row_at_i_not_a_subnode: row (i).parent_row = Void
			row_at_i_plus_n_not_a_subnode: i + n <= row_count implies row (i + n).parent_row = Void
		do
			implementation.move_rows (i, j, n)
		ensure
			rows_moved: (j < i implies row (j) = old row (i) and then row (j + n - 1) = old row (i + n - 1)) or (j >= i + n implies row (j - n + 1) = old row (i) and then row (j - n + n) = old row (i + n - 1))
			row_count_unchanged: row_count = old row_count
		end

	move_column (i, j: INTEGER) is
			-- Move column at index `i' to index `j'.
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			i_not_greater_than_column_count: i <= column_count
			j_not_greater_than_column_count: j <= column_count
			column_i_moveable: column (i).all_items_may_be_removed
			column_j_settable: column ((j - 1).max (1)).all_items_may_be_set
		do
			implementation.move_columns (i, j, 1)
		ensure
			moved: column (j) = old column (i) and then (i /= j implies column (j) /= column (i))
			column_count_unchanged: column_count = old column_count
		end

	move_columns (i, j, n: INTEGER) is
			-- Move `n' columns at index `i' to index `j'.
			-- Columns will not move if overlapping (`j' >= `i' and `j' < `i' + `n').
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			n_positive: n > 0
			i_not_greater_than_column_count: i <= column_count
			j_not_greater_than_column_count: j <= column_count
			n_valid: i + n <= column_count + 1
			columns_removable: are_columns_removable (i, n)
			column_j_settable: column ((j - 1).max (1)).all_items_may_be_set
		do
			implementation.move_columns (i, j, n)
		ensure
			columns_moved: (j < i implies column (j) = old column (i) and then column (j + n - 1) = old column (i + n - 1)) or (j >= i + n implies column (j - n + 1) = old column (i) and then column (j - n + n) = old column (i + n - 1))
			column_count_unchanged: column_count = old column_count
		end	

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Set grid item at position (`a_column', `a_row') to `a_item'.
			-- If `a_item' is `Void', the current item (if any) is removed.
		require
			not_destroyed: not is_destroyed
			a_item_not_parented: a_item /= Void implies a_item.parent = Void
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			item_may_be_added_if_row_is_a_subrow: a_item /= Void and then a_row <= row_count and then row (a_row).is_tree_node implies row (a_row).is_index_valid_for_item_setting_if_tree_node (a_column)
			item_may_be_removed_if_row_is_a_subrow: a_item = Void and then a_row <= row_count and then row (a_row).is_tree_node implies row (a_row).is_index_valid_for_item_removal_if_tree_node (a_column)
		do
			implementation.set_item (a_column, a_row, a_item)
		ensure
			item_set: item (a_column, a_row) = a_item
		end

	remove_item (a_column, a_row: INTEGER) is
			-- Remove grid item at position (`a_column', `a_row').
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			item_may_be_removed_if_row_is_a_subrow: row (a_row).is_tree_node implies row (a_row).is_index_valid_for_item_removal_if_tree_node (a_column)
		do
			set_item (a_column, a_row, Void)
		ensure
			item_removed: item (a_column, a_row) = Void
		end

	clear is
			-- Remove all items from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.clear
		ensure
			to_implement_assertion ("EV_GRID.clear - All items positions return `Void'.")
		end

	wipe_out is
			-- Remove all columns and rows from `Current'.
		require
			not_destroyed: not is_destroyed
			is_parented: parent /= Void
		do
			implementation.wipe_out
		ensure
			columns_removed: column_count = 0
			rows_removed: row_count = 0
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
			column_may_be_removed: column (a_column).all_items_may_be_removed
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

feature -- Contract support

	are_columns_removable (a_index, n: INTEGER): BOOLEAN is
			-- Are `n' columns starting at column index `a_index' removable from `Current'?
		require
			a_index_positive: a_index > 0
			n_positive: n > 0
			a_index_not_greater_than_column_count: a_index <= column_count
			n_valid: a_index + n <= column_count + 1
		local
			a_counter: INTEGER
		do
			from
				Result := True
				a_counter := a_index
			until
				a_counter = a_index + n or else not Result
			loop
				Result := column (a_counter).all_items_may_be_removed
				a_counter := a_counter + 1
			end
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := row_count = 0 and column_count = 0 and not is_horizontal_scrolling_per_item and
				is_vertical_scrolling_per_item and is_header_displayed and
				is_row_height_fixed and subrow_indent = 0 and is_single_item_selection_enabled and is_selection_on_click_enabled and
				are_tree_node_connectors_shown and are_columns_drawn_above_rows and not is_resizing_divider_enabled and
				is_column_resize_immediate and not is_full_redraw_on_virtual_position_change_enabled
		end

feature {EV_GRID_I} -- Implementation

	frozen new_row: like row_type is
			-- Create a new row.
		do
			create Result
		end

	frozen new_column: like column_type is
			-- Create a new column.
		do
			create Result
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
	dynamic_modes_mutually_exclusive: not (is_content_completely_dynamic and is_content_partially_dynamic)

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
