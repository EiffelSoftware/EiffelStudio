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
			Result := c_sqlite3_errcode (a_api.api_pointer (sqlite3_errcode_api), a_db)
		end

	sqlite3_errmsg (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_errmsg (a_api.api_pointer (sqlite3_errmsg_api), a_db)
		end

	sqlite3_extended_errcode (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_extended_errcode (a_api.api_pointer (sqlite3_extended_errcode_api), a_db)
		end

	sqlite3_last_insert_rowid (a_api: SQLITE_API; a_db: POINTER): INTEGER_64
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_last_insert_rowid (a_api.api_pointer (sqlite3_last_insert_rowid_api), a_db)
		end

feature -- Basic operations

	sqlite3_interrupt (a_api: SQLITE_API; a_db: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			c_sqlite3_interrupt (a_api.api_pointer (sqlite3_interrupt_api), a_db)
		end

	sqlite3_changes (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_changes (a_api.api_pointer (sqlite3_changes_api), a_db)
		end

	sqlite3_close (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_close (a_api.api_pointer (sqlite3_close_api), a_db)
		end

	sqlite3_extended_result_codes (a_api: SQLITE_API; a_db: POINTER; a_onoff: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_extended_result_codes (a_api.api_pointer (sqlite3_extended_result_codes_api), a_db, a_onoff)
		end

	sqlite3_open_v2 (a_api: SQLITE_API; a_file_name: POINTER; a_db: TYPED_POINTER [POINTER]; a_flags: INTEGER; a_vfs: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_file_name_is_null: a_file_name /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_open_v2 (a_api.api_pointer (sqlite3_open_v2_api), a_file_name, a_db, a_flags, a_vfs)
		end

	sqlite3_next_stmt (a_api: SQLITE_API; a_db: POINTER; a_stmt: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_next_stmt (a_api.api_pointer (sqlite3_next_stmt_api), a_db, a_stmt)
		end

feature -- Basic operations: Threading

	sqlite3_db_mutex (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_db_mutex (a_api.api_pointer (sqlite3_db_mutex_api), a_db)
		end

	sqlite3_mutex_enter (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			c_sqlite3_mutex_enter (a_api.api_pointer (sqlite3_mutex_enter_api), a_mutex)
		end

	sqlite3_mutex_leave (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			c_sqlite3_mutex_leave (a_api.api_pointer (sqlite3_mutex_leave_api), a_mutex)
		end

feature -- Callbacks

--	sqlite3_progress_handler (a_api: SQLITE_API; a_db: POINTER; a_value: INTEGER; a_callback: POINTER; a_data: POINTER)
--		require
--			a_api_attached: attached a_api
--			a_api_is_interface_usable: a_api.is_interface_usable
--			not_a_db_is_null: a_db /= default_pointer
--		do
--			c_sqlite3_progress_handler (a_api.api_pointer (sqlite3_progress_handler_api), a_db, a_value, a_callback, a_data)
--		end

	sqlite3_commit_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_commit_hook (a_api.api_pointer (sqlite3_commit_hook_api), a_db, c_sqlite3_commit_callback, a_cb_data)
		end

	sqlite3_rollback_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_rollback_hook (a_api.api_pointer (sqlite3_rollback_hook_api), a_db, c_sqlite3_rollback_callback, a_cb_data)
		end

	sqlite3_update_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := c_sqlite3_update_hook (a_api.api_pointer (sqlite3_update_hook_api), a_db, c_sqlite3_update_callback, a_cb_data)
		end

--	sqlite3_unlock_notify (a_api: SQLITE_API; a_db: POINTER; a_callback: POINTER; a_arg: POINTER): INTEGER
--			-- Experimental interface!
--		require
--			a_api_attached: attached a_api
--			a_api_is_interface_usable: a_api.is_interface_usable
--			not_a_db_is_null: a_db /= default_pointer
--			not_a_callback_is_null a_callback /= default_pointer
--		do
--			Result := c_sqlite3_unlock_notify (a_api.api_pointer (sqlite3_unlock_notify_api), a_db, a_callback, a_arg)
--		end

feature {NONE} -- Constants

	sqlite3_changes_api: STRING               = "sqlite3_changes"
	sqlite3_close_api: STRING                 = "sqlite3_close"
	sqlite3_commit_hook_api: STRING           = "sqlite3_commit_hook"
	sqlite3_db_mutex_api: STRING              = "sqlite3_db_mutex"
	sqlite3_errcode_api: STRING               = "sqlite3_errcode"
	sqlite3_errmsg_api: STRING                = "sqlite3_errmsg"
	sqlite3_extended_errcode_api: STRING      = "sqlite3_extended_errcode"
	sqlite3_extended_result_codes_api: STRING = "sqlite3_extended_result_codes"
	sqlite3_interrupt_api: STRING             = "sqlite3_interrupt"
	sqlite3_last_insert_rowid_api: STRING     = "sqlite3_last_insert_rowid"
	sqlite3_mutex_enter_api: STRING           = "sqlite3_mutex_enter"
	sqlite3_mutex_leave_api: STRING           = "sqlite3_mutex_leave"
	sqlite3_next_stmt_api: STRING             = "sqlite3_next_stmt"
	sqlite3_open_v2_api:  STRING              = "sqlite3_open_v2"
	sqlite3_progress_handler_api: STRING      = "sqlite3_progress_handler"
	sqlite3_rollback_hook_api: STRING         = "sqlite3_rollback_hook"
	sqlite3_update_hook_api:   STRING         = "sqlite3_update_hook"
	sqlite3_unlock_notify_api: STRING         = "sqlite3_unlock_notify"

feature {NONE} -- Externals

	c_sqlite3_changes,
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

	c_sqlite3_last_insert_rowid (a_fptr: POINTER; a_db: POINTER): INTEGER_64
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER_64)(FUNCTION_CAST(int, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
			]"
		end

	c_sqlite3_interrupt (a_fptr: POINTER; a_db: POINTER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				(FUNCTION_CAST(void, (sqlite3 *)) $a_fptr) (
					(sqlite3 *)$a_db);
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

feature {NONE} -- Externals: Error handling

	c_sqlite3_errcode,
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

	c_sqlite3_mutex_enter,
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

feature {NONE} -- Callbacks

--	c_sqlite3_progress_handler (a_fptr: POINTER; a_db: POINTER; a_int: INTEGER; a_callback: POINTER; a_data: POINTER)
--		require
--			not_a_fptr_is_null: a_fptr /= default_pointer
--			not_a_db_is_null: a_db /= default_pointer
--		external
--			"C inline use <sqlite3.h>"
--		alias
--			"[
--				if (NULL == $a_callback) {
--					if (NULL != $a_data) {
--						eif_wean($a_data);
--					}
--				} else if (NULL != $a_data) {
--					(FUNCTION_CAST(void *, (sqlite3 *, int, int (*)(void *), void *)) $a_fptr) (
--						(sqlite3 *)$a_db, (int)$a_int, (int (*)(void *))$a_callback, (void *)eif_protect($a_data));
--				}

--			]"
--		end

	c_sqlite3_commit_hook (a_fptr: POINTER; a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void *, (sqlite3 *, int (*)(void *), void *)) $a_fptr) (
					(sqlite3 *)$a_db, (int (*)(void *))$a_callback, (void *)$a_data);
			]"
		end

	c_sqlite3_rollback_hook (a_fptr: POINTER; a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void *, (sqlite3 *, void (*)(void *), void *)) $a_fptr) (
					(sqlite3 *)$a_db, (void (*)(void *))$a_callback, (void *)$a_data);
			]"
		end

	c_sqlite3_update_hook (a_fptr: POINTER; a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		external
			"C inline use %"sqlite3.h%""
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void *, (sqlite3 *, void (*)(void *, int, char const *, char const *, sqlite3_int64), void *)) $a_fptr) (
					(sqlite3 *)$a_db, (void (*)(void *, int, char const *, char const *, sqlite3_int64))$a_callback, (void *)$a_data);
			]"
		end

--	c_sqlite3_unlock_notify (a_fptr: POINTER; a_db: POINTER; a_callback: POINTER; a_arg: POINTER): INTEGER
--			-- Experimental interface!
--		require
--			not_a_fptr_is_null: a_fptr /= default_pointer
--			not_a_db_is_null: a_db /= default_pointer
--			not_a_callback_is_null a_callback /= default_pointer
--		external
--			"C inline use <sqlite3.h>"
--		alias
--			"[
--				(FUNCTION_CAST(void, (sqlite3_mutex *)) $a_fptr) (
--					(sqlite3_mutex *)$a_mutex);
--			]"
--		end

feature {NONE} -- Externals: Eiffel callbacks

	c_sqlite3_commit_callback: POINTER
		external
			"C inline use %"esqlite.h%""
		alias
			"return c_esqlite3_commit_callback"
		end

	c_sqlite3_rollback_callback: POINTER
		external
			"C inline use %"esqlite.h%""
		alias
			"return c_esqlite3_rollback_callback"
		end

	c_sqlite3_update_callback: POINTER
		external
			"C inline use %"esqlite.h%""
		alias
			"return c_esqlite3_update_callback"
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
