note
	description: "MYSQLI Client Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_CLIENT

inherit
	MYSQLI_EXTERNALS
	EXCEPTIONS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize client
		local
			l_return_pointer: POINTER
		do
			-- Default values
			set_settings_from_tuple (default_settings_as_tuple)

			-- Setup client
			create client.make
			l_return_pointer := c_mysql_init (client.item)
			if l_return_pointer /= client.item then
				raise ("MYSQLI_CLIENT.make: c_mysql_init failed")
			end

			-- Last values
			create last_result.make_empty
			create last_results.make
			last_prepared_statement := Void
			create last_client_error_message.make_empty

			-- Reconnect bit creation
			create reconnect_bit.make (1)
		end

feature -- Connection

	host: detachable STRING
			-- Host name of the database server, default: "127.0.0.1", can be Void.

	username: detachable STRING
			-- User name used to connect to the database server, default: "root", can be Void.

	password: detachable STRING
			-- Password used to connect to the database server, default: empty, can be Void.

	database: detachable STRING
			-- Name of the database, default: "test", can be Void.

	port: INTEGER
			-- Port of database server, default: 3306.

	unix_socket: detachable STRING
			-- Name of Unix socket, default: Void, can be Void.

	flags: INTEGER
			-- Connection flags, default: 0 | CLIENT_MULTI_STATEMENTS.

	set_host (a_host: like host)
			-- Set `hostname' to `a_host'. `a_host' can be Void.
		do
			host := a_host
		end

	set_username (a_username: like username)
			-- Set `username' to `a_username'. `a_username' can be Void.
		do
			username := a_username
		end

	set_password (a_password: like password)
			-- Set `password' to `a_password'. `a_password' can be Void.
		do
			password := a_password
		end

	set_database (a_database: like database)
			-- Set `database' to `a_database'. `a_database' can be Void.
		do
			database := a_database
		end

	set_port (a_port: like port)
			-- Set `port' to `a_port'.
		do
			port := a_port
		end

	set_unix_socket (a_unix_socket: like unix_socket)
			-- Set `unix_socket' to `a_unix_socket'. `a_unix_socket' can be Void.
		do
			unix_socket := a_unix_socket
		end

	connect
			-- Connects to a MySQL server at `host':`port' with
			-- `username' and `password'. Selects `database' if not empty or Void.
			-- Use Unix socket `unix_socket' if not Void.
			-- Use `flags'.
		local
			l_retried: BOOLEAN
			l_host_pointer, l_user_pointer, l_password_pointer, l_database_pointer, l_unix_socket_pointer: ANY
			l_return_pointer: POINTER
			l_return_value: INTEGER_32
		do
			if not l_retried then
				if attached host as l_host then
					l_host_pointer := l_host.to_c
				else
					create l_host_pointer
				end
				if attached username as l_username then
					l_user_pointer := l_username.to_c
				else
					create l_user_pointer
				end
				if attached password as l_password then
					l_password_pointer := l_password.to_c
				else
					create l_password_pointer
				end
				if attached database as l_database then
					l_database_pointer := l_database.to_c
				else
					create l_database_pointer
				end
				if attached unix_socket as l_unix_socket then
					l_unix_socket_pointer := l_unix_socket.to_c
				else
					create l_unix_socket_pointer
				end


				reconnect_bit.put_integer_8 (-1, 0)
				l_return_value := c_mysql_options (client.item, MYSQL_OPT_RECONNECT, reconnect_bit.item)
				if l_return_value /= 0 then
					raise ("MYSQLI_CLIENT.connect: c_mysql_options failed")
				end
				l_return_pointer := c_mysql_real_connect (client.item, $l_host_pointer, $l_user_pointer, $l_password_pointer, $l_database_pointer, port.as_natural_32, $l_unix_socket_pointer, flags.as_natural_32)
				if l_return_pointer /= client.item then
					raise ("MYSQLI_CLIENT.connect: c_mysql_real_connect failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

feature -- Flags

	set_flag_autocommit (a_flag: BOOLEAN)
			-- Sets autocommit mode on if `a_flag' is True, off if `a_flag' is False.
		local
			l_retried: BOOLEAN
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_return_value := c_mysql_autocommit (client.item, a_flag.to_integer.to_integer_8)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.set_flag_autocommit: c_mysql_autocommit failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	set_flag_client_compress (a_flag: BOOLEAN)
			-- Use compression protocol. Must be set before call to `connect'.
		do
			flags := flags | CLIENT_COMPRESS
			if not a_flag then
				flags := flags - CLIENT_COMPRESS
			end
		end

	set_flag_multi_statements (a_flag: BOOLEAN)
			-- Tell the server that the client may send multiple statements in a single string (separated by ";")
			-- Must be set before call to `connect'. True by default.
		do
			flags := flags | CLIENT_MULTI_STATEMENTS
			if not a_flag then
				flags := flags - CLIENT_MULTI_STATEMENTS
			end
		end

feature -- Settings

	settings_as_tuple: TUPLE [host, username, password, database, unix_socket: detachable STRING; port, flags: INTEGER]
			-- Settings for this client in a convenient tuple.
		do
			create Result
			Result.host := host
			Result.username := username
			Result.password := password
			Result.database := database
			Result.unix_socket := unix_socket
			Result.port := port
			Result.flags := flags
		end

	set_settings_from_tuple (a_tuple: attached like settings_as_tuple)
			-- Set settings for this client from `a_tuple'.
		do
			host := a_tuple.host
			username := a_tuple.username
			password := a_tuple.password
			database := a_tuple.database
			unix_socket := a_tuple.unix_socket
			port := a_tuple.port
			flags := a_tuple.flags
		end

	default_settings_as_tuple: like settings_as_tuple
			-- Default settings in a convenient tuple.
		do
			create Result
			Result.host := once "127.0.0.1"
			Result.username := once "root"
			Result.password := once ""
			Result.database := once "test"
			Result.unix_socket := Void
			Result.port := 3306
			Result.flags := 0 | CLIENT_MULTI_STATEMENTS
		end

feature -- Access (Errors)

	has_error: BOOLEAN
			-- Indicates if an error occured during the last operation
		do
			Result := has_client_error or has_server_error
		end

	last_error_message: STRING
			-- Last occured error, server or client
		do
			if has_server_error then
				Result := last_server_error_message
			else
				Result := last_client_error_message
			end
		end

	has_server_error: BOOLEAN
			-- Indicates if a server error occured during the last operation
		do
			Result := last_server_error_number /= 0
		end

	last_server_error_message: STRING
			-- Last occured server error
		do
			create Result.make_from_c (c_mysql_error (client.item))
		end

	last_server_error_number: INTEGER
			-- Last occured server error number
		do
			Result := c_mysql_errno (client.item).to_integer_32
		end

	last_sqlstate: STRING
			-- Last SQLState error code
		do
			create Result.make_from_c (c_mysql_sqlstate(client.item))
		end

	has_client_error: BOOLEAN
			-- Indicates if a client error occured during the last operation
		do
			if attached last_client_error_message as l_message then
				if not l_message.is_empty then
					Result := True
				end
			end
		end

	last_client_error_message: STRING
			-- Last occured client error

	last_client_error_number: INTEGER
			-- Last occured client error number

feature -- Access (Info)

	server_info: STRING
			-- Server version number as a string
		local
			l_return_pointer: POINTER
		do
			l_return_pointer := c_mysql_get_server_info (client.item)
			if l_return_pointer.to_integer_32 = 0 then
				create Result.make_empty
			else
				create Result.make_from_c (l_return_pointer)
			end
		end

	server_version: INTEGER
			-- Server version number
		do
			Result := c_mysql_get_server_version (client.item).to_integer_32
		end

	client_info: STRING
			-- Client version number as a string
		local
			l_return_pointer: POINTER
		do
			l_return_pointer := c_mysql_get_client_info
			if l_return_pointer.to_integer_32 = 0 then
				create Result.make_empty
			else
				create Result.make_from_c (l_return_pointer)
			end
		end

	client_version: INTEGER
			-- Client version number
		do
			Result := c_mysql_get_client_version.to_integer_32
		end

	host_info: STRING
			-- Server host name and the connection type.
		local
			l_return_pointer: POINTER
		do
			l_return_pointer := c_mysql_get_host_info (client.item)
			if l_return_pointer.to_integer_32 = 0 then
				create Result.make_empty
			else
				create Result.make_from_c (l_return_pointer)
			end
		end

	protocol_info: INTEGER
			-- Protocol version used by the current connection.
		do
			Result := c_mysql_get_proto_info (client.item).to_integer_32
		end

	status: STRING
			-- Information about uptime in seconds and the number of running threads, questions, reloads, and open tables.
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stat.html
		local
			l_return_pointer: POINTER
		do
			l_return_pointer := c_mysql_stat (client.item)
			if l_return_pointer.to_integer_32 = 0 then
				create Result.make_empty
			else
				create Result.make_from_c (l_return_pointer)
			end
		end

feature -- Transactions

	commit
			-- Commits the current transaction.
		local
			l_retried: BOOLEAN
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_return_value := c_mysql_commit (client.item)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.commit: c_mysql_commit failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	rollback
			-- Rolls back the current transaction.
		local
			l_retried: BOOLEAN
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_return_value := c_mysql_rollback (client.item)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.rollback: c_mysql_rollback failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

feature -- Helpers

	to_hex_string (a_string: STRING): STRING
			-- This function is used to create a legal SQL string that you can use in an SQL statement.
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-hex-string.html
		local
			l_return: MANAGED_POINTER
			l_return_value: NATURAL_64
		do
			create l_return.make (2 * a_string.count + 1)
			l_return_value := c_mysql_hex_string (l_return.item, a_string.area.base_address, a_string.count.to_natural_32)
			create Result.make (l_return_value.as_integer_32)
			Result.from_c_substring (l_return.item, 1, l_return_value.as_integer_32)
		end

	to_escaped_string (a_string: STRING): STRING
			-- This function is used to create a legal SQL string that you can use in an SQL statement.
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-real-escape-string.html
		local
			l_return: MANAGED_POINTER
			l_return_value: NATURAL_64
		do
			create l_return.make (2 * a_string.count + 1)
			l_return_value := c_mysql_real_escape_string (client.item, l_return.item, a_string.area.base_address, a_string.count.to_natural_32)
			create Result.make (l_return_value.as_integer_32)
			Result.from_c_substring (l_return.item, 1, l_return_value.as_integer_32)
		end

feature -- Commands

	ping
			-- Checks whether the connection to the server is working.
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-ping.html
		local
			l_retried: BOOLEAN
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_return_value := c_mysql_ping (client.item)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.ping: c_mysql_ping failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	select_database (a_database: STRING)
			-- Causes `a_database' to become the default (current) database for the current connection
		local
			l_retried: BOOLEAN
			l_database_pointer: ANY
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_database_pointer := a_database.to_c
				l_return_value := c_mysql_select_db (client.item, $l_database_pointer)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.select_database: c_mysql_select_db failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end
			l_retried := True
			retry
		end

	set_character_set (a_character_set: STRING)
			-- Set `a_character_set' to become the  default character set for the current connection
		local
			l_retried: BOOLEAN
			l_character_set_pointer: ANY
			l_return_value: INTEGER_32
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				l_character_set_pointer := a_character_set.to_c
				l_return_value := c_mysql_set_character_set (client.item, $l_character_set_pointer)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_CLIENT.set_character_set: c_mysql_set_character_set failed")
				end
			end
		rescue
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	execute_query (a_query: STRING)
			-- Executes `a_query'.
			-- The result set is always available in `last_result'.
			-- Multiple result sets are made available in `last_results'.
			-- If an error occurred `has_error' will be True and `last_error_message' will contain the error message.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				internal_execute_query (a_query)
			end
		rescue
			-- Reset
			-- Commented the following to compile in void safe mode
			--last_result := Void
			create last_results.make
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	prepare_statement (a_statement: STRING)
			-- Prepares the statement in `a_statement'.
			-- The prepared statement is available in `last_prepared_statement' if the call is successful.
			-- If an error occurred `has_error' will be True and `last_error_message' will contain the error message.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				internal_prepare_statement (a_statement)
			end
		rescue
			-- Reset
			last_prepared_statement := Void
			if attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end

			l_retried := True
			retry
		end

	close
			-- Closes the server connection.
		do
			if client.item.to_integer_32 /= 0 then
				c_mysql_close (client.item)
			end
		end

feature -- Access (Results)

	last_result: MYSQLI_RESULT
			-- The last result set created by the last call to `execute_query'

	last_results: LINKED_LIST [MYSQLI_RESULT]
			-- The result sets created by the last call to `execute_query'

	last_prepared_statement: detachable MYSQLI_PREPARED_STATEMENT
			-- The prepared statement created by the last call to `prepare_statement'

feature{MYSQLI_EXTERNALS} -- Internal

	client: MYSQLI_INTERNAL_CLIENT
			-- Memory structure for internal client

	reconnect_bit: MANAGED_POINTER
			-- Holds the True flag for MYSQLI_OPT_RECONNECT


feature{NONE} -- Implementation

	internal_execute_query (a_query: STRING)
			-- Execute `a_query'
		local
			l_query_pointer: ANY
			l_next_result: INTEGER_64
			l_return_value: INTEGER_32
		do
			-- Ping the server to initiate a re-connect, if necessary
			-- See: http://dev.mysql.com/doc/refman/5.0/en/auto-reconnect.html
			l_return_value := c_mysql_ping (client.item)

			-- Reset `last_result' and `last_results'
			create last_result.make_empty
			create last_results.make

			-- Execute `a_query'
			l_query_pointer := a_query.to_c
			l_return_value := c_mysql_query (client.item, $l_query_pointer)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_CLIENT.execute_query: c_mysql_query failed")
			end

			-- Handling multi-result sets from multiple-statement executions or stored procedures
			from
				l_next_result := 0
			until
				l_next_result = -1
			loop
				-- Reset `last_result'
				create last_result.make_empty

				-- Handle this result
				internal_handle_result

				-- Add `last_result' to `last_results'
				last_results.extend (last_result)

				-- Check for next result
				-- 0 if there are more results
				-- -1 if no more result sets available
				-- otherwise error occured
				l_next_result := c_mysql_next_result (client.item).to_integer_64
				if l_next_result > 0 then
					last_client_error_number := l_next_result.to_integer_32
					raise ("MYSQLI_CLIENT.execute_query: c_mysql_next_result failed")
				end
			end
		end

	internal_handle_result
			-- Fetch current result
		local
			l_return_pointer: POINTER
			l_info: STRING
			l_result: MYSQLI_INTERNAL_RESULT
			l_columns: ARRAYED_LIST [MYSQLI_FIELD]
			l_row: MYSQLI_INTERNAL_ROW
			l_mysql_row: MYSQLI_ROW
			l_num_rows, l_num_fields: INTEGER
			l_lengths_pointer, l_row_pointer: POINTER
			l_value_length: INTEGER
			l_value_string: STRING
			i, j, k: INTEGER
		do
			-- Fetch number of fields in result set and create array of fields
			l_num_fields := c_mysql_field_count (client.item).as_integer_32
			create l_columns.make (l_num_fields)

			-- Fetch affected rows and insert id info
			i := c_mysql_affected_rows (client.item).to_integer_32
			j := c_mysql_insert_id (client.item).to_integer_32
			k := c_mysql_warning_count (client.item).to_integer_32

			-- Fetch info about query
			l_return_pointer := c_mysql_info (client.item)
			if l_return_pointer.to_integer_32 = 0 then
				create l_info.make_empty
			else
				create l_info.make_from_c (l_return_pointer)
			end

			-- If the number of fields is 0 there is no result set
			-- This is different from no rows in the result set
			if l_num_fields = 0 then
				-- Create `last_result' with empty array of fields and no rows
				create last_result.make_with_fields (l_columns, l_info, 0, i, j, k)

			-- There is a result set with fields and rows
			else
				-- The full result is stored on the client
				l_return_pointer := c_mysql_store_result (client.item)
				if l_return_pointer.to_integer_32 = 0 then
					raise ("MYSQLI_CLIENT.execute_query: c_mysql_store_result failed")
				end

				-- Create memory structures
				create l_result.make_by_pointer (l_return_pointer)
				create l_row.make

				-- Create `last_result' with array of fields
				l_num_rows := c_mysql_num_rows (l_result.item).as_integer_32
				create last_result.make_with_fields (l_columns, l_info, l_num_rows, i, j, k)

				-- Fetch field info
				l_return_pointer := c_mysql_fetch_fields(l_result.item)
				if l_return_pointer.to_integer_32 = 0 then
					raise ("MYSQLI_CLIENT.execute_query: c_mysql_fetch_fields failed")
				end

				-- Fetch all fields
				from
					i := 0
				until
					i >= l_num_fields
				loop
					l_columns.extend (create {MYSQLI_FIELD}.make (c_array_mysql_field_at (l_return_pointer, i)))
					i := i + 1
				end

				-- Fetch all rows
				from
					i := 0
				until
					i >= l_num_rows
				loop
					-- Fetch next row
					c_mysql_fetch_row (l_result.item, l_row.item)

					-- Fetch value lengths
					l_lengths_pointer := c_mysql_fetch_lengths (l_result.item)
					if l_lengths_pointer.to_integer_32 = 0 then
						raise ("MYSQLI_CLIENT.execute_query: c_mysql_fetch_lengths failed")
					end

					-- Create next row
					create l_mysql_row.make_with_result (l_num_fields, last_result)

					-- Fetch all fields for this row
					from
						j := 0
					until
						j >= l_num_fields
					loop
						-- Fetch field length
						l_value_length := c_array_unsigned_long_at (l_lengths_pointer, j).as_integer_32

						-- Fetch field pointer
						l_row_pointer := c_array_mysql_row_at (l_row.item, j)

						-- Check for NULL value
						if l_row_pointer.to_integer_32 = 0 then
							l_mysql_row.extend (create {MYSQLI_NULL_VALUE}.make)

						-- Otherwise TEXT value
						else
							create l_value_string.make (l_value_length)
							l_value_string.from_c_substring (l_row_pointer, 1, l_value_length)
							l_mysql_row.extend (create {MYSQLI_TEXT_VALUE}.make (l_value_string))
						end

						-- Next field
						j := j + 1
					end

					-- Append to result and next row
					last_result.extend (l_mysql_row)
					i := i + 1
				end

				-- Free memory
				c_mysql_free_result (l_result.item)
			end
		end

	internal_prepare_statement (a_statement: STRING)
			-- Prepares the statement in `a_statement'
		local
			l_statement_pointer: ANY
			l_stmt: MYSQLI_INTERNAL_STATEMENT
			l_return_pointer: POINTER
			l_return_value: INTEGER_32
		do
			-- Ping the server to initiate a re-connect, if necessary
			-- See: http://dev.mysql.com/doc/refman/5.0/en/auto-reconnect.html
			l_return_value := c_mysql_ping (client.item)

			-- Reset `last_prepared_statement'
			last_prepared_statement := Void


			-- Initialize new statement memory structure
			l_return_pointer := c_mysql_stmt_init (client.item)
			if l_return_pointer.item.to_integer_32 = 0 then
				raise ("MYSQLI_CLIENT.prepare_statement: c_mysql_stmt_init failed")
			end
			create l_stmt.make_by_pointer (l_return_pointer)

			-- Prepare statement
			l_statement_pointer := a_statement.to_c
			l_return_value := c_mysql_stmt_prepare (l_stmt.item, $l_statement_pointer, a_statement.count.to_natural_32)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_CLIENT.prepare_statement: c_mysql_stmt_prepare failed")
			end

			-- Create `last_prepared_statement'
			create last_prepared_statement.make (Current, l_stmt)
		end

end
