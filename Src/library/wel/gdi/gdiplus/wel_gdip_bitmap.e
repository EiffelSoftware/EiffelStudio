indexing
	description: "Btimap functions in Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_BITMAP

inherit
	WEL_GDIP_IMAGE
		redefine
			load_image_from_file
		end

create
	make_with_size

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Creation method.
		require
			larger_than_0: a_width > 0
			larger_than_0: a_height > 0
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_bitmap_from_scan0 (gdi_plus_handle, a_width, a_height, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Command

	load_image_from_file (a_file_name: STRING) is
			-- Redefine
		local
			l_temp: WEL_GDIP_BITMAP
			l_bitmap_data, l_current_data: WEL_GDIP_BITMAP_DATA
			l_rect: WEL_GDIP_RECT
			l_pointer: POINTER
		do
			create l_temp.make_with_size (1, 1)
			l_temp.load_image_from_file_original (a_file_name)

			-- We copy the bitmaps data to a new instance, then the file will not be locked by Gdi+.
			create l_bitmap_data.make
			create l_rect.make_with_size (0, 0, l_temp.width, l_temp.height)
			l_bitmap_data := l_temp.lock_bits (l_rect, {WEL_GDIP_IMAGE_LOCK_MODE}.read_only, {WEL_GDIP_PIXEL_FORMAT}.format32bppargb)

			destroy_item
			make_with_size (l_temp.width, l_temp.height)
			l_current_data := lock_bits (l_rect, {WEL_GDIP_IMAGE_LOCK_MODE}.write_only, {WEL_GDIP_PIXEL_FORMAT}.format32bppargb)

			l_pointer := l_current_data.scan_0
			l_pointer.memory_copy (l_bitmap_data.scan_0, l_temp.width * l_temp.height * 4)
			unlock_bits (l_current_data)

			l_temp.unlock_bits (l_bitmap_data)
			l_temp.dispose
		end

	lock_bits (a_rect: WEL_GDIP_RECT; a_lock_bitmode_flag: NATURAL_32; a_pixel_format: INTEGER): WEL_GDIP_BITMAP_DATA is
			-- Lock image data bits.
		require
			not_void: a_rect /= Void
			is_vaild: (create {WEL_GDIP_IMAGE_LOCK_MODE}).is_valid (a_lock_bitmode_flag)
			is_valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid (a_pixel_format)
		local
			l_result: INTEGER
		do
			create Result.make
			c_gdip_bitmap_lock_bits (gdi_plus_handle, item, a_rect.item, a_lock_bitmode_flag, a_pixel_format, $l_result, Result.item)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		ensure
			not_void: Result /= Void
		end

	unlock_bits (a_locked_data: WEL_GDIP_BITMAP_DATA) is
			-- Unlock `a_lock_data' which is from Current datas.
		require
			not_void: a_locked_data /= Void
		local
			l_result: INTEGER
		do
			c_gdip_bitmap_unlock_bits (gdi_plus_handle, item, a_locked_data.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	new_bitmap: WEL_BITMAP is
			-- Create a 32bits DIB prmulitplied ARGB bitmap from current data.
		local
			l_header_info: WEL_BITMAP_INFO_HEADER
			l_result_pointer: POINTER
			l_bitmap_data: WEL_GDIP_BITMAP_DATA
			l_helper: WEL_BITMAP_HELPER
		do
			create l_header_info.make
			l_header_info.set_width (width)
			l_header_info.set_height (height)
			l_header_info.set_planes (1)
			l_header_info.set_bit_count (32)
			l_header_info.set_compression ({WEL_BI_COMPRESSION_CONSTANTS}.Bi_rgb.to_integer_32)
			l_header_info.set_size_image (0)
			l_header_info.set_x_pels_per_meter (0)
			l_header_info.set_y_pels_per_meter (0)
			l_header_info.set_clr_used (0)
			l_header_info.set_clr_important (0)

			create Result.make_dib (l_header_info)
			l_header_info.dispose

			l_result_pointer := Result.ppv_bits

			l_bitmap_data := lock_bits (create {WEL_GDIP_RECT}.make_with_size (0, 0, width, height), {WEL_GDIP_IMAGE_LOCK_MODE}.read_only, {WEL_GDIP_PIXEL_FORMAT}.format32bpppargb)
			-- We are 32bits, so size is width * height * 4
			l_result_pointer.memory_copy (l_bitmap_data.scan_0, width * height * 4)
			unlock_bits (l_bitmap_data)

			-- WEL_BITMAP store datas bottom up, so we have to flip the datas.
			create l_helper
			l_helper.mirror_image (Result)
		end

feature -- C externals

	c_gdip_create_bitmap_from_scan0 (a_gdiplus_handle: POINTER; a_width, a_height: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER  is
			-- Create a bitmap object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateBitmapFromScan0 = NULL;
				GpBitmap *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipCreateBitmapFromScan0)	{
					GdipCreateBitmapFromScan0 = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateBitmapFromScan0");
				}
				if (GdipCreateBitmapFromScan0) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (INT, INT, INT, PixelFormat, BYTE*, GpBitmap **)) GdipCreateBitmapFromScan0)
								((INT) $a_width,
								(INT) $a_height,
								(INT) 0,
								(PixelFormat) PixelFormat32bppARGB,
								(BYTE*) NULL,
								(GpBitmap **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_bitmap_lock_bits (a_gdiplus_handle, a_bitmap: POINTER; a_gp_rect: POINTER; a_image_lock_flag: NATURAL_32; a_pixel_format: INTEGER; a_result_status: TYPED_POINTER [INTEGER]; a_bitmap_data: POINTER) is
			-- Lock data bits of `a_bitmap', Result is pointer to BitmapData.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_bitmap_not_null: a_bitmap /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipBitmapLockBits = NULL;
					
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipBitmapLockBits)	{
					GdipBitmapLockBits = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipBitmapLockBits");
				}					
				if (GdipBitmapLockBits) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpBitmap *, GDIPCONST GpRect*, UINT, PixelFormat, BitmapData*)) GdipBitmapLockBits)
								((GpBitmap *) $a_bitmap,
								(GDIPCONST GpRect *) $a_gp_rect,
								(UINT) $a_image_lock_flag,
								
								
								(PixelFormat) $a_pixel_format,
								
								
								(BitmapData *) $a_bitmap_data);
				}
			}
			]"
		end

	c_gdip_bitmap_unlock_bits (a_gdiplus_handle, a_bitmap, a_locked_bitmap_data: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Unlock `a_locked_bitmap_data' which if from `a_bitmap'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_bitmap_not_null: a_bitmap /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipBitmapUnlockBits = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipBitmapUnlockBits) {
					GdipBitmapUnlockBits = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipBitmapUnlockBits");
				}
				if (GdipBitmapUnlockBits) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpBitmap*, BitmapData*)) GdipBitmapUnlockBits)
								((GpBitmap*) $a_bitmap,
								(BitmapData*) $a_locked_bitmap_data);				
				}
			}
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
