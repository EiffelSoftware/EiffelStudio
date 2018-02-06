note
	description: "[
		SQLite basic column types.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_TYPE

feature -- Access

	integer: INTEGER
			-- Integer column type.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTEGER"
		ensure
			is_class: class
		end

	float: INTEGER
			-- Float column type.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FLOAT"
		ensure
			is_class: class
		end

	text: INTEGER
			-- Text column type.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_TEXT"
		ensure
			is_class: class
		end

	blob: INTEGER
			-- Blob column type.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_BLOB"
		ensure
			is_class: class
		end

	null: INTEGER
			-- Null columm type.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NULL"
		ensure
			is_class: class
		end

feature -- Status

	is_valid_type (a_type: INTEGER): BOOLEAN
			-- Is `a_type' a valid SQLite type?
		do
			Result :=  a_type = integer
					or a_type = float
					or a_type = text
					or a_type = blob
					or a_type = null
		ensure
			is_class: class
		end

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
