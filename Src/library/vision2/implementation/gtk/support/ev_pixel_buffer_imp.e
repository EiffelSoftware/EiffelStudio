indexing
	description: "Windows implementation for EV_PIXEL_BUFFER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_IMP

inherit
	EV_PIXEL_BUFFER_I

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with size.
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver >= 2 then
				set_gdkpixbuf ({EV_GTK_EXTERNALS}.gdk_pixbuf_new ({EV_GTK_EXTERNALS}.gdk_colorspace_rgb_enum, True, 8, a_width, a_height))
			else
				create internal_pixmap.make_with_size (a_width, a_height)
			end
		end

	make (an_interface: EV_PIXEL_BUFFER) is
			-- Creation method.
		do
			base_make (an_interface)
			make_with_size (1, 1)
		end

	initialize is
			-- Initialize `Current'.
		do
				-- Creating managed pointer used for inspecting RGBA data.
			create reusable_managed_pointer.share_from_pointer (default_pointer, 0)
			set_is_initialized (True)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel data file `a_file_name'.
		local
			a_cs: EV_GTK_C_STRING
			g_error: POINTER
			filepixbuf: POINTER
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver >= 2 then
				a_cs := a_file_name
				filepixbuf := {EV_GTK_EXTERNALS}.gdk_pixbuf_new_from_file (a_cs.item, $g_error)
				if g_error /= default_pointer then
						-- GdkPixbuf could not load the image so we raise an exception.
					(create {EXCEPTIONS}).raise ("Could not load image file.")
				else
					set_gdkpixbuf (filepixbuf)
				end
			else
				internal_pixmap.set_with_named_file (a_file_name)
			end
		end

	save_to_named_file (a_file_name: STRING) is
			-- Save pixel datas to `a_file_name'
		do
			check not_implemented: False end
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Draw Current to `a_drawable'
		local
			l_pixmap_imp: EV_PIXMAP_IMP
			l_pixbuf: POINTER
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver >= 2 then
				create Result
				l_pixmap_imp ?= Result.implementation
				l_pixbuf := {EV_GTK_EXTERNALS}.gdk_pixbuf_new_subpixbuf (gdk_pixbuf, a_rect.x, a_rect.y, a_rect.width, a_rect.height)
				l_pixmap_imp.set_pixmap_from_pixbuf (l_pixbuf)
				{EV_GTK_EXTERNALS}.object_unref (l_pixbuf)
			else
				Result := internal_pixmap.sub_pixmap (a_rect)
			end
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Create a new sub pixel buffer object.
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_pixbuf: POINTER
			l_internal_pixmap: EV_PIXMAP
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver >= 2 then
				create Result
				l_imp ?= Result.implementation
				l_pixbuf := {EV_GTK_EXTERNALS}.gdk_pixbuf_new_subpixbuf (gdk_pixbuf, a_rect.x, a_rect.y, a_rect.width, a_rect.height)
					-- We need to pass in a copy of the pixbuf as subpixbuf shares the pixels.
				l_imp.set_gdkpixbuf ({EV_GTK_EXTERNALS}.gdk_pixbuf_copy (l_pixbuf))
				{EV_GTK_EXTERNALS}.object_unref (l_pixbuf)
			else
				create Result
				l_internal_pixmap := sub_pixmap (a_rect)
				l_imp ?= Result.implementation
				l_imp.set_internal_pixmap (l_internal_pixmap)
			end
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32 is
			-- Get RGBA value at `a_y', `a_y'.
		local
			byte_pos: INTEGER_32
			l_managed_pointer: MANAGED_POINTER
		do
			byte_pos := (((a_y - 1) * width.to_natural_32 + a_x - 1) * 4).to_integer_32
			l_managed_pointer := reusable_managed_pointer
			l_managed_pointer.set_from_pointer ({EV_GTK_EXTERNALS}.gdk_pixbuf_get_pixels (gdk_pixbuf), byte_pos)
			Result := l_managed_pointer.read_natural_32 (byte_pos)
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32) is
			-- Set RGBA value at `a_x', `a_y' to `rgba'.
		local
			byte_pos: INTEGER_32
			l_managed_pointer: MANAGED_POINTER
		do
			byte_pos := (((a_y - 1) * width.to_natural_32 + a_x - 1) * 4).to_integer_32
			l_managed_pointer := reusable_managed_pointer
			l_managed_pointer.set_from_pointer ({EV_GTK_EXTERNALS}.gdk_pixbuf_get_pixels (gdk_pixbuf), byte_pos)
			l_managed_pointer.put_natural_32 (rgba, byte_pos)
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE) is
			-- Draw `a_text' using `a_font' at `a_point'.
		do
			check not_implemented: False end
		end

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE) is
			-- Draw `a_pixel_buffer' to current at `a_rect'.
		local
			l_pixel_buffer_imp: EV_PIXEL_BUFFER_IMP
		do
			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
			{EV_GTK_EXTERNALS}.gdk_pixbuf_copy_area (l_pixel_buffer_imp.gdk_pixbuf, 0, 0, a_rect.width, a_rect.height, gdk_pixbuf, a_rect.x, a_rect.y)
		end

feature -- Query

	width: INTEGER is
			-- Width of buffer in pixels.
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver > 1 then
				Result := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_width (gdk_pixbuf)
			else
				Result := internal_pixmap.width
			end
		end

	height: INTEGER is
			-- Height of buffer in pixels.
		do
			if {EV_GTK_EXTERNALS}.gtk_maj_ver > 1 then
				Result := {EV_GTK_EXTERNALS}.gdk_pixbuf_get_height (gdk_pixbuf)
			else
				Result := internal_pixmap.height
			end
		end

feature {EV_PIXEL_BUFFER_IMP, EV_POINTER_STYLE_IMP, EV_PIXMAP_IMP} -- Implementation

	reusable_managed_pointer: MANAGED_POINTER
		-- Managed pointer used for inspecting current.

	internal_pixmap: EV_PIXMAP
		-- Pixmap used for fallback implementation on gtk 1.2

	set_gdkpixbuf (a_pixbuf: POINTER) is
			-- Set `gdk_pixbuf' to `a_pixbuf'.
		do
			if gdk_pixbuf /= default_pointer then
				{EV_GTK_EXTERNALS}.object_unref (gdk_pixbuf)
			end
			gdk_pixbuf := a_pixbuf
		end

	set_internal_pixmap (a_pixmap: like internal_pixmap) is
			-- Set `internal_pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
		end

	gdk_pixbuf: POINTER
		-- Pointer to the GdkPixbuf structure.

	destroy is
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_gdkpixbuf (default_pointer)
			set_is_destroyed (True)
		end

feature {NONE} -- Dispose

	dispose is
			-- Dispose current.
		do
			set_gdkpixbuf (default_pointer)
		end

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
