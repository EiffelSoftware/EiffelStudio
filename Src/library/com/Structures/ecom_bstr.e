indexing
	description: "Wrapper around BSTR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_BSTR

inherit
	ECOM_WRAPPER

create
	make

feature -- Access

	string: STRING is
			-- Convert to STRING
		local
			l_string: WEL_STRING
		do
			if item /= default_pointer then
				create l_string.share_from_pointer_and_count (item, count * Wide_character_bytes)
				Result := l_string.string
			end
		end

	count: INTEGER is
			-- Character count
		do
			Result := c_sys_string_len (item)
		end

feature {NONE} -- Implementation

	memory_free is
			-- Free BSTR
		do
			c_sys_free_string (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	c_sys_free_string (a_item: POINTER) is
			-- `SysFreeString' API
		external
			"C inline use <windows.h>"
		alias
			"SysFreeString((BSTR)$a_item)"
		end

	c_sys_string_len (a_item: POINTER): INTEGER is
			-- `SysStringLen' API
		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER)SysStringLen((BSTR)$a_item)"
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

end -- class ECOM_BSTR
