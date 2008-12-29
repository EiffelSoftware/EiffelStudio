note
	description: "GpBrush used in GDI+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_BRUSH

inherit
	WEL_GDIP_ANY

create
	make_solid

feature{NONE} -- Initlization

	make_solid (a_color: WEL_GDIP_COLOR)
			-- Create a solid fill color
		require
			not_void: a_color /= Void
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_solid_fill (gdi_plus_handle, a_color.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature{NONE} -- C externals

	c_gdip_create_solid_fill (a_gdiplus_handle: POINTER; a_gdip_color: INTEGER_64; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a solid fill brush with `a_gdip_color'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateSolidFill = NULL;
				GpSolidFill *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateSolidFill) {
					GdipCreateSolidFill = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateSolidFill");
				}
				if (GdipCreateSolidFill) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (ARGB, GpSolidFill **)) GdipCreateSolidFill)
								((ARGB) $a_gdip_color,
								(GpSolidFill **) &l_result);
				}				
				return (EIF_POINTER) l_result;
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
