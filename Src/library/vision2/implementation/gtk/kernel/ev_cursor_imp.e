indexing
	description: "Eiffel Vision cursor. GTK+ implementation."
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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a cursor with the default appearance.
		do
			base_make (an_interface)
			gdk_cursor := C.gdk_cursor_new ((create {EV_CURSOR_CODE_IMP}).standard)
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
			-- Toolkit pointer identification code.

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
		--| FIXME need precondition
		do
			code := a_code
--| FIXME			if gdk_cursor /= Default_pointer then
--| FIXME				C.gdk_cursor_unref (gdk_cursor)
--| FIXME			end
			if gdk_cursor /= Default_pointer then
				C.gdk_cursor_destroy (gdk_cursor)
			end
			gdk_cursor := C.gdk_cursor_new (a_code)
		end

	destroy is
		do
--| FIXME			if gdk_cursor /= Default_pointer then
--| FIXME				C.gdk_cursor_unref (gdk_cursor)
--| FIXME			end
			if gdk_cursor /= Default_pointer then
				C.gdk_cursor_destroy (gdk_cursor)
			end
			is_destroyed := True
			destroy_just_called := True
		end

feature {EV_ANY_I} -- Implementation

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end

	interface: EV_CURSOR

	gdk_cursor: POINTER

end -- class EV_CURSOR_IMP

--!----------------------------------------------------------------
--! EiffelVision Library: Example for the ISE EiffelVision library.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.4.13  2000/02/14 11:01:28  oconnor
--| began implementation, incomplete
--|
--| Revision 1.5.4.12  2000/02/11 04:51:03  oconnor
--| last log message erroneous, should say: partialy implemented destroy
--|
--| Revision 1.5.4.11  2000/02/11 04:49:14  oconnor
--| attached GTK+ exception system to Eiffel
--|
--| Revision 1.5.4.10  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.5.4.9  2000/02/03 23:26:30  brendel
--| Added not yet implemented features code and set_code.
--|
--| Revision 1.5.4.8  2000/01/29 02:40:40  brendel
--| Added inheritance of EV_ANY.
--|
--| Revision 1.5.4.7  2000/01/28 23:20:37  brendel
--| Revised. Now only has `pixmap' and `set_pixmap'.
--| Might be added later: set_code.
--|
--| Revision 1.5.4.6  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.4.5  1999/12/13 19:46:40  oconnor
--| temp hack to compile
--|
--| Revision 1.5.4.4  1999/12/09 18:14:32  oconnor
--| commented out make_with_*
--|
--| Revision 1.5.4.3  1999/12/09 02:28:36  oconnor
--| king: new external  c_gtk_create_cursor_with_pixmap, fixed reading pixmap from file
--|
--| Revision 1.5.4.2  1999/12/04 18:34:57  oconnor
--| inhrit EV_ANY_IMP
--|
--| Revision 1.5.4.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
