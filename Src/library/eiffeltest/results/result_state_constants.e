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

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
