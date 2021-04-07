note
	description: "GpStringFormat used in GDI+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_STRING_FORMAT

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_string_format_get_generic_default (gdi_plus_handle, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Status Change

	set_alignment (a_value : INTEGER)
			-- StringAlignmentNear     = 0
			-- StringAlignmentCenter   = 1
			-- StringAlignmentFar      = 2
		local
			l_result: INTEGER
		do
			l_result := c_gdip_set_string_format_align (gdi_plus_handle, item, a_value)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_line_alignment (a_value : INTEGER)
			-- StringAlignmentNear     = 0
			-- StringAlignmentCenter   = 1
			-- StringAlignmentFar      = 2
		local
			l_result: INTEGER
		do
			l_result := c_gdip_set_string_format_line_align (gdi_plus_handle, item, a_value)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destroy

	destroy_item
			-- Free Current Gdi+ object memory.
		local
			l_null: POINTER
			l_result: INTEGER
		do
			check
				item_valid: item /= l_null implies gdi_plus_handle /= l_null
			end
			if gdi_plus_handle /= l_null then
				l_result := c_gdip_delete_string_format (gdi_plus_handle, item)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_set_string_format_align (a_gdiplus_handle, a_format: POINTER; a_value: INTEGER): INTEGER
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetStringFormatAlign= NULL;
				EIF_INTEGER Result = 1;
				
				if (!GdipSetStringFormatAlign) {
					GdipSetStringFormatAlign = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetStringFormatAlign");
				}
				if (GdipSetStringFormatAlign) {
					Result = (EIF_INTEGER) (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpStringFormat  *, INT)) GdipSetStringFormatAlign)
								((GpStringFormat  *) $a_format, (INT) $a_value);
				}
				return Result;
			}
			]"
		end

	c_gdip_set_string_format_line_align (a_gdiplus_handle, a_format: POINTER; a_value: INTEGER): INTEGER
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetStringFormatLineAlign= NULL;
				EIF_INTEGER Result = 1;
				
				if (!GdipSetStringFormatLineAlign) {
					GdipSetStringFormatLineAlign = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetStringFormatLineAlign");
				}
				if (GdipSetStringFormatLineAlign) {
					Result = (EIF_INTEGER) (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpStringFormat  *, INT)) GdipSetStringFormatLineAlign)
								((GpStringFormat  *) $a_format, (INT) $a_value);
				}
				return Result;
			}
			]"
		end

	c_gdip_string_format_get_generic_default (a_gdiplus_handle: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
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

	c_gdip_delete_string_format (a_gdiplus_handle, a_format: POINTER): INTEGER
			-- Get default
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeleteStringFormat = NULL;
				EIF_INTEGER Result = 1;
				
				if (!GdipDeleteStringFormat) {
					GdipDeleteStringFormat = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeleteStringFormat");
				}
				if (GdipDeleteStringFormat) {
					Result = (EIF_INTEGER) (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpStringFormat  *)) GdipDeleteStringFormat)
								((GpStringFormat  *) $a_format);
				}
				return Result;
			}
			]"
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
