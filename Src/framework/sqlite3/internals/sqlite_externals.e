note
	description: "[
		Direct wrapping of SQLite C functions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_EXTERNALS

feature -- Externals

	c_sqlite3_bind_blob (a_stmt: POINTER; a_index: INTEGER a_blob: POINTER; a_size: INTEGER; a_destructor: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_blob((sqlite3_stmt *)$a_stmt, (int)$a_index, (const void *)$a_blob, (int)$a_size, (void(*)(void*))SQLITE_TRANSIENT)"
		end

	c_sqlite3_bind_double (a_stmt: POINTER; a_index: INTEGER; a_value: REAL_64): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_double((sqlite3_stmt *)$a_stmt, (int)$a_index, (double)$a_value)"
		end

	c_sqlite3_bind_int (a_stmt: POINTER; a_index: INTEGER; a_value: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_int((sqlite3_stmt *)$a_stmt, (int)$a_index, (int)$a_value)"
		end

	c_sqlite3_bind_int64 (a_stmt: POINTER; a_index: INTEGER; a_value: INTEGER_64): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_int64((sqlite3_stmt *)$a_stmt, (int)$a_index, (sqlite_int64)$a_value)"
		end

	c_sqlite3_bind_null (a_stmt: POINTER; a_index: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_null((sqlite3_stmt *)$a_stmt, (int)$a_index)"
		end

	c_sqlite3_bind_parameter_count (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_parameter_count((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_bind_parameter_index (a_stmt: POINTER; a_variable: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_parameter_index((sqlite3_stmt *)$a_stmt, (const char *)$a_variable)"
		end

	c_sqlite3_bind_parameter_name (a_stmt: POINTER; a_index: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_bind_parameter_name((sqlite3_stmt *)$a_stmt, (int)$a_index)"
		end

	c_sqlite3_bind_text (a_stmt: POINTER; a_index: INTEGER a_text: POINTER; a_size: INTEGER; a_destructor: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_bind_text((sqlite3_stmt *)$a_stmt, (int)$a_index, (const char *)$a_text, (int)$a_size, (void(*)(void*))SQLITE_TRANSIENT)"
		end

	c_sqlite3_busy_handler (a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_busy_handler((sqlite3 *)$a_db, (int (*)(void *, int))$a_callback, (void *)$a_data)"
		end

	c_sqlite3_changes (a_db: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_close((sqlite3 *)$a_db)"
		end

	c_sqlite3_clear_bindings (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_clear_bindings((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_close (a_db: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_close((sqlite3 *)$a_db)"
		end

	c_sqlite3_column_blob (a_stmt: POINTER; a_column: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_column_blob((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_bytes (a_stmt: POINTER; a_column: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_column_bytes((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_bytes16 (a_stmt: POINTER; a_column: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_column_bytes16((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_count (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_column_count((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_column_double (a_stmt: POINTER; a_column: INTEGER): REAL_64
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_DOUBLE)sqlite3_column_double((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_int (a_stmt: POINTER; a_column: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_column_int((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_int64 (a_stmt: POINTER; a_column: INTEGER): INTEGER_64
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER_64)sqlite3_column_int64((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_name (a_stmt: POINTER; a_column: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_column_name((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_text (a_stmt: POINTER; a_column: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_column_text((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_text16 (a_stmt: POINTER; a_column: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_column_text16((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_type (a_stmt: POINTER; a_column: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_column_type((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_column_value (a_stmt: POINTER; a_column: INTEGER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_column_value((sqlite3_stmt *)$a_stmt, (int)$a_column)"
		end

	c_sqlite3_commit_hook (a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_commit_hook((sqlite3 *)$a_db, (int (*)(void *))$a_callback, (void *)$a_data)"
		end

	c_sqlite3_complete (a_sql: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_complete((const char *)$a_sql)"
		end

	c_sqlite3_data_count (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_data_count((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_db_handle (a_stmt: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_db_handle((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_db_mutex (a_db: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_db_mutex((sqlite3 *)$a_db)"
		end

	c_sqlite3_errcode (a_db: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_errcode((sqlite3 *)$a_db)"
		end

	c_sqlite3_errmsg (a_db: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_errmsg((sqlite3 *)$a_db)"
		end

	c_sqlite3_extended_errcode (a_db: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_extended_errcode((sqlite3 *)$a_db)"
		end

	c_sqlite3_extended_result_codes (a_db: POINTER; a_onoff: INTEGER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_extended_result_codes((sqlite3 *)$a_db, (int)$a_onoff)"
		end

	c_sqlite3_finalize (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_finalize((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_initialize: INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_initialize()"
		end

	c_sqlite3_interrupt (a_db: POINTER)
		external
			"C inline use <sqlite3.h>"
		alias
			"sqlite3_interrupt((sqlite3 *)$a_db)"
		end

	c_sqlite3_last_insert_rowid (a_db: POINTER): INTEGER_64
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER_64)sqlite3_last_insert_rowid((sqlite3 *)$a_db)"
		end

	c_sqlite3_libversion: POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_libversion()"
		end

	c_sqlite3_libversion_number: INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_libversion_number()"
		end

	c_sqlite3_mutex_enter (a_mutex: POINTER)
		external
			"C inline use <sqlite3.h>"
		alias
			"sqlite3_mutex_enter((sqlite3_mutex *)$a_mutex)"
		end

	c_sqlite3_mutex_leave (a_mutex: POINTER)
		external
			"C inline use <sqlite3.h>"
		alias
			"sqlite3_mutex_leave((sqlite3_mutex *)$a_mutex)"
		end

	c_sqlite3_next_stmt (a_db: POINTER; a_stmt: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_next_stmt((sqlite3 *)$a_db, (sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_open_v2 (a_file_name: POINTER; a_db: TYPED_POINTER [POINTER]; a_flags: INTEGER; a_vfs: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_open_v2((const char *)$a_file_name, (sqlite3 **)$a_db, (int)$a_flags, (const char *)$a_vfs)"
		end

	c_sqlite3_prepare_v2 (a_db: POINTER; a_statement: POINTER; a_bytes: INTEGER; a_hnd: TYPED_POINTER [POINTER]; a_tail: TYPED_POINTER [POINTER]): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_prepare_v2((sqlite3 *)$a_db, (const char *)$a_statement, (int)$a_bytes, (sqlite3_stmt **)$a_hnd, (const char **)$a_tail)"
		end

	c_sqlite3_progress_handler (a_db: POINTER; a_flag: INTEGER; a_callback: POINTER; a_data: POINTER)
		external
			"C inline use <sqlite3.h>"
		alias
			"sqlite3_progress_handler((sqlite3 *)$a_db, (int)$a_flag, (int (*)(void *))$a_callback, (void *)$a_data)"
		end

	c_sqlite3_reset (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_reset((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_rollback_hook (a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_rollback_hook((sqlite3 *)$a_db, (void (*)(void *))$a_callback, (void *)$a_data)"
		end

	c_sqlite3_shutdown: INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_shutdown()"
		end

	c_sqlite3_step (a_stmt: POINTER): INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_step((sqlite3_stmt *)$a_stmt)"
		end

	c_sqlite3_threadsafe: INTEGER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_INTEGER)sqlite3_threadsafe()"
		end

	c_sqlite3_update_hook (a_db: POINTER; a_callback: POINTER; a_data: POINTER): POINTER
		external
			"C inline use <sqlite3.h>"
		alias
			"return (EIF_POINTER)sqlite3_update_hook((sqlite3 *)$a_db, (void (*)(void *, int, char const *, char const *, sqlite3_int64))$a_callback, (void *)$a_data)"
		end


--feature





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
