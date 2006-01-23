indexing
	description: "Dynamic-link library containing one or more functions %
		%that are compiled, linked, and stored separately from the %
		%processes using them."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DLL

inherit
	WEL_ANY

create
	make, make_permanent

feature {NONE} -- Initialization

	make (dll_name: STRING) is
			-- Load the DLL `dll_name'
		require
			dll_name_not_void: dll_name /= Void
			dll_name_not_empty: not dll_name.is_empty
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (dll_name)
			item := cwin_load_library (a_wel_string.item)
		end

	make_permanent (dll_name: STRING) is
			-- Load the DLL `dll_name' permanentely.
			-- It will be unloaded at the very end of the execution
			-- of current system.
		require
			dll_name_not_void: dll_name /= Void
			dll_name_not_empty: not dll_name.is_empty
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (dll_name)
			item := cwin_permanent_load_library (a_wel_string.item)
			is_loaded_at_all_time := True
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
			create a_wel_string.make_empty (max_name_length + 1)
			nb := cwin_get_module_file_name (item, a_wel_string.item,
				Max_name_length + 1)
			Result := a_wel_string.substring (1, nb)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	is_loaded_at_all_time: BOOLEAN
			-- Is current dll to be loaded at all time?

feature {NONE} -- Removal

	destroy_item is
			-- Free the library.
		local
			a_default_pointer: POINTER
		do
			if not is_loaded_at_all_time then
				cwin_free_library (item)
			end
			item := a_default_pointer
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

	cwin_permanent_load_library (dll_name: POINTER): POINTER is
			-- Wrapper around LoadLibrary which will automatically
			-- free the dll at the end of system execution.
		external
			"C [macro %"eif_misc.h%"] (char *): EIF_POINTER"
		alias
			"eif_load_dll"
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




end -- class WEL_DLL

