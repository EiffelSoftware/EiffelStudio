indexing
	description:
		"Constants for test result states"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	RESULT_STATE_CONSTANTS

feature {NONE} -- Constants

	Passed_state, Failure_state, Exception_state: INTEGER is unique
			-- Test result states
			
end -- class RESULT_STATE_CONSTANTS

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
