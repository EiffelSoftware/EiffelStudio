indexing
	description: "Objects that represent action sequences for EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ACTION_SEQUENCES

feature -- Access

	item_drop_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, ANY]] is
			-- Actions to be performed when a pebble is dropped on an item.
		do
			Result := implementation.item_drop_actions
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
		
	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a screen pointer moves over a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
			-- item: EV_GRID_ITEM -- If the motion occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			Result := implementation.pointer_motion_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the press in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the press in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the pressed button.
			-- item: EV_GRID_ITEM -- If the press occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			Result := implementation.pointer_button_press_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer double press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the double press in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the double press in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the pressed button.
			-- item: EV_GRID_ITEM -- If the double press occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer release event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER -- The x position of the release in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the release in grid virtual coordinates.
			-- a_button: INTEGER -- The index of the released button.
			-- item: EV_GRID_ITEM -- If the release occurred above an item, this is the pointed item, otherwise argument is set to `Void'.
		do
			Result := implementation.pointer_button_release_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_enter_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
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
			Result := implementation.pointer_enter_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_leave_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
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
			Result := implementation.pointer_enter_actions
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
		end

	virtual_size_changed_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]] is
			-- Actions to be performed upon next idle after `virtual_width' or `virtual_height' changed in grid.
			-- Arguments (with names for clarity)
			--
			-- a_virtual_width: INTEGER -- New `virtual_width' of grid.
			-- a_virtual_height: INTEGER -- New `virtual_height' of grid.
		do
			Result := implementation.virtual_size_changed_actions
		end
		
feature {NONE} -- Implementation

	implementation: EV_GRID_ACTION_SEQUENCES_I
		
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
