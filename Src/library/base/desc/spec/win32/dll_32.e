indexing

	description:
		"DLL for Win32";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DLL_32

inherit
	SHARED_LIBRARY

	MEMORY
		rename
			free as memory_free
		export
			{NONE} all
		redefine
			dispose
		end

creation
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
			"C [macro %"windows.h%"] (HINSTANCE)"
		alias
			"FreeLibrary"
		end

	win_load_library (p: POINTER): POINTER is
			-- Load library
		external
			"C [macro %"windows.h%"] (LPCTSTR): EIF_POINTER"
		alias
			"LoadLibrary"
		end

end -- class DLL_32

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995
--| Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
