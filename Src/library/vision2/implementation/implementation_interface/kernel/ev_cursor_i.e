indexing
	description: "Eiffel Vision cursor. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CURSOR_I

obsolete
	"Don't use it. EV_CURSOR now inherit from EV_PIXMAP."

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Used as pointer cursor.
		deferred
		end

	code: INTEGER is
			-- Toolkit pointer identification code.
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		ensure
			assigned: pixmap.is_equal (a_pixmap)
		end

	set_code (a_code: INTEGER) is
			-- Set `code' to `a_code'.
		deferred
		ensure
			assigned: code = a_code
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CURSOR

end -- class EV_CURSOR_I

--!-----------------------------------------------------------------------------
--! EiffelVision Library: Example for the ISE EiffelVision library.
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
--| Revision 1.8  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.2.3  2000/05/04 17:36:02  brendel
--| Moved obsolete clause.
--|
--| Revision 1.4.2.2  2000/05/04 04:16:17  pichery
--| This class is now Obsolete and marked as it.
--|
--| Revision 1.4.2.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.4.7  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.4.4.6  2000/02/03 23:19:19  brendel
--| Added feature `set_code' and `code'.
--|
--| Revision 1.4.4.5  2000/01/28 23:20:37  brendel
--| Revised. Now only has `pixmap' and `set_pixmap'.
--| Might be added later: set_code.
--|
--| Revision 1.4.4.4  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.4.3  1999/12/09 03:15:05  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.4.4.2  1999/11/30 22:50:47  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.4.4.1  1999/11/24 17:30:05  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
