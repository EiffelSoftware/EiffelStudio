indexing
	description: "Defines the dimensions and color information for a %
		%Windows device-independent bitmap (DIB)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_dib_colors_constant
		end

creation
	make,
	make_by_dc,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_bitmap_info_header: WEL_BITMAP_INFO_HEADER;
			a_rgb_quad_count: INTEGER) is
			-- Make a BITMAPINFO structure
			-- with `a_bitmap_info_header'
		require
			a_bitmap_info_header_not_void: a_bitmap_info_header
				/= Void
			positive_rgb_quad_count: a_rgb_quad_count >= 0
		do
			rgb_quad_count := a_rgb_quad_count
			structure_make
			set_bitmap_info_header (a_bitmap_info_header)
		end

	make_by_dc (dc: WEL_DC; bitmap: WEL_BITMAP; usage: INTEGER) is
			-- Make a bitmap info structure using `dc' and
			-- `bitmap'.
			-- See class WEL_DIB_COLORS_CONSTANTS for `usage'
			-- values.
		require
			dc_not_void: dc /= Void
			dc_exists: dc.exists
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
			valid_usage: valid_dib_colors_constant (usage)
		local
			bih: WEL_BITMAP_INFO_HEADER
		do
			rgb_quad_count := 0
			structure_make
			create bih.make
			set_bitmap_info_header (bih)
			cwin_get_di_bits (dc.item, bitmap.item, 0, 0,
				default_pointer, item, usage)
		end

feature -- Access

	header: WEL_BITMAP_INFO_HEADER is
			-- Information about the dimensions and color
			-- format of a DIB
		do
			create Result.make_by_pointer (
				cwel_bitmap_info_get_header (item))
		ensure
			result_not_void: Result /= Void
		end

	rgb_quad_count: INTEGER
			-- Number of colors

	rgb_quad (index: INTEGER): WEL_RGB_QUAD is
			-- Bitmap color at zero-based `index'
		require
			index_small_enough: index < rgb_quad_count
			index_large_enough: index >= 0
		do
			create Result.make
			Result.memory_copy (
				cwel_bitmap_info_get_rgb_quad (item, index), 
				c_size_of_rgb_quad)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_bitmap_info_header (a_header: WEL_BITMAP_INFO_HEADER) is
			-- Set `header' with `a_header'.
		require
			a_header_not_void: a_header /= Void
		do
			cwel_bitmap_info_set_header (item, a_header.item)
		end

	set_rgb_quad (index: INTEGER; a_rgb_quad: WEL_RGB_QUAD) is
			-- Set `rgb_quad' with `a_rgb_quad' at
			-- zero-based `index'.
		require
			index_small_enough: index < rgb_quad_count
			index_large_enough: index >= 0
			a_rgb_quad_not_void: a_rgb_quad /= Void
		do
			cwel_bitmap_info_set_rgb_quad_rgb_red (item, index,
				a_rgb_quad.red)
			cwel_bitmap_info_set_rgb_quad_rgb_green (item, index,
				a_rgb_quad.green)
			cwel_bitmap_info_set_rgb_quad_rgb_blue (item, index,
				a_rgb_quad.blue)
			cwel_bitmap_info_set_rgb_quad_rgb_reserved (item,
				index, a_rgb_quad.reserved)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_bitmap_info +
				(rgb_quad_count * c_size_of_rgb_quad)
		end

feature -- Obsolete

	bitmap_info_header: WEL_BITMAP_INFO_HEADER is obsolete "Use ``header''"
		do
			Result := header
		end

feature {NONE} -- Externals

	c_size_of_bitmap_info: INTEGER is
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (BITMAPINFO)"
		end

	c_size_of_rgb_quad: INTEGER is
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (RGBQUAD)"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_red (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_header (ptr: POINTER; value: POINTER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_green (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_blue (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_reserved (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_get_header (ptr: POINTER): POINTER is
		external
			"C [macro <bmpinfo.h>] (BITMAPINFO*): EIF_POINTER"
		end

	cwel_bitmap_info_get_rgb_quad (ptr: POINTER; i: INTEGER): POINTER is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwin_get_di_bits (hdc, hbmp: POINTER; start_scan, scan_lines: INTEGER;
			bits, bi: POINTER; usage: INTEGER) is
			-- SDK GetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, %
				%VOID *, BITMAPINFO *, UINT)"
		alias
			"GetDIBits"
		end

end -- class WEL_BITMAP_INFO


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

