note
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
		redefine
			unlock
		end

create
	make

feature -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with size.
		do
			if is_gdi_plus_installed then
				initial_width := a_width
				initial_height := a_height

				if attached gdip_bitmap as l_gdip_bitmap then
					l_gdip_bitmap.destroy_item
				end
				create gdip_bitmap.make_with_size (initial_width, initial_height)
				check created: attached gdip_bitmap as l_gdip_bitmap and then l_gdip_bitmap.item /= default_pointer end
			else
				create pixmap
			end
		ensure then
			set: is_gdi_plus_installed implies initial_width = a_width
			set: is_gdi_plus_installed implies initial_height = a_height
		end

	old_make (an_interface: EV_PIXEL_BUFFER)
			-- Creation method.
		do
			assign_interface (an_interface)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Creation method.
		local
			l_source_graphics: WEL_GDIP_GRAPHICS
			l_source_dc: WEL_MEMORY_DC
			l_drawable: EV_DRAWABLE_IMP
			l_gdip_bitmap: like gdip_bitmap
		do
			make_with_size (a_pixmap.width, a_pixmap.height)

			l_gdip_bitmap := gdip_bitmap
			check l_gdip_bitmap /= Void then end
			create l_source_graphics.make_from_image (l_gdip_bitmap)

			l_source_dc := l_source_graphics.dc
			l_source_dc.enable_reference_tracking

			create {EV_PIXMAP_IMP_DRAWABLE} l_drawable.make_with_pixel_buffer (l_source_dc)
			-- We have to set drawing mode here, otherwise if `a_pixmap' doesn't have mask bitmap, drawing mode will not correct.
			-- It will cause bug#13249.
			l_drawable.set_drawing_mode (l_drawable.drawing_mode_copy)
			l_drawable.draw_pixmap (0, 0, a_pixmap)

			l_source_graphics.release_dc (l_source_dc)
		end

	make
			-- Initialize
		do
			if is_gdi_plus_installed then
				create gdip_bitmap.make_with_size (1, 1)
			else
				create pixmap
			end

			set_is_initialized (True)
		end

	destroy
			-- Destory
		do
			set_is_in_destroy (True)
			if is_gdi_plus_installed then
				if attached gdip_bitmap as l_gdip_bitmap then
					l_gdip_bitmap.destroy_item
				end
			else
				-- FIXIT: Why there is a Unexcepted harmful signal in EC project ? complier bug?
--				pixmap.destroy
			end
			set_is_destroyed (True)
		end

	initial_width, initial_height: INTEGER
			-- Initial size of Current.

feature -- Command

	set_with_named_path (a_file_name: PATH)
			-- Load pixel data from a file.
		local
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_gdip_bitmap.load_image_from_path (a_file_name)
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				l_pixmap.set_with_named_path (a_file_name)
			end
		end

	set_with_pointer (a_pointer: POINTER; a_size: INTEGER)
			-- <Precursor>
		local
			l_gdip_bitmap: like gdip_bitmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_gdip_bitmap.load_image_from_memory (a_pointer, a_size.as_natural_32)
			else
				check not_supported: False end
			end
		end

	set_gdip_image (a_gdip_image: WEL_GDIP_BITMAP)
			-- Set `gdip_image' with `a_gdip_image'
		require
			valid: is_gdi_plus_installed
			not_void: a_gdip_image /= Void
		do
			if attached gdip_bitmap as l_bitmap then
				l_bitmap.dispose
			end
			gdip_bitmap := a_gdip_image
		ensure
			set: gdip_bitmap = a_gdip_image
		end

	set_from_icon (a_wel_icon: WEL_ICON)
			-- Load pixel data from `a_wel_icon'.
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
			l_bitmap: WEL_BITMAP
			l_icon_info: detachable WEL_ICON_INFO
			l_header_info: WEL_BITMAP_INFO_HEADER
			l_new_bitmap: WEL_BITMAP
			l_mem_dc: WEL_MEMORY_DC
--			i: INTEGER
--			l_managed_ptr: MANAGED_POINTER
--			l_pixel_buffer_iterator: EV_PIXEL_BUFFER_ITERATOR
--			l_pixel_value, l_rgb_value, l_alpha_value: NATURAL_32
			l_rect: WEL_GDIP_RECT
			l_current_data: detachable WEL_GDIP_BITMAP_DATA
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
					-- Retrieve color bitmap.
				l_icon_info := a_wel_icon.get_icon_info
				check l_icon_info /= Void then end
				l_bitmap := l_icon_info.color_bitmap

				make_with_size (l_icon_info.width, l_icon_info.height)

				create l_header_info.make
				l_header_info.set_width (l_icon_info.width)
					-- If we set a negative height value the bitmap gets automagically flipped as scan0 is from the bottom.
				l_header_info.set_height (-l_icon_info.height)
				l_header_info.set_planes (1)
					-- Set alpha meta information
				l_header_info.set_bit_count (32)
				l_header_info.set_compression ({WEL_BI_COMPRESSION_CONSTANTS}.bi_rgb)

					-- Optimized version.
					-- Create new dib and set bit information from icon with GetDIBits.
				create l_new_bitmap.make_dib (l_header_info)
				create l_mem_dc.make
				cwin_get_di_bits (l_mem_dc.item, l_bitmap.item, 0, l_icon_info.height, l_new_bitmap.ppv_bits, l_header_info.item, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

					-- Do a memory copy of the ARGB data straight in to the gdipbitmap.
				create l_rect.make_with_size (0, 0, l_icon_info.width, l_icon_info.height)
					-- Data is not pre-multipled alpha so we set the pixel format for 'format32bppargb'.

				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_current_data := l_gdip_bitmap.lock_bits (l_rect, {WEL_GDIP_IMAGE_LOCK_MODE}.write_only, {WEL_GDIP_PIXEL_FORMAT}.format32bppargb)
				l_current_data.scan_0.memory_copy (l_new_bitmap.ppv_bits, l_icon_info.width * l_icon_info.height * {PLATFORM}.natural_32_bytes)
				l_gdip_bitmap.unlock_bits (l_current_data)

					-- Pixel buffer interface version should gdip_bitmap implementation be replaced with DIBs for less dependence/maintenance.
--					-- Iterate through pixel values via managed pointer and set in to pixel buffer.
--				from
--					create l_managed_ptr.make_from_pointer (l_new_bitmap.ppv_bits, (l_icon_info.width * l_icon_info.height) * {PLATFORM}.natural_32_bytes)
--					lock
--					l_pixel_buffer_iterator := pixel_iterator
--				until
--					i = (l_icon_info.width * l_icon_info.height) * {PLATFORM}.natural_32_bytes
--				loop
--					l_pixel_value := l_managed_ptr.read_natural_32 (i)
--					l_rgb_value := l_pixel_value |<< 8
--						-- Convert to 000'A'
--					l_alpha_value := l_pixel_value |>> 24
--					l_pixel_buffer_iterator.item.set_rgba_value (l_rgb_value | l_alpha_value)
--					l_pixel_buffer_iterator.forth
--					i := i + {PLATFORM}.natural_32_bytes
--				end
--				unlock

				l_header_info.dispose
				l_new_bitmap.delete
				l_mem_dc.release
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				l_pixmap_imp ?= l_pixmap.implementation
				check l_pixmap_imp /= Void then end
				l_pixmap_imp.set_with_resource (a_wel_icon)
			end
		end

	save_to_named_path (a_file_name: PATH)
			-- Save pixel data to `a_file_name'
		local
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_gdip_bitmap.save_image_to_path (a_file_name)
			else
				-- FIXIT: How to know the orignal format of `pixmap'? It's BMP or PNG.
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				l_pixmap.save_to_named_path (create {EV_PNG_FORMAT}, a_file_name)
			end
		end

	save_to_pointer: detachable MANAGED_POINTER
			-- Save pixel data to Result managed pointer
		local
			l_gdip_bitmap: like gdip_bitmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				Result := l_gdip_bitmap.save_image_to_memory
			else
				check not_supported: False end
			end
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP
			-- Create asub pixmap from Current.
		local
			l_temp_buffer: EV_PIXEL_BUFFER
			l_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			l_temp_buffer := sub_pixel_buffer (a_rect)
			l_imp ?= l_temp_buffer.implementation
			check not_void: l_imp /= Void then end
			create Result
			l_imp.draw_to_drawable (Result)
				-- We use `twin' to ensure the implementation of EV_PIXMAP is EV_PIXMAP_IMP
				-- and not EV_PIXMAP_IMP_DRAWABLE.
			Result := Result.twin
		end

	draw_to_drawable (a_drawable: EV_DRAWABLE)
			-- Draw Current to `a_drawable'
		local
			l_pixmap: detachable EV_PIXMAP
		do
			l_pixmap ?= a_drawable
			if l_pixmap /= Void then
				l_pixmap.set_size (width, height)
			end
			if is_gdi_plus_installed then
				draw_to_drawable_with_matrix (a_drawable, Void)
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				a_drawable.draw_pixmap (0, 0, l_pixmap)
			end
		end

	draw_to_drawable_with_dest_rect_src_rect (a_drawable: EV_DRAWABLE; a_dest_rect, a_src_rect: WEL_RECT)
			-- Draw Current to `a_drawable'
		local
			l_graphics: WEL_GDIP_GRAPHICS
			l_drawable_imp: detachable EV_DRAWABLE_IMP
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			l_drawable_imp ?= a_drawable.implementation
			check l_drawable_imp /= Void then end
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_drawable_imp.get_dc
				create l_graphics.make_from_dc (l_drawable_imp.dc)
				l_graphics.draw_image_with_dest_rect_src_rect (l_gdip_bitmap, a_dest_rect, a_src_rect)
				l_graphics.destroy_item
				l_drawable_imp.release_dc
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				a_drawable.draw_sub_pixmap (a_dest_rect.x, a_dest_rect.y, l_pixmap, create {EV_RECTANGLE}.make (a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height))
			end
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Create a new sub pixel buffer object.
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
			l_gdip_bitmap, l_imp_gdip_bitmap: like gdip_bitmap
		do
			create Result.make_with_size (a_rect.width, a_rect.height)

			l_imp ?= Result.implementation
			check not_void: l_imp /= Void then end

			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_imp_gdip_bitmap := l_imp.gdip_bitmap
				check l_imp_gdip_bitmap /= Void then end
				create l_graphics.make_from_image (l_imp_gdip_bitmap)

				create l_dest_rect.make (0, 0, Result.width, Result.height)
				create l_src_rect.make (a_rect.x, a_rect.y, a_rect.right, a_rect.bottom)

				l_graphics.draw_image_with_dest_rect_src_rect (l_gdip_bitmap, l_dest_rect, l_src_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
			else
				check not_implemented: False end
				-- Fail safe
				create Result
			end
		end

	stretched (a_width, a_height: INTEGER): EV_PIXEL_BUFFER
			-- <Precursor>
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
			l_gdip_bitmap, l_imp_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			create Result.make_with_size (a_width, a_height)

			l_imp ?= Result.implementation
			check not_void: l_imp /= Void then end

			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_imp_gdip_bitmap := l_imp.gdip_bitmap
				check l_imp_gdip_bitmap /= Void then end
				create l_graphics.make_from_image (l_imp_gdip_bitmap)

				create l_src_rect.make (0, 0, width, height)
				create l_dest_rect.make (0, 0, a_width, a_height)

				l_graphics.draw_image_with_dest_rect_src_rect (l_gdip_bitmap, l_dest_rect, l_src_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				l_pixmap.stretch (a_width, a_height)
				create Result.make_with_pixmap (l_pixmap)
			end
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_rect'.
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void then end

			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				create l_graphics.make_from_image (l_gdip_bitmap)
				create l_src_rect.make (0, 0, a_pixel_buffer.width, a_pixel_buffer.height)
				create l_dest_rect.make (a_x, a_y, a_x + a_pixel_buffer.width, a_y + a_pixel_buffer.height)

				check same_size: l_src_rect.width = l_dest_rect.width and l_src_rect.height = l_dest_rect.height end

				l_gdip_bitmap := l_imp.gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_graphics.draw_image_with_dest_rect_src_rect (l_gdip_bitmap, l_dest_rect, l_src_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
				-- In GDI+, alpha data issue is automatically handled, so we don't need to set mask.
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				if attached l_imp.pixmap as l_imp_pixmap then
					l_pixmap.draw_pixmap (a_x, a_y, l_imp_pixmap)
				else
					check False end
				end

			end
		end

	draw_text (a_text: READABLE_STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' with `a_font' at `a_rect'.
		local
			l_graphics: WEL_GDIP_GRAPHICS
			l_font: WEL_GDIP_FONT
			l_font_family: WEL_GDIP_FONT_FAMILY
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				create l_graphics.make_from_image (l_gdip_bitmap)

				-- FIXIT: We can't query font name now.
				-- EV_FONT.name and WEL_LOG_FONT.name all return "".
				check only_roman_supported_currently: a_font.family = {EV_FONT_CONSTANTS}.family_roman end
				if a_font.name.is_empty then
					create l_font_family.make
				else
					create l_font_family.make_with_name (a_font.name)
				end

				create l_font.make (l_font_family, a_font.height_in_points)

				l_graphics.draw_string (a_text, l_font, a_point.x, a_point.y)

				l_font.dispose
				l_font_family.dispose
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				l_pixmap.set_font (a_font)
				l_pixmap.draw_text_top_left (a_point.x, a_point.y, a_text)
			end
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Get the RGBA pixel value at `a_x', `a_y'.
		local
			l_gdip_bitmap: like gdip_bitmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				Result := l_gdip_bitmap.get_pixel (a_x, a_y)
			else
				--| FIXME IEK Implement me
			end
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32)
			-- Set the RGBA pixel value at `a_x', `a_y' to `rgba'.
		local
			l_gdip_bitmap: like gdip_bitmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_gdip_bitmap.set_pixel (a_x, a_y, rgba)
			else
				--| FIXME IEK Implement me
			end
		end

	unlock
			-- Redefine
		local
			l_gdip_bitmap: like gdip_bitmap
		do
			Precursor {EV_PIXEL_BUFFER_I}
			if attached data as l_data then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_gdip_bitmap.unlock_bits (l_data)
				data := Void
			end
		ensure then
			cleared: data = Void
		end

feature -- Query

	width: INTEGER
			-- Width
		local
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				Result := l_gdip_bitmap.width
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				Result := l_pixmap.width
			end
		end

	height: INTEGER
			-- Height
		local
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				Result := l_gdip_bitmap.height
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				Result := l_pixmap.height
			end
		end

	mask_bitmap (a_rect: EV_RECTANGLE): EV_BITMAP
			-- Maks bitmap of `a_rect'
		require
			not_void: a_rect /= Void
			not_too_big: a_rect.width <= width  and a_rect.height <= height
			support: is_gdi_plus_installed
		local
			l_imp: detachable EV_BITMAP_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
			l_dest_rect, l_src_rect: WEL_RECT
			l_gdip_bitmap: like gdip_bitmap
		do
			create Result
			Result.set_size (a_rect.width, a_rect.height)

			-- When use GDI+ to convert a bitmp from 32bits (except 24bits 16bits..) bitmap to 1bit will only have black color, white color will lose.
			-- So we first fill whole area whth white color, paint target area with black color. And at final step we invert image.
			-- And we can't create a EV_BITMAP more than 1bpp to overcome this problem, because Windows API maskblt only accept 1bpp bitmap as mask bitmap.
			Result.fill_rectangle (0, 0, width, height)

			l_imp ?= Result.implementation
			check not_void: l_imp /= Void then end

			create l_graphics.make_from_dc (l_imp.dc)
			create l_image_attributes.make
			l_image_attributes.clear_color_key
			l_image_attributes.set_color_matrix (mask_color_matrix)

			create l_dest_rect.make (0, 0, a_rect.width, a_rect.height)
			create l_src_rect.make (a_rect.x, a_rect.y, a_rect.right, a_rect.bottom)

			l_gdip_bitmap := gdip_bitmap
			check l_gdip_bitmap /= Void then end
			l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (l_gdip_bitmap, l_dest_rect, l_src_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)

 			l_dest_rect.dispose
 			l_src_rect.dispose
			l_image_attributes.destroy_item
			l_graphics.destroy_item

			-- Then we have to invert mask bitmap colors to overcome the 32bits to 1bit bitmap convert problem.
			l_imp.dc.bit_blt (0, 0, width, height, l_imp.dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.patinvert)
		ensure
			not_void: Result /= Void
		end

	is_gdi_plus_installed: BOOLEAN
			-- If GDI+ installed?
		local
			l_starter: WEL_GDIP_STARTER
		once
			create l_starter
			Result := l_starter.is_gdi_plus_installed
		end

	pixmap: detachable EV_PIXMAP
			-- If not `is_gdi_plus_installed' then we use this to emulate the functions.

	gdip_bitmap: detachable WEL_GDIP_BITMAP
			-- If `is_gdi_plus_installed' then we use this to function.

	data_ptr: POINTER
			-- Pointer address of image raw data.
			-- Don't forget call `unlock' after operations on result pointer.
			-- This feature is NOT platform independent. Because pixel orders are different.
		local
			l_rect: WEL_GDIP_RECT
			l_gdip_bitmap: like gdip_bitmap
			l_data: like data
		do
			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check not_void: l_gdip_bitmap /= Void then end
				create l_rect.make_with_size (0, 0, width, height)
				l_data := l_gdip_bitmap.lock_bits (l_rect, {WEL_GDIP_IMAGE_LOCK_MODE}.write_only, {WEL_GDIP_PIXEL_FORMAT}.format32bppargb)
				check l_data /= Void then end
				Result := l_data.scan_0
				data := l_data
			else
				check not_implemented: False end
			end
		end

feature {EV_PIXEL_BUFFER_IMP} -- Implementation

--	draw_mask_bitmap: EV_BITMAP is
--			-- Draw bitmap's mask bitmap base on it alpha datas.
--		local
--			l_matrix: WEL_COLOR_MATRIX
--		do
--			create Result.make_with_size (width, height)
--			l_matrix := mask_color_matrix
--		end

	draw_to_drawable_with_matrix (a_drawable: EV_DRAWABLE; a_color_matrix: detachable WEL_COLOR_MATRIX)
			-- Draw Current to `a_drawable' with `a_color_matrix'.
		require
			not_void: a_drawable /= Void
			support: is_gdi_plus_installed
		local
			l_imp: detachable EV_DRAWABLE_IMP
			l_drawing_area: detachable EV_DRAWING_AREA_IMP
			l_pixmap: detachable EV_PIXMAP
			l_graphics: WEL_GDIP_GRAPHICS
			l_rect: WEL_RECT
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
			l_gdip_bitmap: like gdip_bitmap
		do
			l_imp ?= a_drawable.implementation
			check not_void: l_imp /= Void then end
			l_drawing_area ?= l_imp

			l_imp.get_dc

			create l_graphics.make_from_dc (l_imp.dc)

			l_gdip_bitmap := gdip_bitmap
			check l_gdip_bitmap /= Void then end

			if a_color_matrix = Void then
				l_graphics.draw_image (l_gdip_bitmap, 0, 0)
			else
				create l_image_attributes.make
				l_image_attributes.clear_color_key
				l_image_attributes.set_color_matrix (a_color_matrix)
				create l_rect.make (0, 0, width, height)
				l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (l_gdip_bitmap, l_rect, l_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)
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

	mask_color_matrix: WEL_COLOR_MATRIX
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

	data: detachable WEL_GDIP_BITMAP_DATA
		-- Data which generated by `data_ptr'.
		-- It should cleaned by `unlock'.

feature -- Obsolete

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_dest_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' at `a_rect'.
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
			l_gdip_bitmap: like gdip_bitmap
			l_pixmap: like pixmap
		do
			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void then end

			if is_gdi_plus_installed then
				l_gdip_bitmap := gdip_bitmap
				check l_gdip_bitmap /= Void then end
				create l_graphics.make_from_image (l_gdip_bitmap)
				create l_src_rect.make (0, 0, a_dest_rect.width, a_dest_rect.height)
				create l_dest_rect.make (a_dest_rect.x, a_dest_rect.y, a_dest_rect.right, a_dest_rect.bottom)
				l_gdip_bitmap := l_imp.gdip_bitmap
				check l_gdip_bitmap /= Void then end
				l_graphics.draw_image_with_dest_rect_src_rect (l_gdip_bitmap, l_src_rect, l_dest_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.destroy_item
				-- In GDI+, alpha data issue is automatically handled, so we don't need to set mask.			
			else
				l_pixmap := pixmap
				check l_pixmap /= Void then end
				if attached l_imp.pixmap as l_imp_pixmap then
					l_pixmap.draw_pixmap (a_dest_rect.x, a_dest_rect.y, l_imp_pixmap)
				else
					check False end
				end
			end
		end

feature {NONE} -- Externals

	cwin_get_di_bits (hdc, bitmap: POINTER;start_line, no_scanlines: INTEGER;
			 bits, info: POINTER; mode: INTEGER)
			-- SDK GetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, void *, %
				%BITMAPINFO *, UINT)"
		alias
			"GetDIBits"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
