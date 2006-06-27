indexing
	description: "This class is an ancestor of all GDI+ classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_ANY

inherit
	WEL_ANY
		redefine
			destroy_item
		end

feature {NONE} -- Initialization

	initialize_gdi_plus is
			-- Properly initialize Current.
		do
			gdi_plus_handle := gdi_plus_starter.gdi_plus_handle
		end

feature -- Access

	gdi_plus_handle: POINTER
			-- Handle to gdiplus.dll if present.	

feature -- Query

	is_gdi_plus_installed: BOOLEAN is
			-- If gdiplus.dll can be found on user's machine?
		do
			Result := gdi_plus_starter.is_gdi_plus_installed
		end

feature -- Destroy

	destroy_item is
			-- Free Current Gdi+ object memory.
		local
			l_null: POINTER
		do
			check
				item_valid: item /= l_null implies gdi_plus_handle /= l_null
			end
			if gdi_plus_handle /= l_null then
				c_gdip_free (gdi_plus_handle, item)
			end
		end

feature {NONE} -- Externals

	c_gdip_free (a_gdiplus_handle, a_gdip_object: POINTER) is
			-- Free `a_gdip_object' memory.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_gdip_object_not_null: a_gdip_object /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipFree = NULL;
				if (!GdipFree) {
					HMODULE user32_module = (HMODULE) $a_gdiplus_handle;
					GdipFree = GetProcAddress (user32_module, "GdipFree");
				}
				if (GdipFree) {
					(FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (void *)) GdipFree) ((void *) $a_gdip_object);
				}
			}
			]"
		end

feature {WEL_GDIP_ANY} -- Convenience

	gdi_plus_starter: WEL_GDI_PLUS_STARTER is
			-- Control loading of GDI+.
		once
			create Result
		ensure
			gdiplus_starter_not_void: Result /= Void
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
