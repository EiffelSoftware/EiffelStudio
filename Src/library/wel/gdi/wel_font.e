indexing
	description: "Object font which can be selected into a DC."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT

inherit
	WEL_GDI_ANY

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end
creation 
	make,
	make_indirect,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_height, a_width, escapement, orientation, weight, 
			italic, underline, strike_out, charset,
			output_precision, clip_precision, quality,
			pitch_and_family: INTEGER; a_face_name: STRING) is
			-- Make font named `a_face_name'.
		require
			a_face_name_not_void: a_face_name /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_face_name)
			item := cwin_create_font (a_height, a_width, escapement,
				orientation, weight, italic, underline,
				strike_out, charset, output_precision,
				clip_precision, quality, pitch_and_family, a_wel_string.item)
			gdi_make
		end

	make_indirect (a_log_font: WEL_LOG_FONT) is
			-- Make a font using `a_log_font'.
		require
			a_log_font_not_void: a_log_font /= Void
		do
			item := cwin_create_font_indirect (a_log_font.item)
			gdi_make
		end

feature -- Setting

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'.
		require
			a_height_bigger_than_zero: a_height > 0
		local
			l: like log_font
			screen_dc: WEL_SCREEN_DC
		do
			create screen_dc
			screen_dc.get
			l := log_font
			l.set_height (-pixel_to_logical (screen_dc, a_height))
			screen_dc.release

			set_indirect (l)
		end

feature -- Re-initialisation

	set_indirect (a_log_font: WEL_LOG_FONT) is
			-- Reset the current font the 'a_log_font' without
			-- creating new object
		require
			a_log_font_not_void: a_log_font /= Void
		local
			object_destroyed: BOOLEAN
			a_default_pointer: POINTER
		do
				-- we delete the current C item
			debug ("GDI_COUNT")
				decrease_gdi_objects_count
			end
			object_destroyed := cwin_delete_object (item)
			check
				c_object_destroyed: object_destroyed
			end
			item := a_default_pointer

			check
				c_object_destroyed: not exists
			end

				-- Then we retrieve an new C item.
			item := cwin_create_font_indirect (a_log_font.item)
			debug ("GDI_COUNT")
				increase_gdi_objects_count
			end
		end

feature -- Access

	log_font: WEL_LOG_FONT is
			-- Log font structure associated to `Current'
		require
			exists
		do
			create Result.make_by_font (Current)
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		do
			Result := string_width ("x")
		end

	height: INTEGER is
			-- Size of font measured in pixels.
		local
			screen_dc: WEL_SCREEN_DC
		do
			check
				height_negative: log_font.height < 0
			end
			create screen_dc
			screen_dc.get
			Result := logical_to_pixel (screen_dc, -log_font.height)
			screen_dc.release
		ensure
			Result_bigger_than_zero: Result > 0
		end

	point: INTEGER is
			-- Size of font in points (1 point = 1/72 of an inch)
		local
			screen_dc: WEL_SCREEN_DC
		do
			check
				height_negative: log_font.height < 0
			end
			create screen_dc
			screen_dc.get
			Result := pixel_to_point (screen_dc, -log_font.height)
			screen_dc.release
		end

	string_width (a_string: STRING): INTEGER is
			-- Width of `a_string'.
		do
			Result := string_size (a_string).integer_item (1)
		end

	string_height (a_string: STRING): INTEGER is
			-- Height of `a_string'.
		do
			Result := string_size (a_string).integer_item (2)
		end

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER] is
			-- [width, height] of `a_string'.
		local
			cur_width, cur_height: INTEGER
			screen_dc: WEL_SCREEN_DC
			bounding_rect: WEL_RECT
		do
			if a_string.is_empty then
				cur_width := 0
				cur_height := 0
			else
				create bounding_rect.make (0, 0, 32767, 32767)
				create screen_dc
				screen_dc.get
				screen_dc.select_font (Current)

				screen_dc.draw_text (a_string, bounding_rect, Dt_calcrect | Dt_expandtabs | Dt_noprefix)
				cur_width := bounding_rect.width
				cur_height := bounding_rect.height

				screen_dc.unselect_font
				screen_dc.quick_release
			end

			Result := [cur_width, cur_height]
		end

feature {NONE} -- Implementation

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

	cwin_create_font (a_height, a_width, escapement, orientation, weight,
			italic, underline, strike_out,
			charset, output_precision, clip_precision,
			quality, pitch_and_family: INTEGER;
			face: POINTER): POINTER is
			-- SDK CreateFont
		external
			"C [macro <wel.h>] (int, int, int, int, int, DWORD, %
				%DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, %
				%DWORD, LPCSTR): EIF_POINTER"
		alias
			"CreateFont"
		end

	cwin_create_font_indirect (ptr: POINTER): POINTER is
			-- SDK CreateFontIndirect
		external
			"C [macro <wel.h>] (LOGFONT *): EIF_POINTER"
		alias
			"CreateFontIndirect"
		end

	mul_div (i,j,k: INTEGER): INTEGER is
			-- Does `i * j / k' but in a safe manner where the 64 bits integer
			-- obtained by `i * j' is not truncated.
		external
			"C [macro <windows.h>] (int, int, int): EIF_INTEGER"
		alias
			"MulDiv"
		end

	get_device_caps (p: POINTER; i: INTEGER): INTEGER is
			-- Retrieves device-specific information about a specified device.
		external
			"C [macro <windows.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

end -- class WEL_FONT

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

