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
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_pen_l (gdi_plus_handle, a_color.item, a_width, {WEL_GDIP_UNIT}.unitpixel, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- Destroy

	destroy_item
			-- Redefine
		local
			l_result: INTEGER
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

note
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
