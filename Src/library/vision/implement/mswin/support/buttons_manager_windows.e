indexing
	description: "This class is a MS_WINDOWS mouse button manager"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTONS_MANAGER_WINDOWS

feature {NONE} -- Implementation

	left_button_down_implementation: BOOLEAN_REF is
			-- Implementation for left_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	left_button_down: BOOLEAN is
			-- Is the left button down?
		do
			Result := left_button_down_implementation.item
		end

	middle_button_down_implementation: BOOLEAN_REF is
			-- Implementation for the middle_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	middle_button_down: BOOLEAN is
			-- Is the middle button down?
		do
			Result := middle_button_down_implementation.item
		end

	right_button_down_implementation: BOOLEAN_REF is
			-- Implementation for right_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	right_button_down: BOOLEAN is
			-- Is the right button down?
		do
			Result := right_button_down_implementation.item
		end

	buttons_state, buttons: BUTTONS is
			-- State of the mouse buttons
		do
			create Result.make (5)
			Result.put (left_button_down, 1)
			Result.put (middle_button_down, 2)
			Result.put (right_button_down, 3)
			Result.put (False, 4)
			Result.put (False, 5)
		end

end -- class BUTTONS_MANAGER_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

