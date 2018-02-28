note
	description: "BSTR string for COM Interop"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BSTR_STRING

inherit
	COM_BSTR_STRING
		rename
			string as full_string
		end

create
	make_from_string,
	make_by_wel_string,
	make_by_uni_string,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_uni_string (astring: UNI_STRING)
			-- creates new instance from a unistring
		require
			non_void_string: astring /= Void
		do
			item := c_get_bstr (astring.item)
		ensure
			string_created: item /= default_pointer
		end

feature -- Basic Operations

	string: STRING_8
			-- Return content of Current stopping at the first NULL character
			-- truncated to STRING_8.
		obsolete
			"Use `string_32' instead."
		require
			exists: exists
		do
			Result := uni_string.string
		end

	string_32: STRING_32
			-- Return content of Current stopping at the first NULL character.
		require
			exists: exists
		do
			Result := uni_string.string_32
		end

	uni_string: UNI_STRING
			-- returns a UNI_STRING
		require
			exists: exists
		do
			create Result.make_by_pointer (item)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
