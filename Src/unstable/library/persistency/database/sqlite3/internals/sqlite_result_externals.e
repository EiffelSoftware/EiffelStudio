note
	description: "[
		Externals for interacting with SQLite statement (sqlite3_stmt *) results.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_RESULT_EXTERNALS

feature {NONE} -- Query

	sqlite3_column_blob (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_blob (a_stmt, a_column)
		end

	sqlite3_column_bytes (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_bytes (a_stmt, a_column)
		end

	sqlite3_column_bytes16 (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_bytes16 (a_stmt, a_column)
		end

	sqlite3_column_double (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): REAL_64
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_double (a_stmt, a_column)
		end

	sqlite3_column_int (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_int (a_stmt, a_column)
		end

	sqlite3_column_int64 (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): INTEGER_64
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_int64 (a_stmt, a_column)
		end

	sqlite3_column_text (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_text (a_stmt, a_column)
		end

	sqlite3_column_text16 (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_text16 (a_stmt, a_column)
		end

	sqlite3_column_type (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_type (a_stmt, a_column)
		end

	sqlite3_column_value (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_value (a_stmt, a_column)
		end

	sqlite3_data_count (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_data_count (a_stmt)
		end

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
