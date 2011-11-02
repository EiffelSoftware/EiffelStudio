note
	description: "GpTexture used in GDI+"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_TEXTURE_BRUSH

inherit
	WEL_GDIP_BRUSH

create
	make_with_image

feature {NONE} -- Initialization

	make_with_image (a_image: WEL_GDIP_IMAGE)
			-- Creation method
		require
			not_void: a_image /= Void
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_texture (gdi_plus_handle, a_image.item, 0, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- C externals

	c_gdip_create_texture (a_gdiplus_handle: POINTER; a_gdip_image: POINTER; a_wrap_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a texture fill brush with `a_gdip_image'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateTexture = NULL;
				GpTexture *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateTexture) {
					GdipCreateTexture = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateTexture");
				}
				if (GdipCreateTexture) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, GpWrapMode, GpTexture **)) GdipCreateTexture)
								((GpImage *) $a_gdip_image,
								(GpWrapMode) $a_wrap_mode,
								(GpTexture **) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
