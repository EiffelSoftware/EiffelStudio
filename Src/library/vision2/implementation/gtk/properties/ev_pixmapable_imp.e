indexing
	description: 
		"Eiffel Vision pixmapable. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PIXMAPABLE_IMP
	
inherit
	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Initialization

	pixmapable_imp_initialize is
			-- Create a GtkHBox to hold a GtkPixmap.
		do
			pixmap_box := C.gtk_hbox_new (False, 0)
			C.gtk_widget_show (pixmap_box)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap that has been set.
		local
			p: POINTER
			imp: EV_PIXMAP_IMP
		do
			p := gtk_pixmap
			if p /= NULL then
				imp ?= eif_object_from_c (p)
				check
					imp_not_void: imp /= Void
				end
				Result := imp.interface
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			imp: EV_PIXMAP_IMP
			new_pixmap: EV_PIXMAP
		do
			remove_pixmap
			create new_pixmap
			new_pixmap.copy (a_pixmap)

			imp ?= new_pixmap.implementation
			C.gtk_container_add (pixmap_box, imp.c_object)
			C.gtk_widget_show (pixmap_box)		
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		local
			p: POINTER
		do
			p:= gtk_pixmap

			if p /= NULL then
				C.gtk_container_remove (pixmap_box, p)
			end

			C.gtk_widget_hide (pixmap_box)
		end

feature {NONE} -- Implementation

	gtk_pixmap: POINTER is
			-- Pointer to the GtkPixmap widget.
		do
			Result := C.gtk_container_children (pixmap_box)
			if Result /= NULL then
				Result := C.g_list_nth_data (Result, 0)
			end
		end

	pixmap_box: POINTER
			-- GtkHBox to hold the GtkPixmap.

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE

invariant
	pixmap_box_not_null: is_usable implies pixmap_box /= NULL
	pixmap_box_has_parent: is_usable implies
		C.gtk_widget_struct_parent (pixmap_box) /= NULL

end -- EV_PIXMAPABLE_IMP

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
--| Revision 1.26  2001/06/07 23:08:04  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.3  2001/02/16 00:31:27  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.13.4.2  2000/06/05 16:44:57  manus
--| Cosmetics on new lines
--|
--| Revision 1.13.4.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/05/02 18:55:23  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.23  2000/04/27 18:20:59  king
--| Corrected pixmapable to add c_object instead of gtkpixmap
--|
--| Revision 1.22  2000/04/26 17:04:49  oconnor
--| put GtkPixmap in an event box
--|
--| Revision 1.21  2000/03/03 20:08:12  king
--| Corrected indentation, structure, equivalence of pointer to void
--|
--| Revision 1.20  2000/03/03 03:33:07  oconnor
--| fixed feature: pixmap
--|
--| Revision 1.19  2000/03/03 01:45:17  oconnor
--| hack to compensate for broken pixmap feature
--|
--| Revision 1.18  2000/03/03 01:07:11  oconnor
--| added assignment attempt and check in parent
--|
--| Revision 1.17  2000/03/03 01:02:29  oconnor
--| fixed syntax error
--|
--| Revision 1.16  2000/03/03 00:59:46  oconnor
--| erimplemented for new postconditions
--|
--| Revision 1.15  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.22  2000/02/14 11:02:44  oconnor
--| added is_useable to invariants
--|
--| Revision 1.13.6.21  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.13.6.20  2000/01/28 19:00:16  king
--| Altered name of initialize to deal with problems of precursor in descendants
--|
--| Revision 1.13.6.19  2000/01/27 19:29:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.18  2000/01/19 22:12:56  king
--| Reimplemented set_pixmap to create new pixmap every time
--|
--| Revision 1.13.6.17  2000/01/18 23:41:41  oconnor
--| formatting
--|
--| Revision 1.13.6.16  2000/01/18 23:18:55  king
--| Set is_initialized to true
--|
--| Revision 1.13.6.15  2000/01/13 23:55:40  king
--| Changed implementation so it clones the given gtkpixmap
--|
--| Revision 1.13.6.14  2000/01/10 20:13:51  king
--| Show/Hide pix container for set & remove pixmap
--|
--| Revision 1.13.6.13  2000/01/07 22:47:11  king
--| Altered gtk_pixmap from attribute to function
--|
--| Revision 1.13.6.12  2000/01/07 17:13:39  oconnor
--| removed uneeded gtk_pixmap feature
--|
--| Revision 1.13.6.11  1999/12/22 20:11:39  king
--| Corrected spelling and assignment errors
--|
--| Revision 1.13.6.10  1999/12/19 20:09:03  oconnor
--| simplified implementation and onform to new interface
--|
--| Revision 1.13.6.9  1999/12/18 02:17:03  king
--| Removed reference to now defunct creat_window in create_pixmap_place
--|
--| Revision 1.13.6.8  1999/12/04 18:59:13  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.13.6.7  1999/12/03 19:01:49  oconnor
--| use new real_set_*_color features from EV_WIDGET_IMP
--|
--| Revision 1.13.6.6  1999/12/02 08:00:49  oconnor
--| Changed set color features to pass 16 bit values to the C externals.
--| Was wrongly passing 8 bit values.
--|
--| Revision 1.13.6.5  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--| relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.13.6.4  1999/11/30 22:57:28  oconnor
--| redefine interface to be of type EV_PIXMAPABLE
--|
--| Revision 1.13.6.3  1999/11/29 17:26:11  brendel
--| Restored box to deferred feature.
--|
--| Revision 1.13.6.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.13.6.1  1999/11/24 17:29:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.5  1999/11/23 23:00:16  oconnor
--| undefine initialize on repeated inherit
--|
--| Revision 1.13.2.4  1999/11/17 01:53:01  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.13.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.13.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
