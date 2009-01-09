note
	description: "System encodings, Unix implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ENCODINGS_IMP

inherit
	SYSTEM_ENCODINGS_I

	ENCODING_HELPER

feature -- Access

	system_code_page: STRING
			-- <Precursor>
			-- Name of character set.
		local
			l_p: POINTER
		do
			l_p := c_current_codeset
			Result := pointer_to_multi_byte (l_p, c_strlen (l_p))
		end

	console_code_page: STRING
			-- Console code page
		do
			if is_utf8_activated then
				Result := "UTF-8"
			else
				Result := system_code_page
			end
		end

feature {NONE} -- Implementation

	is_utf8_activated: BOOLEAN
			-- Is UTF-8 activated in current system?
		external
			"C inline use <langinfo.h>, <locale.h>"
		alias
			"[
				setlocale (LC_ALL, "");
				return (EIF_BOOLEAN)(strcmp (nl_langinfo (CODESET), "UTF-8") == 0);
			]"
		end

	c_current_codeset: POINTER
			-- Current codeset name.
		external
			"C inline use <eif_langinfo.h>"
		alias
			"[
				#if EIF_OS == EIF_OS_OPENBSD
					return locale_charset ();
				#else
					return nl_langinfo (CODESET);
				#endif
			]"
		end

	c_strlen (ptr: POINTER): INTEGER
				-- length of a c string
		external
			"C (void *): EIF_INTEGER| %"string.h%""
		alias
			"strlen"
		end

note
	library:   "Encoding: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end
