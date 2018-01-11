note
	description: "Interface between MySQL C API and Eiffel. Generated Code."
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_EXTERNALS

feature{MYSQLI_EXTERNALS} -- C API

	c_mysql_affected_rows (a_mysql: POINTER): NATURAL_64
			-- Returns the number of rows changed/deleted/inserted by the last UPDATE, DELETE, or INSERT query
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-affected-rows.html
			-- my_ulonglong mysql_affected_rows(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_affected_rows((MYSQL *)$a_mysql)"
		end

	c_mysql_autocommit (a_mysql: POINTER; a_mode: INTEGER_8): INTEGER_8
			-- Toggles autocommit mode on/off
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-autocommit.html
			-- my_bool mysql_autocommit(MYSQL *mysql, my_bool mode)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_autocommit((MYSQL *)$a_mysql, (my_bool)$a_mode)"
		end

	c_mysql_change_user (a_mysql: POINTER; a_user: POINTER; a_password: POINTER; a_db: POINTER): INTEGER_8
			-- Changes user and database on an open connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-change-user.html
			-- my_bool mysql_change_user(MYSQL *mysql, const char *user, const char *password, const char *db)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_change_user((MYSQL *)$a_mysql, (const char *)$a_user, (const char *)$a_password, (const char *)$a_db)"
		end

	c_mysql_character_set_name (a_mysql: POINTER): POINTER
			-- Return default character set name for current connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-character-set-name.html
			-- const char *mysql_character_set_name(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_character_set_name((MYSQL *)$a_mysql)"
		end

	c_mysql_close (a_mysql: POINTER)
			-- Closes a server connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-close.html
			-- void mysql_close(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_close((MYSQL *)$a_mysql)"
		end

	c_mysql_commit (a_mysql: POINTER): INTEGER_8
			-- Commits the transaction
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-commit.html
			-- my_bool mysql_commit(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_commit((MYSQL *)$a_mysql)"
		end

	c_mysql_data_seek (a_result: POINTER; a_offset: NATURAL_64)
			-- Seeks to an arbitrary row number in a query result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-data-seek.html
			-- void mysql_data_seek(MYSQL_RES *result, my_ulonglong offset)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_data_seek((MYSQL_RES *)$a_result, (my_ulonglong)$a_offset)"
		end

	c_mysql_debug (a_debug: POINTER)
			-- Does a DBUG_PUSH with the given string
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-debug.html
			-- void mysql_debug(const char *debug)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_debug((const char *)$a_debug)"
		end

	c_mysql_dump_debug_info (a_mysql: POINTER): INTEGER_32
			-- Makes the server write debug information to the log
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-dump-debug-info.html
			-- int mysql_dump_debug_info(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_dump_debug_info((MYSQL *)$a_mysql)"
		end

	c_mysql_eof (a_result: POINTER): INTEGER_8
			-- Determines whether the last row of a result set has been read (this function is deprecated; mysql_errno() or mysql_error() may be used instead)
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-eof.html
			-- my_bool mysql_eof(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_eof((MYSQL_RES *)$a_result)"
		end

	c_mysql_errno (a_mysql: POINTER): NATURAL_32
			-- Returns the error number for the most recently invoked MySQL function
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-errno.html
			-- unsigned int mysql_errno(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_errno((MYSQL *)$a_mysql)"
		end

	c_mysql_error (a_mysql: POINTER): POINTER
			-- Returns the error message for the most recently invoked MySQL function
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-error.html
			-- const char *mysql_error(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_error((MYSQL *)$a_mysql)"
		end

	c_mysql_fetch_field_direct (a_result: POINTER; a_fieldnr: NATURAL_32): POINTER
			-- Returns the type of a table field, given a field number
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-fetch-field-direct.html
			-- MYSQL_FIELD *mysql_fetch_field_direct(MYSQL_RES *result, unsigned int fieldnr)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_fetch_field_direct((MYSQL_RES *)$a_result, (unsigned int)$a_fieldnr)"
		end

	c_mysql_fetch_field (a_result: POINTER): POINTER
			-- Returns the type of the next table field
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-fetch-field.html
			-- MYSQL_FIELD *mysql_fetch_field(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_fetch_field((MYSQL_RES *)$a_result)"
		end

	c_mysql_fetch_fields (a_result: POINTER): POINTER
			-- Returns an array of all field structures
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-fetch-fields.html
			-- MYSQL_FIELD *mysql_fetch_fields(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_fetch_fields((MYSQL_RES *)$a_result)"
		end

	c_mysql_fetch_lengths (a_result: POINTER): POINTER
			-- Returns the lengths of all columns in the current row
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-fetch-lengths.html
			-- unsigned long *mysql_fetch_lengths(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_fetch_lengths((MYSQL_RES *)$a_result)"
		end

	c_mysql_fetch_row (a_result: POINTER; a_row: POINTER)
			-- Fetches the next row from the result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-fetch-row.html
			-- MYSQL_ROW mysql_fetch_row(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_ROW *)$a_row) = mysql_fetch_row((MYSQL_RES *)$a_result)"
		end

	c_mysql_field_count (a_mysql: POINTER): NATURAL_32
			-- Returns the number of result columns for the most recent statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-field-count.html
			-- unsigned int mysql_field_count(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_field_count((MYSQL *)$a_mysql)"
		end

	c_mysql_field_seek (a_result: POINTER; a_offset: POINTER; a_field_offset: POINTER)
			-- Puts the column cursor on a specified column
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-field-seek.html
			-- MYSQL_FIELD_OFFSET mysql_field_seek(MYSQL_RES *result, MYSQL_FIELD_OFFSET offset)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_FIELD_OFFSET *)$a_field_offset) = mysql_field_seek((MYSQL_RES *)$a_result, *(MYSQL_FIELD_OFFSET *)$a_offset)"
		end

	c_mysql_field_tell (a_result: POINTER; a_field_offset: POINTER)
			-- Returns the position of the field cursor used for the last mysql_fetch_field()
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-field-tell.html
			-- MYSQL_FIELD_OFFSET mysql_field_tell(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_FIELD_OFFSET *)$a_field_offset) = mysql_field_tell((MYSQL_RES *)$a_result)"
		end

	c_mysql_free_result (a_result: POINTER)
			-- Frees memory used by a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-free-result.html
			-- void mysql_free_result(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_free_result((MYSQL_RES *)$a_result)"
		end

	c_mysql_get_character_set_info (a_mysql: POINTER; a_cs: POINTER)
			-- Return information about default character set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-character-set-info.html
			-- void mysql_get_character_set_info(MYSQL *mysql, MY_CHARSET_INFO *cs)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_get_character_set_info((MYSQL *)$a_mysql, (MY_CHARSET_INFO *)$a_cs)"
		end

	c_mysql_get_client_info : POINTER
			-- Returns client version information as a string
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-client-info.html
			-- const char *mysql_get_client_info(void)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_get_client_info()"
		end

	c_mysql_get_client_version : NATURAL_32
			-- Returns client version information as an integer
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-client-version.html
			-- unsigned long mysql_get_client_version(void)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_get_client_version()"
		end

	c_mysql_get_host_info (a_mysql: POINTER): POINTER
			-- Returns a string describing the connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-host-info.html
			-- const char *mysql_get_host_info(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_get_host_info((MYSQL *)$a_mysql)"
		end

	c_mysql_get_proto_info (a_mysql: POINTER): NATURAL_32
			-- Returns the protocol version used by the connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-proto-info.html
			-- unsigned int mysql_get_proto_info(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_get_proto_info((MYSQL *)$a_mysql)"
		end

	c_mysql_get_server_info (a_mysql: POINTER): POINTER
			-- Returns the server version number
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-server-info.html
			-- const char *mysql_get_server_info(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_get_server_info((MYSQL *)$a_mysql)"
		end

	c_mysql_get_server_version (a_mysql: POINTER): NATURAL_32
			-- Returns version number of server as an integer
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-server-version.html
			-- unsigned long mysql_get_server_version(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_get_server_version((MYSQL *)$a_mysql)"
		end

	c_mysql_get_ssl_cipher (a_mysql: POINTER): POINTER
			-- Return current SSL cipher
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-get-ssl-cipher.html
			-- const char *mysql_get_ssl_cipher(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_get_ssl_cipher((MYSQL *)$a_mysql)"
		end

	c_mysql_hex_string (a_to: POINTER; a_from: POINTER; a_length: NATURAL_32): NATURAL_32
			-- Encode string in hexadecimal format
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-hex-string.html
			-- unsigned long mysql_hex_string(char *to, const char *from, unsigned long length)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_hex_string((char *)$a_to, (const char *)$a_from, (unsigned long)$a_length)"
		end

	c_mysql_info (a_mysql: POINTER): POINTER
			-- Returns information about the most recently executed query
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-info.html
			-- const char *mysql_info(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_info((MYSQL *)$a_mysql)"
		end

	c_mysql_init (a_mysql: POINTER): POINTER
			-- Gets or initializes a MYSQL structure
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-init.html
			-- MYSQL *mysql_init(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_init((MYSQL *)$a_mysql)"
		end

	c_mysql_insert_id (a_mysql: POINTER): NATURAL_64
			-- Returns the ID generated for an AUTO_INCREMENT column by the previous query
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-insert-id.html
			-- my_ulonglong mysql_insert_id(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_insert_id((MYSQL *)$a_mysql)"
		end

	c_mysql_kill (a_mysql: POINTER; a_pid: NATURAL_32): INTEGER_32
			-- Kills a given thread
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-kill.html
			-- int mysql_kill(MYSQL *mysql, unsigned long pid)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_kill((MYSQL *)$a_mysql, (unsigned long)$a_pid)"
		end

	c_mysql_library_end
			-- Finalize the MySQL C API library
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-library-end.html
			-- void mysql_library_end(void)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_library_end()"
		end

	c_mysql_library_init (a_argc: INTEGER_32; a_argv: POINTER; a_groups: POINTER): INTEGER_32
			-- Initialize the MySQL C API library
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-library-init.html
			-- int mysql_library_init(int argc, char **argv, char **groups)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_library_init((int)$a_argc, (char **)$a_argv, (char **)$a_groups)"
		end

	c_mysql_list_dbs (a_mysql: POINTER; a_wild: POINTER): POINTER
			-- Returns database names matching a simple regular expression
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-list-dbs.html
			-- MYSQL_RES *mysql_list_dbs(MYSQL *mysql, const char *wild)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_list_dbs((MYSQL *)$a_mysql, (const char *)$a_wild)"
		end

	c_mysql_list_fields (a_mysql: POINTER; a_table: POINTER; a_wild: POINTER): POINTER
			-- Returns field names matching a simple regular expression
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-list-fields.html
			-- MYSQL_RES *mysql_list_fields(MYSQL *mysql, const char *table, const char *wild)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_list_fields((MYSQL *)$a_mysql, (const char *)$a_table, (const char *)$a_wild)"
		end

	c_mysql_list_processes (a_mysql: POINTER): POINTER
			-- Returns a list of the current server threads
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-list-processes.html
			-- MYSQL_RES *mysql_list_processes(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_list_processes((MYSQL *)$a_mysql)"
		end

	c_mysql_list_tables (a_mysql: POINTER; a_wild: POINTER): POINTER
			-- Returns table names matching a simple regular expression
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-list-tables.html
			-- MYSQL_RES *mysql_list_tables(MYSQL *mysql, const char *wild)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_list_tables((MYSQL *)$a_mysql, (const char *)$a_wild)"
		end

	c_mysql_more_results (a_mysql: POINTER): INTEGER_8
			-- Checks whether any more results exist
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-more-results.html
			-- my_bool mysql_more_results(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_more_results((MYSQL *)$a_mysql)"
		end

	c_mysql_next_result (a_mysql: POINTER): INTEGER_32
			-- Returns/initiates the next result in multiple-result executions
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-next-result.html
			-- int mysql_next_result(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_next_result((MYSQL *)$a_mysql)"
		end

	c_mysql_num_fields (a_result: POINTER): NATURAL_32
			-- Returns the number of columns in a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-num-fields.html
			-- unsigned int mysql_num_fields(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_num_fields((MYSQL_RES *)$a_result)"
		end

	c_mysql_num_rows (a_result: POINTER): NATURAL_64
			-- Returns the number of rows in a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-num-rows.html
			-- my_ulonglong mysql_num_rows(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_num_rows((MYSQL_RES *)$a_result)"
		end

	c_mysql_options (a_mysql: POINTER; a_option: INTEGER_32; a_arg: POINTER): INTEGER_32
			-- Sets connect options for mysql_real_connect()
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-options.html
			-- int mysql_options(MYSQL *mysql, enum mysql_option option, const void *arg)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_options((MYSQL *)$a_mysql, (enum mysql_option)$a_option, (const void *)$a_arg)"
		end

	c_mysql_ping (a_mysql: POINTER): INTEGER_32
			-- Checks whether the connection to the server is working, reconnecting as necessary
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-ping.html
			-- int mysql_ping(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_ping((MYSQL *)$a_mysql)"
		end

	c_mysql_query (a_mysql: POINTER; a_stmt_str: POINTER): INTEGER_32
			-- Executes an SQL query specified as a null-terminated string
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-query.html
			-- int mysql_query(MYSQL *mysql, const char *stmt_str)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_query((MYSQL *)$a_mysql, (const char *)$a_stmt_str)"
		end

	c_mysql_real_connect (a_mysql: POINTER; a_host: POINTER; a_user: POINTER; a_passwd: POINTER; a_db: POINTER; a_port: NATURAL_32; a_unix_socket: POINTER; a_client_flag: NATURAL_32): POINTER
			-- Connects to a MySQL server
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-real-connect.html
			-- MYSQL *mysql_real_connect(MYSQL *mysql, const char *host, const char *user, const char *passwd, const char *db, unsigned int port, const char *unix_socket, unsigned long client_flag)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_real_connect((MYSQL *)$a_mysql, (const char *)$a_host, (const char *)$a_user, (const char *)$a_passwd, (const char *)$a_db, (unsigned int)$a_port, (const char *)$a_unix_socket, (unsigned long)$a_client_flag)"
		end

	c_mysql_real_escape_string (a_mysql: POINTER; a_to: POINTER; a_from: POINTER; a_length: NATURAL_32): NATURAL_32
			-- Escapes special characters in a string for use in an SQL statement, taking into account the current character set of the connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-real-escape-string.html
			-- unsigned long mysql_real_escape_string(MYSQL *mysql, char *to, const char *from, unsigned long length)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_real_escape_string((MYSQL *)$a_mysql, (char *)$a_to, (const char *)$a_from, (unsigned long)$a_length)"
		end

	c_mysql_real_query (a_mysql: POINTER; a_stmt_str: POINTER; a_length: NATURAL_32): INTEGER_32
			-- Executes an SQL query specified as a counted string
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-real-query.html
			-- int mysql_real_query(MYSQL *mysql, const char *stmt_str, unsigned long length)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_real_query((MYSQL *)$a_mysql, (const char *)$a_stmt_str, (unsigned long)$a_length)"
		end

	c_mysql_refresh (a_mysql: POINTER; a_options: NATURAL_32): INTEGER_32
			-- Flush or reset tables and caches
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-refresh.html
			-- int mysql_refresh(MYSQL *mysql, unsigned int options)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_refresh((MYSQL *)$a_mysql, (unsigned int)$a_options)"
		end

	c_mysql_reload (a_mysql: POINTER): INTEGER_32
			-- Tells the server to reload the grant tables
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-reload.html
			-- int mysql_reload(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_reload((MYSQL *)$a_mysql)"
		end

	c_mysql_rollback (a_mysql: POINTER): INTEGER_8
			-- Rolls back the transaction
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-rollback.html
			-- my_bool mysql_rollback(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_rollback((MYSQL *)$a_mysql)"
		end

	c_mysql_row_seek (a_result: POINTER; a_offset: POINTER; a_row_offset: POINTER)
			-- Seeks to a row offset in a result set, using value returned from mysql_row_tell()
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-row-seek.html
			-- MYSQL_ROW_OFFSET mysql_row_seek(MYSQL_RES *result, MYSQL_ROW_OFFSET offset)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_ROW_OFFSET *)$a_row_offset) = mysql_row_seek((MYSQL_RES *)$a_result, *(MYSQL_ROW_OFFSET *)$a_offset)"
		end

	c_mysql_row_tell (a_result: POINTER; a_row_offset: POINTER)
			-- Returns the row cursor position
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-row-tell.html
			-- MYSQL_ROW_OFFSET mysql_row_tell(MYSQL_RES *result)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_ROW_OFFSET *)$a_row_offset) = mysql_row_tell((MYSQL_RES *)$a_result)"
		end

	c_mysql_select_db (a_mysql: POINTER; a_db: POINTER): INTEGER_32
			-- Selects a database
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-select-db.html
			-- int mysql_select_db(MYSQL *mysql, const char *db)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_select_db((MYSQL *)$a_mysql, (const char *)$a_db)"
		end

	c_mysql_set_character_set (a_mysql: POINTER; a_csname: POINTER): INTEGER_32
			-- Set default character set for current connection
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-set-character-set.html
			-- int mysql_set_character_set(MYSQL *mysql, const char *csname)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_set_character_set((MYSQL *)$a_mysql, (const char *)$a_csname)"
		end

	c_mysql_set_local_infile_default (a_mysql: POINTER)
			-- Set the LOAD DATA LOCAL INFILE handler callbacks to their default values
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-set-local-infile-default.html
			-- void mysql_set_local_infile_default(MYSQL *mysql);
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_set_local_infile_default((MYSQL *)$a_mysql)"
		end

	c_mysql_set_server_option (a_mysql: POINTER; a_option: INTEGER_32): INTEGER_32
			-- Sets an option for the connection (like multi-statements)
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-set-server-option.html
			-- int mysql_set_server_option(MYSQL *mysql, enum enum_mysql_set_option option)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_set_server_option((MYSQL *)$a_mysql, (enum enum_mysql_set_option)$a_option)"
		end

	c_mysql_shutdown (a_mysql: POINTER; a_shutdown_level: INTEGER_32): INTEGER_32
			-- Shuts down the database server
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-shutdown.html
			-- int mysql_shutdown(MYSQL *mysql, enum mysql_enum_shutdown_level shutdown_level)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_shutdown((MYSQL *)$a_mysql, (enum mysql_enum_shutdown_level)$a_shutdown_level)"
		end

	c_mysql_sqlstate (a_mysql: POINTER): POINTER
			-- Returns the SQLSTATE error code for the last error
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-sqlstate.html
			-- const char *mysql_sqlstate(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_sqlstate((MYSQL *)$a_mysql)"
		end

	c_mysql_ssl_set (a_mysql: POINTER; a_key: POINTER; a_cert: POINTER; a_ca: POINTER; a_capath: POINTER; a_cipher: POINTER): INTEGER_8
			-- Prepare to establish SSL connection to server
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-ssl-set.html
			-- my_bool mysql_ssl_set(MYSQL *mysql, const char *key, const char *cert, const char *ca, const char *capath, const char *cipher)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_ssl_set((MYSQL *)$a_mysql, (const char *)$a_key, (const char *)$a_cert, (const char *)$a_ca, (const char *)$a_capath, (const char *)$a_cipher)"
		end

	c_mysql_stat (a_mysql: POINTER): POINTER
			-- Returns the server status as a string
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stat.html
			-- const char *mysql_stat(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stat((MYSQL *)$a_mysql)"
		end

	c_mysql_stmt_affected_rows (a_stmt: POINTER): NATURAL_64
			-- Returns the number of rows changed, deleted, or inserted by prepared UPDATE, DELETE, or INSERT statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-affected-rows.html
			-- my_ulonglong mysql_stmt_affected_rows(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_stmt_affected_rows((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_attr_get (a_stmt: POINTER; a_option: INTEGER_32; a_arg: POINTER): INTEGER_8
			-- Gets value of an attribute for a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-attr-get.html
			-- my_bool mysql_stmt_attr_get(MYSQL_STMT *stmt, enum enum_stmt_attr_type option, void *arg)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_attr_get((MYSQL_STMT *)$a_stmt, (enum enum_stmt_attr_type)$a_option, (void *)$a_arg)"
		end

	c_mysql_stmt_attr_set (a_stmt: POINTER; a_option: INTEGER_32; a_arg: POINTER): INTEGER_8
			-- Sets an attribute for a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-attr-set.html
			-- my_bool mysql_stmt_attr_set(MYSQL_STMT *stmt, enum enum_stmt_attr_type option, const void *arg)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_attr_set((MYSQL_STMT *)$a_stmt, (enum enum_stmt_attr_type)$a_option, (const void *)$a_arg)"
		end

	c_mysql_stmt_bind_param (a_stmt: POINTER; a_bind: POINTER): INTEGER_8
			-- Associates application data buffers with the parameter markers in a prepared SQL statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-bind-param.html
			-- my_bool mysql_stmt_bind_param(MYSQL_STMT *stmt, MYSQL_BIND *bind)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_bind_param((MYSQL_STMT *)$a_stmt, (MYSQL_BIND *)$a_bind)"
		end

	c_mysql_stmt_bind_result (a_stmt: POINTER; a_bind: POINTER): INTEGER_8
			-- Associates application data buffers with columns in a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-bind-result.html
			-- my_bool mysql_stmt_bind_result(MYSQL_STMT *stmt, MYSQL_BIND *bind)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_bind_result((MYSQL_STMT *)$a_stmt, (MYSQL_BIND *)$a_bind)"
		end

	c_mysql_stmt_close (a_stmt: POINTER): INTEGER_8
			-- Frees memory used by a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-close.html
			-- my_bool mysql_stmt_close(MYSQL_STMT *)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_close((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_data_seek (a_stmt: POINTER; a_offset: NATURAL_64)
			-- Seeks to an arbitrary row number in a statement result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-data-seek.html
			-- void mysql_stmt_data_seek(MYSQL_STMT *stmt, my_ulonglong offset)
		external
			"C inline use %"mysql.h%""
		alias
			"mysql_stmt_data_seek((MYSQL_STMT *)$a_stmt, (my_ulonglong)$a_offset)"
		end

	c_mysql_stmt_errno (a_stmt: POINTER): NATURAL_32
			-- Returns the error number for the last statement execution
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-errno.html
			-- unsigned int mysql_stmt_errno(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_stmt_errno((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_error (a_stmt: POINTER): POINTER
			-- Returns the error message for the last statement execution
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-error.html
			-- const char *mysql_stmt_error(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stmt_error((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_execute (a_stmt: POINTER): INTEGER_32
			-- Executes a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-execute.html
			-- int mysql_stmt_execute(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_stmt_execute((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_fetch_column (a_stmt: POINTER; a_bind: POINTER; a_column: NATURAL_32; a_offset: NATURAL_32): INTEGER_32
			-- Fetch data for one column of the current row of a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-fetch-column.html
			-- int mysql_stmt_fetch_column(MYSQL_STMT *stmt, MYSQL_BIND *bind, unsigned int column, unsigned long offset)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_stmt_fetch_column((MYSQL_STMT *)$a_stmt, (MYSQL_BIND *)$a_bind, (unsigned int)$a_column, (unsigned long)$a_offset)"
		end

	c_mysql_stmt_fetch (a_stmt: POINTER): INTEGER_32
			-- Fetches the next row of data from a result set and returns data for all bound columns
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-fetch.html
			-- int mysql_stmt_fetch(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_stmt_fetch((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_field_count (a_stmt: POINTER): NATURAL_32
			-- Returns the number of result columns for the most recent statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-field-count.html
			-- unsigned int mysql_stmt_field_count(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_stmt_field_count((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_free_result (a_stmt: POINTER): INTEGER_8
			-- Free the resources allocated to a statement handle
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-free-result.html
			-- my_bool mysql_stmt_free_result(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_free_result((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_init (a_mysql: POINTER): POINTER
			-- Allocates memory for a MYSQL_STMT structure and initializes it
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-init.html
			-- MYSQL_STMT *mysql_stmt_init(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stmt_init((MYSQL *)$a_mysql)"
		end

	c_mysql_stmt_insert_id (a_stmt: POINTER): NATURAL_64
			-- Returns the ID generated for an AUTO_INCREMENT column by a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-insert-id.html
			-- my_ulonglong mysql_stmt_insert_id(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_stmt_insert_id((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_num_rows (a_stmt: POINTER): NATURAL_64
			-- Returns the row count from a buffered statement result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-num-rows.html
			-- my_ulonglong mysql_stmt_num_rows(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_64)mysql_stmt_num_rows((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_param_count (a_stmt: POINTER): NATURAL_32
			-- Returns the number of parameters in a prepared statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-param-count.html
			-- unsigned long mysql_stmt_param_count(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_stmt_param_count((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_param_metadata (a_stmt: POINTER): POINTER
			-- (Return parameter metadata in the form of a result set) Currently, this function does nothing
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-param-metadata.html
			-- MYSQL_RES *mysql_stmt_param_metadata(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stmt_param_metadata((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_prepare (a_stmt: POINTER; a_stmt_str: POINTER; a_length: NATURAL_32): INTEGER_32
			-- Prepares an SQL statement string for execution
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-prepare.html
			-- int mysql_stmt_prepare(MYSQL_STMT *stmt, const char *stmt_str, unsigned long length)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_stmt_prepare((MYSQL_STMT *)$a_stmt, (const char *)$a_stmt_str, (unsigned long)$a_length)"
		end

	c_mysql_stmt_reset (a_stmt: POINTER): INTEGER_8
			-- Resets the statement buffers in the server
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-reset.html
			-- my_bool mysql_stmt_reset(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_reset((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_result_metadata (a_stmt: POINTER): POINTER
			-- Returns prepared statement metadata in the form of a result set
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-result-metadata.html
			-- MYSQL_RES *mysql_stmt_result_metadata(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stmt_result_metadata((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_row_seek (a_stmt: POINTER; a_offset: POINTER; a_row_offset: POINTER)
			-- Seeks to a row offset in a statement result set, using value returned from mysql_stmt_row_tell()
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-row-seek.html
			-- MYSQL_ROW_OFFSET mysql_stmt_row_seek(MYSQL_STMT *stmt, MYSQL_ROW_OFFSET offset)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_ROW_OFFSET *)$a_row_offset) = mysql_stmt_row_seek((MYSQL_STMT *)$a_stmt, *(MYSQL_ROW_OFFSET *)$a_offset)"
		end

	c_mysql_stmt_row_tell (a_stmt: POINTER; a_row_offset: POINTER)
			-- Returns the statement row cursor position
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-row-tell.html
			-- MYSQL_ROW_OFFSET mysql_stmt_row_tell(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"(*(MYSQL_ROW_OFFSET *)$a_row_offset) = mysql_stmt_row_tell((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_send_long_data (a_stmt: POINTER; a_parameter_number: NATURAL_32; a_data: POINTER; a_length: NATURAL_32): INTEGER_8
			-- Sends long data in chunks to server
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-send-long-data.html
			-- my_bool mysql_stmt_send_long_data(MYSQL_STMT *stmt, unsigned int parameter_number, const char *data, unsigned long length)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_8)mysql_stmt_send_long_data((MYSQL_STMT *)$a_stmt, (unsigned int)$a_parameter_number, (const char *)$a_data, (unsigned long)$a_length)"
		end

	c_mysql_stmt_sqlstate (a_stmt: POINTER): POINTER
			-- Returns the SQLSTATE error code for the last statement execution
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-sqlstate.html
			-- const char *mysql_stmt_sqlstate(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_stmt_sqlstate((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_stmt_store_result (a_stmt: POINTER): INTEGER_32
			-- Retrieves a complete result set to the client
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-store-result.html
			-- int mysql_stmt_store_result(MYSQL_STMT *stmt)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER_32)mysql_stmt_store_result((MYSQL_STMT *)$a_stmt)"
		end

	c_mysql_store_result (a_mysql: POINTER): POINTER
			-- Retrieves a complete result set to the client
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-store-result.html
			-- MYSQL_RES *mysql_store_result(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_store_result((MYSQL *)$a_mysql)"
		end

	c_mysql_thread_id (a_mysql: POINTER): NATURAL_32
			-- Returns the current thread ID
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-thread-id.html
			-- unsigned long mysql_thread_id(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_thread_id((MYSQL *)$a_mysql)"
		end

	c_mysql_use_result (a_mysql: POINTER): POINTER
			-- Initiates a row-by-row result set retrieval
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-use-result.html
			-- MYSQL_RES *mysql_use_result(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)mysql_use_result((MYSQL *)$a_mysql)"
		end

	c_mysql_warning_count (a_mysql: POINTER): NATURAL_32
			-- Returns the warning count for the previous SQL statement
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-warning-count.html
			-- unsigned int mysql_warning_count(MYSQL *mysql)
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)mysql_warning_count((MYSQL *)$a_mysql)"
		end

feature{MYSQLI_EXTERNALS} -- Sizes of Structs

	size_of_mysql_field_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_FIELD)"
		end

	size_of_mysql_row_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_ROW)"
		end

	size_of_mysql_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL)"
		end

	size_of_mysql_res_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_RES)"
		end

	size_of_mysql_stmt_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_STMT)"
		end

	size_of_mysql_field_offset_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_FIELD_OFFSET)"
		end

	size_of_mysql_bind_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_BIND)"
		ensure
			is_class: class
		end

	size_of_mysql_time_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_TIME)"
		end

	size_of_mysql_row_offset_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MYSQL_ROW_OFFSET)"
		end

	size_of_my_charset_info_struct: INTEGER
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)sizeof(MY_CHARSET_INFO)"
		end

feature{MYSQLI_EXTERNALS} -- Constants

	NOT_NULL_FLAG: INTEGER
			-- Field can't be NULL
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"NOT_NULL_FLAG"
		end

	PRI_KEY_FLAG: INTEGER
			-- Field is part of a primary key
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"PRI_KEY_FLAG"
		end

	UNIQUE_KEY_FLAG: INTEGER
			-- Field is part of a unique key
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"UNIQUE_KEY_FLAG"
		end

	MULTIPLE_KEY_FLAG: INTEGER
			-- Field is part of a nonunique key
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MULTIPLE_KEY_FLAG"
		end

	UNSIGNED_FLAG: INTEGER
			-- Field has the UNSIGNED attribute
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"UNSIGNED_FLAG"
		end

	ZEROFILL_FLAG: INTEGER
			-- Field has the ZEROFILL attribute
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"ZEROFILL_FLAG"
		end

	BINARY_FLAG: INTEGER
			-- Field has the BINARY attribute
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"BINARY_FLAG"
		end

	AUTO_INCREMENT_FLAG: INTEGER
			-- Field has the AUTO_INCREMENT attribute
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"AUTO_INCREMENT_FLAG"
		end

	NUM_FLAG: INTEGER
			-- Field is numeric
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"NUM_FLAG"
		end

	ENUM_FLAG: INTEGER
			-- Field is an ENUM (deprecated)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"ENUM_FLAG"
		end

	SET_FLAG: INTEGER
			-- Field is a SET (deprecated)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"SET_FLAG"
		end

	BLOB_FLAG: INTEGER
			-- Field is a BLOB or TEXT (deprecated)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"BLOB_FLAG"
		end

	TIMESTAMP_FLAG: INTEGER
			-- Field is a TIMESTAMP (deprecated)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"TIMESTAMP_FLAG"
		end

	NO_DEFAULT_VALUE_FLAG: INTEGER
			-- Field has no default value; see additional notes following table
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"NO_DEFAULT_VALUE_FLAG"
		end

	MYSQL_TYPE_TINY: INTEGER
			-- TINYINT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_TINY"
		end

	MYSQL_TYPE_SHORT: INTEGER
			-- SMALLINT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_SHORT"
		end

	MYSQL_TYPE_LONG: INTEGER
			-- INTEGER field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_LONG"
		end

	MYSQL_TYPE_INT24: INTEGER
			-- MEDIUMINT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_INT24"
		end

	MYSQL_TYPE_LONGLONG: INTEGER
			-- BIGINT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_LONGLONG"
		end

	MYSQL_TYPE_DECIMAL: INTEGER
			-- DECIMAL or NUMERIC field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_DECIMAL"
		end

	MYSQL_TYPE_NEWDECIMAL: INTEGER
			-- Precision math DECIMAL or NUMERIC
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_NEWDECIMAL"
		end

	MYSQL_TYPE_FLOAT: INTEGER
			-- FLOAT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_FLOAT"
		end

	MYSQL_TYPE_DOUBLE: INTEGER
			-- DOUBLE or REAL field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_DOUBLE"
		end

	MYSQL_TYPE_BIT: INTEGER
			-- BIT field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_BIT"
		end

	MYSQL_TYPE_TIMESTAMP: INTEGER
			-- TIMESTAMP field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_TIMESTAMP"
		end

	MYSQL_TYPE_DATE: INTEGER
			-- DATE field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_DATE"
		end

	MYSQL_TYPE_TIME: INTEGER
			-- TIME field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_TIME"
		end

	MYSQL_TYPE_DATETIME: INTEGER
			-- DATETIME field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_DATETIME"
		end

	MYSQL_TYPE_YEAR: INTEGER
			-- YEAR field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_YEAR"
		end

	MYSQL_TYPE_STRING: INTEGER
			-- CHAR or BINARY field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_STRING"
		end

	MYSQL_TYPE_VAR_STRING: INTEGER
			-- VARCHAR or VARBINARY field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_VAR_STRING"
		end

	MYSQL_TYPE_BLOB: INTEGER
			-- BLOB or TEXT field (use max_length to determine the maximum length)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_BLOB"
		end

	MYSQL_TYPE_SET: INTEGER
			-- SET field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_SET"
		end

	MYSQL_TYPE_ENUM: INTEGER
			-- ENUM field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_ENUM"
		end

	MYSQL_TYPE_GEOMETRY: INTEGER
			-- Spatial field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_GEOMETRY"
		end

	MYSQL_TYPE_NULL: INTEGER
			-- NULL-type field
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_TYPE_NULL"
		end

	CLIENT_COMPRESS: INTEGER
			-- Use compression protocol.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_COMPRESS"
		end

	CLIENT_FOUND_ROWS: INTEGER
			-- Return the number of found (matched) rows, not the number of changed rows.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_FOUND_ROWS"
		end

	CLIENT_IGNORE_SIGPIPE: INTEGER
			-- Prevents the client library from installing a SIGPIPE signal handler. This can be used to avoid conflicts with a handler that the application has already installed.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_IGNORE_SIGPIPE"
		end

	CLIENT_IGNORE_SPACE: INTEGER
			-- Permit spaces after function names. Makes all functions names reserved words.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_IGNORE_SPACE"
		end

	CLIENT_INTERACTIVE: INTEGER
			-- Permit interactive_timeout seconds (instead of wait_timeout seconds) of inactivity before closing the connection. The client's session wait_timeout variable is set to the value of the session interactive_timeout variable.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_INTERACTIVE"
		end

	CLIENT_LOCAL_FILES: INTEGER
			-- Enable LOAD DATA LOCAL handling.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_LOCAL_FILES"
		end

	CLIENT_MULTI_RESULTS: INTEGER
			-- Tell the server that the client can handle multiple result sets from multiple-statement executions or stored procedures. This flag is automatically enabled if CLIENT_MULTI_STATEMENTS is enabled. See the note following this table for more information about this flag.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_MULTI_RESULTS"
		end

	CLIENT_MULTI_STATEMENTS: INTEGER
			-- Tell the server that the client may send multiple statements in a single string (separated by ";"). If this flag is not set, multiple-statement execution is disabled. See the note following this table for more information about this flag.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_MULTI_STATEMENTS"
		end

	CLIENT_NO_SCHEMA: INTEGER
			-- Do not permit the db_name.tbl_name.col_name syntax. This is for ODBC. It causes the parser to generate an error if you use that syntax, which is useful for trapping bugs in some ODBC programs.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_NO_SCHEMA"
		end

	CLIENT_ODBC: INTEGER
			-- Unused.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_ODBC"
		end

	CLIENT_SSL: INTEGER
			-- Use SSL (encrypted protocol). This option should not be set by application programs; it is set internally in the client library. Instead, use mysql_ssl_set() before calling mysql_real_connect().
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_SSL"
		end

	CLIENT_REMEMBER_OPTIONS: INTEGER
			-- Remember options specified by calls to mysql_options(). Without this option, if mysql_real_connect() fails, you must repeat the mysql_options() calls before trying to connect again. With this option, the mysql_options() calls need not be repeated.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"CLIENT_REMEMBER_OPTIONS"
		end

	STMT_ATTR_UPDATE_MAX_LENGTH: INTEGER
			-- If set to 1, causes mysql_stmt_store_result() to update the metadata MYSQL_FIELD->max_length value.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"STMT_ATTR_UPDATE_MAX_LENGTH"
		end

	STMT_ATTR_CURSOR_TYPE: INTEGER
			-- Type of cursor to open for statement when mysql_stmt_execute() is invoked. *arg can be CURSOR_TYPE_NO_CURSOR (the default) or CURSOR_TYPE_READ_ONLY.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"STMT_ATTR_CURSOR_TYPE"
		end

	STMT_ATTR_PREFETCH_ROWS: INTEGER
			-- Number of rows to fetch from server at a time when using a cursor. *arg can be in the range from 1 to the maximum value of unsigned long. The default is 1.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"STMT_ATTR_PREFETCH_ROWS"
		end

	MYSQL_OPT_RECONNECT: INTEGER
			-- Enable or disable automatic reconnection to the server if the connection is found to have been lost. Reconnect is off by default; this option provides a way to set reconnection behavior explicitly.
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C macro use %"mysql.h%""
		alias
			"MYSQL_OPT_RECONNECT"
		end

feature{MYSQLI_EXTERNALS} -- Checks

	c_is_not_null (a_flag: INTEGER): INTEGER
			-- True if this field is defined as NOT NULL
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)IS_NOT_NULL((int)$a_flag)"
		end

	c_is_pri_key (a_flag: INTEGER): INTEGER
			-- True if this field is a primary key
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)IS_PRI_KEY((int)$a_flag)"
		end

	c_is_blob (a_flag: INTEGER): INTEGER
			-- True if this field is a BLOB or TEXT (deprecated; test field->type instead)
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)IS_BLOB((int)$a_flag)"
		end

	c_is_num (a_flag: INTEGER): INTEGER
			-- True if the field is numeric
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-data-structures.html
			-- http://dev.mysql.com/doc/refman/5.1/en/c-api-prepared-statement-data-structures.html
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_INTEGER)IS_NUM((int)$a_flag)"
		end

feature{MYSQLI_EXTERNALS} -- Struct: MYSQL_FIELD

	c_struct_mysql_field_name (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"name"
		end

	c_struct_mysql_field_set_name (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"name"
		end

	c_struct_mysql_field_org_name (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"org_name"
		end

	c_struct_mysql_field_set_org_name (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"org_name"
		end

	c_struct_mysql_field_table (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"table"
		end

	c_struct_mysql_field_set_table (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"table"
		end

	c_struct_mysql_field_org_table (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"org_table"
		end

	c_struct_mysql_field_set_org_table (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"org_table"
		end

	c_struct_mysql_field_db (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"db"
		end

	c_struct_mysql_field_set_db (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"db"
		end

	c_struct_mysql_field_catalog (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"catalog"
		end

	c_struct_mysql_field_set_catalog (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"catalog"
		end

	c_struct_mysql_field_def (a_field: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): POINTER"
		alias
			"def"
		end

	c_struct_mysql_field_set_def (a_field: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, char *)"
		alias
			"def"
		end

	c_struct_mysql_field_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"length"
		end

	c_struct_mysql_field_set_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned long)"
		alias
			"length"
		end

	c_struct_mysql_field_max_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"max_length"
		end

	c_struct_mysql_field_set_max_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned long)"
		alias
			"max_length"
		end

	c_struct_mysql_field_name_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"name_length"
		end

	c_struct_mysql_field_set_name_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"name_length"
		end

	c_struct_mysql_field_org_name_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"org_name_length"
		end

	c_struct_mysql_field_set_org_name_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"org_name_length"
		end

	c_struct_mysql_field_table_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"table_length"
		end

	c_struct_mysql_field_set_table_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"table_length"
		end

	c_struct_mysql_field_org_table_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"org_table_length"
		end

	c_struct_mysql_field_set_org_table_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"org_table_length"
		end

	c_struct_mysql_field_db_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"db_length"
		end

	c_struct_mysql_field_set_db_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"db_length"
		end

	c_struct_mysql_field_catalog_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"catalog_length"
		end

	c_struct_mysql_field_set_catalog_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"catalog_length"
		end

	c_struct_mysql_field_def_length (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"def_length"
		end

	c_struct_mysql_field_set_def_length (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"def_length"
		end

	c_struct_mysql_field_flags (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"flags"
		end

	c_struct_mysql_field_set_flags (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"flags"
		end

	c_struct_mysql_field_decimals (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"decimals"
		end

	c_struct_mysql_field_set_decimals (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"decimals"
		end

	c_struct_mysql_field_charsetnr (a_field: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): NATURAL_32"
		alias
			"charsetnr"
		end

	c_struct_mysql_field_set_charsetnr (a_field: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, unsigned int)"
		alias
			"charsetnr"
		end

	c_struct_mysql_field_type (a_field: POINTER): INTEGER_32
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD): INTEGER_32"
		alias
			"type"
		end

	c_struct_mysql_field_set_type (a_field: POINTER; a_value: INTEGER_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_FIELD, enum enum_field_types)"
		alias
			"type"
		end

feature{MYSQLI_EXTERNALS} -- Struct: MYSQL_BIND

	c_struct_mysql_bind_buffer_type (a_bind: POINTER): INTEGER_32
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): INTEGER_32"
		alias
			"buffer_type"
		end

	c_struct_mysql_bind_set_buffer_type (a_bind: POINTER; a_value: INTEGER_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, enum enum_field_types)"
		alias
			"buffer_type"
		end

	c_struct_mysql_bind_buffer (a_bind: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): POINTER"
		alias
			"buffer"
		end

	c_struct_mysql_bind_set_buffer (a_bind: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, void *)"
		alias
			"buffer"
		end

	c_struct_mysql_bind_buffer_length (a_bind: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): NATURAL_32"
		alias
			"buffer_length"
		end

	c_struct_mysql_bind_set_buffer_length (a_bind: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, unsigned long)"
		alias
			"buffer_length"
		end

	c_struct_mysql_bind_length (a_bind: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): POINTER"
		alias
			"length"
		end

	c_struct_mysql_bind_set_length (a_bind: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, unsigned long *)"
		alias
			"length"
		end

	c_struct_mysql_bind_is_null (a_bind: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): POINTER"
		alias
			"is_null"
		end

	c_struct_mysql_bind_set_is_null (a_bind: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, my_bool *)"
		alias
			"is_null"
		end

	c_struct_mysql_bind_is_unsigned (a_bind: POINTER): INTEGER_8
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): INTEGER_8"
		alias
			"is_unsigned"
		end

	c_struct_mysql_bind_set_is_unsigned (a_bind: POINTER; a_value: INTEGER_8)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, my_bool)"
		alias
			"is_unsigned"
		end

	c_struct_mysql_bind_error (a_bind: POINTER): POINTER
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND): POINTER"
		alias
			"error"
		end

	c_struct_mysql_bind_set_error (a_bind: POINTER; a_value: POINTER)
		external
			"C [struct %"mysql.h%"] (MYSQL_BIND, my_bool *)"
		alias
			"error"
		end

feature{MYSQLI_EXTERNALS} -- Struct: MYSQL_TIME

	c_struct_mysql_time_year (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"year"
		end

	c_struct_mysql_time_set_year (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"year"
		end

	c_struct_mysql_time_month (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"month"
		end

	c_struct_mysql_time_set_month (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"month"
		end

	c_struct_mysql_time_day (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"day"
		end

	c_struct_mysql_time_set_day (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"day"
		end

	c_struct_mysql_time_hour (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"hour"
		end

	c_struct_mysql_time_set_hour (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"hour"
		end

	c_struct_mysql_time_minute (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"minute"
		end

	c_struct_mysql_time_set_minute (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"minute"
		end

	c_struct_mysql_time_second (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"second"
		end

	c_struct_mysql_time_set_second (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned int)"
		alias
			"second"
		end

	c_struct_mysql_time_neg (a_time: POINTER): INTEGER_8
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): INTEGER_8"
		alias
			"neg"
		end

	c_struct_mysql_time_set_neg (a_time: POINTER; a_value: INTEGER_8)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, my_bool)"
		alias
			"neg"
		end

	c_struct_mysql_time_second_part (a_time: POINTER): NATURAL_32
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME): NATURAL_32"
		alias
			"second_part"
		end

	c_struct_mysql_time_set_second_part (a_time: POINTER; a_value: NATURAL_32)
		external
			"C [struct %"mysql.h%"] (MYSQL_TIME, unsigned long)"
		alias
			"second_part"
		end

feature{MYSQLI_EXTERNALS} -- Client Error Codes

	c_error_code_to_message (a_code: INTEGER): STRING
			-- Client Error Codes and Messages
			-- http://dev.mysql.com/doc/refman/5.5/en/error-messages-client.html
		do
			inspect
				a_code
			when 2000 then
				-- Unknown MySQL error
				Result := "CR_UNKNOWN_ERROR"
			when 2001 then
				-- Can't create UNIX socket (%d)
				Result := "CR_SOCKET_CREATE_ERROR"
			when 2002 then
				-- Can't connect to local MySQL server through socket '%s' (%d)
				Result := "CR_CONNECTION_ERROR"
			when 2003 then
				-- Can't connect to MySQL server on '%s' (%d)
				Result := "CR_CONN_HOST_ERROR"
			when 2004 then
				-- Can't create TCP/IP socket (%d)
				Result := "CR_IPSOCK_ERROR"
			when 2005 then
				-- Unknown MySQL server host '%s' (%d)
				Result := "CR_UNKNOWN_HOST"
			when 2006 then
				-- MySQL server has gone away
				Result := "CR_SERVER_GONE_ERROR"
			when 2007 then
				-- Protocol mismatch; server version = %d, client version = %d
				Result := "CR_VERSION_ERROR"
			when 2008 then
				-- MySQL client ran out of memory
				Result := "CR_OUT_OF_MEMORY"
			when 2009 then
				-- Wrong host info
				Result := "CR_WRONG_HOST_INFO"
			when 2010 then
				-- Localhost via UNIX socket
				Result := "CR_LOCALHOST_CONNECTION"
			when 2011 then
				-- %s via TCP/IP
				Result := "CR_TCP_CONNECTION"
			when 2012 then
				-- Error in server handshake
				Result := "CR_SERVER_HANDSHAKE_ERR"
			when 2013 then
				-- Lost connection to MySQL server during query
				Result := "CR_SERVER_LOST"
			when 2014 then
				-- Commands out of sync; you can't run this command now
				Result := "CR_COMMANDS_OUT_OF_SYNC"
			when 2015 then
				-- Named pipe: %s
				Result := "CR_NAMEDPIPE_CONNECTION"
			when 2016 then
				-- Can't wait for named pipe to host: %s pipe: %s (%lu)
				Result := "CR_NAMEDPIPEWAIT_ERROR"
			when 2017 then
				-- Can't open named pipe to host: %s pipe: %s (%lu)
				Result := "CR_NAMEDPIPEOPEN_ERROR"
			when 2018 then
				-- Can't set state of named pipe to host: %s pipe: %s (%lu)
				Result := "CR_NAMEDPIPESETSTATE_ERROR"
			when 2019 then
				-- Can't initialize character set %s (path: %s)
				Result := "CR_CANT_READ_CHARSET"
			when 2020 then
				-- Got packet bigger than 'max_allowed_packet' bytes
				Result := "CR_NET_PACKET_TOO_LARGE"
			when 2021 then
				-- Embedded server
				Result := "CR_EMBEDDED_CONNECTION"
			when 2022 then
				-- Error on SHOW SLAVE STATUS:
				Result := "CR_PROBE_SLAVE_STATUS"
			when 2023 then
				-- Error on SHOW SLAVE HOSTS:
				Result := "CR_PROBE_SLAVE_HOSTS"
			when 2024 then
				-- Error connecting to slave:
				Result := "CR_PROBE_SLAVE_CONNECT"
			when 2025 then
				-- Error connecting to master:
				Result := "CR_PROBE_MASTER_CONNECT"
			when 2026 then
				-- SSL connection error
				Result := "CR_SSL_CONNECTION_ERROR"
			when 2027 then
				-- Malformed packet
				Result := "CR_MALFORMED_PACKET"
			when 2028 then
				-- This client library is licensed only for use with MySQL servers having '%s' license
				Result := "CR_WRONG_LICENSE"
			when 2029 then
				-- Invalid use of null pointer
				Result := "CR_NULL_POINTER"
			when 2030 then
				-- Statement not prepared
				Result := "CR_NO_PREPARE_STMT"
			when 2031 then
				-- No data supplied for parameters in prepared statement
				Result := "CR_PARAMS_NOT_BOUND"
			when 2032 then
				-- Data truncated
				Result := "CR_DATA_TRUNCATED"
			when 2033 then
				-- No parameters exist in the statement
				Result := "CR_NO_PARAMETERS_EXISTS"
			when 2034 then
				-- Invalid parameter number
				Result := "CR_INVALID_PARAMETER_NO"
			when 2035 then
				-- Can't send long data for non-string/non-binary data types (parameter: %d)
				Result := "CR_INVALID_BUFFER_USE"
			when 2036 then
				-- Using unsupported buffer type: %d (parameter: %d)
				Result := "CR_UNSUPPORTED_PARAM_TYPE"
			when 2037 then
				-- Shared memory: %s
				Result := "CR_SHARED_MEMORY_CONNECTION"
			when 2038 then
				-- Can't open shared memory; client could not create request event (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_REQUEST_ERROR"
			when 2039 then
				-- Can't open shared memory; no answer event received from server (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_ANSWER_ERROR"
			when 2040 then
				-- Can't open shared memory; server could not allocate file mapping (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_FILE_MAP_ERROR"
			when 2041 then
				-- Can't open shared memory; server could not get pointer to file mapping (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_MAP_ERROR"
			when 2042 then
				-- Can't open shared memory; client could not allocate file mapping (%lu)
				Result := "CR_SHARED_MEMORY_FILE_MAP_ERROR"
			when 2043 then
				-- Can't open shared memory; client could not get pointer to file mapping (%lu)
				Result := "CR_SHARED_MEMORY_MAP_ERROR"
			when 2044 then
				-- Can't open shared memory; client could not create %s event (%lu)
				Result := "CR_SHARED_MEMORY_EVENT_ERROR"
			when 2045 then
				-- Can't open shared memory; no answer from server (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_ABANDONED_ERROR"
			when 2046 then
				-- Can't open shared memory; cannot send request event to server (%lu)
				Result := "CR_SHARED_MEMORY_CONNECT_SET_ERROR"
			when 2047 then
				-- Wrong or unknown protocol
				Result := "CR_CONN_UNKNOW_PROTOCOL"
			when 2048 then
				-- Invalid connection handle
				Result := "CR_INVALID_CONN_HANDLE"
			when 2049 then
				-- Connection using old (pre-4.1.1) authentication protocol refused (client option 'secure_auth' enabled)
				Result := "CR_SECURE_AUTH"
			when 2050 then
				-- Row retrieval was canceled by mysql_stmt_close() call
				Result := "CR_FETCH_CANCELED"
			when 2051 then
				-- Attempt to read column without prior row fetch
				Result := "CR_NO_DATA"
			when 2052 then
				-- Prepared statement contains no metadata
				Result := "CR_NO_STMT_METADATA"
			when 2053 then
				-- Attempt to read a row while there is no result set associated with the statement
				Result := "CR_NO_RESULT_SET"
			when 2054 then
				-- This feature is not implemented yet
				Result := "CR_NOT_IMPLEMENTED"
			when 2055 then
				-- Lost connection to MySQL server at '%s', system error: %d
				Result := "CR_SERVER_LOST_EXTENDED"
			when 2056 then
				-- Statement closed indirectly because of a preceeding %s() call
				Result := "CR_STMT_CLOSED"
			when 2057 then
				-- The number of columns in the result set differs from the number of bound buffers. You must reset the statement, rebind the result set columns, and execute the statement again
				Result := "CR_NEW_STMT_METADATA"
			when 2058 then
				-- This handle is already connected. Use a separate handle for each connection.
				Result := "CR_ALREADY_CONNECTED"
			when 2059 then
				-- Authentication plugin '%s' cannot be loaded: %s
				Result := "CR_AUTH_PLUGIN_CANNOT_LOAD"
			else
				-- Not a valid MySQL error code
				Result := "UNKNOWN_ERROR"
			end
		end

feature{MYSQLI_EXTERNALS} -- Helpers

	c_array_mysql_row_at (a_row: POINTER; a_offset: INTEGER_32): POINTER
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)((*(MYSQL_ROW *)$a_row)[(int)$a_offset])"
		end

	c_array_mysql_field_at (a_field_array: POINTER; a_offset: INTEGER_32): POINTER
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)&(((MYSQL_FIELD *)$a_field_array)[(int)$a_offset])"
		end

	c_array_mysql_bind_at (a_bind_array: POINTER; a_offset: INTEGER_32): POINTER
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_POINTER)&(((MYSQL_BIND *)$a_bind_array)[(int)$a_offset])"
		end

	c_array_unsigned_long_at (a_array: POINTER; a_offset: INTEGER_32): NATURAL_32
		external
			"C inline use %"mysql.h%""
		alias
			"return (EIF_NATURAL_32)(((unsigned long *)$a_array)[(int)$a_offset])"
		end

end
