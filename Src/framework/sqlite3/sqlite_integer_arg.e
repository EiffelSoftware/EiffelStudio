note
	description: "[
		An integer binding argument value for use with executing a SQLite statement.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_INTEGER_ARG

inherit
	SQLITE_BIND_ARG [INTEGER_64]

create
	make

feature {SQLITE_STATEMENT} -- Basic operations

	bind_to_statement (a_statement: SQLITE_STATEMENT; a_index: INTEGER)
			-- <Precursor>
		local
			l_result: INTEGER
		do
			if value <= {INTEGER_32}.max_value.to_integer_64 then
				l_result := c_sqlite3_bind_int (sqlite_api.api_pointer (sqlite3_bind_int_api), a_statement.internal_stmt, a_index, value.as_integer_32)
			else
				l_result := c_sqlite3_bind_int64 (sqlite_api.api_pointer (sqlite3_bind_int_api), a_statement.internal_stmt, a_index, value)
			end
			sqlite_raise_on_failure (l_result)
		end

feature {NONE} -- Implemention: Internal cache

	internal_value: INTEGER_64
			-- Cached version of `value'.

feature {NONE} -- Externals

	c_sqlite3_bind_int (a_fptr: POINTER; a_stmt: POINTER; a_index: INTEGER; a_value: INTEGER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_index_positive: a_index > 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_stmt *, int, int)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt, (int)$a_index, (int)$a_value);
			]"
		end

	c_sqlite3_bind_int64 (a_fptr: POINTER; a_stmt: POINTER; a_index: INTEGER; a_value: INTEGER_64): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_index_positive: a_index > 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_stmt *, int, sqlite_int64)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt, (int)$a_index, (sqlite_int64)$a_value);
			]"
		end

feature {NONE} -- Constants

	sqlite3_bind_int_api: STRING = "sqlite3_bind_int"
	sqlite3_bind_int64_api: STRING = "sqlite3_bind_int64"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
