note
	description: "MySQL externals"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQL_EXTERNALS

feature -- Functions

	mysql_commit (mysql_ptr: POINTER): BOOLEAN
			-- Return True, if there was error.
		external
			"C | %"eif_mysql.h%""
		end

	mysql_rollback (mysql_ptr: POINTER): BOOLEAN
			-- Return True, if there was error.
		external
			"C | %"eif_mysql.h%""
		end

	mysql_real_escape_string (mysql_ptr: POINTER; a_to: POINTER; a_from: POINTER; a_length: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	mysql_affected_rows (mysql_ptr: POINTER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_init (mysql_ptr: POINTER): POINTER
			-- MYSQL_STMT *mysql_stmt_init(MYSQL *mysql)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_close (mysql_stmt_ptr: POINTER): BOOLEAN
			-- my_bool mysql_stmt_close(MYSQL_STMT *)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_prepare (mysql_stmt_ptr: POINTER; stmt: POINTER; length: INTEGER): INTEGER
			-- int mysql_stmt_prepare(MYSQL_STMT *stmt, const char *stmt_str, unsigned long length)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_bind_param (mysql_stmt_ptr: POINTER; mysql_bind_ptr: POINTER): BOOLEAN
			-- my_bool mysql_stmt_bind_param(MYSQL_STMT *stmt, MYSQL_BIND *bind)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_execute (mysql_stmt_ptr: POINTER): INTEGER
			-- int mysql_stmt_execute(MYSQL_STMT *stmt)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_affected_rows (mysql_stmt_ptr: POINTER): INTEGER
			-- my_ulonglong mysql_stmt_affected_rows(MYSQL_STMT *stmt)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_result_metadata (mysql_stmt_ptr: POINTER): POINTER
			-- MYSQL_RES *mysql_stmt_result_metadata(MYSQL_STMT *stmt)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_num_fields (mysql_stmt_ptr: POINTER): INTEGER
			-- unsigned int mysql_num_fields(MYSQL_RES *result)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_bind_result (mysql_stmt_ptr: POINTER; mysql_bind_ptr: POINTER): BOOLEAN
			-- my_bool mysql_stmt_bind_result(MYSQL_STMT *stmt, MYSQL_BIND *bind)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_fetch (mysql_stmt_ptr: POINTER): INTEGER
			-- int mysql_stmt_fetch(MYSQL_STMT *stmt)
			-- Result code:
			-- MYSQL_NO_DATA        100
			-- MYSQL_DATA_TRUNCATED 101
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_fetch_column (mysql_stmt_ptr, mysql_bind_ptr: POINTER; col: INTEGER; offset: INTEGER): INTEGER
			-- int mysql_stmt_fetch_column(MYSQL_STMT *stmt, MYSQL_BIND *bind, unsigned int column, unsigned long offset)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_fetch_field_direct (mysql_res_ptr: POINTER; i: INTEGER): POINTER
			-- MYSQL_FIELD *mysql_fetch_field_direct(MYSQL_RES *result, unsigned int fieldnr)
		external
			"C | %"eif_mysql.h%""
		end

	mysql_stmt_store_result (mysql_stmt_ptr: POINTER): INTEGER
			-- int mysql_stmt_store_result(MYSQL_STMT *stmt)
		external
			"C | %"eif_mysql.h%""
		end

	c_mysql_column_type (mysql_field: POINTER): INTEGER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				return ((MYSQL_FIELD *)$mysql_field)->type;
			]"
		end

	c_mysql_column_length (mysql_field: POINTER): INTEGER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				return ((MYSQL_FIELD *)$mysql_field)->length;
			]"
		end

	c_mysql_column_name (mysql_field: POINTER): POINTER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				return ((MYSQL_FIELD *)$mysql_field)->name;
			]"
		end

	c_mysql_column_name_length (mysql_field: POINTER): INTEGER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				return ((MYSQL_FIELD *)$mysql_field)->name_length;
			]"
		end

	c_set_mysql_time (p: POINTER; year, month, day, hour, minute, second: INTEGER)
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				((MYSQL_TIME *)$p)->year = $year;
				((MYSQL_TIME *)$p)->month = $month;
				((MYSQL_TIME *)$p)->day = $day;
				((MYSQL_TIME *)$p)->hour = $hour;
				((MYSQL_TIME *)$p)->minute = $minute;
				((MYSQL_TIME *)$p)->second = $second;
			]"
		end

	c_mysql_time_year (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"year"
		end

	c_mysql_time_month (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"month"
		end

	c_mysql_time_day (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"day"
		end

	c_mysql_time_hour (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"hour"
		end

	c_mysql_time_minute (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"minute"
		end

	c_mysql_time_second (p: POINTER): INTEGER
		external
			"C [struct %"eif_mysql.h%"] (MYSQL_TIME): EIF_INTEGER"
		alias
			"second"
		end

	c_set_mysql_bind (p: POINTER; i: INTEGER; buf: POINTER; buf_len: INTEGER; type: INTEGER; length, is_null: POINTER)
		external
			"C inline use %"eif_mysql.h%""
		alias
			"[
				(((MYSQL_BIND *)$p)[$i - 1]).buffer_type = $type;
				(((MYSQL_BIND *)$p)[$i - 1]).buffer = $buf;
				(((MYSQL_BIND *)$p)[$i - 1]).buffer_length = $buf_len;
				(((MYSQL_BIND *)$p)[$i - 1]).is_null = $is_null;	
				(((MYSQL_BIND *)$p)[$i - 1]).length = $length;
			]"
		end

	c_sizeof_mysql_bind: INTEGER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"return sizeof (MYSQL_BIND);"
		end

	c_sizeof_mysql_time: INTEGER
		external
			"C inline use %"eif_mysql.h%""
		alias
			"return sizeof (MYSQL_TIME);"
		end

feature -- Access

	MYSQL_DATA_TRUNCATED: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_DATA_TRUNCATED"
		end

feature -- Type

	MYSQL_TYPE_STRING: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_STRING"
		end

	MYSQL_TYPE_LONG: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_LONG"
		end

	MYSQL_TYPE_SHORT: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_SHORT"
		end

	MYSQL_TYPE_LONGLONG: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_LONGLONG"
		end

	MYSQL_TYPE_TIME: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_TIME"
		end

	MYSQL_TYPE_DATETIME: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_DATETIME"
		end

	MYSQL_TYPE_DATE: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_DATE"
		end

	MYSQL_TYPE_FLOAT: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_FLOAT"
		end

	MYSQL_TYPE_DOUBLE: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_DOUBLE"
		end

	MYSQL_TYPE_TINY: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_TINY"
		end

	MYSQL_TYPE_NULL: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"MYSQL_TYPE_NULL"
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
