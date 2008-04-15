indexing
	description: "[
					Helper functions of file name.
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FILE_NAME_HELPER

feature -- Access

	short_path_name (a_file_name: !STRING): STRING_GENERAL is
			-- Short path name of `a_file_name'
			-- File/directory must exists before convert to short name
		local
			l_ptr: POINTER
			l_wel_string: WEL_STRING
			l_api_return_value: NATURAL_32
		do
			l_ptr := api_pointer
			if l_ptr /= default_pointer then
				create l_wel_string.make (a_file_name)

				-- This API's input and output string buffer can be same pointer
				l_api_return_value := c_win_get_short_path_name (l_ptr, l_wel_string.item, l_wel_string.item, l_wel_string.count.as_natural_32);
				if l_api_return_value /= 0 then
					Result := l_wel_string.string
				else
					-- Error
					Result := Void
				end
			end
		end

feature {NONE} -- Implementation

	module_pointer: POINTER is
			-- Module pointer
		local
			l_api: WEL_API
		once
			create l_api
			Result := l_api.load_module ("kernel32")
		end

	api_pointer: POINTER is
			-- "GetShortPathNameW" api pointer
			-- Result maybe not initialized if api not found
		local
			l_api: WEL_API
		once
			create l_api
			Result := l_api.loal_api (module_pointer, "GetShortPathNameW")
		end

	c_win_get_short_path_name (a_api: POINTER; a_long_path: POINTER; a_short_path: POINTER; a_string_length: NATURAL_32): NATURAL_32 is
			-- Result 0 means failed.
			-- Result value is the length of the string that is copied, not including the terminating null character.
		external
			"C inline use <windows.h>"
		alias
			"[
				EIF_NATURAL_32 l_result;
				
				l_result = (FUNCTION_CAST(DWORD, (LPCTSTR, LPTSTR, DWORD)) $a_api)((LPCTSTR) $a_long_path,
																		(LPTSTR) $a_short_path,
																		(DWORD) $a_string_length);		
				return l_result;
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
