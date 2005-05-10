indexing
	description: "Objects that contain action sequences for EV_GRID_COLUMN_I."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN_ACTION_SEQUENCES_I

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is selected.
		do
			if select_actions_internal = Void then
				create select_actions_internal
			end
			Result := select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is deselected.
		do
			if deselect_actions_internal = Void then
				create deselect_actions_internal
			end
			Result := deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.

	deselect_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `deselect_actions'.

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
