indexing
	description: "Objects that represent action sequences for EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ACTION_SEQUENCES

feature -- Access

	active_item_setup_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_WINDOW]] is
			-- Actions to be performed to setup an item that is currently activated.
			-- Overrides default setup of activatable items.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- activate_item: EV_GRID_ITEM		The item that is currently activated.
			-- popup_window: EV_WINDOW		The popup window used to interactively edit `activate_item', this
			--						window has already been sized and positioned by the grid.
		do
			Result := implementation.active_item_setup_actions
		end

	item_deactivate_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item has been deactivated.
		do
			Result := implementation.item_deactivate_actions
		end

	item_select_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected.
		do
			Result := implementation.item_select_actions
		ensure
			not_void: Result /= Void
		end

	row_select_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when an row is deselected.
		do
			Result := implementation.row_select_actions
		ensure
			not_void: Result /= Void
		end
		
	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a screen pointer moves over a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER				The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER				The y position of the motion in grid virtual coordinates.
			-- item: EV_GRID_ITEM			If the motion occurred above an item, this is the pointed item, otherwise
			--								this argument is set to `Void'.
		do
			Result := implementation.pointer_motion_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER				The x position of the press in grid virtual coordinates.
			-- y_pos: INTEGER				The y position of the press in grid virtual coordinates.
			-- a_button: INTEGER			The index of the pressed button.
			-- item: EV_GRID_ITEM			If the press occurred above an item, this is the pointed item, otherwise
			--								this argument is set to `Void'.
		do
			Result := implementation.pointer_button_press_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer double press event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER				The x position of the double press in grid virtual coordinates.
			-- y_pos: INTEGER				The y position of the double press in grid virtual coordinates.
			-- a_button: INTEGER			The index of the pressed button.
			-- item: EV_GRID_ITEM			If the double press occurred above an item, this is the pointed item, otherwise
			--								this argument is set to `Void'.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer release event is received by a grid.
			-- Arguments (with names for clarity):
			--
			-- x_pos: INTEGER				The x position of the release in grid virtual coordinates.
			-- y_pos: INTEGER				The y position of the release in grid virtual coordinates.
			-- a_button: INTEGER			The index of the released button.
			-- item: EV_GRID_ITEM			If the release occurred above an item, this is the pointed item, otherwise
			--								this argument is set to `Void'.
		do
			Result := implementation.pointer_button_release_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_enter_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer enter event is received by a grid or grid item
			-- Arguments (with names for clarity):
			--
			-- on_grid: BOOLEAN				Did the enter event occur for the grid?
			-- item: EV_GRID_ITEM			If the enter event occurred for an item, this is the item.
			--
			--								Note that `on_grid' may be set to `True' and `item' may be non-Void
			--								in the case where the pointer enters a grid at a location where there
			--								is an item contained.
		do
			Result := implementation.pointer_enter_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_leave_actions: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]] is
			-- Actions to be performed when a pointer leave event is received by a grid or grid item
			-- Arguments (with names for clarity):
			--
			-- on_grid: BOOLEAN				Did the leave event occur for the grid?
			-- item: EV_GRID_ITEM			If the leave event occurred for an item, this is the item.
			--
			--								Note that `on_grid' may be set to `True' and `item' may be non-Void
			--								in the case where the pointer leaves a grid from a location where there
			--								was an item contained.
		do
			Result := implementation.pointer_enter_actions
		ensure
			result_not_void: Result /= Void
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
