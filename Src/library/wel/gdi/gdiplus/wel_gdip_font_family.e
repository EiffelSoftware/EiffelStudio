indexing
	description: "Font family used by Gdi+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_FONT_FAMILY

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make_with_name,
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_get_generic_font_family_sans_serif (gdi_plus_handle, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_with_name (a_font_name: STRING_GENERAL) is
			-- Creation method
		local
			l_wel_string: WEL_STRING
			l_result: INTEGER
		do
			default_create
			create l_wel_string.make (a_font_name)

			item := c_gdip_create_font_family_from_name (gdi_plus_handle, l_wel_string.item, default_pointer, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Query

	height (a_style: INTEGER): INTEGER is
			-- Height
		require
			vaild: (create {WEL_GDIP_FONT_STYLE}).is_valid (a_style)
		local
			l_result: INTEGER
		do
			Result := c_gdip_get_em_height (gdi_plus_handle, item, a_style, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Delete

	destroy_item is
			-- Redefine
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_delete_font_family (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_create_font_family_from_name (a_gdiplus_handle: POINTER; a_name: POINTER; a_font_collection: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Create font family from `a_name' which in `a_font_collection'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_name_exist: a_name /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateFontFamilyFromName = NULL;
				GpFontFamily *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateFontFamilyFromName) {
					GdipCreateFontFamilyFromName = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateFontFamilyFromName");
				}
				if (GdipCreateFontFamilyFromName) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST WCHAR *, GpFontCollection *, GpFontFamily **)) GdipCreateFontFamilyFromName)
								((GDIPCONST WCHAR *) $a_name,
								(GpFontCollection *) $a_font_collection,
								(GpFontFamily **) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_generic_font_family_sans_serif (a_gdiplus_handle: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Get generic font family sans serif
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetGenericFontFamilySansSerif = NULL;
				GpFontFamily *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetGenericFontFamilySansSerif) {
					GdipGetGenericFontFamilySansSerif = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetGenericFontFamilySansSerif");
				}
				if (GdipGetGenericFontFamilySansSerif) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpFontFamily **)) GdipGetGenericFontFamilySansSerif)
								((GpFontFamily **) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_em_height (a_gdiplus_handle: POINTER; a_font_family: POINTER; a_style: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): INTEGER is
			-- Get height of `a_font_family' which style is `a_style'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetEmHeight = NULL;
				EIF_INTEGER l_result = 0;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGetEmHeight) {
					GdipGetEmHeight = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetEmHeight");
				}
				if (GdipGetEmHeight) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST GpFontFamily *, INT, UINT16 *)) GdipGetEmHeight)
								((GpFontFamily *) $a_font_family,
								(INT) $a_style,
								(UINT16 *) &l_result);
				}
				return (EIF_INTEGER) l_result;
			}
			]"
		end

	c_gdip_delete_font_family (a_gdiplus_handle: POINTER; a_font_family: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Dispose `a_font_family'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_iamge_not_null: a_font_family /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeleteFontFamily = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDeleteFontFamily) {
					GdipDeleteFontFamily = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeleteFontFamily");
				}			
				if (GdipDeleteFontFamily) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpFontFamily *)) GdipDeleteFontFamily)
								((GpFontFamily *) $a_font_family);
				}
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
