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

	make (dll_name: STRING_GENERAL) is
			-- Load the DLL `dll_name'
		require
			dll_name_not_void: dll_name /= Void
			dll_name_not_empty: not dll_name.is_empty
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (dll_name)
			item := {WEL_API}.load_module (a_wel_string.item)
		end

	make_permanent (dll_name: STRING) is
			-- Load the DLL `dll_name' permanentely.
			-- It will be unloaded at the very end of the execution
			-- of current system.
		require
			dll_name_not_void: dll_name /= Void
			dll_name_not_empty: not dll_name.is_empty
		local
			a_string: C_STRING
		do
			create a_string.make (dll_name)
			item := cwin_permanent_load_library (a_string.item)
			is_loaded_at_all_time := True
		end

feature -- Access

	name: STRING_32 is
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

	loal_api (a_name: STRING): POINTER is
			-- Load api which name is `a_name' in current dll
		require
			exists: item /= default_pointer
			exists: a_name /= Void
		local
			l_c_string: C_STRING
		do
			create l_c_string.make (a_name)
			Result := {WEL_API}.loal_api (item, l_c_string.item)
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free the library.
		local
			a_default_pointer: POINTER
			l_result: BOOLEAN
		do
			if not is_loaded_at_all_time then
				l_result := {WEL_API}.free_module (item)
				check success: l_result = True end
			end
			item := a_default_pointer
		end

feature {NONE} -- Implementation

	Max_name_length: INTEGER is 255
			-- Maximum dll name length

feature {NONE} -- Externals

	cwin_permanent_load_library (dll_name: POINTER): POINTER is
			-- Wrapper around LoadLibrary which will automatically
			-- free the dll at the end of system execution.
		external
			"C [macro %"eif_misc.h%"] (char *): EIF_POINTER"
		alias
			"eif_load_dll"
		end

	cwin_get_module_file_name (hinstance, buffer: POINTER;
			length: INTEGER): INTEGER is
			-- SDK GetModuleFileName
		external
			"C [macro <wel.h>] (HINSTANCE, LPTSTR, int): EIF_INTEGER"
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

