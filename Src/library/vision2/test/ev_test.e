indexing
	description:
		"Test class for Eiffel Vision.%N%
		%Provides generic interface for all test classes."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEST2

feature -- Basic operation

	execute is
			-- Perform testing.
		deferred
		end

feature -- Access

	test_successful: BOOLEAN
			-- Should be `True' after `execute'.

	description: STRING is
			-- Description of the test, its results and other (ir)relevant information.
		deferred
		end

end -- class EV_TEST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/06/07 23:08:57  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.1  2000/05/03 19:10:21  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/03/09 02:17:21  oconnor
--| renamed class
--|
--| Revision 1.1  2000/03/01 00:41:33  brendel
--| Base class for vision2 test classes.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

