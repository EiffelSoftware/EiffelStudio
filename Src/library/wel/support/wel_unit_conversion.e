indexing
	description: "Unit conversion."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UNIT_CONVERSION

inherit
	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	Himetric_per_inch: INTEGER is   2540
			-- Defined as HIMETRIC_PER_INCH in AtlWin.h
	
feature -- Basic Operations

	map_pixel_to_loghim (x,ppli: INTEGER): INTEGER is   
			-- Defined as MAP_PIX_TO_LOGHIM in AtlWin.h
		local
			temp: INTEGER_64
		do
			temp := integer_32x32_to_64 (Himetric_per_inch, x) + ppli // 2
			Result := integer_64_to_32 (temp // ppli)
		end

	map_loghim_to_pixel (x,ppli: INTEGER): INTEGER is 
			-- Defined as MAP_LOGHIM_TO_PIX in AtlWin.h
		local
			temp: INTEGER_64
		do
			temp := integer_32x32_to_64 (ppli, x) + Himetric_per_inch // 2
			Result := integer_64_to_32 (temp // Himetric_per_inch)
		end
	
	pixel_to_himetric (a_size_in_pixel: WEL_SIZE): WEL_SIZE is
			-- Convert pixels into himetric.
		require
			non_void_size: a_size_in_pixel /= Void
		local
			screen_dc: WEL_SCREEN_DC
			n_pixels_per_inch_x: INTEGER
			n_pixels_per_inch_y: INTEGER
		do
			create screen_dc
			screen_dc.get
			
			n_pixels_per_inch_x := get_device_caps (screen_dc.item, logical_pixels_x)
			n_pixels_per_inch_y := get_device_caps (screen_dc.item, logical_pixels_y)
			
			screen_dc.release
			
			create Result
			Result.set_width (map_pixel_to_loghim (a_size_in_pixel.width, n_pixels_per_inch_x))
			Result.set_height (map_pixel_to_loghim (a_size_in_pixel.height, n_pixels_per_inch_y))
		ensure
			non_void_result: Result /= Void
		end

	himetric_to_pixel (a_size_in_himetric: WEL_SIZE): WEL_SIZE is
			-- Convert himetric into pixels.
		require
			non_void_size: a_size_in_himetric /= Void
		local
			screen_dc: WEL_SCREEN_DC
			n_pixels_per_inch_x: INTEGER
			n_pixels_per_inch_y: INTEGER
		do
			create screen_dc
			screen_dc.get
			
			n_pixels_per_inch_x := get_device_caps (screen_dc.item, logical_pixels_x)
			n_pixels_per_inch_y := get_device_caps (screen_dc.item, logical_pixels_y)
			
			screen_dc.release
			
			create Result
			Result.set_width (map_loghim_to_pixel (a_size_in_himetric.width, n_pixels_per_inch_x))
			Result.set_height (map_loghim_to_pixel (a_size_in_himetric.height, n_pixels_per_inch_y))
		ensure
			non_void_result: Result /= Void
		end

	point_to_pixel (hdc: WEL_DC; pt, divisor: INTEGER): INTEGER is
			-- Convert a size `pt/divisor' expressed in point into pixel.
		do
			Result :=  mul_div (
				get_device_caps (hdc.item, logical_pixels_y), pt, 72 * divisor)
		end

	pixel_to_point (hdc: WEL_DC; pi: INTEGER): INTEGER is
			-- Convert a size `pi' expressed in pixel into point.
		do
			Result :=  mul_div (pi, 72,
				get_device_caps (hdc.item, logical_pixels_y))
		end

	point_to_logical (hdc: WEL_DC; pt, divisor: INTEGER): INTEGER is
			-- Convert a size `pt/divisor' expressed in point into logical units.
		do
			Result := pixel_to_logical (hdc, point_to_pixel (hdc, pt, divisor))
		end

	logical_to_point (hdc: WEL_DC; lo: INTEGER): INTEGER is
			-- Convert a size `lo' expressed in logical unit into point.
		do
			Result := pixel_to_point (hdc, logical_to_pixel (hdc, lo))
		end

	pixel_to_logical (hdc: WEL_DC; pi: INTEGER): INTEGER is
			-- Convert `pi' expressed in pixel unit into logical unit.
		local
			arr: WEL_ARRAY [WEL_POINT]
			p1, p2: WEL_POINT
		do
			create arr.make (2, (create {WEL_POINT}.make (0, 0)).structure_size)
			arr.put (create {WEL_POINT}.make (0, 0), 0)
			arr.put (create {WEL_POINT}.make (0, pi), 1)

			cwin_dp_to_lp (hdc.item, arr.item, 2)

			create p1.make_by_pointer (arr.i_th_item (0))
			create p2.make_by_pointer (arr.i_th_item (1))

			Result := (p2.y - p1.y).abs
		end

	logical_to_pixel (hdc: WEL_DC; lo: INTEGER): INTEGER is
			-- Convert `lo' expressed in logical unit into pixel unit.
		local
			arr: WEL_ARRAY [WEL_POINT]
			p1, p2: WEL_POINT
		do
			create arr.make (2, (create {WEL_POINT}.make (0, 0)).structure_size)
			arr.put (create {WEL_POINT}.make (0, 0), 0)
			arr.put (create {WEL_POINT}.make (0, lo), 1)

			cwin_lp_to_dp (hdc.item, arr.item, 2);
			create p1.make_by_pointer (arr.i_th_item (0))
			create p2.make_by_pointer (arr.i_th_item (1))

			Result := (p2.y - p1.y).abs
		end

feature {NONE} -- Externals

	cwin_dp_to_lp (dc, p: POINTER; i: INTEGER) is
		external
			"C [macro <windows.h>] (HDC, LPPOINT, int)"
		alias
			"DPtoLP"
		end

	cwin_lp_to_dp (dc, p: POINTER; i: INTEGER) is
		external
			"C [macro <windows.h>] (HDC, LPPOINT, int)"
		alias
			"LPtoDP"
		end
		
	mul_div (i,j,k: INTEGER): INTEGER is
			-- Does `i * j / k' but in a safe manner where the 64 bits integer
			-- obtained by `i * j' is not truncated.
		external
			"C [macro <windows.h>] (int, int, int): EIF_INTEGER"
		alias
			"MulDiv"
		end

	integer_32x32_to_64 (i,j: INTEGER): INTEGER_64 is
			-- Multiplies two signed 32-bit integers, returning a 
			-- signed 64-bit integer result. 
		external
			"C [macro <windows.h>] (LONG , LONG): EIF_INTEGER_64"
		alias
			"Int32x32To64"
		end

	get_device_caps (p: POINTER; i: INTEGER): INTEGER is
			-- Retrieves device-specific information about a specified device.
		external
			"C [macro <windows.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

	integer_64_to_32 (i64: INTEGER_64): INTEGER is
			-- Converts INTEGER_64 to INTEGER
		external
			"C [macro <eif_eiffel.h>]"
		alias
			" "
		end

end -- class WEL_UNIT_CONVERSION


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

