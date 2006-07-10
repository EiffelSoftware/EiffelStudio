indexing
	description: "Windows implementation of EV_POINTER_STYLE_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE_IMP

inherit
	EV_POINTER_STYLE_I
		redefine
			destroy
		end

create
	make

feature {NONE} -- Initlization

	make (an_interface: EV_POINTER_STYLE) is
			-- Creation method
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize
		do
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Initialize from `a_pixel_buffer'
		local
			l_pix_buf_imp: EV_PIXEL_BUFFER_IMP
		do
			l_pix_buf_imp ?= a_pixel_buffer.implementation
			set_gdkpixbuf ({EV_GTK_EXTERNALS}.gdk_pixbuf_copy (l_pix_buf_imp.gdk_pixbuf))
		end

	init_predefined (a_constant: INTEGER) is
			-- Initialized a predefined cursor.
		do
			predefined_cursor_code := a_constant
		end

	init_from_cursor (a_cursor: EV_CURSOR) is
			-- Initialize from `a_cursor'
		local
			a_pix_imp: EV_PIXMAP_IMP
		do
			a_pix_imp ?= a_cursor.implementation
			set_gdkpixbuf (a_pix_imp.pixbuf_from_drawable)
		end

feature -- Command

	destroy is
			-- Destroy
		do
			set_gdkpixbuf (default_pointer)
		end

feature -- Query

	width: INTEGER is
			-- Width of pointer style.
		do
			if gdk_pixbuf /= default_pointer then
				Result := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_width (gdk_pixbuf)
			else
				Result := {EV_GTK_EXTERNALS}.gdk_display_get_default_cursor_size ({EV_GTK_EXTERNALS}.gdk_display_get_default)
			end
		end

	height: INTEGER is
			-- Height of pointer style.
		do
			if gdk_pixbuf /= default_pointer then
				Result := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_height (gdk_pixbuf)
			else
				Result := {EV_GTK_EXTERNALS}.gdk_display_get_default_cursor_size ({EV_GTK_EXTERNALS}.gdk_display_get_default)
			end
		end

feature -- Implementation

	set_gdkpixbuf (a_pixbuf: POINTER) is
			-- Set gdk_pixbuf to `a_pixbuf'.
		do
			if gdk_pixbuf /= default_pointer then
				{EV_GTK_EXTERNALS}.object_unref (gdk_pixbuf)
			end
			gdk_pixbuf := a_pixbuf
		end

	gdk_pixbuf: POINTER
		-- Pixbuf used for pointer style implementation.

feature {EV_ANY_HANDLER} -- Implementation

	predefined_cursor_code: INTEGER;
		-- Predefined cursor code used for selecting platform cursors.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end
