note
	description: "Cocoa implementation for EV_PIXEL_BUFFER_I."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_IMP

inherit
	EV_PIXEL_BUFFER_I

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: EV_PIXEL_BUFFER)
			-- Creation method.
		do
			assign_interface (an_interface)
			make_with_size (1, 1)
		end

feature -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with size.
		do
			create image.make_with_size (create {NS_SIZE}.make_size (1000, 1000))
			width := a_width
			height := a_height
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap''s image data.
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
		do
			width := a_pixmap.width
			height := a_pixmap.height
			l_pixmap_imp ?= a_pixmap.implementation
			check l_pixmap_imp /= Void then end
			image := l_pixmap_imp.image.twin
		end

	make
			-- Initialize `Current'.
		do
			create image.make_with_size (create {NS_SIZE}.make_size (1000, 1000))
			set_is_initialized (True)
		end

feature -- Command

	set_with_named_path (a_path: PATH)
			-- Load pixel data file `a_file_name'.
		local
			l_image: NS_IMAGE
			l_image_rep: detachable NS_IMAGE_REP
		do
			create l_image.make_with_referencing_file_path (a_path)
			if l_image.representations.count > 0 then
				-- File found, representation loaded
				l_image_rep := l_image.representations.item (0)
				check l_image_rep /= void then end
				width := l_image_rep.pixels_wide
				height := l_image_rep.pixels_high
				image := l_image
			else
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
		end

	set_with_pointer (a_pointer: POINTER; a_size: INTEGER)
			-- Load pixel data from `a_pointer'
			-- `a_size' size in bytes
		do
			(create {EXCEPTIONS}).raise ("Not implemented.")
		end

	save_to_named_path (a_filename: PATH)
			-- Save pixel data to file `a_filename'.
			-- NOTE Why there are different implementations to save a pixel_buffer and a pixmap is a mistery to me
		local
			l_image_rep: NS_BITMAP_IMAGE_REP
			l_data: NS_DATA
			l_success: BOOLEAN
			l_extension: STRING_32
			l_format: INTEGER
		do
			l_extension := a_filename.name.split ('.').last.as_upper
			if l_extension.is_equal ("JPEG") or l_extension.is_equal ("JPG") then
				l_format := {NS_BITMAP_IMAGE_REP}.JPEG_file_type
			elseif l_extension.is_equal ("TIFF") or l_extension.is_equal ("TIF") then
				l_format := {NS_BITMAP_IMAGE_REP}.TIFF_file_type
			elseif l_extension.is_equal ("BMP") then
				l_format := {NS_BITMAP_IMAGE_REP}.BMP_file_type
			elseif l_extension.is_equal ("GIF") then
				l_format := {NS_BITMAP_IMAGE_REP}.GIF_file_type
			elseif l_extension.is_equal ("PNG") then
				l_format := {NS_BITMAP_IMAGE_REP}.PNG_file_type
			else
				(create {EXCEPTIONS}).raise ("Could not save image file: Format " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_extension) + " unknown.")
			end

			create l_image_rep.make_with_data (image.tiff_representation)
			l_data := l_image_rep.representation_using_type (l_format, Void)
			l_success := l_data.write_to_file_path_atomically (a_filename, False)
			if not l_success then
				(create {EXCEPTIONS}).raise ("Could not save image file.")
			end
		end

	save_to_pointer: detachable MANAGED_POINTER
			-- Save pixel data to Result managed pointer
		do
		end

	sub_pixmap (a_area: EV_RECTANGLE): EV_PIXMAP
			-- Draw Current to `a_drawable'
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
			l_area_y: INTEGER
		do
			create Result.make_with_size (a_area.width, a_area.height)
			l_pixmap_imp ?= Result.implementation
			check l_pixmap_imp /= Void then end
			l_pixmap_imp.image.lock_focus
			l_area_y := height - a_area.height - a_area.y -- Flipped y coordinate
			image.draw_in_rect (
				create {NS_RECT}.make_rect (0, 0, a_area.width, a_area.height),
				create {NS_RECT}.make_rect (a_area.x, l_area_y, a_area.width, a_area.height),
				{NS_IMAGE}.composite_source_over, 1)
			l_pixmap_imp.image.unlock_focus
		end

	stretched (a_width, a_height: INTEGER): EV_PIXEL_BUFFER
			-- <Precursor>
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			create Result.make_with_size (a_width, a_height)
			l_pixel_buffer_imp ?= Result.implementation
			check l_pixel_buffer_imp /= Void then end
			l_pixel_buffer_imp.image.lock_focus
			image.draw_at_point (
				create {NS_POINT}.make_point (0, 0),
				create {NS_RECT}.make,-- .make_rect (0, 0, a_width, a_height),
				{NS_IMAGE}.composite_source_over, 1)
			l_pixel_buffer_imp.image.unlock_focus
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Create a new sub pixel buffer object.
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			create Result.make_with_size (a_rect.width, a_rect.height)
			l_pixel_buffer_imp ?= Result.implementation
			check l_pixel_buffer_imp /= Void then end
			l_pixel_buffer_imp.image.lock_focus
			image.draw_at_point (
				create {NS_POINT}.make_point (0, 0),
				create {NS_RECT}.make,-- .make_rect (a_rect.x, a_rect.y, a_rect.width, a_rect.height),
				{NS_IMAGE}.composite_source_over, 1)
			l_pixel_buffer_imp.image.unlock_focus
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Get RGBA value at `a_y', `a_y'.
		do
			-- See NSReadPixel on NSImage
			-- http://lists.apple.com/archives/applescript-studio/2008/Mar/msg00035.html
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32)
			-- Set RGBA value at `a_x', `a_y' to `rgba'.
		do
		end

	draw_text (a_text: READABLE_STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' using `a_font' at `a_point'.
		do
			check not_implemented: False end
		end

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' to current at `a_rect'.
		local
			pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			image.lock_focus
			pixel_buffer_imp ?= a_pixel_buffer.implementation
			check pixel_buffer_imp /= Void then end
			pixel_buffer_imp.image.draw_at_point (
				create {NS_POINT}.make_point (a_rect.x, height - a_rect.y - a_rect.height),
				create {NS_RECT}.make_rect (0, 0, a_rect.width, a_rect.height),
				{NS_IMAGE}.composite_source_over, 1)
			image.unlock_focus
		end

feature -- Query

	width: INTEGER
			-- Width of buffer in pixels.

	height: INTEGER
			-- Height of buffer in pixels.

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		local
			pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			image.lock_focus
			pixel_buffer_imp ?= a_pixel_buffer.implementation
			check pixel_buffer_imp /= Void then end
			pixel_buffer_imp.image.draw_at_point (
				create {NS_POINT}.make_point (a_x, height - a_y - a_pixel_buffer.height),
				create {NS_RECT}.make_rect (0, 0, a_pixel_buffer.width, a_pixel_buffer.height),
				{NS_IMAGE}.composite_source_over, 1)
			image.unlock_focus
		end

	image: NS_IMAGE

	data_ptr: POINTER
			-- A pointer to the byte-data. Accessed by classes in the Smart Docking library
		local
--			l_image_rep: NS_BITMAP_IMAGE_REP
		do
--			create l_image_rep.make_with_data (image.tiff_representation)
--			Result := l_image_rep.bitmap_data
			Result := Result.memory_alloc (width * height * 3)
		end

feature {EV_PIXEL_BUFFER_IMP, EV_POINTER_STYLE_IMP, EV_PIXMAP_IMP} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
