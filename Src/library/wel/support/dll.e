indexing
	description: "Dynamic-link library containing one or more functions %
		%that are compiled, linked, and stored separately from the %
		%processes using them."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DLL

inherit
	WEL_ANY

creation
	make

feature {NONE} -- Initialization

	make (dll_name: STRING) is
			-- Load the DLL `dll_name'
		require
			dll_name_not_void: dll_name /= Void
			dll_name_not_empty: not dll_name.empty
		local
			a: ANY
		do
			a := dll_name.to_c
			item := cwin_load_library ($a)
		end

feature -- Access

	name: STRING is
			-- DLL name (including the path)
		require
			exists: exists
		local
			a: ANY
		do
			!! Result.make (Max_name_length + 1)
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_module_file_name (item, $a,
				Max_name_length + 1))
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.empty
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free the library.
		do
			cwin_free_library (item)
			item := default_pointer
		end

feature {NONE} -- Implementation

	Max_name_length: INTEGER is 255
			-- Maximum dll name length

feature {NONE} -- Externals

	cwin_load_library (dll_name: POINTER): POINTER is
			-- SDK LoadLibrary
		external
			"C [macro <wel.h>] (LPCSTR): EIF_POINTER"
		alias
			"LoadLibrary"
		end

	cwin_free_library (a_item: POINTER) is
			-- SDK FreeLibrary
		external
			"C [macro <wel.h>] (HINSTANCE)"
		alias
			"FreeLibrary"
		end

	cwin_get_module_file_name (hinstance, buffer: POINTER;
			length: INTEGER): INTEGER is
			-- SDK GetModuleFileName
		external
			"C [macro <wel.h>] (HINSTANCE, LPSTR, %
				%int): EIF_INTEGER"
		alias
			"GetModuleFileName"
		end

end -- class WEL_DLL

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
