indexing
	description: 
		"EiffelVision cell. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CELL_I

inherit
	EV_CONTAINER_I

feature -- Element change

	extend (an_item: like item) is
			-- Ensure that structure includes `an_item'.
		do	
			replace (an_item)
		end

end -- class EV_CELL

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
--| Revision 1.4  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.6.1  2000/05/03 19:09:04  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.7  2000/02/08 20:33:59  rogers
--| Un-commented replace in extend.
--|
--| Revision 1.1.2.6  2000/02/08 18:04:34  king
--| Commented out replace to make compilation
--|
--| Revision 1.1.2.5  2000/02/08 09:30:21  oconnor
--| replaced put with extend
--|
--| Revision 1.1.2.4  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.2.3  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.2  2000/01/18 17:59:52  oconnor
--| formatting
--|
--| Revision 1.1.2.1  1999/12/17 18:38:53  rogers
--| Initial.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
