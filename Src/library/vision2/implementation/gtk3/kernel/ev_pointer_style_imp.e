note
	description: "Windows implementation of EV_POINTER_STYLE_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision: 86769 $"

class
	EV_POINTER_STYLE_IMP

inherit
	EV_POINTER_STYLE_I
		export
			{EV_ANY, EV_ANY_I, EV_ANY_HANDLER}
				interface
		redefine
			destroy
		end

	EV_ANY_HANDLER

	DISPOSABLE

create
	make

feature {NONE} -- Initlization

	old_make (an_interface: EV_POINTER_STYLE)
			-- Creation method
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize
		do
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Initialize from `a_pixel_buffer'
		local
			l_pix_buf_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			l_pix_buf_imp ?= a_pixel_buffer.implementation
			check l_pix_buf_imp /= Void end
			set_gdkpixbuf ({GTK}.gdk_pixbuf_copy (l_pix_buf_imp.gdk_pixbuf))
			set_x_hotspot (a_x_hotspot)
			set_y_hotspot (a_x_hotspot)
		end

	init_predefined (a_constant: INTEGER)
			-- Initialized a predefined cursor.
		local
			l_x_hotspot, l_y_hotspot: INTEGER
		do
			predefined_cursor_code := a_constant
				-- Set hotspot values
			inspect
				a_constant
			when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
				l_x_hotspot := 15
				l_y_hotspot := 15
			when
				{EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor
			then
				l_x_hotspot := 7
				l_y_hotspot := 10
			when
				{EV_POINTER_STYLE_CONSTANTS}.no_cursor
			then
				l_x_hotspot := 10
				l_y_hotspot := 10
			when
				{EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor
			then
				l_x_hotspot := 8
				l_y_hotspot := 8
			when
				{EV_POINTER_STYLE_CONSTANTS}.sizens_cursor
			then
				l_x_hotspot := 5
				l_y_hotspot := 7
			when
				{EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor
			then
				l_x_hotspot := 8
				l_y_hotspot := 7
			when
				{EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor
			then
				l_x_hotspot := 7
				l_y_hotspot := 7
			when
				{EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor
			then
				l_x_hotspot := 7
				l_y_hotspot := 5
			when
				{EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor
			then
				l_x_hotspot := 0
				l_y_hotspot := 5
			when
				{EV_POINTER_STYLE_CONSTANTS}.busy_cursor
			then
				l_x_hotspot := 16
				l_y_hotspot := 16
			when
				{EV_POINTER_STYLE_CONSTANTS}.header_sizewe_cursor
			then
				l_x_hotspot := 7
				l_y_hotspot := 5
			else
				l_x_hotspot := 0
				l_y_hotspot := 0
			end
			set_x_hotspot (l_x_hotspot)
			set_y_hotspot (l_y_hotspot)
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		local
			a_pix_imp: detachable EV_PIXMAP_IMP
		do
			a_pix_imp ?= a_cursor.implementation
			check a_pix_imp /= Void end
			set_gdkpixbuf (a_pix_imp.pixbuf_from_drawable)
			set_x_hotspot (a_cursor.x_hotspot)
			set_y_hotspot (a_cursor.y_hotspot)
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y: INTEGER_32)
			-- Initalize from `a_pixmap'
		local
			a_pix_imp: detachable EV_PIXMAP_IMP
		do
			a_pix_imp ?= a_pixmap.implementation
			check a_pix_imp /= Void end
			set_gdkpixbuf (a_pix_imp.pixbuf_from_drawable)
			set_x_hotspot (a_hotspot_x)
			set_y_hotspot (a_hotspot_y)
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		do
			x_hotspot := a_x
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		do
			y_hotspot := a_y
		end

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_gdkpixbuf (default_pointer)
			set_is_destroyed (True)
		end

feature -- Query

	width: INTEGER
			-- Width of pointer style.
		do
			if gdk_pixbuf /= default_pointer then
				Result := {GTK}.gdk_pixbuf_get_width (gdk_pixbuf)
			else
				Result := {GTK2}.gdk_display_get_default_cursor_size ({GTK2}.gdk_display_get_default)
			end
		end

	height: INTEGER
			-- Height of pointer style.
		do
			if gdk_pixbuf /= default_pointer then
				Result := {GTK}.gdk_pixbuf_get_height (gdk_pixbuf)
			else
				Result := {GTK2}.gdk_display_get_default_cursor_size ({GTK2}.gdk_display_get_default)
			end
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

feature -- Implementation

	gdk_cursor_from_pointer_style: POINTER
			-- Return a GdkCursor constructed from `a_cursor'
		local
			a_image: POINTER
		do
			inspect
				predefined_cursor_code
					-- Return a predefined cursor if available.
			when {EV_POINTER_STYLE_CONSTANTS}.busy_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_watch_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_left_ptr_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_crosshair_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_xterm_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_fleur_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.sizens_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.Gdk_size_sb_v_double_arrow_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.wait_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_watch_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.help_cursor then
				Result := {GTK}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_question_arrow_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.hyperlink_cursor then
				Result := {GTK}.gdk_cursor_new (60) -- GDK_HAND2
			when {EV_POINTER_STYLE_CONSTANTS}.no_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.no_cursor_xpm)
			when {EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenwse_cursor_xpm)
			when {EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenesw_cursor_xpm)
			when {EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizewe_cursor_xpm)
			when {EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.uparrow_cursor_xpm)
			when {EV_POINTER_STYLE_CONSTANTS}.header_sizewe_cursor then
				a_image := image_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizewe_cursor_xpm)
			else
				a_image := gdk_pixbuf
				a_image := {GTK2}.g_object_ref (a_image)
			end

			if Result = default_pointer and then predefined_cursor_code /= {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
				check
					a_image_not_null: a_image /= default_pointer
				end
				Result := {GTK2}.gdk_cursor_new_from_pixbuf (
					{GTK2}.gdk_display_get_default,
					a_image,
					attached_interface.x_hotspot,
					attached_interface.y_hotspot
				)
				{GTK2}.g_object_unref (a_image)
			end
		end

	image_from_xpm_data (a_xpm_data: POINTER): POINTER
			-- Return image data from `a_xpm_data'.
		require
			a_xpm_not_null: a_xpm_data /= default_pointer
		do
			Result := {GTK}.gdk_pixbuf_new_from_xpm_data (a_xpm_data)
		end

	set_gdkpixbuf (a_pixbuf: POINTER)
			-- Set gdk_pixbuf to `a_pixbuf'.
		do
			if gdk_pixbuf /= default_pointer then
				{GTK2}.g_object_unref (gdk_pixbuf)
			end
			gdk_pixbuf := a_pixbuf
		end

	gdk_pixbuf: POINTER
		-- Pixbuf used for pointer style implementation.

feature -- Duplication

	copy_from_pointer_style (a_pointer_style: like interface)
			-- Copy attributes of `a_pointer_style' to `Current'
		local
			l_pointer_style_imp: detachable like Current
		do
			l_pointer_style_imp ?= a_pointer_style.implementation
			check l_pointer_style_imp /= Void end
			if l_pointer_style_imp.gdk_pixbuf /= default_pointer then
				set_gdkpixbuf ({GTK}.gdk_pixbuf_copy (l_pointer_style_imp.gdk_pixbuf))
			end
			predefined_cursor_code := l_pointer_style_imp.predefined_cursor_code
		end

feature {EV_ANY_HANDLER, EV_ANY_I} -- Implementation

	predefined_cursor_code: INTEGER;
		-- Predefined cursor code used for selecting platform cursors.

feature {NONE} -- Implementation

	dispose
			-- Clean up `Current'.
		do
			set_gdkpixbuf (default_pointer)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end
