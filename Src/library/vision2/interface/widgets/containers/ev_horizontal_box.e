indexing
	description: 
		"Eiffel Vision horizontal box."
	status: "See notice at end of class"
	keywords: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_BOX

inherit
	EV_BOX
		redefine			
			implementation
		end
	
create
	default_create,
	make_for_test
	
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of horizontal box.
		do
			create {EV_HORIZONTAL_BOX_IMP} implementation.make (Current)
		end

feature {EV_ANY_I} -- Implementation
 	
	implementation: EV_HORIZONTAL_BOX_I
 			
end -- class EV_HORIZONTAL_BOX

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
--| Revision 1.12  2000/03/01 20:07:35  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.11  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.10  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.9  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.5  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.7.6.4  2000/01/28 17:44:01  oconnor
--| changed export status of  Implementation to allow access from EV_ANY_I
--|
--| Revision 1.7.6.3  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  1999/12/15 18:33:05  oconnor
--| formatting
--|
--| Revision 1.7.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/17 02:02:27  oconnor
--| updated to use new EV_WIDGET_LIST stuff
--|
--| Revision 1.7.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
