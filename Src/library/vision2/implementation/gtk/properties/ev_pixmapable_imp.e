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
			pixmap_box := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- 
		do
			if internal_pixmap /= Void then
				Result := clone (internal_pixmap.interface)
			end		
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			remove_pixmap
			--internal_pixmap := clone (a_pixmap)
			internal_pixmap ?= a_pixmap.implementation	
			internal_set_pixmap (internal_pixmap, internal_pixmap.width, internal_pixmap.height)
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		do	
			internal_pixmap := Void
			internal_remove_pixmap
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)
		end
		
feature {EV_ITEM_PIXMAP_SCALER_I} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER) is
			-- 
		local
			gtk_pix_wid: POINTER
		do
			if a_width /= internal_pixmap.width or else a_height /= internal_pixmap.height then
				-- We need to scale pixmap before it is placed in to pixmap holder
				internal_remove_pixmap
				a_pixmap_imp.stretch (a_width, a_height)
			end
			gtk_pix_wid := feature {EV_GTK_EXTERNALS}.gtk_pixmap_new (a_pixmap_imp.drawable, a_pixmap_imp.mask)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (gtk_pix_wid)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (pixmap_box, gtk_pix_wid)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (pixmap_box)				
		end
		
	internal_remove_pixmap is
			-- Remove pixmap from Current
		local
			p: POINTER
		do	
			p := gtk_pixmap
			if p /= NULL then
				--| We want p to be deallocated by gtk.
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (pixmap_box, p)
			end
		end	

	internal_pixmap: EV_PIXMAP_IMP
			-- Internal stored pixmap.		

feature {NONE} -- Implementation

	gtk_pixmap: POINTER is
			-- Pointer to the GtkPixmap widget.
		local
			a_child_list: POINTER
		do
			a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (pixmap_box)
			if a_child_list /= NULL then
				Result := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_child_list, 0)
				feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
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

