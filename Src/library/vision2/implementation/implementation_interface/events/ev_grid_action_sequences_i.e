indexing
	description:
		"Action sequences for EV_GRID_I."
	keywords: "event, action, sequence"

deferred class
	 EV_GRID_ACTION_SEQUENCES_I


feature -- Event handling

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
		
	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a screen pointer moves over a grid.
			-- Arguments of TUPLE (with names for clarity):
			
			-- x_pos: INTEGER		The x position of the motion relative to the left edge of the viewable
			--						area of the grid. 
			-- y_pos: INTEGER		The y position of the motion relative to the top of the viewable
			--						area of the grid.
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

feature {EV_ANY_I} -- Implementation

	item_select_actions_internal: EV_GRID_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `item_select_actions'.

	row_select_actions_internal: EV_GRID_ROW_ACTION_SEQUENCE
			-- Implementation of once per object `row_select_actions'.
			
	pointer_motion_actions_internal: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, EV_GRID_ITEM]]
			-- Implementation of once per object `motion_actions_internal'.

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
