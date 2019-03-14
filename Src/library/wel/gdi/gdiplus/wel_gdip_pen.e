note
	description: "Gdi+ pen's functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_PEN

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_color: WEL_GDIP_COLOR; a_width: REAL)
			-- Creation method
		require
			a_color_not_void: a_color /= Void
		local
			l_result: INTEGER_32
		do
			default_create
			item := c_gdip_create_pen_l (gdi_plus_handle, a_color.item, a_width, {WEL_GDIP_UNIT}.unitpixel, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Modification

	set_dash_style (style: INTEGER_32)
			-- Set dash style to the given value `style`.
			-- See: `{WEL_GDIP_DASH_STYLE}`.
		require
			is_style_valid: {WEL_GDIP_DASH_STYLE}.is_valid (style)
		local
			r: INTEGER_32
		do
			c_gdip_set_dash_style (gdi_plus_handle, item, style, $r)
		end

	set_line_join (join: INTEGER_32)
			-- Set line join to the given value `join`.
			-- See: `{WEL_GDIP_LINE_JOIN}`.
		require
			is_style_valid: {WEL_GDIP_LINE_JOIN}.is_valid (join)
		local
			r: INTEGER_32
		do
			c_gdip_set_line_join (gdi_plus_handle, item, join, $r)
		end

feature {NONE} -- Destroy

	destroy_item
			-- Redefine
		local
			l_result: INTEGER_32
		do
			if item /= default_pointer then
				c_gdip_delete_pen (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_create_pen_l (a_gdiplus_handle: POINTER; a_argb: INTEGER_64; a_width: REAL; a_unit: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create Current
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_width_valid: a_width > 0
			a_unit_valid: (create {WEL_GDIP_UNIT}).is_valid (a_unit)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreatePen1 = NULL;
				GpPen *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreatePen1) {
					GdipCreatePen1 = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreatePen1");				
				}									
				
				if (GdipCreatePen1) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (ARGB, REAL, GpUnit, GpPen **)) GdipCreatePen1)
								((ARGB) $a_argb,
								(REAL) $a_width,
								(GpUnit) $a_unit,
								(GpPen **) &l_result);
				}				
				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_delete_pen (a_gdiplus_handle: POINTER; a_pen: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Delete Gdi+ object `a_pen'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_pen_not_null: a_pen /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeletePen = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDeletePen) {
					GdipDeletePen = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeletePen");				
				}							
				if (GdipDeletePen) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPen *)) GdipDeletePen)
								((GpPen *) $a_pen);
				}				
			}
			]"
		end

	c_gdip_set_dash_style (handle: POINTER; pen: POINTER; style: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Sets the dash style of the pen `pen` accessible using a GDI+ handle `handle` to `style` and record return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			pen_not_null: pen /= default_pointer
			style_valid: {WEL_GDIP_DASH_STYLE}.is_valid (style)
		external
			"[
				C++ inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipSetPenDashStyle = NULL;
				*(EIF_INTEGER *) $status = 1;

				if (!GdipSetPenDashStyle) {
					GdipSetPenDashStyle = GetProcAddress ((HMODULE) $handle, "GdipSetPenDashStyle");
				}
				if (GdipSetPenDashStyle) {
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPen *, INT)) GdipSetPenDashStyle)
								((GpPen *) $pen,
								(INT) $style);
				}
			}
			]"
		end

	c_gdip_set_line_join (handle: POINTER; pen: POINTER; join: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Sets the line join of the pen `pen` accessible using a GDI+ handle `handle` to `join` and record return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			pen_not_null: pen /= default_pointer
			style_valid: {WEL_GDIP_LINE_JOIN}.is_valid (join)
		external
			"[
				C inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipSetPenLineJoin = NULL;
				*(EIF_INTEGER *) $status = 1;

				if (!GdipSetPenLineJoin) {
					GdipSetPenLineJoin = GetProcAddress ((HMODULE) $handle, "GdipSetPenLineJoin");
				}
				if (GdipSetPenLineJoin) {
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPen *, INT)) GdipSetPenLineJoin)
								((GpPen *) $pen,
								(INT) $join);
				}
			}
			]"
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
