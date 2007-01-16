indexing
	description: "GpStringFormat used in GDI+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	WEL_GDIP_STRING_FORMAT

inherit
	WEL_GDIP_ANY

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_string_format_get_generic_default (gdi_plus_handle, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature{NONE} -- C externals

	c_gdip_string_format_get_generic_default (a_gdiplus_handle: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Get default
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipStringFormatGetGenericDefault = NULL;
				GpStringFormat *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipStringFormatGetGenericDefault) {
					GdipStringFormatGetGenericDefault = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipStringFormatGetGenericDefault");
				}
				if (GdipStringFormatGetGenericDefault) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpStringFormat  **)) GdipStringFormatGetGenericDefault)
								((GpStringFormat  **) &l_result);
				}
				return (EIF_POINTER) l_result;
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
