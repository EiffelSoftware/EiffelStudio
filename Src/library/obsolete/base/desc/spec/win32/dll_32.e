indexing

	description:
		"DLL for Win32"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DLL_32

obsolete
	"This class should no longer be used due to platform dependence and non-64bit compliance"

inherit
	DISPOSABLE

	SHARED_LIBRARY

create
	make

feature {NONE} -- Initialization

	make (lib_name: STRING) is
			-- Load DLL `lib_name'
		local
			c_lib_name: ANY
		do
			library_name := lib_name
			c_lib_name := lib_name.to_c
			module_handle := win_load_library ($c_lib_name)
			if module_handle = default_pointer then
				error_code := No_library
			else
				error_code := No_error
			end
		end

feature -- Access

	library_name: STRING
			-- Name of shared library

feature -- Status report

	error_code: INTEGER
			-- Current status of the library

feature -- Removal

	free is
			-- Release the library
		require
			meaningful: meaningful
		do
			win_free_library (module_handle)
			module_handle := default_pointer
			error_code := Library_freed
		ensure
			not_meaningful: not meaningful
		end

feature {NONE} -- Removal

	dispose is
			-- Release the library at time of collection if not already done
		do
			if module_handle /= default_pointer then
				win_free_library (module_handle)
			end
		end

feature {DLL_32_ROUTINE} -- Implementation

	module_handle: POINTER
			-- Pointer to the external library

feature {NONE} -- Externals

	win_free_library (p: POINTER) is
			-- Free library
		external
			"C [macro <windows.h>] (HINSTANCE)"
		alias
			"FreeLibrary"
		end

	win_load_library (p: POINTER): POINTER is
			-- Load library
		external
			"C [macro <windows.h>] (LPCTSTR): EIF_POINTER"
		alias
			"LoadLibraryA"
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





end -- class DLL_32


