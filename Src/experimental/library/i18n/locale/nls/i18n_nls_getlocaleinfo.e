note
	description: "Wrapper for extracting locale information from the NLS get_localeinfo function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_GETLOCALEINFO

inherit
	SHARED_I18N_NLS_LC_CTYPE_CONSTANTS

feature {NONE} -- Interface

	extract_locale_integer (lcid: INTEGER; lc_ctype: INTEGER): INTEGER_32
			-- Extract number locale information of `lcid' of `lc_ctype'.
		local
			l_result: INTEGER
			l_ctype: INTEGER
		do
			if is_overriding_current_user_setting then
				l_ctype := lc_ctype | locale_return_number | locale_no_user_override
			else
				l_ctype := lc_ctype | locale_return_number
			end
			l_result := c_get_locale_info (lcid, l_ctype, $Result, {PLATFORM}.integer_32_bytes // 2)
			check l_result /= 0 end
		end

	extract_locale_string (lcid: INTEGER; lc_ctype: INTEGER): STRING_32
			-- Extract locale information of `lcid' of `lc_ctype'.
		local
			c: MANAGED_POINTER
			bufferlen: INTEGER
			l_ctype: INTEGER
			utf: UTF_CONVERTER
		do
			if is_overriding_current_user_setting then
				l_ctype := lc_ctype | locale_no_user_override
			else
				l_ctype := lc_ctype
			end
			c := c_ptr
			bufferlen := c_get_locale_info (lcid, l_ctype, default_pointer, 0)
			if bufferlen /= 0 then
				if bufferlen * 2 > c.count then
					c.resize (bufferlen * 2)
				end
				bufferlen := c_get_locale_info (lcid, l_ctype | locale_no_user_override, c.item, bufferlen)
			end
			if bufferlen = 0 then
					-- An error occurred, return an empty string.
				check False end
				create Result.make_empty
			else
				Result := utf.utf_16_0_pointer_to_string_32 (c)
			end
		end

feature {NONE} -- Access

	is_overriding_current_user_setting: BOOLEAN
			-- Are we going to use the current user setting to query the OS for the locale information?
			--| By default it is always False from the outside world, but internally we change it to True
			--| to query other locale. It cannot be made an invariant because of agent callbacks.

feature {NONE} -- C helper

	c_get_locale_info (lcid, lc_ctype: INTEGER; p: POINTER; p_size: INTEGER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"return GetLocaleInfo((LCID) $lcid, (LCTYPE) $lc_ctype, (LPTSTR) $p, (DWORD) $p_size);"
		end

	c_ptr: MANAGED_POINTER
			-- Buffer for `GetLocaleInfo'
		once
			create Result.make (10)
		ensure
			at_least_2: Result.count >= 2
			multiple_of_two: Result.count \\ 2 = 0
		end

	locale_return_number: INTEGER
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_RETURN_NUMBER;"
		end

	locale_no_user_override: INTEGER
		external
			"C inline use <windows.h>"
		alias
			"return LOCALE_NOUSEROVERRIDE;"
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
