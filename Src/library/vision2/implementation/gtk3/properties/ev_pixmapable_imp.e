note
	description:
		"Eiffel Vision pixmapable. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Initialization

	pixmapable_imp_initialize
			-- Create a GtkHBox to hold a GtkPixmap.
		do
			pixmap_box := {GTK3}.gtk_box_new ( {GTK_ORIENTATION}.gtk_orientation_horizontal, 0)
		end

feature -- Access

	pixmap: detachable EV_PIXMAP
			-- Pixmap shown in `Current'
		do
			if attached internal_pixmap as l_internal_pixmap then
				Result := l_internal_pixmap.attached_interface.twin
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		local
			l_internal_pixmap: like internal_pixmap
		do
			l_internal_pixmap ?= a_pixmap.twin.implementation
			check l_internal_pixmap /= Void then end
			internal_pixmap := l_internal_pixmap
			internal_set_pixmap (l_internal_pixmap, l_internal_pixmap.width, l_internal_pixmap.height)
		end

	remove_pixmap
			-- Assign Void to `pixmap'.
		do
			internal_pixmap := Void
			internal_remove_pixmap
			{GTK}.gtk_widget_hide (pixmap_box)
		end

feature {EV_ANY_I} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		local
			gtk_pix_wid: POINTER
			l_internal_pixmap: like internal_pixmap
			l_pixbuf: POINTER
		do
			internal_remove_pixmap
			l_internal_pixmap ?= internal_pixmap
			check l_internal_pixmap /= Void then end
			if a_width /= l_internal_pixmap.width or else a_height /= l_internal_pixmap.height then
				-- We need to scale pixmap before it is placed in to pixmap holder			
				a_pixmap_imp.stretch (a_width, a_height)
			end
			l_pixbuf := {GTK}.gdk_pixbuf_get_from_surface (a_pixmap_imp.cairo_surface, 0, 0, a_width, a_height)
			gtk_pix_wid := {GTK2}.gtk_image_new_from_pixbuf (l_pixbuf)
			{GTK}.gtk_widget_show (gtk_pix_wid)
			{GTK}.gtk_container_add (pixmap_box, gtk_pix_wid)
			{GTK}.gtk_widget_show (pixmap_box)
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		local
			p: POINTER
		do
			p := gtk_pixmap
			if p /= default_pointer then
				--| We want p to be deallocated by gtk.
				{GTK}.gtk_container_remove (pixmap_box, p)
			end
		end

	internal_pixmap: detachable EV_PIXMAP_IMP
			-- Internal stored pixmap.		

feature {NONE} -- Implementation

	gtk_pixmap: POINTER
			-- Pointer to the GtkPixmap widget.
		local
			a_child_list, l_null: POINTER
		do
			a_child_list := {GTK}.gtk_container_get_children (pixmap_box)
			if a_child_list /= l_null then
				Result := {GTK}.g_list_nth_data (a_child_list, 0)
				{GTK}.g_list_free (a_child_list)
			end
		end

	pixmap_box: POINTER
			-- GtkHBox to hold the GtkPixmap.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PIXMAPABLE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_PIXMAPABLE_IMP
