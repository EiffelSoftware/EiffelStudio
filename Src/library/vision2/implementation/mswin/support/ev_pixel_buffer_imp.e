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

	WEL_GDIP_BITMAP
		rename
			make_with_size as gdip_make_with_size,
			width as gdip_width,
			height as gdip_height
		export
			{NONE} all
			{ANY} is_gdi_plus_installed
		end
	DISPOSABLE

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with size.
		do
			if is_gdi_plus_installed then
				initial_width := a_width
				initial_height := a_height

				if item /= default_pointer then
					delete
				end

				gdip_make_with_size (initial_width, initial_height)
				check created: item /= default_pointer end
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

	initialize is
			-- Initialize
		local
			l_starter: WEL_GDI_PLUS_STARTER
		do
			if is_gdi_plus_installed then
				create l_starter
				l_starter.gdi_plus_init

				make_with_size (1, 1)
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
				delete
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
				load_image_from_file (a_file_name)
			else
				pixmap.set_with_named_file (a_file_name)
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
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_temp_pixmap: EV_PIXMAP
			l_graphics: WEL_GDIP_GRAPHICS
			l_dest_rect, l_src_rect: WEL_RECT
			l_image: WEL_GDIP_IMAGE
		do
			create Result.make_with_size (a_rect.width, a_rect.height)
			l_imp ?= Result.implementation
			check not_void: l_imp /= Void end

			if is_gdi_plus_installed then
				l_image ?= Result.implementation
				check not_void: l_image /= Void end
				create l_graphics.make_from_image (l_image)
				create l_dest_rect.make (0, 0, a_rect.width, a_rect.height)
				create l_src_rect.make (a_rect.x, a_rect.y, a_rect.right, a_rect.bottom)
				l_graphics.draw_image_with_src_rect_dest_rect (Current, l_dest_rect, l_src_rect)

				l_dest_rect.dispose
				l_src_rect.dispose
				l_graphics.delete
				-- In GDI+, alpha data issue is automatically handled, so we don't need to set mask.			
			else
				l_temp_pixmap := pixmap.sub_pixmap (a_rect)
				l_imp.pixmap.set_size (width, height)
				l_imp.pixmap.draw_pixmap (0, 0, l_temp_pixmap)

			end
		end

feature -- Query

	width: INTEGER is
			-- Width
		do
			if is_gdi_plus_installed then
				Result := gdip_width
			else
				Result := pixmap.width
			end
		end

	height: INTEGER is
			-- Height
		do
			if is_gdi_plus_installed then
				Result := gdip_height
			else
				Result := pixmap.height
			end
		end

feature {NONE} -- Dispose

	dispose is
			-- Dispose current.
		do
			destroy
		end

feature {EV_PIXEL_BUFFER_IMP} -- Implementation

	pixmap: EV_PIXMAP
			-- If not `is_gdi_plus_installed' then we use this to emulate the functions.

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
				l_graphics.draw_image (Current, 0, 0)
			else
				create l_image_attributes.make
				l_image_attributes.clear_color_key
				l_image_attributes.set_color_matrix (a_color_matrix)
				create l_rect.make (0, 0, width, height)
				l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (Current, l_rect, l_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)
				l_image_attributes.delete
			end

			l_graphics.delete

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

			l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (Current, l_dest_rect, l_src_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)

 			l_dest_rect.dispose
 			l_src_rect.dispose
			l_image_attributes.delete
			l_graphics.delete

			-- Then we have to invert mask bitmap colors to overcome the 32bits to 1bit bitmap convert problem.
			l_imp.dc.bit_blt (0, 0, width, height, l_imp.dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.patinvert)
		ensure
			not_void: Result /= Void
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
