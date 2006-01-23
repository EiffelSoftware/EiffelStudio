indexing
	description:
		"Action sequences for EV_GRID_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"

deferred class
	 EV_GRID_ACTION_SEQUENCES_I
	 
inherit
	REFACTORING_HELPER

feature -- Event handling

	item_drop_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, ANY]] is
			-- Actions to be performed when a pebble is dropped here.
		do
			if item_drop_actions_internal = Void then
				create item_drop_actions_internal
			end
			Result := item_drop_actions_internal
		ensure
			not_void: Result /= Void
		end

	item_deactivate_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deactivated.
		do
			if item_deactivate_actions_internal = Void then
				create item_deactivate_actions_internal
			end
			Result := item_deactivate_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	item_select_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected.
		do
			if item_select_actions_internal = Void then
				create item_select_actions_internal
			end
			Result := item_select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	item_deselect_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deselected.
		do
			if item_deselect_actions_internal = Void then
				create item_deselect_actions_internal
			end
			Result := item_deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	row_select_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is selected.
		do
			if row_select_actions_internal = Void then
				create row_select_actions_internal
			end
			Result := row_select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	row_deselect_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is deselected.
		do
			if row_deselect_actions_internal = Void then
				create row_deselect_actions_internal
			end
			Result := row_deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	column_select_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]] is
			-- Actions to be performed when a column is selected.
		do
			if column_select_actions_internal = Void then
				create column_select_actions_internal
			end
			Result := column_select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	column_deselect_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]] is
			-- Actions to be performed when a column is deselected.
		do
			if column_deselect_actions_internal = Void then
				create column_deselect_actions_internal
			end
			Result := column_deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	row_expand_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is expanded.
		do
			if row_expand_actions_internal = Void then
				create row_expand_actions_internal
			end
			Result := row_expand_actions_internal
		ensure
			result_not_void: Result /= Void
		end
	
	row_collapse_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is collapsed.
		do
			if row_collapse_actions_internal = Void then
				create row_collapse_actions_internal
			end
			Result := row_collapse_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_motion_item_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a screen pointer moves over a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
			-- item: EV_GRID_ITEM -- If the motion occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			if pointer_motion_item_actions_internal = Void then
				create pointer_motion_item_actions_internal
			end
			Result := pointer_motion_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	item_activate_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_POPUP_WINDOW]] is
			-- Actions to be performed to setup an item that is currently activated.
			-- Overrides default setup of activatable items.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- activate_item: EV_GRID_ITEM -- The item that is currently activated.
			-- popup_window: EV_WINDOW -- The popup window used to interactively edit `activate_item', window has already been sized and positioned.
		do
			if item_activate_actions_internal = Void then
				create item_activate_actions_internal
			end
			Result := item_activate_actions_internal
		end
		
	pointer_button_press_item_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the press in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the press in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the pressed button.
			-- item: EV_GRID_ITEM -- If the press occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			if pointer_button_press_item_actions_internal = Void then
				create pointer_button_press_item_actions_internal
			end
			Result := pointer_button_press_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_double_press_item_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer double press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the double press in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the double press in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the pressed button.
			-- item: EV_GRID_ITEM -- If the double press occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			if pointer_double_press_item_actions_internal = Void then
				create pointer_double_press_item_actions_internal
			end
			Result := pointer_double_press_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_button_release_item_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer release event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the release in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the release in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the released button.
			-- item: EV_GRID_ITEM -- If the release occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			if pointer_button_release_item_actions_internal = Void then
				create pointer_button_release_item_actions_internal
			end
			Result := pointer_button_release_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_enter_item_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer enter event is received by a grid or grid item
			-- Arguments (with names for clarity):
			--
			-- on_grid: BOOLEAN -- Did the enter event occur for the grid?
			-- item: EV_GRID_ITEM -- If the enter event occurred for an item, this is the item.
			--
			-- Note that `on_grid' may be set to `True' and `item' may be non-Void
			-- in the case where the pointer enters a grid at a location where there
			-- is an item contained.
		do
			if pointer_enter_item_actions_internal = Void then
				create pointer_enter_item_actions_internal
			end
			Result := pointer_enter_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_leave_item_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer leave event is received by a grid or grid item
			-- Arguments (with names for clarity):
			--
			-- on_grid: BOOLEAN -- Did the leave event occur for the grid?
			-- item: EV_GRID_ITEM -- If the leave event occurred for an item, this is the item.
			--
			-- Note that `on_grid' may be set to `True' and `item' may be non-Void
			-- in the case where the pointer leaves a grid from a location where there.
		do
			if pointer_leave_item_actions_internal = Void then
				create pointer_leave_item_actions_internal
			end
			Result := pointer_leave_item_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	virtual_position_changed_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]] is
			-- Actions to be performed upon next idle after `virtual_x_position' or `virtual_y_position' changed in grid.
			-- Arguments (with names for clarity)
			--
			-- a_virtual_x_position: INTEGER -- New `virtual_x_position' of grid.
			-- a_virtual_y_position: INTEGER -- New `virtual_y_position' of grid.
		do
			if virtual_position_changed_actions_internal = Void then
				create virtual_position_changed_actions_internal
			end
			Result := virtual_position_changed_actions_internal
		end

	virtual_size_changed_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]] is
			-- Actions to be performed upon next idle after `virtual_width' or `virtual_height' changed in grid.
			-- Arguments (with names for clarity)
			--
			-- a_virtual_width: INTEGER -- New `virtual_width' of grid.
			-- a_virtual_height: INTEGER -- New `virtual_height' of grid.
		do
			if virtual_size_changed_actions_internal = Void then
				create virtual_size_changed_actions_internal
			end
			Result := virtual_size_changed_actions_internal
		end
		
	pre_draw_overlay_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, EV_GRID_ITEM, INTEGER, INTEGER]] is
			-- Actions to be performed before the features of an item cell in `Current' have been drawn but after the background of
			-- the cell has been drawn. The four pieces of event data are:
			-- drawable: EV_DRAWABLE The drawable into which you may draw to overlay onto the already drawn background.
			-- grid_item: EV_GRID_ITEM The item which has just been drawn, may be Void in the case that an
			-- item cell is being drawn which does not contain an item.
			-- a_column_index: INTEGER The column index of the grid cell that has just been drawn.
			-- a_row_index: INTEGER The row index of the grid cell that has just been drawn.

			-- This is useful for drawing additional border styles or other such effects. The upper left corner
			-- of the item cell starts at coordinates 0x0 in the passed drawable. All drawing Performed
			-- in the drawable is clipped to `width' of the column at `a_column_index' and `height' of row at `a_row_index'.
			-- Note that the upper left corner of `drawable' corresponds to the upper left corner of the item
			-- cell and not the actual items horizontal position within the cell which may be greater than 0 if
			-- the item is within a tree structure. Use `horizontal_indent' of the item to determine this.
		do
			if pre_draw_overlay_actions_internal = Void then
				create pre_draw_overlay_actions_internal
			end
			Result := pre_draw_overlay_actions_internal
		ensure
			not_void: Result /= Void
		end

	post_draw_overlay_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, EV_GRID_ITEM, INTEGER, INTEGER]] is
			-- Actions to be performed after an item cell in `Current'  has been drawn. The four pieces of event data are:
			-- drawable: EV_DRAWABLE The drawable into which you may draw to overlay onto the already drawn item.
			-- grid_item: EV_GRID_ITEM The item which has just been drawn, may be Void in the case that an
			-- item cell is being drawn which does not contain an item.
			-- a_column_index: INTEGER The column index of the grid cell that has just been drawn.
			-- a_row_index: INTEGER The row index of the grid cell that has just been drawn.

			-- This is useful for drawing additional border styles or other such effects. The upper left corner
			-- of the item cell starts at coordinates 0x0 in the passed drawable. All drawing Performed
			-- in the drawable is clipped to `width' of the column at `a_column_index' and `height' of row at `a_row_index'.
			-- Note that the upper left corner of `drawable' corresponds to the upper left corner of the item
			-- cell and not the actual items horizontal position within the cell which may be greater than 0 if
			-- the item is within a tree structure. Use `horizontal_indent' of the item to determine this.
		do
			if post_draw_overlay_actions_internal = Void then
				create post_draw_overlay_actions_internal
			end
			Result := post_draw_overlay_actions_internal
		ensure
			not_void: Result /= Void
		end

	fill_background_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, INTEGER, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when part of the background area of the grid that is outside of the
			-- area filled by `row_count' and `column_count' needs to be redrawn.
			-- By default, the grid fills the area in its `background_color'. If one or more agents are
			-- contained in this action sequence, the grid is no longer responsible for drawing its background
			-- and the agents must redraw this area, otherwis graphical glitches may appear.
			-- The five pieces of event data passed are:
			-- drawable: EV_DRAWABLE The drawable into which you must draw the background.
			-- virtual_x: INTEGER The virtual x position of the area to be redrawn.
			-- virtual_y: INTEGER The virtual y position of the area to be redrawn.
			-- width: INTEGER The width of the area that must be redrawn.
			-- height: INTEGER The height of the area that must be redrawn.
			-- The upper left corner of the drawing must start at 0x0 in `drawable' with an area given by `width'
			-- and `height'. The virtual coordinates specify the position of the area in relation to the grid's
			-- virtual positiion which is essential if you wish to draw something such as a texture which must be
			-- matched based on its position.
			-- Note that `fill_background_actions' may be fired multiple times to fill the complete area of the
			-- background that is invalid.
		do
			if fill_background_actions_internal = Void then
				create fill_background_actions_internal
			end
			Result := fill_background_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	item_activate_actions_internal: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_POPUP_WINDOW]]
			-- Implementation of once per object `item_activate_actions'.

	item_drop_actions_internal: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, ANY]]
			-- Implementation of once per object  `item_drop_actions'.

	item_deactivate_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_deactivate_actions'.

	item_select_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_select_actions'.

	item_deselect_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_deselect_actions'.

	row_select_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_select_actions'.

	column_select_actions_internal: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]]
			-- Implementation of once per object `column_select_actions'.

	row_deselect_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_deselect_actions'.

	column_deselect_actions_internal: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]]
			-- Implementation of once per object `column_deselect_actions'.
			
	pointer_motion_item_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `motion_actions_internal'.
			
	pointer_double_press_item_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `double_press_actions_internal'.
		
	pointer_leave_item_actions_internal: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]]	
			-- Implementation of once per object `pointer_leave_item_actions_internal'.
	
	pointer_enter_item_actions_internal: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]]	
			-- Implementation of once per object `pointer_enter_item_actions_internal'.
		
	pointer_button_press_item_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `pointer_button_press_item_actions_internal'.
		
	pointer_button_release_item_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `pointer_button_release_item_actions_internal'.
			
	row_expand_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_expand_actions_internal'.
			
	row_collapse_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_collapse_actions_internal'.

	virtual_position_changed_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]]
			-- Implementation of once per object `virtual_position_changed_actions'.

	virtual_size_changed_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]]
			-- Implementation of once per object `virtual_size_changed_actions'.

	pre_draw_overlay_actions_internal: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, EV_GRID_ITEM, INTEGER, INTEGER]]
			-- Implementation of once per object `pre_draw_overlay_actions'.

	post_draw_overlay_actions_internal: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, EV_GRID_ITEM, INTEGER, INTEGER]]
			-- Implementation of once per object `post_draw_overlay_actions'.

	fill_background_actions_internal: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, INTEGER, INTEGER, INTEGER, INTEGER]];

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

