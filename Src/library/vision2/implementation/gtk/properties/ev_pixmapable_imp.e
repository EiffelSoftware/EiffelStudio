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
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap that has been set.
		local
			pix_imp: EV_PIXMAP_IMP
			temp_gtk_pixmap, gdk_data, gdk_mask: POINTER
		do
			temp_gtk_pixmap := gtk_pixmap
			if temp_gtk_pixmap /= NULL then
				create Result
				pix_imp ?= Result.implementation
				C.gtk_pixmap_get (temp_gtk_pixmap, $gdk_data, $gdk_mask)
				pix_imp.copy_from_gdk_data (gdk_data, gdk_mask, pix_width, pix_height)
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			imp: EV_PIXMAP_IMP
			gtk_pix_wid: POINTER
		do
			remove_pixmap
			imp ?= a_pixmap.implementation
			pix_width := imp.width
			pix_height := imp.height
			gtk_pix_wid := C.gtk_pixmap_new (imp.drawable, imp.mask)
			C.gtk_widget_show (gtk_pix_wid)
			C.gtk_container_add (pixmap_box, gtk_pix_wid)
			C.gtk_widget_show (pixmap_box)		
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		local
			p: POINTER
		do	
			p := gtk_pixmap
			if p /= NULL then
				--C.gtk_object_ref (p)
				--| We want p to be deallocated by gtk.
				C.gtk_container_remove (pixmap_box, p)
			end
			C.gtk_widget_hide (pixmap_box)
		end

feature {NONE} -- Implementation

	gtk_pixmap: POINTER is
			-- Pointer to the GtkPixmap widget.
		local
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (pixmap_box)
			if a_child_list /= NULL then
				Result := C.g_list_nth_data (a_child_list, 0)
				C.g_list_free (a_child_list)
			end
		end
		
	pix_width, pix_height: INTEGER
		-- Stored dimensions used for creating on the fly pixmaps.

	pixmap_box: POINTER
			-- GtkHBox to hold the GtkPixmap.

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE

end -- EV_PIXMAPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

