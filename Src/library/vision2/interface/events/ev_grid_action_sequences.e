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
