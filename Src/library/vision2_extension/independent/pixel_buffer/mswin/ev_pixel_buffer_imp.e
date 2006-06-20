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

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with size.
		do
			if is_gdi_plus_installed then
				initial_width := a_width
				initial_height := a_height
				cpp_bitmap_delete (item)
				item := cpp_bitmap_create (initial_width, initial_height)
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
				item := cpp_bitmap_create (initial_width, initial_height)
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
				cpp_bitmap_delete (item)
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
		local
			l_wel_string: WEL_STRING
		do
			if is_gdi_plus_installed then
				cpp_bitmap_delete (item)
				create l_wel_string.make (a_file_name)
				item := cpp_bitmap_from_file (l_wel_string.item)
			else
				pixmap.set_with_named_file (a_file_name)
			end
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
		do
			create Result.make_with_size (a_rect.width, a_rect.height)
			l_imp ?= Result.implementation
			check not_void: l_imp /= Void end

			if is_gdi_plus_installed then
				cpp_bitmap_draw_bitmap (l_imp.item, item, 0, 0, a_rect.width, a_rect.height, a_rect.x, a_rect.y, a_rect.width, a_rect.height)
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
				Result := cpp_bitmap_width (item).to_integer_32
			else
				Result := pixmap.width
			end
		end

	height: INTEGER is
			-- Height
		do
			if is_gdi_plus_installed then
				Result := cpp_bitmap_height (item).to_integer_32
			else
				Result := pixmap.height
			end
		end

	is_gdi_plus_installed: BOOLEAN is
			-- If user installed GDI+ librarys?
		local
			l_starter: WEL_GDI_PLUS_STARTER
		once
			create l_starter
			Result := l_starter.is_gdi_plus_installed
		end

	item: POINTER
			-- Pointer to a GDI+ bitmap object.

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
			--
		require
			not_void: a_drawable /= Void
			support: is_gdi_plus_installed
		local
			l_imp: EV_DRAWABLE_IMP
			l_drawing_area: EV_DRAWING_AREA_IMP
			l_pixmap: EV_PIXMAP
		do
			l_imp ?= a_drawable.implementation
			check not_void: l_imp /= Void end
			l_drawing_area ?= l_imp

			l_imp.get_dc

			if a_color_matrix = Void then
				cpp_bitmap_draw_to_dc (item, l_imp.dc.item, 0, 0, width, height)
			else
				cpp_bitmap_draw_to_dc_with_matrix (item, l_imp.dc.item, 0, 0, width, height, 0, 0, width, height, a_color_matrix.item.item)
			end

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
			l_not_1bpp_bitmap: WEL_BITMAP
			l_screen_dc: WEL_SCREEN_DC
			l_mem_dc: WEL_MEMORY_DC
			l_test: WEL_BITMAP
		do
			create Result
			Result.set_size (a_rect.width, a_rect.height)

			-- When use GDI+ to convert a bitmp from 32bits (except 24bits 16bits..) bitmap to 1bit will only have black color, white color will lose.
			-- So we first fill whole area whth white color, paint target area with black color. And at final step we invert image.
			-- And we can't create a EV_BITMAP more than 1bpp to overcome this problem, because Windows API maskblt only accept 1bpp bitmap as mask bitmap.
			Result.fill_rectangle (0, 0, width, height)

			l_imp ?= Result.implementation
			check not_void: l_imp /= Void end

			cpp_bitmap_draw_to_dc_with_matrix (item, l_imp.dc.item, 0, 0, a_rect.width, a_rect.height, a_rect.x, a_rect.y, a_rect.width, a_rect.height, mask_color_matrix.item.item)
			-- Then we have to invert mask bitmap colors to overcome the 32bits to 1bit bitmap convert problem.
			l_imp.dc.bit_blt (0, 0, width, height, l_imp.dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.patinvert)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- C++ externals initlization

	cpp_bitmap_create (a_width, a_height: INTEGER): POINTER is
			-- Create a C++ bitmap object.
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
				(EIF_POINTER) new Gdiplus::Bitmap ($a_width, $a_height, PixelFormat32bppARGB);
			]"
		end

	cpp_bitmap_from_file (a_wchar_file_name: POINTER): POINTER is
			-- Create a C++ bitmap object name from file `a_wchar_file_name'.
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
				(EIF_POINTER) Gdiplus::Bitmap::FromFile ((const WCHAR *)($a_wchar_file_name));
			]"
		end

	cpp_bitmap_draw_bitmap (a_result_bitmap: POINTER; a_orignal_bitmap: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER) is
			-- Draw `a_orignal_bitmap' onto `a_result_bitmap'.
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
			{
				using namespace Gdiplus;
				Graphics l_g ((Bitmap *)$a_result_bitmap);
				RectF l_r_dest ($a_dest_x, $a_dest_y, $a_dest_width, $a_dest_height);
				int l_states = l_g.DrawImage ((Bitmap *)$a_orignal_bitmap, l_r_dest, $a_src_x, $a_src_y, $a_src_width, $a_src_height, UnitPixel);
				if (l_states != Ok)
				{
					printf ("\n cpp_bitmap_draw_bitmap failed, with Result: %d", l_states);
				}
			}
			]"
		end

	cpp_bitmap_draw_bitmap_with_matrix (a_result_bitmap: POINTER; a_orignal_bitmap: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER; a_color_matrix: POINTER) is
			-- Draw `a_orignal_bitmap' onto `a_result_bitmap'.
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
			{
				using namespace Gdiplus;
				Graphics l_g ((Bitmap *)$a_result_bitmap);			
				RectF l_r_dest ($a_dest_x, $a_dest_y, $a_dest_width, $a_dest_height);
				ImageAttributes *image_attributes = new ImageAttributes ();
				image_attributes->ClearColorKey(ColorAdjustTypeBitmap);
				image_attributes->SetColorMatrix((ColorMatrix *)$a_color_matrix);				
				int l_states = l_g.DrawImage ((Bitmap *)$a_orignal_bitmap, l_r_dest, $a_src_x, $a_src_y, $a_src_width, $a_src_height, UnitPixel, image_attributes);
				if (l_states != Ok)
				{
					printf ("\n cpp_bitmap_draw_bitmap failed, with Result: %d", l_states);
				}
				delete image_attributes;
			}
			]"
		end

	cpp_bitmap_delete (a_item: POINTER)is
			-- Destroy C++ Bitmap object which indicated by `a_item'
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
			{
				delete (Gdiplus::Bitmap *)$a_item;
			}
			]"
		end

feature -- C++ externals operations

	cpp_bitmap_draw_to_dc (a_item: POINTER; a_dc: POINTER; a_x, a_y, a_width, a_height: INTEGER) is
			-- Draw `a_item' onto `a_dc'.
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
			{
				using namespace Gdiplus;
				Graphics l_g ((HDC)$a_dc);
				int l_states = l_g.DrawImage ((Bitmap *)$a_item, $a_x, $a_y, $a_width, $a_height);
				if (l_states != Ok)
				{
					printf ("\n cpp_bitmap_draw_to_dc failed, with Result: %d", l_states);
				}			
			}
			]"
		end

	cpp_bitmap_draw_to_dc_with_matrix (a_item: POINTER; a_dc: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER; a_color_matrix: POINTER) is
			-- Draw `a_item' onto `a_dc'.
			-- FIXIT: We can merge several external features to one feature?
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
			{
				using namespace Gdiplus;
				Graphics l_g ((HDC)$a_dc);			
				RectF l_r_dest ($a_dest_x, $a_dest_y, $a_dest_width, $a_dest_height);
				ImageAttributes *image_attributes = new ImageAttributes ();
				image_attributes->ClearColorKey(ColorAdjustTypeBitmap);
				image_attributes->SetColorMatrix((ColorMatrix *)$a_color_matrix);				
							
				int l_states = l_g.DrawImage ((Bitmap *)$a_item, l_r_dest, $a_src_x, $a_src_y, $a_src_width, $a_src_height, UnitPixel, image_attributes);
				if (l_states != Ok)
				{
					printf ("\n cpp_bitmap_draw_to_dc_with_matrix failed, with Result: %d", l_states);
				}

				delete image_attributes;
			}
			]"
		end

feature -- C++ externals querys

	cpp_bitmap_width (a_item: POINTER): NATURAL_32 is
			-- Width
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
				((Gdiplus::Bitmap*)$a_item)->GetWidth()
			]"
		end

	cpp_bitmap_height (a_item: POINTER): NATURAL_32 is
			-- Height
		require
			support: is_gdi_plus_installed
		external
			"C++ inline use <gdiplus.h>"
		alias
			"[
				((Gdiplus::Bitmap*)$a_item)->GetHeight()
			]"
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
