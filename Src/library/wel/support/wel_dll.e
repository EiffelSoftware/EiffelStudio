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
			dll_name_not_empty: not dll_name.is_empty
		local
			a_wel_string: WEL_STRING
		do
			!! a_wel_string.make (dll_name)
			item := cwin_load_library (a_wel_string.item)
		end

feature -- Access

	name: STRING is
			-- DLL name (including the path)
		require
			exists: exists
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			!! Result.make (Max_name_length + 1)
			Result.fill_blank
			!! a_wel_string.make (Result)
			nb := cwin_get_module_file_name (item, a_wel_string.item,
				Max_name_length + 1)
			Result := a_wel_string.string
			Result.head (nb)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

