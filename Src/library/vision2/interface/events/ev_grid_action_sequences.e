indexing
	description: "Objects that represent action sequences for EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ACTION_SEQUENCES

feature -- Access

	item_drop_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, ANY]] is
			-- Actions to be performed when a pebble is dropped on an item.
		do
			Result := implementation.item_drop_actions
		ensure
			result_not_void: Result /= Void
		end

	item_activate_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_POPUP_WINDOW]] is
			-- Actions to be performed to override the default `activate' setup of an item, see {EV_GRID_EDITABLE_ITEM}.activate_action.
			-- Useful for repositioning `popup_window', which will then be shown automatically by the grid.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- activate_item: EV_GRID_ITEM -- The item that is currently activated.
			-- popup_window: EV_POPUP_WINDOW -- The popup window used to interactively edit `activate_item', window has already been sized and positioned.
		do
			Result := implementation.item_activate_actions
		ensure
			result_not_void: Result /= Void
		end

	item_deactivate_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item has been deactivated.
		do
			Result := implementation.item_deactivate_actions
		ensure
			result_not_void: Result /= Void
		end

	item_select_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected.
		do
			Result := implementation.item_select_actions
		ensure
			result_not_void: Result /= Void
		end

	item_deselect_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deselected.
		do
			Result := implementation.item_deselect_actions
		ensure
			result_not_void: Result /= Void
		end

	row_select_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is selected.
		do
			Result := implementation.row_select_actions
		ensure
			result_not_void: Result /= Void
		end

	row_deselect_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is deselected.
		do
			Result := implementation.row_deselect_actions
		ensure
			result_not_void: Result /= Void
		end

	column_select_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]] is
			-- Actions to be performed when a column is selected
		do
			Result := implementation.column_select_actions
		ensure
			result_not_void: Result /= Void
		end

	column_deselect_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_COLUMN]] is
			-- Actions to be performed when a column is deselected
		do
			Result := implementation.column_deselect_actions
		ensure
			result_not_void: Result /= Void
		end

	row_expand_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is expanded.
		do
			Result := implementation.row_expand_actions
		ensure
			result_not_void: Result /= Void
		end

	row_collapse_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is collapsed.
		do
			Result := implementation.row_collapse_actions
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
			Result := implementation.pointer_motion_item_actions
		ensure
			result_not_void: Result /= Void
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
			Result := implementation.pointer_button_press_item_actions
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
			Result := implementation.pointer_double_press_item_actions
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
			Result := implementation.pointer_button_release_item_actions
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
			Result := implementation.pointer_enter_item_actions
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
			-- in the case where the pointer leaves a grid from a location where there
			-- was an item contained.
		do
			Result := implementation.pointer_leave_item_actions
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
			Result := implementation.virtual_position_changed_actions
		ensure
			result_not_void: Result /= Void
		end

	virtual_size_changed_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]] is
			-- Actions to be performed upon next idle after `virtual_width' or `virtual_height' changed in grid.
			-- Arguments (with names for clarity)
			--
			-- a_virtual_width: INTEGER -- New `virtual_width' of grid.
			-- a_virtual_height: INTEGER -- New `virtual_height' of grid.
		do
			Result := implementation.virtual_size_changed_actions
		ensure
			result_not_void: Result /= Void
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
			Result := implementation.pre_draw_overlay_actions
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
			Result := implementation.post_draw_overlay_actions
		ensure
			not_void: Result /= Void
		end

	fill_background_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE, INTEGER, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when part of the background area of the grid that is outside of the
			-- area filled by `row_count' and `column_count' needs to be redrawn.
			-- By default, the grid fills the area in its `background_color'. If one or more agents are
			-- contained in this action sequence, the grid is no longer responsible for drawing its background
			-- and the agents must redraw this area, otherwise graphical glitches may appear.
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
			Result := implementation.fill_background_actions
		ensure
			not_void: Result /= Void
		end


feature {NONE} -- Implementation

	implementation: EV_GRID_ACTION_SEQUENCES_I;

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

