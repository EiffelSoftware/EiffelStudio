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
			--C.gtk_widget_show (pixmap_box)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap that has been set.

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			imp: EV_PIXMAP_IMP
		do
			remove_pixmap
			create pixmap
			pixmap.copy (a_pixmap)
			imp ?= pixmap.implementation
			C.gtk_container_add (pixmap_box, imp.c_object)
			C.gtk_widget_show (pixmap_box)		
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		local
			p: POINTER
		do
			pixmap := Void
			p := gtk_pixmap
			if p /= NULL then
				C.gtk_object_ref (p)
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

