note
	description: "[
		Externals for interacting with SQLite statements (sqlite3_stmt *).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_STATEMENT_EXTERNALS

feature -- Access

	sqlite3_column_count (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_count (a_stmt)
		end

	sqlite3_db_handle (a_api: SQLITE_API; a_stmt: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_db_handle (a_stmt)
		end

feature -- Query

	sqlite3_column_name (a_api: SQLITE_API; a_stmt: POINTER; a_column: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_column_non_negative: a_column >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_column_name (a_stmt, a_column)
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
			Result := {SQLITE_EXTERNALS}.c_sqlite3_prepare_v2 (a_db, a_statement, a_bytes, a_hnd, a_tail)
		end

	sqlite3_step (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_step (a_stmt)
		end

	sqlite3_reset (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_reset (a_stmt)
		end

	sqlite3_clear_bindings (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_clear_bindings (a_stmt)
		end

	sqlite3_finalize (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_finalize (a_stmt)
		end

	sqlite3_bind_parameter_index (a_api: SQLITE_API; a_stmt: POINTER; a_variable: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			not_a_variable_is_null: a_variable /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_bind_parameter_index (a_stmt, a_variable)
		end

	sqlite3_bind_parameter_name (a_api: SQLITE_API; a_stmt: POINTER; a_index: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_index_positive: a_index > 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_bind_parameter_name (a_stmt, a_index)
		end

	sqlite3_bind_parameter_count (a_api: SQLITE_API; a_stmt: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_bind_parameter_count (a_stmt)
		end

	sqlite3_bind_null (a_api: SQLITE_API; a_stmt: POINTER; a_index: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_index_positive: a_index > 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_bind_null (a_stmt, a_index)
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
