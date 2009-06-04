note
	description: "[
		Externals for interacting with SQLite statments (sqlite3_stmt *).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_STATEMENT_EXTERNALS

feature -- Access

	sqlite3_data_count (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_data_count (a_api.api_pointer (once "sqlite3_data_count"), a_stmt)
		end

	sqlite3_column_count (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_column_count (a_api.api_pointer (once "sqlite3_column_count"), a_stmt)
		end

	sqlite3_db_handle (a_api: SQLITE_API; a_stmt: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_db_handle (a_api.api_pointer (once "sqlite3_db_handle"), a_stmt)
		end

feature -- Query

	sqlite3_column_name (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := c_sqlite3_column_name (a_api.api_pointer (once "sqlite3_column_name"), a_stmt, a_column)
		end

feature -- Basic operations

	sqlite3_prepare_v2 (a_api: SQLITE_API; a_db: POINTER; a_statement: POINTER; a_bytes: INTEGER; a_hnd: TYPED_POINTER [POINTER]; a_tail: TYPED_POINTER [POINTER]): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
			not_a_statement_is_null: a_statement /= default_pointer
			a_bytes_positive: a_bytes > 0
			not_a_hnd_is_null: a_hnd /= default_pointer
		do
			Result := c_sqlite3_prepare_v2 (a_api.api_pointer (once "sqlite3_prepare_v2"), a_db, a_statement, a_bytes, a_hnd, a_tail)
		end

	sqlite3_step (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_step (a_api.api_pointer (once "sqlite3_step"), a_stmt)
		end

	sqlite3_reset (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_reset (a_api.api_pointer (once "sqlite3_reset"), a_stmt)
		end

	sqlite3_finalize (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := c_sqlite3_finalize (a_api.api_pointer (once "sqlite3_finalize"), a_stmt)
		end

feature {NONE} -- Externals

	c_sqlite3_db_handle (a_fptr: POINTER; a_stmt: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(sqlite3 *, (sqlite3_stmt *)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt);
			]"
		end

	c_sqlite3_prepare_v2 (a_fptr: POINTER; a_db: POINTER; a_statement: POINTER; a_bytes: INTEGER; a_hnd: TYPED_POINTER [POINTER]; a_tail: TYPED_POINTER [POINTER]): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
			not_a_statement_is_null: a_statement /= default_pointer
			a_bytes_non_negative: a_bytes >= 0
			not_a_hnd_is_null: a_hnd /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *, const char *, int, sqlite3_stmt **, const char **)) $a_fptr) (
						(sqlite3 *)$a_db, (const char *)$a_statement, (int)$a_bytes, (sqlite3_stmt **)$a_hnd, (const char **)$a_tail);
			]"
		end

	c_sqlite3_step,
	c_sqlite3_reset,
	c_sqlite3_finalize (a_fptr: POINTER; a_stmt: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_stmt *)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt);
			]"
		end

	c_sqlite3_column_count,
	c_sqlite3_data_count (a_fptr: POINTER; a_stmt: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_stmt *)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt);
			]"
		end

	c_sqlite3_column_name (a_fptr: POINTER; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(const char *, (sqlite3_stmt *, int)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt, (int)$a_column);
			]"
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
