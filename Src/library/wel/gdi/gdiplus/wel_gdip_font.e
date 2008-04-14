indexing
	description: "Font functions in GDI+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_FONT

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make,
	make_with_family_size_sytle_unit

feature{NONE} -- Initlization

	make (a_font_family: WEL_GDIP_FONT_FAMILY; a_em_size: REAL) is
			-- Creation method.
		require
			not_void: a_font_family /= Void
		do
			make_with_family_size_sytle_unit (a_font_family, a_em_size, {WEL_GDIP_FONT_STYLE}.fontstyleregular, {WEL_GDIP_UNIT}.unitpoint)
		end

	make_with_family_size_sytle_unit (a_font_family: WEL_GDIP_FONT_FAMILY; a_em_size: REAL; a_style: INTEGER; a_unit: INTEGER) is
			-- Create a font with `a_font_family', `a_em_size', `a_style' and `a_unit'.
		require
			not_void: a_font_family /= Void
			valid: (create {WEL_GDIP_FONT_STYLE}).is_valid (a_unit)
			valid: (create {WEL_GDIP_UNIT}).is_valid (a_unit)
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_font (gdi_plus_handle, a_font_family.item, a_em_size, a_style, a_unit, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Delete

	destroy_item is
			-- Redefine
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_delete_font (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_create_font (a_gdiplus_handle: POINTER; a_font_family: POINTER; a_em_size: REAL; a_style, a_unit: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			--	Create a Gdi+ font
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateFont = NULL;
				GpFont *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateFont) {
					GdipCreateFont = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateFont");
				}
				if (GdipCreateFont) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST GpFontFamily *, REAL, INT, Unit, GpFont **)) GdipCreateFont)
								((GDIPCONST GpFontFamily *) $a_font_family,
								(REAL) $a_em_size,
								(INT) $a_style,
								(Unit) $a_unit,
								(GpFont **) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_delete_font (a_gdiplus_handle: POINTER; a_gdiplus_font: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			--	Delete a Gdi+ font
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			exists: a_gdiplus_font /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeleteFont = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDeleteFont) {
					GdipDeleteFont = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeleteFont");
				}
				if (GdipDeleteFont) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpFont *)) GdipDeleteFont)
								((GpFont *) $a_gdiplus_font);
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
