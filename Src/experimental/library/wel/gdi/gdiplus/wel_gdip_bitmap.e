note
	description: "[
					Bitmap functions in Gdi+.
					For more information, please see:
					MSDN Bitmap Functions:
					http://msdn.microsoft.com/en-us/library/ms533971(VS.85).aspx
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_BITMAP

inherit
	WEL_GDIP_IMAGE
		redefine
			load_image_from_path,
			raw_format
		end

create
	make_with_size,
	make_formatted,
	make_with_graphics,
	make_from_icon,
	make_from_bitmap,
	make_from_dib_bitmap,
	make_from_bitmap_with_alpha

create {WEL_GDIP_BITMAP}
	make_from_pointer

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER)
			-- Creation method.
		require
			larger_than_0: a_width > 0
			larger_than_0: a_height > 0
		do
			make_formatted (a_width, a_height, {WEL_GDIP_PIXEL_FORMAT}.Format32bppARGB)
		end

	make_formatted (a_width, a_height: INTEGER; a_format: INTEGER)
			-- Creation method
		require
			larger_than_0: a_width > 0
			larger_than_0: a_height > 0
			valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid_format (a_format)
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_bitmap_from_scan0 (gdi_plus_handle, a_width, a_height, a_format, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_with_graphics (a_width, a_height: INTEGER; a_graphics: WEL_GDIP_GRAPHICS)
			-- Creation method.
		require
			larger_than_0: a_width > 0
			larger_than_0: a_height > 0
			not_void: a_graphics /= Void
			a_graphics_exists: a_graphics.exists
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_bitmap_from_graphics  (gdi_plus_handle, a_width, a_height, a_graphics.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_icon (a_icon: WEL_ICON)
			-- Creation method.
		require
			a_icon_not_void: a_icon /= Void
			a_icon_exists: a_icon.exists
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_bitmap_from_hicon  (gdi_plus_handle, a_icon.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_pointer (a_pointer: POINTER)
			-- Creation method
			-- Pointer points to an existing gdip_bitmap.
		require
			a_pointer_not_null: a_pointer /= default_pointer
		do
			default_create
			item := a_pointer
		end

	make_from_bitmap (a_bitmap: WEL_BITMAP; a_palette: detachable WEL_PALETTE)
			-- Creation method.
			-- When convert from `a_bitmap' to Current, alpha channel data will lost.
		require
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
			a_palette_valid: a_palette /= Void implies a_palette.exists
		local
			l_result: INTEGER
			l_palette: POINTER
		do
			default_create
			if a_palette /= Void then
				l_palette := a_palette.item
			end
			item := c_gdip_create_bitmap_from_bitmap  (gdi_plus_handle, a_bitmap.item, l_palette, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_dib_bitmap (a_bitmap_info: WEL_BITMAP_INFO; a_bitmap_data: POINTER)
			-- Creation method.
			-- When convert from `a_bitmap_info' and `a_bitmap_data' to Current, alpha channel data will lost.
		require
			exists: a_bitmap_info /= Void and then a_bitmap_info.exists
			exists: a_bitmap_data /= default_pointer
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_bitmap_from_dib_bitmap (gdi_plus_handle, a_bitmap_info.item, a_bitmap_data, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_bitmap_with_alpha (a_bitmap: WEL_BITMAP)
			-- Copy raw image data from `a_bitmap' directly.
			-- `a_bitmap' must have alpha channel and bits order is argb.
		require
			exists: a_bitmap /= Void and then a_bitmap.exists
		local
			l_current_data: WEL_GDIP_BITMAP_DATA
			l_rect: WEL_GDIP_RECT
			l_pointer: POINTER
			l_width, l_height: INTEGER
			l_data: MANAGED_POINTER
			l_dc: WEL_MEMORY_DC
			l_info: WEL_BITMAP_INFO
			l_header: WEL_BITMAP_INFO_HEADER
			l_format: INTEGER
		do
			l_width := a_bitmap.width
			l_height := a_bitmap.height

			create l_dc.make
			create l_info.make_by_dc (l_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_header := l_info.header

				-- Gdi and Gdi+ have different pixel data order (`up to bottom' vs `bottom to up')
				-- Let's revert the data
			l_header.set_height (- l_height)
			l_data := l_dc.di_bits_pointer (a_bitmap, 0, l_height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

			inspect l_header.bit_count
			when 1 then l_format := {WEL_GDIP_PIXEL_FORMAT}.format1bppindexed
			when 4 then l_format := {WEL_GDIP_PIXEL_FORMAT}.format4bppindexed
			when 8 then l_format := {WEL_GDIP_PIXEL_FORMAT}.format8bppindexed
			when 16 then
				if l_header.compression = {WEL_BI_COMPRESSION_CONSTANTS}.bi_bitfields then
					if
						l_info.rgb_quad_natural (0) = 0xF800 and l_info.rgb_quad_natural (1) = 0x07E0 and
						l_info.rgb_quad_natural (2) = 0x001F
					then
						l_format := {WEL_GDIP_PIXEL_FORMAT}.format16bpprgb565
					else
						check
							expected_555_format: l_info.rgb_quad_natural (0) = 0x7C00 and l_info.rgb_quad_natural (1) = 0x03E0 and
							l_info.rgb_quad_natural (2) = 0x001F
						end
						l_format := {WEL_GDIP_PIXEL_FORMAT}.format16bpprgb555
					end
				else
					l_format := {WEL_GDIP_PIXEL_FORMAT}.format16bpprgb555
				end
			when 24 then l_format := {WEL_GDIP_PIXEL_FORMAT}.format24bpprgb
			when 32 then l_format := {WEL_GDIP_PIXEL_FORMAT}.format32bppargb
			else
				check False end
			end

			make_formatted (l_width, l_height, l_format)
			create l_rect.make_with_size (0, 0, l_width, l_height)
			l_current_data := lock_bits (l_rect, {WEL_GDIP_IMAGE_LOCK_MODE}.write_only, l_format)
			l_pointer := l_current_data.scan_0

			l_pointer.memory_copy (l_data.item, l_data.count)

			unlock_bits (l_current_data)
			l_info.dispose
		end

feature -- Command

	set_with_icon (a_icon: WEL_ICON)
			-- Creation method.
		require
			a_icon_not_void: a_icon /= Void
			a_icon_exists: a_icon.exists
			exists: exists
		do
			destroy_item
			make_from_icon (a_icon)
		end

	load_image_from_path (a_file_name: PATH)
			-- Redefine
		local
			l_temp: WEL_GDIP_BITMAP
			l_bitmap_data, l_current_data: WEL_GDIP_BITMAP_DATA
			l_rect: WEL_GDIP_RECT
			l_pointer: POINTER
		do
			create l_temp.make_with_size (1, 1)
			l_temp.load_image_from_file_original (a_file_name)

			raw_format_recorded := l_temp.raw_format_orignal

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

	lock_bits (a_rect: WEL_GDIP_RECT; a_lock_bitmode_flag: NATURAL_32; a_pixel_format: INTEGER): WEL_GDIP_BITMAP_DATA
			-- Lock image data bits.
		require
			not_void: a_rect /= Void
			is_vaild: (create {WEL_GDIP_IMAGE_LOCK_MODE}).is_valid (a_lock_bitmode_flag)
			is_valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid (a_pixel_format)
			exists: exists
		local
			l_result: INTEGER
		do
			create Result.make
			c_gdip_bitmap_lock_bits (gdi_plus_handle, item, a_rect.item, a_lock_bitmode_flag, a_pixel_format, $l_result, Result.item)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		ensure
			not_void: Result /= Void
		end

	unlock_bits (a_locked_data: WEL_GDIP_BITMAP_DATA)
			-- Unlock `a_lock_data' which is from Current datas.
		require
			not_void: a_locked_data /= Void
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_bitmap_unlock_bits (gdi_plus_handle, item, a_locked_data.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_pixel (a_x, a_y, argb_value: NATURAL_32)
			-- Set ARGB pixel value at `a_x', `a_y' to `argb_value'.
		require
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_bitmap_set_pixel (gdi_plus_handle, item, a_x, a_y, argb_value, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Return ARGB pixel value at `a_x', `a_y'.
		require
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_bitmap_get_pixel (gdi_plus_handle, item, a_x, a_y, $Result, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end


	sub_gdip_bitmap (a_x, a_y, a_width, a_height: NATURAL_32): WEL_GDIP_BITMAP
			-- Return a new GDI+ bitmap that represents a sub-pixmap of `Current'.
		require
			exists: exists
		local
			l_result: INTEGER
			l_bitmap_result: POINTER
		do
			c_gdip_clone_bitmap_area_i (gdi_plus_handle, a_x, a_y, a_width, a_height, {WEL_GDIP_PIXEL_FORMAT}.Format32bppArgb, item, $l_bitmap_result, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
			create Result.make_from_pointer (l_bitmap_result)
		end

	new_bitmap: WEL_BITMAP
			-- Create a 32bits DIB prmulitplied ARGB bitmap from current data.
		require
			exists: exists
		local
			l_header_info: WEL_BITMAP_INFO_HEADER
			l_result_pointer: POINTER
			l_bitmap_data: WEL_GDIP_BITMAP_DATA
			l_helper: WEL_BITMAP_HELPER
		do
			create l_header_info.make
			l_header_info.set_planes (1)
			l_header_info.set_bit_count (32)
			l_header_info.set_compression ({WEL_BI_COMPRESSION_CONSTANTS}.Bi_rgb)
			l_header_info.set_size_image (0)
			l_header_info.set_x_pels_per_meter (0)
			l_header_info.set_y_pels_per_meter (0)
			l_header_info.set_clr_used (0)
			l_header_info.set_clr_important (0)
			l_header_info.set_width (width)
			l_header_info.set_height (height)
			create Result.make_dib (l_header_info)
			l_header_info.dispose

			l_result_pointer := Result.ppv_bits

			l_bitmap_data := lock_bits (
				create {WEL_GDIP_RECT}.make_with_size (0, 0, width, height),
				{WEL_GDIP_IMAGE_LOCK_MODE}.read_only, {WEL_GDIP_PIXEL_FORMAT}.format32bpppargb)
			-- We are 32bits, so size is width * height * 4
			l_result_pointer.memory_copy (l_bitmap_data.scan_0, width * height * 4)
			unlock_bits (l_bitmap_data)

			-- WEL_BITMAP store datas bottom up, so we have to flip the data.
			create l_helper
			l_helper.mirror_image (Result)
		end

feature -- Query

	raw_format: detachable WEL_GUID
			-- Redefine
		do
			Result := raw_format_recorded
		end

feature {NONE} -- Implementation

	raw_format_recorded: detachable WEL_GUID
			-- When `load_image_from_file' we copied orignal datas to a memoryBMP image, we record orignal image type here.

feature -- C externals

	c_gdip_create_bitmap_from_scan0 (a_gdiplus_handle: POINTER; a_width, a_height: INTEGER; a_pixel_format: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a bitmap object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			valid: (create {WEL_GDIP_PIXEL_FORMAT}).is_valid_format (a_pixel_format)
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
								(PixelFormat) $a_pixel_format,
								(BYTE*) NULL,
								(GpBitmap **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_create_bitmap_from_graphics (a_gdiplus_handle: POINTER; a_width, a_height: INTEGER; a_target_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a bitmap object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateBitmapFromGraphics = NULL;
				GpBitmap *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipCreateBitmapFromGraphics)	{
					GdipCreateBitmapFromGraphics = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateBitmapFromGraphics");
				}
				if (GdipCreateBitmapFromGraphics) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (INT, INT, GpGraphics *, GpBitmap **)) GdipCreateBitmapFromGraphics)
								((INT) $a_width,
								(INT) $a_height,
								(GpGraphics *) $a_target_graphics,
								(GpBitmap **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_create_bitmap_from_bitmap (a_gdiplus_handle: POINTER; a_image, a_palette: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
				-- Create a bitmap object.	
			require
				a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			external
				"C inline use %"wel_gdi_plus.h%""
			alias
				"[
				{
					static FARPROC GdipCreateBitmapFromHBITMAP = NULL;
					GpBitmap *l_result = NULL;
					*(EIF_INTEGER *) $a_result_status = 1;

					if (!GdipCreateBitmapFromHBITMAP)	{
						GdipCreateBitmapFromHBITMAP = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateBitmapFromHBITMAP");
					}
					if (GdipCreateBitmapFromHBITMAP) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (HBITMAP, HPALETTE, GpBitmap **)) GdipCreateBitmapFromHBITMAP)
									((HBITMAP) $a_image,
									(HPALETTE) $a_palette,
									(GpBitmap **) &l_result);
					}
					return (EIF_POINTER) l_result;
				}
				]"
			end

	c_gdip_create_bitmap_from_dib_bitmap (a_gdiplus_handle: POINTER; a_bitmap_info, a_bitmap_data: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
				-- Create a bitmap object.	
			require
				a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			external
				"C inline use %"wel_gdi_plus.h%""
			alias
				"[
				{
					static FARPROC GdipCreateBitmapFromGdiDib = NULL;
					GpBitmap *l_result = NULL;
					*(EIF_INTEGER *) $a_result_status = 1;

					if (!GdipCreateBitmapFromGdiDib)	{
						GdipCreateBitmapFromGdiDib = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateBitmapFromGdiDib");
					}
					if (GdipCreateBitmapFromGdiDib) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST BITMAPINFO*, VOID*, GpBitmap **)) GdipCreateBitmapFromGdiDib)
									((GDIPCONST BITMAPINFO*) $a_bitmap_info,
									(VOID*) $a_bitmap_data,
									(GpBitmap **) &l_result);
					}
					return (EIF_POINTER) l_result;
				}
				]"
			end

	c_gdip_create_bitmap_from_hicon (a_gdiplus_handle: POINTER; a_hicon: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a bitmap object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateBitmapFromHICON = NULL;
				GpBitmap *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipCreateBitmapFromHICON)	{
					GdipCreateBitmapFromHICON = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateBitmapFromHICON");
				}
				if (GdipCreateBitmapFromHICON) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (HICON, GpBitmap **)) GdipCreateBitmapFromHICON)
								((HICON) $a_hicon,
								(GpBitmap **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_bitmap_get_pixel (a_gdiplus_handle, a_bitmap: POINTER; a_x, a_y: NATURAL_32; a_color: TYPED_POINTER [NATURAL_32]; a_result_status: TYPED_POINTER [INTEGER])
				-- Get pixel of `a_bitmap' at `a_x', `a_y'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_bitmap_not_null: a_bitmap /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetPixel = NULL;
					
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetPixel)	{
					GdipGetPixel = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipBitmapGetPixel");
				}					
				if (GdipGetPixel) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpBitmap *, INT, INT, ARGB*)) GdipGetPixel)
								((GpBitmap *) $a_bitmap,
								(INT) $a_x,
								(INT) $a_y,
								(ARGB*) $a_color);
				}
			}
			]"
		end

	c_gdip_bitmap_set_pixel (a_gdiplus_handle, a_bitmap: POINTER; a_x, a_y: NATURAL_32; a_color: NATURAL_32; a_result_status: TYPED_POINTER [INTEGER])
				-- Set pixel of `a_bitmap' at `a_x', `a_y'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_bitmap_not_null: a_bitmap /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetPixel = NULL;
					
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipSetPixel)	{
					GdipSetPixel = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipBitmapSetPixel");
				}					
				if (GdipSetPixel) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpBitmap *, INT, INT, ARGB)) GdipSetPixel)
								((GpBitmap *) $a_bitmap,
								(INT) $a_x,
								(INT) $a_y,
								(ARGB) $a_color);
				}
			}
			]"
		end

	c_gdip_bitmap_lock_bits (a_gdiplus_handle, a_bitmap: POINTER; a_gp_rect: POINTER; a_image_lock_flag: NATURAL_32; a_pixel_format: INTEGER; a_result_status: TYPED_POINTER [INTEGER]; a_bitmap_data: POINTER)
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

	c_gdip_bitmap_unlock_bits (a_gdiplus_handle, a_bitmap, a_locked_bitmap_data: POINTER; a_result_status: TYPED_POINTER [INTEGER])
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

  	c_gdip_clone_bitmap_area_i (a_gdiplus_handle: POINTER; a_x, a_y, a_width, a_height: NATURAL_32; a_pixel_format: INTEGER; a_source_pixbuf: POINTER; a_dest_pixbuf: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw `a_image' on `a_graphics'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCloneBitmapAreaI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCloneBitmapAreaI) {
					GdipCloneBitmapAreaI  = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCloneBitmapAreaI");
				}
				if (GdipCloneBitmapAreaI) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (INT, INT, INT, INT, PixelFormat, GpBitmap *, GpBitmap **)) GdipCloneBitmapAreaI)
								((INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height,
								(PixelFormat) $a_pixel_format,
								(GpBitmap *) $a_source_pixbuf,
								(GpBitmap **) $a_dest_pixbuf);
				}
			}
			]"
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
