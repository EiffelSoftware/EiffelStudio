note
	description: "MySQL Prepared Statement Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_PREPARED_STATEMENT

inherit
	MYSQLI_EXTERNALS
	EXCEPTIONS

create{MYSQLI_EXTERNALS}
	make

feature -- Initialization

	make (a_client: attached like client; a_statement: attached like statement)
			-- Initialize statement
		local
			i: INTEGER
		do
			client := a_client
			statement := a_statement
			create last_client_error_message.make_empty
			parameter_count := c_mysql_stmt_param_count (statement.item).to_integer_32
			create parameters.make (parameter_count)
			from
				i := 0
			until
				i >= parameter_count
			loop
				parameters.extend (create {MYSQLI_NULL_VALUE}.make)
				i := i + 1
			end
			create last_result.make_empty
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
			create Result.make_from_c (c_mysql_stmt_error (statement.item))
		end

	last_server_error_number: INTEGER
			-- Last occured server error number
		do
			Result := c_mysql_stmt_errno (statement.item).to_integer_32
		end

	has_client_error: BOOLEAN
			-- Indicates if a client error occured during the last operation
		do
			Result := not last_client_error_message.is_empty
		end

	last_client_error_message: STRING
			-- Last occured client error

	last_client_error_number: INTEGER
			-- Last occured client error number

feature -- Commands

	execute
			-- Executes this prepared statement.
			-- The result set is available in `last_result'.
			-- If an error occurred `has_error' will be True
			-- and `last_error_message' will contain the error message.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				create last_client_error_message.make_empty
				last_client_error_number := 0
				internal_execute
			end
		rescue
			create last_result.make_empty
			if  attached tag_name as l_tag_name then
				last_client_error_message := l_tag_name
				if last_client_error_number /= 0 then
					last_client_error_message.append (" ("+c_error_code_to_message (last_client_error_number)+")")
				end
			end
			l_retried := True
			retry
		end

	close
			-- Frees memory used by this prepared statement.
		local
			l_retried: BOOLEAN
			l_return_value: INTEGER_32
		do
			if not l_retried then
				if statement.item.to_integer_32 /= 0 then
					l_return_value := c_mysql_stmt_close (statement.item)
					if l_return_value /= 0 then
						last_client_error_number := l_return_value.to_integer_32
						raise ("MYSQLI_PREPARED_STATEMENT.close: c_mysql_stmt_close failed")
					end
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


feature -- Access

	client: MYSQLI_CLIENT
			-- Client that created this statement

	parameter_count: INTEGER
			-- Number of parameters for the current statement

	parameters: ARRAYED_LIST [MYSQLI_VALUE]
			-- Parameters for the current statement
			-- Size must not be changed!
			-- Items must not be Void!

	last_result: MYSQLI_RESULT
			-- The result set created by the last successfuly call to `execute'

feature{NONE} -- Internal

	statement: MYSQLI_INTERNAL_STATEMENT
			-- Wrapper for MYSQL_STMT C Struct

feature{NONE} -- Implementation

	internal_execute
		local
			l_return_value: INTEGER_32
			l_return_pointer: POINTER
			l_managed_pointer: MANAGED_POINTER

			l_param: MYSQLI_VALUE
			l_mysql_row: MYSQLI_ROW

			l_field_count: INTEGER
			l_bind: POINTER
			l_num_rows: INTEGER
			i, j: INTEGER
			l_string: STRING

			l_field_array: POINTER
			l_field: MYSQLI_FIELD
			l_fields: ARRAYED_LIST [MYSQLI_FIELD]

			l_param_array: MYSQLI_INTERNAL_BIND_ARRAY
			l_param_bind: TUPLE [buffer, length, is_null: MANAGED_POINTER]
			l_param_binds: ARRAYED_LIST [TUPLE [buffer, length, is_null: MANAGED_POINTER]]

			l_bind_array: MYSQLI_INTERNAL_BIND_ARRAY
			l_value_bind: TUPLE [buffer, length, is_null: MANAGED_POINTER]
			l_value_binds: ARRAYED_LIST [TUPLE [buffer, length, is_null: MANAGED_POINTER]]
		do
			-- Ping the server to initiate a re-connect, if necessary
			-- See: http://dev.mysql.com/doc/refman/5.0/en/auto-reconnect.html
			l_return_value := c_mysql_ping (client.client.item)

			-- Reset `last_result'
			create last_result.make_empty

			-- The code follows the example given in the MySQL C API documentation
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-stmt-execute.html

			-- Steps:
			--   1. Create MYSQL_BIND array and populate with entries from `parameters'
			--   2. Execute and store statement
			--   3. Create MYSQL_BIND array for result set by looking at all fields
			--   4. Fetch all rows and turn values into MYSQL_*_VALUE objects using the array

			-- ------------------------------------------------------------------------------
			-- 1. Parameters
			-- ------------------------------------------------------------------------------
			if parameters.count /= parameter_count then
				raise ("MYSQLI_PREPARED_STATEMENT.execute: size of parameters is not the expected size")
			end
			if parameter_count > 0 then
				create l_param_array.make_with_size (parameter_count)
			else
				create l_param_array.make_with_size (1) -- Need Pointer for C API
			end
			create l_param_binds.make (parameter_count)
			from
				i := 0
			until
				i >= parameter_count
			loop
				l_param := parameters.at (i + 1)
				if l_param = Void then
					raise ("MYSQLI_PREPARED_STATEMENT.execute: parameter is Void")
				end

				-- Create tuple to hold memory space for parameters
				create l_param_bind.default_create
				l_param_binds.extend (l_param_bind)

				-- Create memory space for length, is_null and buffer for parameters
				l_param_bind.length := create {MANAGED_POINTER}.make (8)
				l_param_bind.is_null := create {MANAGED_POINTER}.make (8)
				l_param_bind.buffer := create {MANAGED_POINTER}.make (size_of_mysql_time_struct)

				-- Link to C Struct
				l_bind := c_array_mysql_bind_at (l_param_array.item, i)

				-- Have parameter fill itself into memory space
				l_param.bind (l_bind, l_param_bind.buffer, l_param_bind.is_null, l_param_bind.length)
				i := i + 1
			end
			l_return_value := c_mysql_stmt_bind_param (statement.item, l_param_array.item)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_bind_param failed")
			end
			-- ------------------------------------------------------------------------------


			-- ------------------------------------------------------------------------------
			-- 2. Execute
			-- ------------------------------------------------------------------------------
			create l_managed_pointer.make (4)
			l_managed_pointer.put_integer_32 (1, 0)
			l_return_value := c_mysql_stmt_attr_set (statement.item, STMT_ATTR_UPDATE_MAX_LENGTH, l_managed_pointer.item)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_attr_set failed")
			end
			l_return_value := c_mysql_stmt_execute (statement.item)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_execute failed")
			end
			l_return_value := c_mysql_stmt_store_result (statement.item)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_store_result failed")
			end
			-- ------------------------------------------------------------------------------


			-- ------------------------------------------------------------------------------
			-- 3. Fields
			-- ------------------------------------------------------------------------------
			l_field_count := c_mysql_stmt_field_count (statement.item).to_integer_32
			if l_field_count > 0 then

				-- MYSQL_BIND C Struct for result
				create l_bind_array.make_with_size (l_field_count.as_integer_32)
				l_return_pointer := c_mysql_stmt_result_metadata(statement.item)
				if l_return_pointer.to_integer_32 = 0 then
					raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_result_metadata failed")
				end
				l_field_array := c_mysql_fetch_fields(l_return_pointer)
				if l_field_array.to_integer_32 = 0 then
					raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_fetch_fields failed")
				end
				create l_fields.make (l_field_count)
				create l_value_binds.make (l_field_count)
				from
					i := 0
				until
					i >= l_field_count
				loop
					-- Retrieve field meta data
					create l_field.make (c_array_mysql_field_at (l_field_array, i))
					l_fields.extend (l_field)

					-- Pointer to i-th MYSQL_BIND C Struct
					l_bind := c_array_mysql_bind_at (l_bind_array.item, i)

					-- Set type, max_length and unsigned of field
					c_struct_mysql_bind_set_buffer_type (l_bind, l_field.type)
					c_struct_mysql_bind_set_buffer_length (l_bind, l_field.max_length)
					if l_field.is_unsigned then
						c_struct_mysql_bind_set_is_unsigned (l_bind, 1)
					end

					-- Create tuple to hold memory space for return value
					create l_value_bind.default_create
					l_value_binds.extend (l_value_bind)

					-- Set length memory space
					l_value_bind.length := create {MANAGED_POINTER}.make (8)
					c_struct_mysql_bind_set_length (l_bind, l_value_bind.length.item)
					-- Set is_null memory space
					l_value_bind.is_null := create {MANAGED_POINTER}.make (8)
					c_struct_mysql_bind_set_is_null (l_bind, l_value_bind.is_null.item)

					-- Set buffer memory space
					if l_field.is_date_time then
						l_value_bind.buffer := create {MANAGED_POINTER}.make (size_of_mysql_time_struct)
					else
						l_value_bind.buffer := create {MANAGED_POINTER}.make (l_field.max_length.as_integer_32 + 8)
					end
					c_struct_mysql_bind_set_buffer (l_bind, l_value_bind.buffer.item)

					i := i + 1
				end
				c_mysql_free_result (l_return_pointer)
				l_return_value := c_mysql_stmt_bind_result (statement.item, l_bind_array.item)
				if l_return_value /= 0 then
					last_client_error_number := l_return_value.to_integer_32
					raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_bind_result failed")
				end
			-- ------------------------------------------------------------------------------


			-- ------------------------------------------------------------------------------
			-- 4. Rows
			-- ------------------------------------------------------------------------------
				l_num_rows := c_mysql_stmt_num_rows (statement.item).to_integer_32
				i := c_mysql_stmt_affected_rows (statement.item).to_integer_32
				j := c_mysql_stmt_insert_id (statement.item).to_integer_32
				create last_result.make_with_fields (l_fields, once "", l_num_rows, i, j, 0)
				from
					i := 0
				until
					i >= l_num_rows
				loop
					l_return_value := c_mysql_stmt_fetch (statement.item)
					if l_return_value /= 0 then
						last_client_error_number := l_return_value.to_integer_32
						raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_fetch failed")
					end
					create l_mysql_row.make_with_result (l_field_count, last_result)
					from
						j := 0
					until
						j >= l_field_count
					loop
						l_value_bind := l_value_binds.at (j + 1)
						l_field := l_fields.at (j + 1)

						-- Fetch value
						if l_value_bind.is_null.read_integer_32 (0) = 1 then
							l_mysql_row.extend (create {MYSQLI_NULL_VALUE}.make)
						elseif l_field.type = MYSQL_TYPE_BLOB then
							l_mysql_row.extend (create {MYSQLI_TEXT_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_STRING then
							l_mysql_row.extend (create {MYSQLI_CHAR_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_VAR_STRING then
							l_mysql_row.extend (create {MYSQLI_VARCHAR_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_DECIMAL then
							l_mysql_row.extend (create {MYSQLI_DECIMAL_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_NEWDECIMAL then
							l_mysql_row.extend (create {MYSQLI_NEWDECIMAL_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_ENUM then
							l_mysql_row.extend (create {MYSQLI_ENUM_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_SET then
							l_mysql_row.extend (create {MYSQLI_SET_VALUE}.make (parse_mysql_string (l_value_bind)))
						elseif l_field.type = MYSQL_TYPE_TINY then
							l_mysql_row.extend (create {MYSQLI_TINYINT_VALUE}.make_as_natural_8 (l_value_bind.buffer.read_natural_8 (0)))
						elseif l_field.type = MYSQL_TYPE_SHORT then
							l_mysql_row.extend (create {MYSQLI_SMALLINT_VALUE}.make_as_natural_16 (l_value_bind.buffer.read_natural_16 (0)))
						elseif l_field.type = MYSQL_TYPE_LONG then
							l_mysql_row.extend (create {MYSQLI_INTEGER_VALUE}.make_as_natural_32 (l_value_bind.buffer.read_natural_32 (0)))
						elseif l_field.type = MYSQL_TYPE_INT24 then
							l_mysql_row.extend (create {MYSQLI_MEDIUMINT_VALUE}.make_as_integer_32 (l_value_bind.buffer.read_integer_32 (0)))
						elseif l_field.type = MYSQL_TYPE_LONGLONG then
							l_mysql_row.extend (create {MYSQLI_BIGINT_VALUE}.make_as_natural_64 (l_value_bind.buffer.read_natural_64 (0)))
						elseif l_field.type = MYSQL_TYPE_FLOAT then
							l_mysql_row.extend (create {MYSQLI_FLOAT_VALUE}.make (l_value_bind.buffer.read_real_32 (0)))
						elseif l_field.type = MYSQL_TYPE_DOUBLE then
							l_mysql_row.extend (create {MYSQLI_DOUBLE_VALUE}.make (l_value_bind.buffer.read_real_64 (0)))
						elseif l_field.type = MYSQL_TYPE_YEAR then
							l_mysql_row.extend (create {MYSQLI_YEAR_VALUE}.make (l_value_bind.buffer.read_natural_16 (0).to_integer_16))
						elseif l_field.type = MYSQL_TYPE_BIT then
							l_mysql_row.extend (create {MYSQLI_BIT_VALUE}.make (l_value_bind.buffer.read_natural_64 (0)))
						elseif l_field.type = MYSQL_TYPE_TIMESTAMP then
							l_mysql_row.extend (create {MYSQLI_TIMESTAMP_VALUE}.make (parse_mysql_timestamp (l_value_bind.buffer.item)))
						elseif l_field.type = MYSQL_TYPE_DATETIME then
							l_mysql_row.extend (create {MYSQLI_DATETIME_VALUE}.make (parse_mysql_timestamp (l_value_bind.buffer.item)))
						elseif l_field.type = MYSQL_TYPE_DATE then
							l_mysql_row.extend (create {MYSQLI_DATE_VALUE}.make (parse_mysql_timestamp (l_value_bind.buffer.item)))
						elseif l_field.type = MYSQL_TYPE_TIME then
							l_mysql_row.extend (create {MYSQLI_TIME_VALUE}.make (parse_mysql_timestamp (l_value_bind.buffer.item)))
						elseif l_field.type = MYSQL_TYPE_GEOMETRY then
							raise ("MYSQLI_PREPARED_STATEMENT.execute: GEOMETRY values are not supported")
						else
							raise ("MYSQLI_PREPARED_STATEMENT.execute: unknown field type")
						end

						j := j + 1
					end
					last_result.extend (l_mysql_row)
					i := i + 1
				end
			end
			l_return_value := c_mysql_stmt_free_result (statement.item)
			if l_return_value /= 0 then
				last_client_error_number := l_return_value.to_integer_32
				raise ("MYSQLI_PREPARED_STATEMENT.execute: c_mysql_stmt_free_result failed")
			end
		end

	parse_mysql_string (a_value_bind: TUPLE [buffer, length, is_null: MANAGED_POINTER]): STRING
				-- Read string from MYSQL_BIND C Struct
		do
			create Result.make (a_value_bind.buffer.read_integer_32 (0))
			Result.from_c_substring (a_value_bind.buffer.item, 1, a_value_bind.length.read_integer_32 (0))
		end

	parse_mysql_timestamp (a_pointer: POINTER): TUPLE [years, months, days, hours, minutes, seconds: INTEGER_32]
				-- Read values from MYSQL_TIME C Struct
		do
			create Result.default_create
			Result.years := c_struct_mysql_time_year (a_pointer).to_integer_32
			Result.months := c_struct_mysql_time_month (a_pointer).to_integer_32
			Result.days := c_struct_mysql_time_day (a_pointer).to_integer_32
			Result.hours := c_struct_mysql_time_hour (a_pointer).to_integer_32
			Result.minutes := c_struct_mysql_time_minute (a_pointer).to_integer_32
			Result.seconds := c_struct_mysql_time_second (a_pointer).to_integer_32
			if c_struct_mysql_time_neg (a_pointer).to_integer_32 = 1 then
				Result.hours := Result.hours.opposite
			end
		end

end
