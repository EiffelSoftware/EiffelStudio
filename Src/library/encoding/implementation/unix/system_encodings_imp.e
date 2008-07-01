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
			-- System code page
			-- Take oem as default
		do
			-- Not implemented.
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
