note
	description: "Gtk implementation for EV_PIXEL_BUFFER_I."
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

feature -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with size.
		local
			l_x, l_y, l_width, l_height: NATURAL_32
		do
			if {GTK}.gtk_maj_ver >= 2 then
				l_width := a_width.as_natural_32
				l_height := a_height.as_natural_32
				set_gdkpixbuf ({GTK}.gdk_pixbuf_new ({GTK}.gdk_colorspace_rgb_enum, True, 8, a_width, a_height))
					-- Creating managed pointer used for inspecting RGBA data.
				create reusable_managed_pointer.share_from_pointer (default_pointer, 0)
				from
						-- Reset existing data to zero.
						--| FIXME IEK Optimize
					l_y := 0
				until
					l_y = l_height
				loop
					from
						l_x := 0
					until
						l_x = l_width
					loop
						set_pixel (l_x, l_y, 0)
						l_x := l_x + 1
					end
					l_y := l_y + 1
				end
			else
				create internal_pixmap.make_with_size (a_width, a_height)
			end
		end

	old_make (an_interface: EV_PIXEL_BUFFER)
			-- Creation method.
		do
			assign_interface (an_interface)
			make_with_size (1, 1)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap''s image data.
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
			l_pixbuf: POINTER
		do
			l_pixmap_imp ?= a_pixmap.implementation
			check l_pixmap_imp /= Void end
			l_pixbuf := {GTK2}.gdk_pixbuf_get_from_drawable (default_pointer, l_pixmap_imp.drawable, default_pointer, 0, 0, 0, 0, l_pixmap_imp.width, l_pixmap_imp.height)
			set_gdkpixbuf (l_pixbuf)
		end

	make
			-- Initialize `Current'.
		do
			if reusable_managed_pointer = Void then
					-- Creating managed pointer used for inspecting RGBA data.
				create reusable_managed_pointer.share_from_pointer (default_pointer, 0)
			end
			set_is_initialized (True)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING)
			-- Load pixel data file `a_file_name'.
		local
			l_cs: EV_GTK_C_STRING
			g_error: POINTER
			filepixbuf: POINTER
		do
			if {GTK}.gtk_maj_ver >= 2 then
				l_cs := a_file_name
				filepixbuf := {GTK}.gdk_pixbuf_new_from_file (l_cs.item, $g_error)
				if g_error /= default_pointer then
						-- GdkPixbuf could not load the image so we raise an exception.
					(create {EXCEPTIONS}).raise ("Could not load image file.")
				else
					set_gdkpixbuf (filepixbuf)
				end
			elseif attached internal_pixmap as l_internal_pixmap then
				l_internal_pixmap.set_with_named_file (a_file_name)
			end
		end

	set_with_pointer (a_pointer: POINTER; a_size: INTEGER)
			-- Load pixel data from `a_pointer'
			-- `a_size' size in bytes
		local
			l_pixel_buf: POINTER
			l_error: POINTER
			l_stream: EV_G_INPUT_STREAM
		do
			create l_stream.new_from_data (a_pointer, a_size)
			l_pixel_buf := {GTK}.gdk_pixbuf_new_from_stream (l_stream.item, default_pointer, $l_error)
			if l_error /= default_pointer then
					-- GdkPixbuf could not load the image so we raise an exception.
				(create {EXCEPTIONS}).raise ("Could not load image from stream.")
			else
				set_gdkpixbuf (l_pixel_buf)
			end
		end

	save_to_named_file (a_file_name: STRING)
			-- Save pixel data to file `a_file_name'.
		local
			l_cs, l_file_type: EV_GTK_C_STRING
			g_error: POINTER
			l_writeable_formats: ARRAYED_LIST [STRING_32]
			l_extension: STRING_32
			l_format: detachable STRING_32
			l_app_imp: detachable EV_APPLICATION_IMP
			i: INTEGER
		do
			l_app_imp ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_app_imp /= Void end
			l_writeable_formats := l_app_imp.writeable_pixbuf_formats
			l_extension := a_file_name.split ('.').last.as_upper
			if l_extension.is_equal ("JPEG") then
				l_extension := "JPG"
			end
			from
				i := 1
			until
				i > l_writeable_formats.count
			loop
				if l_writeable_formats [i].as_upper.is_equal (l_extension) then
					l_format := l_extension
				end
				i := i + 1
			end
			if l_format /= Void then
				if ("JPG").is_equal (l_format)  then
					l_format := "jpeg"
				end
				if {GTK}.gtk_maj_ver >= 2 then
					l_cs := a_file_name
					l_file_type := l_format
					{GTK2}.gdk_pixbuf_save (gdk_pixbuf, l_cs.item, l_file_type.item, $g_error)
					if g_error /= default_pointer then
							-- GdkPixbuf could not save the image so we raise an exception.
						(create {EXCEPTIONS}).raise ("Could not save image file.")
					end
				else
					if ("PNG").is_equal (l_format) and then attached internal_pixmap as l_internal_pixmap then
						l_internal_pixmap.save_to_named_file (create {EV_PNG_FORMAT}, create {FILE_NAME}.make_from_string (a_file_name))
					else
						(create {EXCEPTIONS}).raise ("Could not save image file.")
					end

				end
			else
				(create {EXCEPTIONS}).raise ("Could not save image file.")
			end
		end



	save_to_pointer: detachable MANAGED_POINTER
			-- <Precursor>
		local
			l_result: INTEGER
			l_file_type: EV_GTK_C_STRING
			l_buffer_size: INTEGER
			l_error: POINTER
			l_pointer: POINTER
		do
			-- Same as Windows {EV_PIXEL_BUFFER_IMP} implementation, using PNG format as default
			create l_file_type.set_with_eiffel_string ("png")

			l_result := {GTK}.gdk_pixbuf_save_to_buffer (gdk_pixbuf, $l_pointer, $l_buffer_size, l_file_type.item, $l_error)
			check success: l_result /= 0 end
			if l_result /= 0 then
				create Result.own_from_pointer (l_pointer, l_buffer_size)
			end
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP
			-- Draw Current to `a_drawable'
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
			l_pixbuf: POINTER
			l_internal_pixmap: like internal_pixmap
		do
			if {GTK}.gtk_maj_ver >= 2 then
				create Result
				l_pixmap_imp ?= Result.implementation
				check l_pixmap_imp /= Void end
				l_pixbuf := {GTK}.gdk_pixbuf_new_subpixbuf (gdk_pixbuf, a_rect.x, a_rect.y, a_rect.width, a_rect.height)
				l_pixmap_imp.set_pixmap_from_pixbuf (l_pixbuf)
				{GTK2}.object_unref (l_pixbuf)
			else
				l_internal_pixmap := internal_pixmap
				check l_internal_pixmap /= Void end
				Result := l_internal_pixmap.sub_pixmap (a_rect)
			end
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Create a new sub pixel buffer object.
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_pixbuf: POINTER
			l_internal_pixmap: EV_PIXMAP
		do
			if {GTK}.gtk_maj_ver >= 2 then
				create Result
				l_imp ?= Result.implementation
				check l_imp /= Void end
				l_pixbuf := {GTK}.gdk_pixbuf_new_subpixbuf (gdk_pixbuf, a_rect.x, a_rect.y, a_rect.width, a_rect.height)
					-- We need to pass in a copy of the pixbuf as subpixbuf shares the pixels.
				l_imp.set_gdkpixbuf ({GTK}.gdk_pixbuf_copy (l_pixbuf))
				{GTK2}.object_unref (l_pixbuf)
			else
				create Result
				l_internal_pixmap := sub_pixmap (a_rect)
				l_imp ?= Result.implementation
				check l_imp /= Void end
				l_imp.set_internal_pixmap (l_internal_pixmap)
			end
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Get RGBA value at `a_y', `a_y'.
		local
			byte_pos: INTEGER_32
			l_managed_pointer: detachable MANAGED_POINTER
			l_n_channels: NATURAL
			l_row_stride: NATURAL_32
			l_bytes_per_sample: NATURAL
		do
			l_n_channels := {GTK}.gdk_pixbuf_get_n_channels (gdk_pixbuf)
			l_bytes_per_sample := {GTK}.gdk_pixbuf_get_bits_per_sample (gdk_pixbuf) // 8

			l_row_stride := {GTK}.gdk_pixbuf_get_rowstride (gdk_pixbuf)

			byte_pos := (a_y * l_row_stride + (a_x * l_n_channels * l_bytes_per_sample)).as_integer_32

			l_managed_pointer := reusable_managed_pointer
			check l_managed_pointer /= Void end
			l_managed_pointer.set_from_pointer ({GTK}.gdk_pixbuf_get_pixels (gdk_pixbuf), byte_pos)
				-- Data is stored at a byte level of R G B A which is big endian, so we need to read big endian.
			Result := l_managed_pointer.read_natural_32_be (byte_pos)
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32)
			-- Set RGBA value at `a_x', `a_y' to `rgba'.
		local
			byte_pos: INTEGER_32
			l_managed_pointer: detachable MANAGED_POINTER
			l_n_channels: NATURAL
			l_row_stride: NATURAL_32
			l_bytes_per_sample: NATURAL
		do
			l_n_channels := {GTK}.gdk_pixbuf_get_n_channels (gdk_pixbuf)
			l_bytes_per_sample := {GTK}.gdk_pixbuf_get_bits_per_sample (gdk_pixbuf) // 8

			l_row_stride := {GTK}.gdk_pixbuf_get_rowstride (gdk_pixbuf)

			byte_pos := (a_y * l_row_stride + (a_x * l_n_channels * l_bytes_per_sample)).as_integer_32

			l_managed_pointer := reusable_managed_pointer
			check l_managed_pointer /= Void end
			l_managed_pointer.set_from_pointer ({GTK}.gdk_pixbuf_get_pixels (gdk_pixbuf), byte_pos + (l_bytes_per_sample * l_n_channels).to_integer_32)
				-- Data is stored at a byte level of R G B A which is big endian, so we need to set big endian.

			l_managed_pointer.put_natural_32_be (rgba, byte_pos)
		end

	draw_text (a_text: READABLE_STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' using `a_font' at `a_point'.
		local
			l_x, l_y, l_width, l_height: INTEGER
			l_string_size: TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
			l_pixmap: EV_PIXMAP
			l_pixmap_imp: detachable EV_PIXMAP_IMP
			l_pixbuf_ptr, l_pixbuf_ptr2: POINTER
			l_pixbuf: EV_PIXEL_BUFFER
			l_pixbuf_imp: detachable EV_PIXEL_BUFFER_IMP
			l_color: EV_COLOR
			l_grey_value, l_composite_alpha: NATURAL_8
		do
			l_x := a_point.x
			l_y := a_point.y
			l_string_size := a_font.string_size (a_text)
			l_width := (l_x + l_string_size.width).min (width) - l_x
			l_height := (l_y + l_string_size.height).min (height) - l_y

			create l_pixmap.make_with_size (l_width, l_height)
			l_pixmap.set_font (a_font)

			l_grey_value := 75
			l_composite_alpha := 200

			create l_color.make_with_8_bit_rgb (l_grey_value, l_grey_value, l_grey_value)

				-- Create a pixmap with a grey background so that anti-aliasing is not so harsh.
			l_pixmap.set_background_color (l_color)
			l_pixmap.clear
			l_pixmap.draw_text_top_left (0, 0, a_text)

			l_pixmap_imp ?= l_pixmap.implementation
			check l_pixmap_imp /= Void end

			create l_pixbuf
			l_pixbuf_imp ?= l_pixbuf.implementation
			check l_pixbuf_imp /= Void end

				-- Retrieve pixbuf from drawable and set the previous background color 'l_grey_value' to transparent alpha.
			l_pixbuf_ptr := {GTK2}.gdk_pixbuf_get_from_drawable (default_pointer, l_pixmap_imp.drawable, default_pointer, 0, 0, 0, 0, l_width, l_height)
			l_pixbuf_ptr2 := {GTK2}.gdk_pixbuf_add_alpha (l_pixbuf_ptr, True, l_grey_value, l_grey_value, l_grey_value)
				-- Clean up
			{GTK2}.object_unref (l_pixbuf_ptr)
			l_pixbuf_ptr := default_pointer

				-- Composite pixbuf with alpha on to `Current'
			{GTK2}.gdk_pixbuf_composite (l_pixbuf_ptr2, gdk_pixbuf, l_x, l_y, l_width, l_height, 0, 0, 1, 1, 0, l_composite_alpha)
				-- Clean up
			{GTK2}.object_unref (l_pixbuf_ptr2)
			l_pixbuf_ptr2 := default_pointer
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
			l_dest_width, l_dest_height: INTEGER
			l_x, l_y: INTEGER
		do
			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
			check l_pixel_buffer_imp /= Void end
			-- We must make sure dest rectangle not larger than source rectangle
			-- http://library.gnome.org/devel/gdk-pixbuf/stable/gdk-pixbuf-scaling.html#gdk-pixbuf-composite
			-- They say:
			-- When the destination rectangle contains parts not in the source image, the data at the edges
			-- of the source image is replicated to infinity.
			-- We modify `l_dest_width' and `l_dest_height' to avoid it, so it will consistent with Windows implementation
			l_x := a_x
			l_y := a_y
			l_dest_width := l_pixel_buffer_imp.width
			l_dest_height := l_pixel_buffer_imp.height
			if l_x < 0 then
				l_x := 0
				l_dest_width := l_dest_width + a_x
				if l_dest_width < 0 then
					l_dest_width := 0
				end
			end
			if l_y < 0 then
				l_dest_height := l_dest_height + a_y
				l_y := 0
				if l_dest_height < 0 then
					l_dest_height := 0
				end
			end

			-- We also have to make sure, dest rectangle not larger than source image, otherwise the API will not draw the image and this is
			-- not consitent with Windows implementation
			if l_x + l_dest_width > width then
				l_dest_width := width - l_x
				if l_x > width then
					l_x := width
				end
				if l_dest_width < 0 then
					l_dest_width := 0
				end
			end
			if l_y + l_dest_height > height then
				l_dest_height := height - l_y
				if l_y > height then
					l_y := height
				end
				if l_dest_height < 0 then
					l_dest_height := 0
				end
			end

			{GTK2}.gdk_pixbuf_composite (l_pixel_buffer_imp.gdk_pixbuf, gdk_pixbuf, l_x, l_y, l_dest_width, l_dest_height, a_x, a_y, 1, 1, {GTK2}.gdk_interp_hyper, 255)
		end

feature -- Query

	width: INTEGER
			-- Width of buffer in pixels.
		do
			if {GTK}.gtk_maj_ver > 1 then
				Result := {GTK}.gdk_pixbuf_get_width (gdk_pixbuf)
			elseif attached internal_pixmap as l_internal_pixmap then
				Result := l_internal_pixmap.width
			end
		end

	height: INTEGER
			-- Height of buffer in pixels.
		do
			if {GTK}.gtk_maj_ver > 1 then
				Result := {GTK}.gdk_pixbuf_get_height (gdk_pixbuf)
			elseif attached internal_pixmap as l_internal_pixmap then
				Result := l_internal_pixmap.height
			end
		end

	data_ptr: POINTER
			--Memory acess point to image data.
			-- This feature is NOT platform independent.
		do
			Result := {GTK}.gdk_pixbuf_get_pixels (gdk_pixbuf)
		end

feature {EV_STOCK_PIXMAPS_IMP} -- Implementation

	set_from_stock_id (a_stock_id: POINTER)
			-- Pixmap symbolizing a piece of information
		require
			a_stock_id_not_null: a_stock_id /= default_pointer
		local
			stock_pixbuf: POINTER
			l_label: POINTER
		do
			l_label := {GTK}.gtk_label_new (default_pointer)
			{GTK2}.object_ref (l_label)
			stock_pixbuf := {GTK2}.gtk_widget_render_icon (l_label, a_stock_id, {GTK2}.gtk_icon_size_dialog_enum, default_pointer)
			{GTK2}.object_unref (l_label)
			l_label := default_pointer
			if stock_pixbuf /= default_pointer then
					-- If a stock pixmap can be found then set it, else do nothing.
				set_gdkpixbuf ({GTK}.gdk_pixbuf_copy (stock_pixbuf))
				{GTK2}.object_unref (stock_pixbuf)
			end
		end

feature {EV_PIXEL_BUFFER_IMP, EV_POINTER_STYLE_IMP, EV_DRAWABLE_IMP} -- Implementation

	reusable_managed_pointer: detachable MANAGED_POINTER
		-- Managed pointer used for inspecting current.

	internal_pixmap: detachable EV_PIXMAP
		-- Pixmap used for fallback implementation on gtk 1.2

	set_gdkpixbuf (a_pixbuf: POINTER)
			-- Set `gdk_pixbuf' to `a_pixbuf'.
		do
			if gdk_pixbuf /= default_pointer then
					-- Unref previous gdkpixbuf
				{GTK2}.object_unref (gdk_pixbuf)
			end
			if a_pixbuf /= default_pointer then
				if not {GTK2}.gdk_pixbuf_get_has_alpha (a_pixbuf) then
						-- Make sure that the pixel data is internally stored as R G B A
					gdk_pixbuf := {GTK2}.gdk_pixbuf_add_alpha (a_pixbuf, False, 0, 0, 0)
					{GTK2}.object_unref (a_pixbuf)
				else
					gdk_pixbuf := a_pixbuf
				end
			else
				gdk_pixbuf := default_pointer
			end

		end

	set_internal_pixmap (a_pixmap: like internal_pixmap)
			-- Set `internal_pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
		end

	gdk_pixbuf: POINTER
		-- Pointer to the GdkPixbuf structure.

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_gdkpixbuf (default_pointer)
			set_is_destroyed (True)
		end

feature {NONE} -- Dispose

	dispose
			-- Dispose current.
		do
			set_gdkpixbuf (default_pointer)
		end

feature {NONE} -- Obsolete

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' to current at `a_rect'.
		obsolete
			"Use draw_pixel_buffer_with_x_y instead"
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
			check l_pixel_buffer_imp /= Void end
			{GTK2}.gdk_pixbuf_copy_area (l_pixel_buffer_imp.gdk_pixbuf, 0, 0, a_rect.width, a_rect.height, gdk_pixbuf, a_rect.x, a_rect.y)
		end

note
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
