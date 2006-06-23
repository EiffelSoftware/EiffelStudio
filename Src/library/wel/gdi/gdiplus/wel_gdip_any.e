indexing
	description: "This class is an ancestor of all GDI+ classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_ANY

feature -- Query

	is_gdi_plus_installed: BOOLEAN is
			-- If gdiplus.dll can be found on user's machine?
		local
			l_result: INTEGER
		do
			c_load_gdip_dll ($l_result)
			if l_result /= 0 then
				Result := True
			end
		end

feature {WEL_GDIP_ANY} -- Implementation

	item: POINTER
			-- Pointer to a GDI+ object.

feature -- Destroy

	delete is
			-- Free Current Gdi+ object memory.
		do
			c_gdip_free (item)
		end


feature {NONE} -- Externals

	c_load_gdip_dll (a_result: TYPED_POINTER [INTEGER]) is
			-- Try to loca gdiplus.dll, if found result is 1.
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

	c_gdip_free (a_gdip_object: POINTER) is
			-- Free `a_gdip_object' memory.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipFree = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				if (user32_module) {
					GdipFree = GetProcAddress (user32_module, "GdipFree");
					if (GdipFree) {
							(FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (void *)) GdipFree)
									((void *) $a_gdip_object);
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}				
			}
			]"
		end

invariant
	support: is_gdi_plus_installed

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
