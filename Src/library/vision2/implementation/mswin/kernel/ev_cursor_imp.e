indexing
	description:
		"EiffelVision cursor, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_IMP

obsolete
	"Don't use it. EV_CURSOR now inherit from EV_PIXMAP."

inherit
	EV_CURSOR_I
		redefine
			interface
		end

	WEL_CURSOR
		rename
			item as wel_item
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a cursor with the default appearance.
		local
			ccode: EV_CURSOR_CODE
		do
			base_make (an_interface)
			create ccode
			make_by_predefined_id (cwel_integer_to_pointer (ccode.standard))
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Used as pointer cursor.
		do
			check
				to_be_implemented: False
			end
		end

	code: INTEGER

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		do
			check
				to_be_implemented: False
			end
		end

	set_code (a_code: INTEGER) is
			-- Set `code' to `a_code'.
		do
			destroy_item
			code := a_code
			make_by_predefined_id (cwel_integer_to_pointer (a_code))
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			destroy_item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CURSOR

end -- class EV_CURSOR_IMP

--|----------------------------------------------------------------
--| EiffelVision Library: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.8.5  2000/08/21 22:05:53  rogers
--| Removed fixme's as this class is now obsolete.
--|
--| Revision 1.4.8.4  2000/06/12 20:15:39  rogers
--| Added two FIXME's to features that need implementing.
--|
--| Revision 1.4.8.3  2000/05/04 17:37:14  brendel
--| Moved obsolete clause.
--|
--| Revision 1.4.8.2  2000/05/04 04:24:27  pichery
--| This class is now obsolete and marked as it.
--|
--| Revision 1.4.8.1  2000/05/03 19:09:12  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/03/16 17:13:33  brendel
--| Fixed creation.
--|
--| Revision 1.7  2000/03/15 18:52:00  rogers
--| Fixed set_code.
--|
--| Revision 1.6  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.5  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.5  2000/02/03 23:19:19  brendel
--| Added feature `set_code' and `code'.
--|
--| Revision 1.4.10.4  2000/01/29 01:18:35  brendel
--| Added not yet implemented features regarding pixmap.
--|
--| Revision 1.4.10.3  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.2  1999/12/17 17:25:53  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.4.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.3  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
