indexing
	description: "Class which used for start/shutdown GDI+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDI_PLUS_STARTER

feature -- Command

	gdi_plus_init is
			-- Initialized Gdi+.
		once
			c_gdi_plus_startup
		end

	gdi_plus_shutdown is
			-- Shutdown Gdi+.
		once
			c_gdi_plus_shutdown
		end

feature -- Command

	is_gdi_plus_installed: BOOLEAN is
			-- If gdiplus.dll can be fount on user's machine?
		local
			l_result: INTEGER
		do
			c_load_gdip_dll ($l_result)
			if l_result /= 0 then
				Result := True
			end
		end

feature {NONE} -- Externals

	c_load_gdip_dll (a_result: TYPED_POINTER [INTEGER]) is
			-- Try to load gdiplus.dll, if fount return 1.
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				HMODULE user32_module = LoadLibrary (L"gdiplus.dll");
				if (user32_module) {
					*(EIF_INTEGER *)($a_result) = TRUE;
				}
			}
			]"
		end

	c_gdi_plus_startup is
			-- Before any GDI+ call, we should call this function.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				GdiplusStartupInput gdiplusStartupInput = {1, NULL, FALSE, FALSE};
		   		ULONG_PTR gdiplusToken;
			  	FARPROC GdiplusStartup = NULL;
				HMODULE user32_module = LoadLibrary (L"gdiplus.dll");
				
				if (user32_module) {
					GdiplusStartup = GetProcAddress (user32_module, "GdiplusStartup");
					if (GdiplusStartup) {
						(FUNCTION_CAST_TYPE(GpStatus, WINAPI, (ULONG_PTR *, const GdiplusStartupInput *,  GdiplusStartupOutput *)) GdiplusStartup)					
									(&gdiplusToken, &gdiplusStartupInput, NULL);
					}
				}			  
   			}
   			]"
   		end

	c_gdi_plus_shutdown is
			-- After delete all Gdi+ objects, we should call this function.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				ULONG_PTR gdiplusToken;
			  	FARPROC GdiplusShutdown = NULL;
				HMODULE user32_module = LoadLibrary (L"gdiplus.dll");
				if (user32_module) {
					GdiplusShutdown = GetProcAddress (user32_module, "GdiplusShutdown");
					if (GdiplusShutdown) {
						(FUNCTION_CAST_TYPE(void, WINAPI, (ULONG_PTR)) gdiplusToken)					
									((ULONG_PTR) gdiplusToken);
					}
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
