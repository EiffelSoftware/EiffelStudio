indexing
	description: "Windows Bitmap, which can be loaded from a resource %
			%or created from an existing DIB."
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
			make_by_pointer,
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

creation
	make_by_id,
	make_by_name,
	make_by_dib,
	make_compatible,
	make_indirect,
	make_by_pointer,
	make_by_bitmap

feature {NONE} -- Initialization

	make_by_id (id: INTEGER) is
			-- Load the resource by an `id'
		do
			debug ("GDI_COUNT")
				io.putstring ("Creating WEL_BITMAP")
			end
			Precursor {WEL_RESOURCE} (id)
			gdi_make
		end

	make_by_name (name: STRING) is
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

	cwin_set_di_bits (hdc, bitmap: POINTER;start_line, lenght: INTEGER;
			 bits, info: POINTER; mode: INTEGER) is
			-- SDK SetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, void *, %
				%BITMAPINFO *, UINT)"
		alias
			"SetDIBits"
		end

	cwin_load_bitmap (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadBitmap
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
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

	Cbm_init: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBM_INIT"
		end

end -- class WEL_BITMAP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

