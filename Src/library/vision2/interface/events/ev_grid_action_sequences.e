indexing
	description: "Objects that represent action sequences for EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ACTION_SEQUENCES


feature {NONE} -- Implementation

	implementation: EV_GRID_ACTION_SEQUENCES_I

feature -- Access

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
			
			-- x_pos: INTEGER		The x position of the motion relative to the left edge of the viewable
			--						area of the grid. 
			-- y_pos: INTEGER		The y position of the motion relative to the top of the viewable
			--						area of the grid.
			-- item: EV_GRID_ITEM	If the motion occurred above an item, this is the pointed item, otherwise
			--						this argument is set to `Void'.
		do
			Result := implementation.pointer_motion_actions
		ensure
			result_not_void: Result /= Void
		end
		
	pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]] is
			-- Actions to be performed when a double press event is received by a grid.
			-- Arguments (with names for clarity):
			
			-- x_pos: INTEGER		The x position of the motion relative to the left edge of the viewable
			--						area of the grid. 
			-- y_pos: INTEGER		The y position of the motion relative to the top of the viewable
			--						area of the grid.
			-- a_button: INTEGER	The index of the pressed button.
			--
			-- item: EV_GRID_ITEM	If the motion occurred above an item, this is the pointed item, otherwise
			--						this argument is set to `Void'.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			result_not_void: Result /= Void
		end
		
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
