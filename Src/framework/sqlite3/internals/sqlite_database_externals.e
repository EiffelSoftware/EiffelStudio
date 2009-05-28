note
	description: "[
		Externals for interacting with SQLite databases (sqlite3 *).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_DATABASE_EXTERNALS

feature -- Query: Error handling

	sqlite3_errcode (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_errcode (a_api.api_pointer (once "sqlite3_errcode"), a_db)
		end

	sqlite3_extended_errcode (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_extended_errcode (a_api.api_pointer (once "sqlite3_extended_errcode"), a_db)
		end

	sqlite3_errmsg (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_errmsg (a_api.api_pointer (once "sqlite3_errmsg"), a_db)
		end

feature -- Basic operations

	sqlite3_changes (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_changes (a_api.api_pointer (once "sqlite3_changes"), a_db)
		end

	sqlite3_close (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_close (a_api.api_pointer (once "sqlite3_close"), a_db)
		end

	sqlite3_extended_result_codes (a_api: SQLITE_API; a_db: POINTER; a_onoff: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_extended_result_codes (a_api.api_pointer (once "sqlite3_extended_result_codes"), a_db, a_onoff)
		end

	sqlite3_open_v2 (a_api: SQLITE_API; a_file_name: POINTER; a_db: TYPED_POINTER [POINTER]; a_flags: INTEGER; a_vfs: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_file_name_is_null: a_file_name /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_open_v2 (a_api.api_pointer (once "sqlite3_open_v2"), a_file_name, a_db, a_flags, a_vfs)
		end

	sqlite3_next_stmt (a_api: SQLITE_API; a_db: POINTER; a_stmt: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_next_stmt (a_api.api_pointer (once "sqlite3_next_stmt"), a_db, a_stmt)
		end

feature -- Basic operations: Threading

	sqlite3_db_mutex (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_db_mutex (a_api.api_pointer (once "sqlite3_db_mutex"), a_db)
		end

	sqlite3_mutex_enter (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			c_sqlite3_mutex_enter (a_api.api_pointer (once "sqlite3_mutex_enter"), a_mutex)
		end

	sqlite3_mutex_leave (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			c_sqlite3_mutex_leave (a_api.api_pointer (once "sqlite3_mutex_leave"), a_mutex)
		end

feature {NONE} -- Externals

	c_sqlite3_changes (a_fptr: POINTER; a_db: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_close (a_fptr: POINTER; a_db: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_extended_result_codes (a_fptr: POINTER; a_db: POINTER; a_onoff: INTEGER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *, int)) $a_fptr) (
					(sqlite3 *)$a_db, (int)$a_onoff);
			]"
		end

	c_sqlite3_open_v2 (a_fptr: POINTER; a_file_name: POINTER; a_db: TYPED_POINTER [POINTER]; a_flags: INTEGER; a_vfs: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_file_name_is_null: a_file_name /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (const char *, sqlite3 **, int, const char *)) $a_fptr) (
					(const char *)$a_file_name, (sqlite3 **)$a_db, (int)$a_flags, (const char *)$a_vfs);
			]"
		end

	c_sqlite3_next_stmt (a_fptr: POINTER; a_db: POINTER; a_stmt: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(sqlite3_stmt *, (sqlite3 *, sqlite3_stmt *)) $a_fptr) (
					(sqlite3 *)$a_db, (sqlite3_stmt *)$a_stmt);
			]"
		end

feature {NONE} -- Externals: Error handling

	c_sqlite3_errcode (a_fptr: POINTER; a_db: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_extended_errcode (a_fptr: POINTER; a_db: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_errmsg (a_fptr: POINTER; a_db: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(const char *, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

feature {NONE} -- Externals: Threading

	c_sqlite3_db_mutex (a_fptr: POINTER; a_db: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(sqlite3_mutex *, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_mutex_enter (a_fptr: POINTER; a_mutex: POINTER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_mutex_is_null: a_mutex /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				(FUNCTION_CAST(void, (sqlite3_mutex *)) $a_fptr) (
					(sqlite3_mutex *)$a_mutex);
			]"
		end

	c_sqlite3_mutex_leave (a_fptr: POINTER; a_mutex: POINTER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_mutex_is_null: a_mutex /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				(FUNCTION_CAST(void, (sqlite3_mutex *)) $a_fptr) (
					(sqlite3_mutex *)$a_mutex);
			]"
		end

feature -- Externals: Macros

	SQLITE_OPEN_READONLY: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OPEN_READONLY"
		end

	SQLITE_OPEN_READWRITE: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OPEN_READWRITE"
		end

	SQLITE_OPEN_CREATE: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OPEN_CREATE"
		end

	SQLITE_OPEN_NOMUTEX: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OPEN_NOMUTEX"
		end

	SQLITE_OPEN_FULLMUTEX: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OPEN_FULLMUTEX"
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
