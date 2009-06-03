note
	description: "Class which used for start/shutdown GDI+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_STARTER

feature -- Command

	gdi_plus_init
			-- Initialize Gdi+.
		local
			l_token: POINTER
		once
			if is_gdi_plus_installed then
				l_token := gdi_plus_token
			end
		end

	gdi_plus_shutdown
			-- Shutdown Gdi+.
		once
			if is_gdi_plus_installed then
				c_gdi_plus_shutdown (gdi_plus_handle, gdi_plus_token)
			end
		end

	gdi_plus_handle: POINTER
			-- Handle for `gdiplus.dll' if present.
		once
			Result := c_load_gdip_dll
		end

	gdi_plus_token: POINTER
			-- Token for GDI+ startup.
		once
			if is_gdi_plus_installed then
				Result := c_gdi_plus_startup (gdi_plus_handle)
			end
		end

feature -- Command

	is_gdi_plus_installed: BOOLEAN
			-- If gdiplus.dll can be fount on user's machine?
		do
			Result := gdi_plus_handle /= default_pointer
		end

feature {NONE} -- Externals

	c_load_gdip_dll: POINTER
			-- Try to load gdiplus.dll, if fount return 1.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) LoadLibrary (L%"gdiplus.dll%");"
		end

	c_gdi_plus_startup (a_gdiplus_handle: POINTER): POINTER
			-- Before any GDI+ call, we should call this function.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				GdiplusStartupInput gdiplusStartupInput = {1, NULL, FALSE, FALSE};
		   		ULONG_PTR gdiplusToken;
			  	FARPROC GdiplusStartup = NULL;
				HMODULE user32_module = (HMODULE) $a_gdiplus_handle;
				
				GdiplusStartup = GetProcAddress (user32_module, "GdiplusStartup");
				if (GdiplusStartup) {
					(FUNCTION_CAST_TYPE(GpStatus, WINAPI, (ULONG_PTR *, const GdiplusStartupInput *,  GdiplusStartupOutput *)) GdiplusStartup)					
								(&gdiplusToken, &gdiplusStartupInput, NULL);
				}
				return (EIF_POINTER) gdiplusToken;
   			}
   			]"
   		end

	c_gdi_plus_shutdown (a_gdiplus_handle, a_token: POINTER)
			-- After delete all Gdi+ objects, we should call this function.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
			  	FARPROC GdiplusShutdown = NULL;
				HMODULE user32_module = (HMODULE) $a_gdiplus_handle;
				GdiplusShutdown = GetProcAddress (user32_module, "GdiplusShutdown");
				if (GdiplusShutdown) {
					(FUNCTION_CAST_TYPE(void, WINAPI, (ULONG_PTR)) GdiplusShutdown) ((ULONG_PTR) $a_token);
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
