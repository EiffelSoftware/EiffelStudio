note
	description: "MySQL specification"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQL

inherit
	DATABASE
		redefine
			default_create,
			parse,
			bind_arguments,
			convert_string_type,
			no_args,
			is_affected_row_count_supported,
			affected_row_count,
			result_order
		end

	STRING_HANDLER
		redefine
			default_create
		end

	GLOBAL_SETTINGS
		export
			{NONE} all
		redefine
			default_create
		end

	MYSQL_EXTERNALS
		export
			{NONE} all
		redefine
			default_create
		end

	DB_CONSTANT
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize Current
		do
			create descriptors.make_filled (Void, 1, max_descriptor_number)
			create result_pointers.make_filled (default_pointer, 1, max_descriptor_number)
			create arguments.make_filled (Void, 1, max_descriptor_number)
			create results.make_filled (Void, 1, max_descriptor_number)
			create row_pointers.make_filled (default_pointer, 1, max_descriptor_number)
			create statement_pointers.make_filled (default_pointer, 1, max_descriptor_number)
			create last_date_data.make (0)
			create date_buffer.make (date_length)
			create string_buffer.make (selection_string_size)
			last_descriptor := 0
		end

feature -- Constants

	database_handle_name: STRING = "MYSQL"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has a MySQL function been called since the last update which may
			-- have caused an update to error code, error message, or warning
			-- message?

	is_warning_updated: BOOLEAN
			-- Has a database function been called since last update which may have
			-- warnings?

	found: BOOLEAN
			-- Is there any record matching the last selection condition used?

	clear_error
			-- Reset database error status
		do
				-- Don't need to do anything in database
			is_error_updated := True
			is_warning_updated := True
		end

	insert_auto_identity_column: BOOLEAN = True
			-- For INSERTs and UPDATEs should record auto-increment identity
			-- columns be explicitly included in the statement?

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
			-- Is a descriptor available? For MySQL the answer is: Yes.
		local
			l_descriptor_index: INTEGER
		do
			from
				Result := False
				l_descriptor_index := 1
			until
				Result or else l_descriptor_index > max_descriptor_number
			loop
				if descriptors.item (l_descriptor_index) = Void then
					Result := True
				else
					l_descriptor_index := l_descriptor_index + 1
				end
			end
		end

	affected_row_count: INTEGER
			-- It returns the number of rows changed, deleted, or inserted by the last statement
			-- if it was an UPDATE, DELETE, or INSERT. For SELECT statements, number of rows in the result set.
		do
			Result := mysql_affected_rows (mysql_pointer)
		end

	max_descriptor_number: INTEGER = 20
			-- Max number of descriptors

	is_affected_row_count_supported: BOOLEAN = True
			-- <Precursor>

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in MySQL of `object'
		do
			create Result.make (21) -- At most 21 chars.
			Result.append_character ('%'')
			Result.append (object.formatted_out ("yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss"))
			Result.append_character ('%'')
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'.
		obsolete
			"Use `string_format_32' instead [2017-11-30]."
		do
			Result := string_format_32 (object).as_string_8_conversion
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in MySQL of `object'
			-- WARNING: use "IS NULL" if object is empty instead of "= NULL"
			--          (which does not work)
		do
			if object = Void then
				Result := once {STRING_32} "IS NULL"
			else
				Result := escaped_sql_string (object)
				Result.prepend_character ({CHARACTER_32} '%'')
				Result.append_character ({CHARACTER_32} '%'')
			end
		end

	True_representation: STRING = "1"
			-- String representation in MySQL for the boolean 'true' value
			--| Boolean types are actually tinyint(1) or bit(1) so we need 1 here

	False_representation: STRING = "0"
			-- String representation in MySQL for the boolean 'false' value
			--| Boolean types are actually tinyint(1) or bit(1) so we need 0 here

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN
			-- Should the SQL string be parsed normally using SQL_SCAN?
		do
			Result := False
		end

	parse (descriptor: INTEGER; uht: detachable DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]; uhandle: HANDLE; sql: READABLE_STRING_GENERAL; dynamic: BOOLEAN): BOOLEAN
			-- Parse and prepare a dynamic statement.
		local
			l_stmt: POINTER
			l_c_string: MYSQL_SQL_STRING
		do
			if dynamic then
				l_stmt := mysql_stmt_init (mysql_pointer)
				if l_stmt /= default_pointer then
					descriptors.put (sql, descriptor)
					statement_pointers.put (l_stmt, descriptor)
					create l_c_string.make (utf32_to_utf8 (sql.as_string_32))
					if mysql_stmt_prepare (l_stmt, l_c_string.item, l_c_string.bytes_count) = 0 and then attached uht as l_ht then
						bind_arguments (descriptor, l_ht, ht_order)
					end
					is_error_updated := False
					Result := True
				end
			end
		end

	bind_arguments (descriptor: INTEGER_32; uht: DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_GENERAL])
			-- Bind arguments
		local
			l_args: DB_PARA_MYSQL
			i: INTEGER
			l_pointer: POINTER
		do
			if uht.count > 0 and then ht_order /= Void then
				if attached arguments.item (descriptor) as l_arg then
					l_args := l_arg
				else
					create l_args.make (uht.count)
					arguments.put (l_args, descriptor)
				end
				from
					ht_order.start
					i := 1
				until
					ht_order.after
				loop
					if i <= l_args.count then
						l_args.replace_parameter (i, uht.item (ht_order.item))
					end
					l_args.extend_parameter (uht.item (ht_order.item))
					ht_order.forth
					i := i + 1
				end
				l_args.set_parameter_count (i - 1)
				l_pointer := l_args.bound_parameter_pointer
				if l_pointer /= default_pointer then
					mysql_stmt_bind_param (statement_pointers.item (descriptor), l_pointer).do_nothing
				end
				is_error_updated := False
			end
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
			-- The name of the MySQL type that represents a string
		do
			Result := "VARCHAR (255)"
		end

	map_var_name_32 (a_para: READABLE_STRING_GENERAL): STRING_32
			-- Map `a_para' to the MySQL statement parameter representation
		do
			create Result.make (a_para.count + 1)
			Result.append ({STRING_32}":")
			Result.append_string_general (a_para)
		end

feature -- DECIMAL

	sql_name_decimal: STRING
			-- SQL type name for decimal
		once
			Result := " decimal"
		end

feature -- DATABASE_REAL

	sql_name_real: STRING = "FLOAT"

feature -- DATABASE_DATATIME

	sql_name_datetime: STRING = "DATETIME"

feature -- DATABASE_DOUBLE

	sql_name_double: STRING = "DOUBLE"

feature -- DATABASE_CHARACTER

	sql_name_character: STRING = "CHAR"

feature -- DATABASE_INTEGER

	sql_name_integer: STRING = "INTEGER"

	sql_name_integer_16: STRING = "SMALLINT"

	sql_name_integer_64: STRING = "BIGINT"

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING = "TINYINT(1)"

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upassword: STRING): BOOLEAN
			-- Is the given `upassword' correct?
		do
				-- Password can be empty.
			Result := upassword /= Void
		end

	password_ensure (name, password, uname, upassword: STRING): BOOLEAN
			-- Make sure `name' equals `uname' and `password' equals `upassword'
		do
			Result := True
		end

feature -- For database types

	convert_string_type (r_any: ANY; field_name, class_name: STRING): ANY
			-- Convert `r_any' to the expected object.
			-- By default, this routine returns `r_any', redefined in MySQL to
			-- return an INTEGER_REF when `field_name' is "data_type"
		local
			data_type: INTEGER_REF
		do
			if field_name.is_equal ("data_type") then
				if class_name.is_equal (("").generator) then
					create data_type
					if r_any.is_equal ("varchar") or else r_any.is_equal ("char") then
						data_type.set_item ({DB_TYPES}.string_type)
					elseif r_any.is_equal ("nvarchar") or else r_any.is_equal ("nchar") then
						data_type.set_item ({DB_TYPES}.string_32_type)
					elseif r_any.is_equal ("double") then
						data_type.set_item ({DB_TYPES}.real_64_type)
					elseif r_any.is_equal ("decimal") then
						data_type.set_item ({DB_TYPES}.decimal_type)
					elseif r_any.is_equal ("float") then
						data_type.set_item ({DB_TYPES}.real_32_type)
					elseif
						r_any.is_equal ("int") or else r_any.is_equal ("bit") or else
						r_any.is_equal ("tinyint") or else r_any.is_equal ("mediumint")
					then
						if not use_extended_types then
							data_type.set_item ({DB_TYPES}.integer_32_type)
						else
							if r_any.is_equal ("tinyint") then
								data_type.set_item ({DB_TYPES}.integer_16_type)
							else
								data_type.set_item ({DB_TYPES}.integer_32_type)
							end
						end
					elseif r_any.is_equal ("smallint") then
						data_type.set_item ({DB_TYPES}.integer_16_type)
					elseif r_any.is_equal ("bigint") then
						data_type.set_item ({DB_TYPES}.integer_64_type)
					elseif r_any.is_equal ("datetime") or else r_any.is_equal ("date") then
						data_type.set_item ({DB_TYPES}.date_type)
					else
						io.error.putstring ("Unknown data type '")
						print (r_any)
						io.error.putstring ("'%N")
					end
					Result := data_type
				else
					Result := r_any
				end
			else
				Result := r_any
			end
		end

feature -- For DATABASE_PROC

	support_sql_of_proc: BOOLEAN = True

	support_stored_proc: BOOLEAN = True

	sql_as: STRING = " BEGIN "

	sql_end: STRING = "; END;"

	sql_execution: STRING = "CALL "

	sql_creation: STRING = "create procedure "

	sql_after_exec: STRING = ""

	support_drop_proc: BOOLEAN = True

	name_proc_lower: BOOLEAN = True

	map_var_between : STRING = ""

	no_args: STRING = " () "

	Select_text_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := {STRING_32}"select ROUTINE_DEFINITION %
				%from information_schema.ROUTINES %
				%where ROUTINE_NAME = :name and %
				%ROUTINE_TYPE = 'PROCEDURE'"
		end

	Select_exists_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := {STRING_32}"select count(*) from information_schema.ROUTINES %
				%where routine_type = 'PROCEDURE' and %
				%routine_name = :name"
		end

feature -- For DATABASE_REPOSITORY

	Selection_string (rep_qualifier, rep_owner, rep_name: STRING): STRING
		do
			--| FIXME
			--| Do we need this side effect?
			repository_name := rep_name
					-- By default we should use this query.
			Result := "SELECT table_catalog, table_schema, table_name, %
				%column_name, ordinal_position as column_id, %
				%column_default as data_default, is_nullable as nullable, %
				%data_type, character_maximum_length as column_size, %
				%character_octet_length, numeric_precision as data_precision, %
				%numeric_scale as scale, character_set_name, collation_name, %
				%column_type, column_key, extra, privileges, column_comment %
				%FROM information_schema.columns WHERE table_name = :rep"
		end

	sql_string: STRING = "VARCHAR("

	sql_string2 (int: INTEGER): STRING
		do
			Result := "VARCHAR("
			Result.append (int.out)
			Result.append_character (')')
		end

	sql_wstring: STRING = "NVARCHAR ("

	sql_wstring2 (int: INTEGER): STRING
		do
			Result := "NVARCHAR ("
			Result.append (int.out)
			Result.append (")")
		end

feature -- Multiple Statements

	enable_multiple_statements
			-- Enable multiple statements if possible
		do
			eif_mysql_enable_multi_statements (mysql_pointer)
		end

	disable_multiple_statements
			-- Disable multiple statements if possible
		do
			eif_mysql_disable_multi_statements (mysql_pointer)
		end

feature -- External features

	get_error_message: POINTER
			-- The error message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		do
			Result := eif_mysql_get_error_message (mysql_pointer)
			is_error_updated := True
		end

	get_error_message_string: STRING_32
			-- The error message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		local
			l_s: MYSQL_SQL_STRING
		do
			create l_s.make_by_pointer (get_error_message)
			Result := l_s.string
		end

	get_error_code: INTEGER
			-- The error code as returned by the RDBMS after the last action.
			-- This feature also sets is_error_updated to True
		do
			Result := eif_mysql_get_error_code (mysql_pointer)
			is_error_updated := True
		end

	get_warn_message: POINTER
			-- The warning message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_warning_updated to True
		do
			Result := eif_mysql_get_warn_message (mysql_pointer)
			is_warning_updated := True
		end

	get_warn_message_string: STRING_32
			-- The warning message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_warning_updated to True
		local
			l_s: MYSQL_SQL_STRING
		do
			create l_s.make_by_pointer (get_warn_message)
			Result := l_s.string
		end

	new_descriptor: INTEGER
			-- Create a new descriptor under which queries can and will be
			-- executed
		local
			l_descriptor_index: INTEGER
		do
			from
				Result := 0
				l_descriptor_index := 1
			until
				Result > 0 or else l_descriptor_index = max_descriptor_number
			loop
				if descriptors.item (l_descriptor_index) = Void then
					Result := l_descriptor_index
				else
					l_descriptor_index := l_descriptor_index + 1
				end
			end
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		do
			descriptors.put (command, no_descriptor)
				-- No statement prepared, we reset the pointer.
			statement_pointers.put (default_pointer, no_descriptor)
		end

	start_order (no_descriptor: INTEGER)
		local
			l_c_string: MYSQL_SQL_STRING
			l_p, l_db_result, l_meta: POINTER
			l_result_bind: DB_PARA_MYSQL
			l_num_field: INTEGER
		do
			l_p := statement_pointers.item (no_descriptor)
			if l_p = default_pointer then
				if attached descriptors.item (no_descriptor) as l_descriptor then
					create l_c_string.make (utf32_to_utf8 (l_descriptor.as_string_32))
					l_db_result := eif_mysql_execute (mysql_pointer, l_c_string.item)
					result_pointers.put (l_db_result, no_descriptor)
					is_error_updated := False
				end
			else
				if mysql_stmt_execute (l_p) = 0 then
						-- Execution succeeded.
					l_meta := mysql_stmt_result_metadata (l_p)
					if l_meta /= default_pointer then
						l_num_field := mysql_num_fields (l_meta)
						if l_num_field > 0 and then (not attached results.item (no_descriptor) as l_results or else l_num_field /= l_results.count) then
								-- Might be another query, we create a new bind to receive results.
							create l_result_bind.make (l_num_field)
							results.put (l_result_bind, no_descriptor)
						end
					end
				end
				is_error_updated := False
			end
		end

	result_order (no_descriptor: INTEGER)
			-- Call MySQL API to store results
		local
			l_p: POINTER
			l_res: INTEGER
		do
			l_p := statement_pointers.item (no_descriptor)
			if l_p /= default_pointer and then attached results.item (no_descriptor) as l_results then
				retrieve_results_length_and_type (no_descriptor, l_results)
				l_results.prepare_result_buffers
					-- Bind again to make sure that new buffers are updated.
				mysql_stmt_bind_result (l_p, l_results.bound_parameter_pointer).do_nothing
				l_res := mysql_stmt_store_result (l_p)
				is_error_updated := False
			end
		end

	next_row (no_descriptor: INTEGER)
			-- Fetch the next row from the result set for `no_descriptor' and
			-- indicate in `found' whether a next row was retrieved
		local
			l_result_pointer, l_p: POINTER
			l_res: INTEGER
		do
			l_p := statement_pointers.item (no_descriptor)
			if l_p = default_pointer then
				l_result_pointer := eif_mysql_next_row (result_pointers.item (no_descriptor))
				if l_result_pointer = default_pointer then
					found := False
					row_pointers.put (default_pointer, no_descriptor)
				else
					found := True
					row_pointers.put (l_result_pointer, no_descriptor)
				end
			else
				if attached results.item (no_descriptor) as l_results then
					l_res := mysql_stmt_fetch (l_p)
					if l_res = 0 or else l_res = mysql_data_truncated then
--						fetch_result_columns (no_descriptor, l_results)
						found := True
					else
						found := False
					end
				else
					found := False
				end
			end
		end

	terminate_order (no_descriptor: INTEGER)
		do
			eif_mysql_free_result (mysql_pointer, result_pointers.item (no_descriptor))
			result_pointers.put (default_pointer, no_descriptor)
			descriptors.put (Void, no_descriptor)
			is_error_updated := False
			is_warning_updated := False
		end

	close_cursor (no_descriptor: INTEGER)
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		do
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING
		max_len: INTEGER): INTEGER
			-- Put the column name of field `index' from result set
			-- `no_descriptor' into `ar', with a maximum length of
			-- `max_len' and return the length of the column name
		local
			i: INTEGER
			l_area: MANAGED_POINTER
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				ar.wipe_out
				if attached l_results.i_th (index).column_name as l_name then
					ar.append (l_name)
				end
				Result := ar.count
			else
				l_area := string_buffer
				l_area.resize (max_len)
				Result := eif_mysql_column_name (
					result_pointers.item (no_descriptor), index, l_area.item, max_len)
				check
					Result <= max_len
				end
				ar.set_count (Result)
				from
					i := 1
				until
					i > Result
				loop
					ar.put (l_area.read_integer_8 (i - 1).to_character_8, i)
					i := i + 1
				end
			end
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING
		max_len: INTEGER): INTEGER
			-- Put the data of field `ind' from result set
			-- `no_descriptor' into `ar', with a maximum length of
			-- `max_len' and return the length of data in `ar'
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_length: INTEGER
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				ar.wipe_out
				if attached l_results.i_th (index).read_string as l_s then
					ar.append (l_s)
				end
				Result := ar.count
			else
				l_area := string_buffer
				l_length := get_data_len (no_descriptor, index)
				if (l_length >= l_area.count) then
   					l_area.resize (l_length)
				end
				Result := eif_mysql_column_data (
							row_pointers.item (no_descriptor), index, l_area.item, l_length)
				check
   					 Result <= l_length
				end

				ar.set_count (Result)
				from
					i := 1
				until
					i > Result
				loop
					ar.put (l_area.read_integer_8 (i - 1).to_character_8, i)
					i := i + 1
				end
			end
		end

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32
		max_len: INTEGER): INTEGER
			-- Put the data of field `ind' from result set
			-- `no_descriptor' into `ar', with a maximum length of
			-- `max_len' and return the length of data in `ar'
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_length: INTEGER
			l_str: STRING
			l_str32: STRING_32
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				ar.wipe_out
				if attached l_results.i_th (index).read_string as l_s then
					ar.append (utf8_to_utf32 (l_s))
				end
				Result := ar.count
			else
				l_area := string_buffer
				l_length := get_data_len (no_descriptor, index)
				if (l_length >= l_area.count) then
   					l_area.resize (l_length)
				end
				Result := eif_mysql_column_data (
						row_pointers.item (no_descriptor), index, l_area.item, l_length)
				check
   					 Result <= l_length
				end

				create l_str.make (Result)
				l_str.set_count (Result)
				from
					i := 1
				until
					i > Result
				loop
					l_str.put (l_area.read_integer_8 (i - 1).to_character_8, i)
					i := i + 1
				end
				l_str32 := utf8_to_utf32 (l_str)
				ar.wipe_out
				ar.append (l_str32)
				Result := l_str32.count
			end
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := index
		end

	get_count (no_descriptor: INTEGER): INTEGER
			-- The number of columns in a result for `no_descriptor'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.parameter_count
			else
				Result := eif_mysql_num_fields (result_pointers.item (no_descriptor))
			end
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The length of the data in the result for `no_descriptor', field
			-- index `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).count
			else
				Result := eif_mysql_data_length (result_pointers.item (no_descriptor), ind)
			end
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The length of the column with index `ind' for the indicated
			-- `no_descriptor' as defined by the table definition
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).column_length
			else
				Result := eif_mysql_column_length (result_pointers.item (no_descriptor), ind)
			end
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The column type of column `ind' in result set `no_descriptor'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).eiffel_type
			else
				Result := eif_mysql_column_type (result_pointers.item (no_descriptor), ind)
			end
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_integer
			else
				Result := eif_mysql_integer_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_integer_16
			else
				Result := eif_mysql_integer_16_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_integer_64
			else
				Result := eif_mysql_integer_64_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_float
			else
				Result := eif_mysql_float_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_real
			else
				Result := eif_mysql_real_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is the data in column `ind' of result set `no_descriptor' NULL?
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).is_null
			else
				Result := eif_mysql_is_null_data (row_pointers.item (no_descriptor), ind)
			end
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Retrieve the date in row `no_descriptor' for field `ind' and
			-- return 1 (as needed by DATABASE_DATA.fill_in)
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_int_8: INTEGER_8
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := 1
			else
				l_area := date_buffer
				Result := eif_mysql_date_data (row_pointers.item (no_descriptor), ind, l_area.item)
				if Result = 1 then
					from
						last_date_data_descriptor := no_descriptor
						last_date_data_ind := ind
						last_date_data.wipe_out
						i := 1
					until
						i > 19
					loop
						l_int_8 := l_area.read_integer_8 (i - 1)
						last_date_data.append_code (l_int_8.as_natural_32)
						i := i + 1
					end
				end
			end
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer hour for the date from row set `no_descriptor'
			-- and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_hour
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (12, 13).to_integer
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_hour (no_descriptor, ind)
				end
			end
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer second for the date from row set
			-- `no_descriptor' and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_second
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (18, 19).to_integer
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_sec (no_descriptor, ind)
				end
			end
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer minute for the date from row set
			-- `no_descriptor' and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_minute
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (15, 16).to_integer
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_min (no_descriptor, ind)
				end
			end
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer year for the date from row set
			-- `no_descriptor' and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_year
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (1, 4).to_integer
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_year (no_descriptor, ind)
				end
			end
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer day for the date from row set
			-- `no_descriptor' and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_day
				if Result = 0 then
					Result := 1
				end
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (9, 10).to_integer
					if Result = 0 then
						Result := 1
					end
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_day (no_descriptor, ind)
				end
			end
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer month for the date from row set
			-- `no_descriptor' and field `ind'
		do
			if statement_pointers.item (no_descriptor) /= default_pointer and then attached results.item (no_descriptor) as l_results then
				Result := l_results.i_th (ind).read_month
				if Result = 0 then
					Result := 1
				end
			else
				if
					no_descriptor = last_date_data_descriptor and
					ind = last_date_data_ind
				then
					Result := last_date_data.substring (6, 7).to_integer
					if Result = 0 then
						Result := 1
					end
				else
					Result := get_date_data (no_descriptor, ind)
					Result := get_month (no_descriptor, ind)
				end
			end
		end

	get_decimal (no_descriptor: INTEGER; ind: INTEGER): detachable TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Function used to get decimal info
		do
			Result := ["0", 1, 1, 0]
		end

	decimal_tuple_from_string (a_str: STRING_8): detachable TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Decimal tuple from string
			-- Simple implementation
		do
			Result := ["0", 1, 1, 0]
		end

	database_make (i: INTEGER)
		do
		end

	connect (user_name, user_passwd, data_source, application, hostname,
			a_role_id, a_role_passwd, a_group_id: STRING)
		local
			l_base: C_STRING
			l_colon_position: INTEGER
			l_host: C_STRING
			l_pass: C_STRING
			l_port: INTEGER
			l_user: C_STRING
		do
			create l_user.make (user_name)
			create l_pass.make (user_passwd)
			l_colon_position := hostname.index_of (':', 1)
			if l_colon_position > 0 then
				create l_host.make (hostname.substring (1,
					l_colon_position - 1))
				l_port := hostname.substring (l_colon_position + 1,
					hostname.count).to_integer
			else
				create l_host.make (hostname)
				l_port := 3306
			end
			create l_base.make (application)
			mysql_pointer := eif_mysql_connect (l_user.item, l_pass.item, l_host.item, l_port, l_base.item)
				-- Default to Disabled, otherwise procedure creation will probably fail,
				-- as normally there are more than one statements for procedure creation.
			disable_multiple_statements
			is_error_updated := False
			is_warning_updated := False
		end

	connect_by_connection_string (a_connect_string: STRING)
			-- Connect to database by connection string
		do
			--| To be implemented
		end

	disconnect
		do
			eif_mysql_disconnect (mysql_pointer)
		end

	commit
			-- Commit
		do
			is_error_updated := not mysql_commit (mysql_pointer)
			if eif_mysql_autocommit (mysql_pointer, True) then
				is_error_updated := False
			end
				-- We use error message as warning message in C code
			is_warning_updated := is_error_updated
		end

	rollback
			-- Rollback
		do
			is_error_updated := not mysql_rollback (mysql_pointer)
			if eif_mysql_autocommit (mysql_pointer, True) then
				is_error_updated := True
			end
				-- We use error message as warning message in C code
			is_warning_updated := is_error_updated
		end

	trancount: INTEGER
			--| MySQL does not have a way to retrieve number of transactions.
		do
		end

 	begin
 			-- Start transaction.
 			-- In MySQL, disable auto commit mode to use transaction.
 			-- It is not nessary to call begin, if one does not use transaction.
 			-- http://dev.mysql.com/tech-resources/articles/mysql-connector-cpp.html#trx
		do
			is_error_updated := not eif_mysql_autocommit (mysql_pointer, False)
			is_warning_updated := is_error_updated
		end

	last_insert_id: NATURAL_64
			-- Last inserted id (For auto-incremental columns)
		do
			Result := mysql_insert_id (mysql_pointer)
		end

	escaped_sql_string (a_str: READABLE_STRING_GENERAL): STRING_32
			-- Escaped SQL string from `a_str'.
		local
			l_to, l_from: C_STRING
			l_count: INTEGER
		do
			create l_from.make (utf32_to_utf8 (a_str.as_string_32))
			create l_to.make_empty (l_from.count * 2)
			l_count := mysql_real_escape_string (mysql_pointer, l_to.item, l_from.item, l_from.count)
			l_to.set_count (l_count)
			Result := utf8_to_utf32 (l_to.string)
		end

feature {NONE} -- Implementation

	retrieve_results_length_and_type (no_descriptor: INTEGER; a_results: DB_PARA_MYSQL)
			-- Retrieve length for results
		require
			statement_pointer_exists: statement_pointers.item (no_descriptor) /= default_pointer
		local
			l_bind: DB_BIND_MYSQL
			l_p, l_meta: POINTER
			l_c: INTEGER
		do
			l_p := statement_pointers.item (no_descriptor)
			l_meta := mysql_stmt_result_metadata (l_p)
			if a_results.is_empty then
				from
				until
					a_results.full
				loop
					create l_bind.make (0, Void, 0)
					a_results.extend (l_bind)
				end
			end
			from
				a_results.start
			until
				a_results.after
			loop
				l_bind := a_results.item
				l_bind.set_eiffel_type (eif_mysql_column_type (l_meta, a_results.index))
				l_bind.set_meta_info (mysql_fetch_field_direct (l_meta, a_results.index - 1))
				l_bind.set_type (c_mysql_column_type (l_bind.meta_info))
				l_c := data_length_of_mysql_type (l_bind.type)
				if attached l_bind.buffer as l_buffer then
					l_buffer.resize (l_c)
				else
					l_bind.set_buffer (create {MANAGED_POINTER}.make (l_c))
				end
				l_bind.set_count (l_c)
				a_results.forth
			end
			a_results.set_parameter_count (a_results.count)
		end

	fetch_result_columns (no_descriptor: INTEGER; a_results: DB_PARA_MYSQL)
			-- Fetch results from columns
		require
			statement_pointer_exists: statement_pointers.item (no_descriptor) /= default_pointer
		local
			l_p: POINTER
		do
			l_p := statement_pointers.item (no_descriptor)
			from
				a_results.start
			until
				a_results.after
			loop
				mysql_stmt_fetch_column (l_p, a_results.bound_parameter (a_results.index), a_results.index - 1, 0).do_nothing
				a_results.forth
			end
		end

	data_length_of_mysql_type (a_type: INTEGER): INTEGER
			-- Get buffer length for a mysql `a_type'.
		note
			EIS: "name=Length of MySQL types", "protocol=URI", "src=http://dev.mysql.com/doc/refman/5.0/en/mysql-stmt-fetch.html"
		do
			if a_type = mysql_type_tiny then
				Result := 1
			elseif a_type = mysql_type_short then
				Result := 2
			elseif a_type = mysql_type_long then
				Result := 4
			elseif a_type = mysql_type_longlong then
				Result := 8
			elseif a_type = mysql_type_float then
				Result := 4
			elseif a_type = mysql_type_double then
				Result := 8
			elseif a_type = mysql_type_time then
				Result := c_sizeof_mysql_time
			elseif a_type = mysql_type_date then
				Result := c_sizeof_mysql_time
			elseif a_type = mysql_type_datetime then
				Result := c_sizeof_mysql_time
			elseif a_type = mysql_type_string then
					-- Leave it zero, the length will be fetched.
				Result := 0
			elseif a_type = mysql_type_string then
					-- Leave it zero, the length will be fetched.
				Result := 0
			else

			end
		end

feature {NONE} -- Attributes

	descriptors: ARRAY [detachable READABLE_STRING_GENERAL]
			-- Array of descriptors, so that we can keep track of requests
			-- made to the database
			--| This is done in Eiffel, so that we can guarantee that the Clib
			--| stub library is going to be thread safe.

	last_date_data: STRING
			-- The last date retrieved by `get_date_data'

	last_date_data_descriptor: INTEGER
			-- Descriptor used to retrieve `last_date_data'

	last_date_data_ind: INTEGER
			-- Column index used to retrieve `last_date_data'

	last_descriptor: INTEGER
			-- Last descriptor used

	mysql_pointer: POINTER
			-- Pointer to the C MYSQL structure returned by eif_mysql_connect

	repository_name: detachable STRING
			-- Name of the repository

	result_pointers: ARRAY [POINTER]
			-- Array of result pointers so that we can safely remember which
			-- MYSQL_RESULT belongs to which request

	row_pointers: ARRAY [POINTER]
			-- Array of row pointers so that we can safely remember which
			-- MYSQL_ROW belongs to which descriptor

	statement_pointers: ARRAY [POINTER]
			-- Array of pointers of MYSQL_STMT structure
			-- Indexed by descriptors

	arguments: ARRAY [detachable DB_PARA_MYSQL]
			-- Array of parameters to be bound for dynamic SQL.

	results: ARRAY [detachable DB_PARA_MYSQL]
			-- Array of bound results for dynamic SQL.

	date_buffer: MANAGED_POINTER
			-- Buffer of date

	string_buffer: MANAGED_POINTER
			-- Buffer of string

	date_length: INTEGER = 19
			-- Date length defined by MYSQL

feature {NONE} -- C Externals	

	eif_mysql_column_data (row_ptr: POINTER; ind: INTEGER; ar: POINTER len: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_column_length (result_ptr: POINTER; ind: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_column_name (result_ptr: POINTER; ind: INTEGER; ar: POINTER; a_max_len: INTEGER):
			INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_column_type (result_ptr: POINTER; ind: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_connect (user_name, user_passwd, hostname: POINTER; port: INTEGER; application: POINTER): POINTER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_data_length (result_ptr: POINTER; ind: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_date_data (row_ptr: POINTER; ind: INTEGER; ar: POINTER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_disconnect (mysql_ptr: POINTER)
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_execute (mysql_ptr: POINTER; command: POINTER): POINTER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_float_data (row_ptr: POINTER; ind: INTEGER): DOUBLE
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_free_result (mysql_ptr: POINTER; result_ptr: POINTER)
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_get_error_code (mysql_ptr: POINTER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_get_error_message (mysql_ptr: POINTER): POINTER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_get_warn_message (mysql_ptr: POINTER): POINTER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_integer_data (row_ptr: POINTER; ind: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_integer_16_data (row_ptr: POINTER; ind: INTEGER): INTEGER_16
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_integer_64_data (row_ptr: POINTER; ind: INTEGER): INTEGER_64
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_is_null_data (result_ptr: POINTER; ind: INTEGER): BOOLEAN
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_next_row (result_ptr: POINTER): POINTER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_num_fields (result_ptr: POINTER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_real_data (row_ptr: POINTER; ind: INTEGER): REAL
		external
			"C | %"eif_mysql.h%""
		end

	mysql_insert_id (mysql_ptr: POINTER): NATURAL_64
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_autocommit (mysql_ptr: POINTER; a_mode: BOOLEAN): BOOLEAN
			-- Return True, if there was error.
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_enable_multi_statements (mysql_ptr: POINTER)
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_disable_multi_statements (mysql_ptr: POINTER)
		external
			"C | %"eif_mysql.h%""
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
