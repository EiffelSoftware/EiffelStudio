indexing
	description: "Windows Bitmap, which can be loaded from a resource %
			%or created from an existing DIB."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP

inherit
	WEL_GDI_ANY

	WEL_RESOURCE
		undefine
			make_by_pointer,
			dispose
		redefine
			make_by_id,
			make_by_name
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_dib_colors_constant
		end

	WEL_IMAGE_CONSTANTS
		export
			{NONE} all
		end

create
	make_by_id,
	make_by_name,
	make_by_dib,
	make_compatible,
	make_direct,
	make_indirect,
	make_by_pointer,
	make_by_bitmap,
	make_dib

feature {NONE} -- Initialization

	make_by_id (id: INTEGER) is
			-- Load the resource by an `id'
		do
			debug ("WEL_GDI_COUNT")
				io.put_string ("Creating WEL_BITMAP")
			end
			Precursor {WEL_RESOURCE} (id)
			gdi_make
		end

	make_by_name (name: STRING_GENERAL) is
			-- Load the resource by a `name'
		do
			Precursor (name)
			gdi_make
		end

	make_compatible (a_dc: WEL_DC; a_width, a_height: INTEGER) is
			-- Initialize current bitmap to be compatible
			-- with `a_dc' and with `a_width' as `width',
			-- `a_height' as `height'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
			positive_width: a_width >= 0
			positive_height: a_height >= 0
		do
			item := cwin_create_compatible_bitmap (a_dc.item,
				a_width, a_height)
			gdi_make
		end

	make_by_dib (a_dc: WEL_DC; dib: WEL_DIB; mode: INTEGER) is
			-- Create a WEL_BITMAP from a `dib' in the `a_dc'
			-- using `mode'. See class `WEL_DIB_COLORS_CONSTANTS'
			-- for `mode' values.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
			dib_not_void: dib /= Void
			valid_mode: valid_dib_colors_constant (mode)
		do
			item := cwin_create_di_bitmap (a_dc.item, dib.info_header.item,
				Cbm_init, dib.item_bits, dib.item, mode)
			gdi_make
		ensure
			bitmap_created: item /= item.default
		end

	make_by_bitmap (a_bitmap: WEL_BITMAP) is
			-- Create a WEL_BITMAP from another WEL_BITMAP. The
			-- bitmap is copied by value
		do
			item := cwin_copy_image(a_bitmap.item, Image_bitmap, a_bitmap.width, a_bitmap.height, 0)
			shared := False
			if a_bitmap.is_made_by_dib or a_bitmap.ppv_bits /= default_pointer then
				is_made_by_dib := True
			end
			gdi_make
		end

	make_indirect (a_log_bitmap: WEL_LOG_BITMAP) is
			-- Make a bitmap using `a_log_bitmap'.
		require
			a_log_bitmap_not_void: a_log_bitmap /= Void
		do
			item := cwin_create_bitmap_indirect (a_log_bitmap.item)
			gdi_make
		end

	make_direct (a_width, a_height, a_planes, a_bits_per_pixel: INTEGER; a_data: STRING) is
			-- Make a bitmap of dimension `a_width' x `a_height' that has `a_planes' number
			-- of color planes and `a_bits_per_pixel' (number of bits to identify color).
			-- `a_data' contains color data array.
		require
			positive_width: a_width >= 0
			positive_height: a_height >= 0
			positive_planes: a_planes >= 0
			positive_bits_per_pixel: a_bits_per_pixel >= 0
			data_not_void: a_data /= Void
			data_count_big_enough: a_data.count >= 2 * (a_width * a_height * a_bits_per_pixel * a_planes) // 8
		local
			l_data: C_STRING
		do
			create l_data.make (a_data)
			item := cwin_create_bitmap (a_width, a_height, a_planes, a_bits_per_pixel, l_data.item)
			gdi_make
		end

	make_dib (a_header_info: WEL_BITMAP_INFO_HEADER) is
			-- Create a DIB bitmap section.
		require
			a_header_info_not_void: a_header_info /= Void
			a_header_info_exist: a_header_info.exists
		local
			l_null_pointer, l_ppv_bits: POINTER
		do
			item := cwin_create_dib_section (l_null_pointer, a_header_info.item, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors, $l_ppv_bits, l_null_pointer, 0)
			ppv_bits := l_ppv_bits
		ensure
			bitmap_created: item /= default_pointer
			ppv_bits_assigned: ppv_bits /= default_pointer
		end

feature -- Access

	width: INTEGER is
			-- Bitmap width
		require
			exists: exists
		do
			Result := log_bitmap.width
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER is
			-- Bitmap height
		require
			exists: exists
		do
			Result := log_bitmap.height
		ensure
			positive_result: Result >= 0
		end

	log_bitmap: WEL_LOG_BITMAP is
			-- Log bitmap structure associated to `Current'
		require
			exists: exists
		do
			create Result.make_by_bitmap (Current)
		ensure
			result_not_void: Result /= Void
		end

	ppv_bits: POINTER
			-- If Current if Created by `make_dib', this is the pointer to the location of the DIB bit values.
			-- Otherwise it's void.

	is_made_by_dib: BOOLEAN
		-- When calling `make_by_bitmap', if current made from DIB bitmap?

feature -- Basic operations

	set_di_bits (a_dc: WEL_DC; start_line, length: INTEGER; dib: WEL_DIB;
			mode: INTEGER) is
			-- Set the bits of the current bitmap to the values
			-- given in `dib', starting at line `start_line'
			-- during `length' lines, using `mode'.
			-- See class WEL_DIB_COLORS_CONSTANTS for `mode' values.
		require
			exists: exists
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
			dib_not_void: dib /= Void
			valid_mode: valid_dib_colors_constant (mode)
		do
			cwin_set_di_bits (a_dc.item, item, start_line, length,
				dib.item_bits, dib.item, mode)
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
		do
			item := cwin_load_bitmap (hinstance, id)
		end

feature {NONE} -- Externals

	cwin_create_compatible_bitmap (hdc: POINTER; w, h: INTEGER): POINTER is
			-- SDK CreateCompatibleBitmap
		external
			"C [macro <wel.h>] (HDC, int, int): EIF_POINTER"
		alias
			"CreateCompatibleBitmap"
		end

	cwin_create_di_bitmap (hdc, bitmapinfo: POINTER;init: INTEGER;
				bits, infodib: POINTER; mode: INTEGER): POINTER is
			-- SDK CreateDIBitmap
		external
			"C [macro <wel.h>] (HDC, BITMAPINFOHEADER *, DWORD, %
				%void *, BITMAPINFO *, UINT): EIF_POINTER"
		alias
			"CreateDIBitmap"
		end

	cwin_set_di_bits (hdc, bitmap: POINTER;start_line, length: INTEGER;
			 bits, info: POINTER; mode: INTEGER) is
			-- SDK SetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, void *, %
				%BITMAPINFO *, UINT)"
		alias
			"SetDIBits"
		end

	cwin_get_di_bits (hdc, bitmap: POINTER;start_line, no_scanlines: INTEGER;
			 bits, info: POINTER; mode: INTEGER) is
			-- SDK GetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, void *, %
				%BITMAPINFO *, UINT)"
		alias
			"GetDIBits"
		end

	cwin_load_bitmap (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadBitmap
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR): EIF_POINTER"
		alias
			"LoadBitmap"
		end

	cwin_copy_image (himage: POINTER; utype, new_width, new_height, flags: INTEGER): POINTER is
			-- SDK CopyImage
		external
			"C [macro <wel.h>] (HANDLE, UINT, int, int, UINT): EIF_POINTER"
		alias
			"CopyImage"
		end

	cwin_create_bitmap_indirect (a_log_bitmap: POINTER): POINTER is
			-- SDK CreateBitmapIndirect
		external
			"C [macro <wel.h>] (BITMAP *): EIF_POINTER"
		alias
			"CreateBitmapIndirect"
		end

	cwin_create_bitmap (a_width, a_height, a_planes, a_bits_per_pixel: INTEGER; a_data: POINTER): POINTER is
			-- SDK CreateBitmapt
		external
			"C [macro <wel.h>] (int, int, UINT, UINT, CONST VOID *): EIF_POINTER"
		alias
			"CreateBitmap"
		end

	cwin_create_dib_section (a_dc, a_bitmap_info: POINTER; a_i_usage: INTEGER; a_ppv_bits: TYPED_POINTER [POINTER]; a_h_section: POINTER; a_offset: NATURAL_64): POINTER is
			-- SDK CreateDIBSection
		external
			"C inline use <windows.h>"
		alias
			"[
				CreateDIBSection (
								(HDC) $a_dc,
								(CONST BITMAPINFO *) $a_bitmap_info,
								(UINT) $a_i_usage,
								(VOID **) $a_ppv_bits,
								(HANDLE) $a_h_section,
								(DWORD) $a_offset
								)
			]"
		end

	Cbm_init: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBM_INIT"
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




end -- class WEL_BITMAP

