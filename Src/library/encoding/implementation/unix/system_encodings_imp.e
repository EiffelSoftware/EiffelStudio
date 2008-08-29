indexing
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

	system_code_page: STRING is
			-- <Precursor>
			-- Name of character set.
		local
			l_p: POINTER
		do
			l_p := c_current_codeset
			Result := pointer_to_multi_byte (l_p, c_strlen (l_p))
		end

	console_code_page: STRING is
			-- Console code page
		do
			if is_utf8_activated then
				Result := "UTF-8"
			else
				Result := system_code_page
			end
		end

feature {NONE} -- Implementation

	is_utf8_activated: BOOLEAN is
			-- Is UTF-8 activated in current system?
		external
			"C inline use <langinfo.h>, <locale.h>"
		alias
			"[
				setlocale (LC_ALL, "");
				return (EIF_BOOLEAN)(strcmp (nl_langinfo (CODESET), "UTF-8") == 0);
			]"
		end

	c_current_codeset: POINTER is
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

	c_strlen (ptr: POINTER): INTEGER is
				-- length of a c string
		external
			"C (void *): EIF_INTEGER| %"string.h%""
		alias
			"strlen"
		end

indexing
	library:   "Encoding: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end
