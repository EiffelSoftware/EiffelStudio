indexing
	description: "code page of Unix console output"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_CODE_PAGE_IMP

inherit
	CONSOLE_CODE_PAGE_I
		redefine
			console_code_page
		end
		
feature -- Access

	console_code_page: STRING is
			-- Code page for console output
		do
			if is_utf8_activated then
				Result := "UTF-8"
			else
				Result := Precursor {CONSOLE_CODE_PAGE_I}
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
