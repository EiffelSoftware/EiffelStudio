indexing
	description: "Eiffel Vision cursor. GTK+ implementation."
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

	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a cursor with the default appearance.
		do
			base_make (an_interface)
			c_object := C.gdk_cursor_new ((create {EV_CURSOR_CODE_IMP}).standard)
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Used as pointer cursor.
	code: INTEGER
			-- Toolkit pointer identification code.

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		local
			pix_imp: EV_PIXMAP_IMP
			pix_mask: POINTER
			pix_val: POINTER
			fg, bg: POINTER
		do
			create pixmap
			pixmap.copy (a_pixmap)
			code := 0

			if c_object /= NULL then
				C.gdk_cursor_destroy (c_object)
			end

			pix_imp ?= a_pixmap.implementation

			C.gtk_pixmap_get (pix_imp.gtk_pixmap, $pix_val, $pix_mask)

			fg := C.c_gdk_color_struct_allocate
			bg := C.c_gdk_color_struct_allocate
			C.set_gdk_color_struct_red (fg, 65535)
			C.set_gdk_color_struct_green (fg, 65535)
			C.set_gdk_color_struct_blue (fg, 65535)

			c_object := C.gdk_cursor_new_from_pixmap (pix_mask, pix_mask, $fg, $bg, 0, 0)

			C.c_gdk_color_struct_free (fg)
			C.c_gdk_color_struct_free (bg)
			
		end

	set_code (a_code: INTEGER) is
			-- Set `code' to `a_code'.
		--| FIXME need precondition
		do
			code := a_code
			if c_object /= NULL then
				C.gdk_cursor_destroy (c_object)
			end
			c_object := C.gdk_cursor_new (a_code)
			pixmap := Void
		end

	destroy is
		do
			if c_object /= NULL then
				C.gdk_cursor_destroy (c_object)
			end
			is_destroyed := True
			code := 0
			pixmap := Void
		end

feature {EV_ANY_I} -- Implementation

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end

	interface: EV_CURSOR

	c_object: POINTER
		-- Pointer to the gdk cursor.

end -- class EV_CURSOR_IMP

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
--| Revision 1.12  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.2.4  2001/05/18 18:46:08  king
--| Updated for destroy_just_called
--|
--| Revision 1.5.2.3  2000/05/04 19:26:40  king
--| Made obsolete
--|
--| Revision 1.5.2.2  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/05/02 18:55:21  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.9  2000/04/26 17:04:48  oconnor
--| put GtkPixmap in an event box
--|
--| Revision 1.8  2000/03/15 22:44:05  king
--| Revised cursor imp, implemented pixmap functionality
--|
--| Revision 1.7  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
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
