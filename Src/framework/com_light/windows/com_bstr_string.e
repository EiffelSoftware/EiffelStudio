note
	description: "BSTR string for COM Interop"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_BSTR_STRING

inherit
	DISPOSABLE

create
	make_from_string,
	make_by_wel_string,
	make_by_pointer

feature {NONE} -- Initialization

	make_from_string (a_string: READABLE_STRING_GENERAL)
			-- Creates a new isntance of COM_BSTR_STRING from `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			l_str: WEL_STRING
		do
			create l_str.make (a_string)
			item := c_get_bstr (l_str.item)
		end

	make_by_wel_string (a_string: WEL_STRING)
			-- Creates a new instance from a WEL_STRING
		require
			a_string_not_void: a_string /= Void
		do
			item := c_get_bstr (a_string.item)
		end

	make_by_pointer (p: POINTER)
			-- create a BSTR from a pointer
		require
			non_void_pointer: p /= default_pointer
		do
			item := p
		end

feature -- Access

	item: POINTER
		-- pointer to the BSTR string

	bytes_count: INTEGER
			-- Length in bytes of Current.
		require
			exists: exists
		do
			Result := c_bytes_length (item)
		end

feature -- Basic Operations

	string: READABLE_STRING_32
			-- Return all characters (even null characters).
		require
			exists: exists
		do
			Result := (create {WEL_STRING}.make_by_pointer_and_count (
				item, bytes_count)).substring (1, bytes_count // character_size)
		ensure
			valid_count: Result.count = (bytes_count // character_size)
		end

	wel_string: WEL_STRING
			-- returns a WEL_STRING
		require
			exists: exists
		do
			create Result.make_by_pointer (item)
		end

feature -- Status Report

	exists: BOOLEAN
			-- Does current exist?
		do
			Result := item /= default_pointer
		end

feature -- Destruction

	dispose
			-- free up used resources
		do
			c_free_bstr (item)
		end

feature {NONE} -- Implementation

	c_get_bstr (astring: POINTER): POINTER
			-- returns a BSTR from a UNI_STRING
		external
			"C signature (LPWSTR): EIF_POINTER use %"OleAuto.h%""
		alias
			"SysAllocString"
		ensure
			is_class: class
		end

	c_bytes_length (astring: POINTER): INTEGER
			-- Length of BSTR `astring'.
		external
			"C signature (BSTR): EIF_INTEGER use %"OleAuto.h%""
		alias
			"SysStringByteLen"
		ensure
			is_class: class
		end

	c_free_bstr (abstr: POINTER)
			-- frees a BSTR
		external
			"C signature (BSTR) use %"OleAuto.h%""
		alias
			"SysFreeString"
		ensure
			is_class: class
		end

	frozen character_size: INTEGER
			-- Number of bytes occupied by a TCHAR.
		external
			"C macro use <tchar.h>"
		alias
			"sizeof(OLECHAR)"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
