indexing
	description:
		"Action sequences for EV_GRID_I."
	keywords: "event, action, sequence"

deferred class
	 EV_GRID_ACTION_SEQUENCES_I


feature -- Event handling

	item_deactivate_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deactivated.
		do
			if item_deactivate_actions_internal = Void then
				create item_deactivate_actions_internal
			end
			Result := item_deactivate_actions_internal
		ensure
			not_void: Result /= Void
		end

	item_select_actions: EV_GRID_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected
		do
			if item_select_actions_internal = Void then
				create item_select_actions_internal
			end
			Result := item_select_actions_internal
		ensure
			not_void: Result /= Void
		end

	row_select_actions: EV_GRID_ROW_ACTION_SEQUENCE is
			-- Actions to be performed when a row is selected
		do
			if row_select_actions_internal = Void then
				create row_select_actions_internal
			end
			Result := row_select_actions_internal
		ensure
			not_void: Result /= Void
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
		
	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a screen pointer moves over a grid.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- x_pos: INTEGER		The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER		The y position of the motion in grid virtual coordinates.
			-- item: EV_GRID_ITEM	If the motion occurred above an item, this is the pointed item, otherwise
			--						this argument is set to `Void'.
		do
			if pointer_motion_actions_internal = Void then
				create pointer_motion_actions_internal
			end
			Result := pointer_motion_actions_internal
		ensure
			result_not_void: Result /= Void
		end

	active_item_setup_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_WINDOW]] is
			-- Actions to be performed to setup an item that is currently activated.
			-- Overrides default setup of activatable items.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- activate_item: EV_GRID_ITEM		The item that is currently activated.
			-- popup_window: EV_WINDOW		The popup window used to interactively edit `activate_item', this
			--						window has already been sized and positioned by the grid.
		do
			if active_item_setup_actions_internal = Void then
				create active_item_setup_actions_internal
			end
			Result := active_item_setup_actions_internal
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
			if pointer_button_press_actions_internal = Void then
				create pointer_button_press_actions_internal
			end
			Result := pointer_button_press_actions_internal
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
			if pointer_double_press_actions_internal = Void then
				create pointer_double_press_actions_internal
			end
			Result := pointer_double_press_actions_internal
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
			if pointer_button_release_actions_internal = Void then
				create pointer_button_release_actions_internal
			end
			Result := pointer_button_release_actions_internal
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
			if pointer_enter_actions_internal = Void then
				create pointer_enter_actions_internal
			end
			Result := pointer_enter_actions_internal
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
			if pointer_leave_actions_internal = Void then
				create pointer_leave_actions_internal
			end
			Result := pointer_leave_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	item_deactivate_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_deactivate_actions'.

	item_select_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_select_actions'.

	row_select_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_select_actions'.
			
	pointer_motion_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `motion_actions_internal'.

	active_item_setup_actions_internal: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM, EV_WINDOW]]
			-- Implementation of once per object `active_item_setup_actions'
			
	pointer_double_press_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `double_press_actions_internal'.
		
	pointer_leave_actions_internal: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]]	
			-- Implementation of once per object `pointer_leave_actions_internal'.
	
	pointer_enter_actions_internal: ACTION_SEQUENCE [TUPLE [BOOLEAN, EV_GRID_ITEM]]	
			-- Implementation of once per object `pointer_enter_actions_internal'.
		
	pointer_button_press_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `pointer_button_press_actions_internal'.
		
	pointer_button_release_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `pointer_button_release_actions_internal'.
			
	row_expand_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_expand_actions_internal'.
			
	row_collapse_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_collapse_actions_internal'.

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
