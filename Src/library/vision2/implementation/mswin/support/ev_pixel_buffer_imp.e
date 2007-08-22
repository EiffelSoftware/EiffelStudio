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

create
	make,
	make_with_pixmap

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with size.
		do
			if is_gdi_plus_installed then
				initial_width := a_width
				initial_height := a_height

				if gdip_bitmap /= Void then
					gdip_bitmap.destroy_item
				end
				create gdip_bitmap.make_with_size (initial_width, initial_height)
				check created: gdip_bitmap.item /= default_pointer end
			else
				create pixmap
			end
		ensure then
			set: is_gdi_plus_installed implies initial_width = a_width
			set: is_gdi_plus_installed implies initial_height = a_height
		end

	make (an_interface: EV_PIXEL_BUFFER) is
			-- Creation method.
		do
			base_make (an_interface)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP) is
			-- Creation method.
		local
			l_source_graphics: WEL_GDIP_GRAPHICS
			l_source_dc: WEL_MEMORY_DC
			l_drawable: EV_DRAWABLE_IMP
		do
			make_with_size (a_pixmap.width, a_pixmap.height)

			create l_source_graphics.make_from_image (gdip_bitmap)

			l_source_dc := l_source_graphics.dc

			create {EV_PIXMAP_IMP_DRAWABLE} l_drawable.make_with_pixel_buffer (l_source_dc)
			-- We have to set drawing mode here, otherwise if `a_pixmap' doesn't have mask bitmap, drawing mode will not correct.
			-- It will cause bug#13249.
			l_drawable.set_drawing_mode (l_drawable.drawing_mode_copy)
			l_drawable.draw_pixmap (0, 0, a_pixmap)

			l_source_graphics.release_dc (l_source_dc)
		end

	initialize is
			-- Initialize
		do
			if is_gdi_plus_installed then
				create gdip_bitmap.make_with_size (1, 1)
			else
				create pixmap
			end

			set_is_initialized (True)
		end

	destroy is
			-- Destory
		do
			set_is_in_destroy (True)
			if is_gdi_plus_installed then
				gdip_bitmap.destroy_item
			else
				-- FIXIT: Why there is a Unexcepted harmful signal in EC project ? complier bug?
--				pixmap.destroy
			end
			set_is_destroyed (True)
		end

	initial_width, initial_height: INTEGER
			-- Initial size of Current.

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel datas from a file.
		do
			if is_gdi_plus_installed then
				gdip_bitmap.load_image_from_file (a_file_name)
			else
				pixmap.set_with_named_file (a_file_name)
			end
		end

	save_to_named_file (a_file_name: STRING) is
			-- Save pixel datas to `a_file_name'
		local
			l_file_name: FILE_NAME
		do
			if is_gdi_plus_installed then
				gdip_bitmap.save_image_to_file (a_file_name)
			else
				create l_file_name.make_from_string (a_file_name)
				-- FIXIT: How to know the orignal format of `pixmap'? It's BMP or PNG.
				pixmap.save_to_named_file (create {EV_PNG_FORMAT}, l_file_name)
			end
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Create asub pixmap from Current.
		local
			l_temp_buffer: EV_PIXEL_BUFFER
			l_imp: EV_PIXEL_BUFFER_IMP
		do
			l_temp_buffer := sub_pixel_buffer (a_rect)
			l_imp ?= l_temp_buffer.implementation
			check not_void: l_imp /= Void end
			create Result
			l_imp.draw_to_drawable (Result)
				-- We use `twin' to ensure the implementation of EV_PIXMAP is EV_PIXMAP_IMP
				-- and not EV_PIXMAP_IMP_DRAWABLE.
			Result := Result.twin
		end

	draw_to_drawable (a_drawable: EV_DRAWABLE) is
			-- Draw Current to `a_drawable'
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap ?= a_drawable
			if l_pixmap /= Void then
				l_pixmap.set_size (width, height)
			end
			if is_gdi_plus_installed then
				draw_to_drawable_with_matrix (a_drawable, Void)
			else
				a_drawable.draw_pixmap (0, 0, pixmap)
			end
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Create a new sub pixel buffer object.
		do
			create Result.make_with_size (a_rect.width, a_rect.height)
			Result.draw_pixel_buffer (interface, a_rect)
		end

	draw_pixel_buffer_with_rect (a_pixel_buffer: EV_PIXEL_BUFFER; a_dest_rect: EV_RECTANGLE) is
			-- Draw `a_pixel_buffer' at `a_rect'.
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
		do
			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void end

			if is_gdi_plus_installed then
				create l_graphics.make_from_image (gdip_bitmap)
				create l_src_rect.make (0, 0, a_pixel_buffer.width, a_pixel_buffer.height)
				create l_dest_rect.make (a_dest_rect.x, a_dest_rect.y, a_dest_rect.right, a_dest_rect.bottom)
				l_graphics.draw_image_with_dest_rect_src_rect (l_imp.gdip_bitmap, l_dest_rect, l_src_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
				-- In GDI+, alpha data issue is automatically handled, so we don't need to set mask.			
			else
				pixmap.draw_pixmap (a_dest_rect.x, a_dest_rect.y, l_imp.pixmap)
			end
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE) is
			-- Draw `a_text' with `a_font' at `a_rect'.
		local
			l_graphics: WEL_GDIP_GRAPHICS
			l_font: WEL_GDIP_FONT
			l_font_family: WEL_GDIP_FONT_FAMILY
		do
			if is_gdi_plus_installed then
				create l_graphics.make_from_image (gdip_bitmap)

				-- FIXIT: We can't query font name now.
				-- EV_FONT.name and WEL_LOG_FONT.name all return "".
				check only_roman_supported_currently: a_font.family = {EV_FONT_CONSTANTS}.family_roman end
				create l_font_family.make_with_name ("Times New Roman")

				create l_font.make (l_font_family, a_font.height_in_points)
				l_graphics.draw_string (a_text, a_text.count, l_font, a_point.x, a_point.y)
			else
				pixmap.set_font (a_font)
				pixmap.draw_text_top_left (a_point.x, a_point.y, a_text)
			end
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32 is
			-- Get the RGBA pixel value at `a_x', `a_y'.
		do
			if is_gdi_plus_installed then
				Result := gdip_bitmap.get_pixel (a_x, a_y)
			else
				--| FIXME IEK Implement me
			end
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32) is
			-- Set the RGBA pixel value at `a_x', `a_y' to `rgba'.
		do
			if is_gdi_plus_installed then
				gdip_bitmap.set_pixel (a_x, a_y, rgba)
			else
				--| FIXME IEK Implement me
			end
		end

feature -- Query

	width: INTEGER is
			-- Width
		do
			if is_gdi_plus_installed then
				Result := gdip_bitmap.width
			else
				Result := pixmap.width
			end
		end

	height: INTEGER is
			-- Height
		do
			if is_gdi_plus_installed then
				Result := gdip_bitmap.height
			else
				Result := pixmap.height
			end
		end

	mask_bitmap (a_rect: EV_RECTANGLE): EV_BITMAP is
			-- Maks bitmap of `a_rect'
		require
			not_void: a_rect /= Void
			not_too_big: a_rect.width <= width  and a_rect.height <= height
			support: is_gdi_plus_installed
		local
			l_imp: EV_BITMAP_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
			l_dest_rect, l_src_rect: WEL_RECT
		do
			create Result
			Result.set_size (a_rect.width, a_rect.height)

			-- When use GDI+ to convert a bitmp from 32bits (except 24bits 16bits..) bitmap to 1bit will only have black color, white color will lose.
			-- So we first fill whole area whth white color, paint target area with black color. And at final step we invert image.
			-- And we can't create a EV_BITMAP more than 1bpp to overcome this problem, because Windows API maskblt only accept 1bpp bitmap as mask bitmap.
			Result.fill_rectangle (0, 0, width, height)

			l_imp ?= Result.implementation
			check not_void: l_imp /= Void end

			create l_graphics.make_from_dc (l_imp.dc)
			create l_image_attributes.make
			l_image_attributes.clear_color_key
			l_image_attributes.set_color_matrix (mask_color_matrix)

			create l_dest_rect.make (0, 0, a_rect.width, a_rect.height)
			create l_src_rect.make (a_rect.x, a_rect.y, a_rect.right, a_rect.bottom)

			l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (gdip_bitmap, l_dest_rect, l_src_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)

 			l_dest_rect.dispose
 			l_src_rect.dispose
			l_image_attributes.destroy_item
			l_graphics.destroy_item

			-- Then we have to invert mask bitmap colors to overcome the 32bits to 1bit bitmap convert problem.
			l_imp.dc.bit_blt (0, 0, width, height, l_imp.dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.patinvert)
		ensure
			not_void: Result /= Void
		end

	is_gdi_plus_installed: BOOLEAN is
			--
		local
			l_starter: WEL_GDIP_STARTER
		once
			create l_starter
			Result := l_starter.is_gdi_plus_installed
		end

	pixmap: EV_PIXMAP
			-- If not `is_gdi_plus_installed' then we use this to emulate the functions.

	gdip_bitmap: WEL_GDIP_BITMAP
			-- If `is_gdi_plus_installed' then we use this to function.

feature {EV_PIXEL_BUFFER_IMP} -- Implementation

	draw_mask_bitmap: EV_BITMAP is
			-- Draw bitmap's mask bitmap base on it alpha datas.
		local
			l_matrix: WEL_COLOR_MATRIX
		do
			create Result.make_with_size (width, height)
			l_matrix := mask_color_matrix
		end

	draw_to_drawable_with_matrix (a_drawable: EV_DRAWABLE; a_color_matrix: WEL_COLOR_MATRIX) is
			-- Draw Current to `a_drawable' with `a_color_matrix'.
		require
			not_void: a_drawable /= Void
			support: is_gdi_plus_installed
		local
			l_imp: EV_DRAWABLE_IMP
			l_drawing_area: EV_DRAWING_AREA_IMP
			l_pixmap: EV_PIXMAP
			l_graphics: WEL_GDIP_GRAPHICS
			l_rect: WEL_RECT
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
		do
			l_imp ?= a_drawable.implementation
			check not_void: l_imp /= Void end
			l_drawing_area ?= l_imp

			l_imp.get_dc

			create l_graphics.make_from_dc (l_imp.dc)

			if a_color_matrix = Void then
				l_graphics.draw_image (gdip_bitmap, 0, 0)
			else
				create l_image_attributes.make
				l_image_attributes.clear_color_key
				l_image_attributes.set_color_matrix (a_color_matrix)
				create l_rect.make (0, 0, width, height)
				l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (gdip_bitmap, l_rect, l_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)
				l_image_attributes.destroy_item
			end

			l_graphics.destroy_item

			l_imp.release_dc

			-- Set mask bitmap
			l_pixmap ?= a_drawable
			if l_pixmap /= Void then
				l_pixmap.set_mask (mask_bitmap (create {EV_RECTANGLE}.make (0, 0, width, height)))
			end
		end

	mask_color_matrix: WEL_COLOR_MATRIX is
			-- Color matrix used for make a EV_BITMAP base on image's alpha data.
			-- See www.codeproject.com: "ColorMatrix Basics - Simple Image Color Adjustment" to know how color matrix works.
		require
			support: is_gdi_plus_installed
		do
			create Result.make
			Result.set_m_row (<<1, 0, 0, 0, 0>>, 0)
			Result.set_m_row (<<0, 1, 0, 0, 0>>, 1)
			Result.set_m_row (<<0, 0, 1, 0, 0>>, 2)
			Result.set_m_row (<<0, 0, 0, 1, 0>>, 3)
			Result.set_m_row (<<-1, -1, -1, 0, 0>>, 4)
		ensure
			not_void: Result /= Void
		end

feature -- Obsolete

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_dest_rect: EV_RECTANGLE) is
			-- Draw `a_pixel_buffer' at `a_rect'.
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
		do
			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void end

			if is_gdi_plus_installed then
				create l_graphics.make_from_image (gdip_bitmap)
				create l_src_rect.make (0, 0, a_dest_rect.width, a_dest_rect.height)
				create l_dest_rect.make (a_dest_rect.x, a_dest_rect.y, a_dest_rect.right, a_dest_rect.bottom)
				l_graphics.draw_image_with_src_rect_dest_rect (l_imp.gdip_bitmap, l_src_rect, l_dest_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
				-- In GDI+, alpha data issue is automatically handled, so we don't need to set mask.			
			else
				pixmap.draw_pixmap (a_dest_rect.x, a_dest_rect.y, l_imp.pixmap)
			end
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
