indexing
	description:
		"Apearance of a screen pointer cursor, typicaly moved by a mouse."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

--| FIXME Exactly how the codes work and if they are needed should be looked
--| into and documented here.

class
	EV_CURSOR

inherit
	EV_ANY
		redefine
			implementation,
			is_equal
		end

create
	default_create,
	make_with_code,
	make_with_pixmap

feature {NONE} -- Initialization

	make_with_code (a_code: INTEGER) is
		do
			default_create
			set_code (a_code)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP) is
		do
			default_create
			set_pixmap (a_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Used as pointer cursor.
		do
			Result := implementation.pixmap
		ensure
			bridge_ok: Result.is_equal (implementation.pixmap)
		end

	code: INTEGER is
			-- Toolkit pointer identification code.
			--| FIXME To be implemented: Constants.
		do
			Result := implementation.code
		ensure
			bridge_ok: Result = implementation.code
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			assigned: pixmap.is_equal (a_pixmap)
		end

	set_code (a_code: INTEGER) is
			-- Set `code' to `a_code'.
		do
			implementation.set_code (a_code)
		ensure
			assigned: code = a_code
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' look like `Current'.
		do
			check to_be_implemented: False end
			--|FIXME Result := pixmap.is_equal (other.pixmap)
			Result := True 
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_CURSOR_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CURSOR_IMP} implementation.make (current)
		end

end -- class EV_CURSOR

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
--| Revision 1.8  2000/03/16 01:13:15  oconnor
--| comments
--|
--| Revision 1.7  2000/03/15 22:47:20  king
--| Implemented a make_with_pixmap creation procedure
--|
--| Revision 1.6  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.12  2000/02/03 23:19:19  brendel
--| Added feature `set_code' and `code'.
--|
--| Revision 1.4.6.11  2000/02/03 22:51:15  rogers
--| Removed invariant, as it is possible for the pixmap to be Void.
--|
--| Revision 1.4.6.10  2000/01/29 01:22:42  brendel
--| Added make_with_code.
--|
--| Revision 1.4.6.9  2000/01/28 23:20:37  brendel
--| Revised. Now only has `pixmap' and `set_pixmap'.
--| Might be added later: set_code.
--|
--| Revision 1.4.6.8  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.4.6.7  2000/01/27 19:30:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.6  2000/01/15 02:18:53  oconnor
--| formatting
--|
--| Revision 1.4.6.5  1999/12/09 19:03:00  oconnor
--| TEMPORARY: commented out make_with_filename
--|
--| Revision 1.4.6.4  1999/12/02 20:15:57  brendel
--| Commented out implementation.pixmap.
--|
--| Revision 1.4.6.3  1999/12/02 20:03:36  brendel
--| Added : BOOLEAN to `is_equal'.
--|
--| Revision 1.4.6.2  1999/12/02 19:20:08  oconnor
--| new access feature pixmap and is_equal
--|
--| Revision 1.4.6.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.4  1999/11/04 23:10:53  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.3  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
