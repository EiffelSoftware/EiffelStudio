indexing
	description: 
		"Eiffel Vision label. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LABEL_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- implementation

	interface: EV_LABEL	
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
	
end --class EV_LABEL_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.2  2000/07/28 17:57:36  king
--| Label now inherits from EV_FONTABLE
--|
--| Revision 1.13.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.7  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.13.6.6  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.5  2000/01/18 19:38:19  oconnor
--| removed inheritance of fontable
--|
--| Revision 1.13.6.4  2000/01/18 07:30:36  oconnor
--| formatting and labels
--|
--| Revision 1.13.6.3  1999/12/17 18:10:31  rogers
--| Redefined interface to be of more refined type. make_with_text is no longer
--| required.
--|
--| Revision 1.13.6.2  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.13.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
