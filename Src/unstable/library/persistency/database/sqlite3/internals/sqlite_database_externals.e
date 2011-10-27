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

feature -- Measure

	sqlite3_changes (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_changes (a_db)
		end

	sqlite3_total_changes (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_total_changes (a_db)
		end

feature -- Query: Error handling

	sqlite3_errcode (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_errcode (a_db)
		end

	sqlite3_errmsg (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_errmsg (a_db)
		end

	sqlite3_extended_errcode (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_extended_errcode (a_db)
		end

	sqlite3_last_insert_rowid (a_api: SQLITE_API; a_db: POINTER): INTEGER_64
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_last_insert_rowid (a_db)
		end

feature -- Basic operations

	sqlite3_busy_timeout (a_api: SQLITE_API; a_db: POINTER; a_ms: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
			a_ms_non_negative: a_ms >= 0
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_busy_timeout (a_db, a_ms)
		end

	sqlite3_interrupt (a_api: SQLITE_API; a_db: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			{SQLITE_EXTERNALS}.c_sqlite3_interrupt (a_db)
		end

	sqlite3_close (a_api: SQLITE_API; a_db: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_close (a_db)
		end

	sqlite3_extended_result_codes (a_api: SQLITE_API; a_db: POINTER; a_onoff: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_extended_result_codes (a_db, a_onoff)
		end

	sqlite3_open_v2 (a_api: SQLITE_API; a_file_name: POINTER; a_db: TYPED_POINTER [POINTER]; a_flags: INTEGER; a_vfs: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_file_name_is_null: a_file_name /= default_pointer
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_open_v2 (a_file_name, a_db, a_flags, a_vfs)
		end

	sqlite3_next_stmt (a_api: SQLITE_API; a_db: POINTER; a_stmt: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_next_stmt (a_db, a_stmt)
		end

feature -- Basic operations: Threading

	sqlite3_db_mutex (a_api: SQLITE_API; a_db: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_db_mutex (a_db)
		end

	sqlite3_mutex_enter (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			{SQLITE_EXTERNALS}.c_sqlite3_mutex_enter (a_mutex)
		end

	sqlite3_mutex_leave (a_api: SQLITE_API; a_mutex: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_mutex_is_null: a_mutex /= default_pointer
		do
			{SQLITE_EXTERNALS}.c_sqlite3_mutex_leave (a_mutex)
		end

feature -- Callbacks

	sqlite3_progress_handler (a_api: SQLITE_API; a_db: POINTER; a_flags: INTEGER; a_cb_data: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			{SQLITE_EXTERNALS}.c_sqlite3_progress_handler (a_db, a_flags, c_sqlite3_busy_callback, a_cb_data)
		end

	sqlite3_busy_handler (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_busy_handler (a_db, c_sqlite3_busy_callback, a_cb_data)
		end

	sqlite3_commit_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_commit_hook (a_db, c_sqlite3_commit_callback, a_cb_data)
		end

	sqlite3_rollback_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_rollback_hook (a_db, c_sqlite3_rollback_callback, a_cb_data)
		end

	sqlite3_update_hook (a_api: SQLITE_API; a_db: POINTER; a_cb_data: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_db_is_null: a_db /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_update_hook (a_db, c_sqlite3_update_callback, a_cb_data)
		end

feature {NONE} -- Externals: Eiffel callbacks

	c_sqlite3_progress_callback: POINTER
		external
			"C inline use %"esqlite.h%""
		alias
			"return c_esqlite3_progress_callback"
		end

	c_sqlite3_busy_callback: POINTER
		external
			"C inline use %"esqlite.h%""
		alias
			"return c_esqlite3_busy_callback"
		end

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
