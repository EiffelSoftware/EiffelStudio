--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision cursor, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_IMP

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
			create ccode.make
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
			make_by_predefined_id (cwel_integer_to_pointer (code))
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
