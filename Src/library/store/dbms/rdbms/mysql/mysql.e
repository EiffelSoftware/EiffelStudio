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
			normal_parse,
			parse,
			convert_string_type
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

feature {NONE} -- Initialization

	default_create
			-- Initialize Current
		do
			create descriptors.make (1, 20)
			create result_pointers.make (1, 20)
			create row_pointers.make (1, 20)
			create last_date_data.make (0)
			last_descriptor := 0
		end

feature

	database_handle_name: STRING = "MYSQL"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has a MySQL function been called since the last update which may
			-- have caused an update to error code, error message, or warning
			-- message?

	found: BOOLEAN
			-- Is there any record matching the last selection condition used?

	clear_error
			-- Reset database error status
		do
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
			if descriptors = Void then
					-- If we have not yet created the descriptors array, we
					-- must assume the creation thereof will make descriptors
					-- available
				Result := True
			else
				from
					Result := False
					l_descriptor_index := 1
				until
					Result or else l_descriptor_index = 20
				loop
					if descriptors.item (l_descriptor_index) = Void then
						Result := True
					else
						l_descriptor_index := l_descriptor_index + 1
					end
				end
			end
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in MySQL of `object'
		do
			Result := "'" + object.date.year.out + "-" + object.date.month.out +
				"-" + object.date.day.out + "'"
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'.
		obsolete
			"Use `string_format_32' instead."
		do
			Result := string_format_32 (object)
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in MySQL of `object'
			-- WARNING: use "IS NULL" if object is empty instead of "= NULL"
			--          (which does not work)
		do
			if object = Void then
				Result := {STRING_32}"IS NULL"
			else
				Result := {STRING_32}"'" + object.as_string_32 + {STRING_32}"'"
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

	parse (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [ANY]
		ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: READABLE_STRING_GENERAL): BOOLEAN
			-- ???
		do
		end

	bind_parameter (value: ARRAY [ANY]; parameters: ARRAY [ANY]
		descriptor: INTEGER; sql: STRING)
			-- ???
		do
		end

	bind_args_value (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [ANY]
		sql: STRING)
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments. `uht' can be
			-- empty (for stored Procedures).
		do
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
			-- The name of the MySQL type that represents a string
		do
			Result := "VARCHAR"
		end

	map_var_name (a_para: STRING): STRING
			-- Map `a_para' to the MySQL statement parameter representation
		do
			Result := ":" + a_para
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
						data_type.set_item (c_string_type)
					elseif r_any.is_equal ("nvarchar") or else r_any.is_equal ("nchar") then
						data_type.set_item (c_wstring_type)
					elseif r_any.is_equal ("double") or else r_any.is_equal ("decimal") then
						data_type.set_item (c_float_type)
					elseif r_any.is_equal ("float") then
						data_type.set_item (c_real_type)
					elseif
						r_any.is_equal ("int") or else r_any.is_equal ("bit") or else
						r_any.is_equal ("tinyint") or else r_any.is_equal ("mediumint")
					then
						if not use_extended_types then
							data_type.set_item (c_integer_type)
						else
							if r_any.is_equal ("tinyint") then
								data_type.set_item (c_integer_16_type)
							else
								data_type.set_item (c_integer_type)
							end
						end
					elseif r_any.is_equal ("smallint") then
						data_type.set_item (c_integer_16_type)
					elseif r_any.is_equal ("bigint") then
						data_type.set_item (c_integer_64_type)
					elseif r_any.is_equal ("datetime") or else r_any.is_equal ("date") then
						data_type.set_item (c_date_type)
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

	sql_as: STRING = " AS BEGIN "

	sql_end: STRING = "; END;"

	sql_execution: STRING = "CALL "

	sql_creation: STRING = "create procedure "

	sql_after_exec: STRING = ""

	support_drop_proc: BOOLEAN = True

	name_proc_lower: BOOLEAN = True

	map_var_between : STRING = ""

	Select_text (proc_name: STRING): STRING
		do
			Result := "select ROUTINE_DEFINITION %
				%from information_schema.ROUTINES %
				%where ROUTINE_NAME = :name and %
				%ROUTINE_TYPE = 'PROCEDURE'"
		end

	Select_exists (proc_name: STRING): STRING
		do
			Result := "select count(*) from information_schema.ROUTINES %
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
			l_s: SQL_STRING
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
			-- This feature also sets is_error_updated to True
		do
			Result := eif_mysql_get_warn_message (mysql_pointer)
			is_error_updated := True
		end

	get_warn_message_string: STRING_32
			-- The warning message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		local
			l_s: SQL_STRING
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
				Result > 0 or else l_descriptor_index = 20
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
		end

	start_order (no_descriptor: INTEGER)
		local
			l_db_result: POINTER
			l_c_string: SQL_STRING
		do
			if attached descriptors.item (no_descriptor) as l_descriptor then
				create l_c_string.make (utf32_to_utf8 (l_descriptor.as_string_32))
				l_db_result := eif_mysql_execute (mysql_pointer, l_c_string.item)
				result_pointers.put (l_db_result, no_descriptor)
				is_error_updated := False
			end
		end

	next_row (no_descriptor: INTEGER)
			-- Fetch the next row from the result set for `no_descriptor' and
			-- indicate in `found' whether a next row was retrieved
		local
			l_result_pointer: POINTER
		do
			l_result_pointer := eif_mysql_next_row (result_pointers.item (
				no_descriptor))
			if l_result_pointer = default_pointer then
				found := False
				row_pointers.put (default_pointer, no_descriptor)
			else
				found := True
				row_pointers.put (l_result_pointer, no_descriptor)
			end
		end

	terminate_order (no_descriptor: INTEGER)
		do
			eif_mysql_free_result(result_pointers.item (no_descriptor))
			result_pointers.put (default_pointer, no_descriptor)
			descriptors.put (Void, no_descriptor)
			is_error_updated := False
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
			create l_area.make (max_len)
			Result := eif_mysql_column_name (
				result_pointers.item (no_descriptor), index, l_area.item)
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

	put_data (no_descriptor: INTEGER; ind: INTEGER; ar: STRING
		max_len: INTEGER): INTEGER
			-- Put the data of field `ind' from result set
			-- `no_descriptor' into `ar', with a maximum length of
			-- `max_len' and return the length of data in `ar'
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_length: INTEGER
		do
			create l_area.make (max_len)
			l_length := get_data_len (no_descriptor, ind)
			Result := eif_mysql_column_data (
				row_pointers.item (no_descriptor), ind, l_area.item, l_length)
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

	put_data_32 (no_descriptor: INTEGER; ind: INTEGER; ar: STRING_32
		max_len: INTEGER): INTEGER
			-- Put the data of field `ind' from result set
			-- `no_descriptor' into `ar', with a maximum length of
			-- `max_len' and return the length of data in `ar'
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_length: INTEGER
			l_count: INTEGER
			l_str: STRING
			l_str32: STRING_32
		do
			create l_area.make (max_len)
			l_length := get_data_len (no_descriptor, ind)
			l_count := eif_mysql_column_data (
				row_pointers.item (no_descriptor), ind, l_area.item, l_length)
			check
				l_count <= max_len
			end
			create l_str.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_str.put (l_area.read_integer_8 (i - 1).to_character_8, i)
				i := i + 1
			end
			l_str.set_count (l_count)
			l_str32 := utf8_to_utf32 (l_str)
			ar.wipe_out
			ar.append (l_str32)
			Result := l_str32.count
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := index
		end

	get_count (no_descriptor: INTEGER): INTEGER
			-- The number of columns in a result for `no_descriptor'
		do
			Result := eif_mysql_num_fields (result_pointers.item (
				no_descriptor))
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The length of the data in the result for `no_descriptor', field
			-- index `ind'
		do
			Result := eif_mysql_data_length (result_pointers.item (
				no_descriptor), ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The length of the column with index `ind' for the indicated
			-- `no_descriptor' as defined by the table definition
		do
			Result := eif_mysql_column_length (result_pointers.item (
				no_descriptor), ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- The column type of column `ind' in result set `no_descriptor'
		do
			Result := eif_mysql_column_type (result_pointers.item (
				no_descriptor), ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			Result := eif_mysql_integer_data (row_pointers.item (
				no_descriptor), ind)
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			Result := eif_mysql_integer_16_data (row_pointers.item (
				no_descriptor), ind)
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
			-- Get the integer for field `ind' in row set `no_descriptor'
		do
			Result := eif_mysql_integer_64_data (row_pointers.item (
				no_descriptor), ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := eif_mysql_float_data (row_pointers.item (
				no_descriptor), ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := eif_mysql_real_data (row_pointers.item (
				no_descriptor), ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is the data in column `ind' of result set `no_descriptor' NULL?
		do
			Result := eif_mysql_is_null_data (row_pointers.item (no_descriptor),
				ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Retrieve the date in row `no_descriptor' for field `ind' and
			-- return 1 (as needed by DATABASE_DATA.fill_in)
		local
			i: INTEGER
			l_area: MANAGED_POINTER
			l_int_8: INTEGER_8
		do
			create l_area.make (19)
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

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer hour for the date from row set `no_descriptor'
			-- and field `ind'
		do
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

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer second for the date from row set
			-- `no_descriptor' and field `ind'
		do
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

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer minute for the date from row set
			-- `no_descriptor' and field `ind'
		do
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

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer year for the date from row set
			-- `no_descriptor' and field `ind'
		do
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

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer day for the date from row set
			-- `no_descriptor' and field `ind'
		do
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

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Return the integer month for the date from row set
			-- `no_descriptor' and field `ind'
		do
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

	c_string_type: INTEGER
		do
			Result := eif_mysql_c_string_type
		end

	c_wstring_type: INTEGER
		do
			Result := eif_mysql_c_wstring_type
		end

	c_character_type: INTEGER
		do
			Result := eif_mysql_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := eif_mysql_c_int_type
		end

	c_integer_16_type: INTEGER
		do
			Result := eif_mysql_c_int16_type
		end

	c_integer_64_type: INTEGER
		do
			Result := eif_mysql_c_int64_type
		end

	c_float_type: INTEGER
		do
			Result := eif_mysql_c_float_type
		end

   	c_real_type: INTEGER
		do
			Result := eif_mysql_c_real_type
		end

	c_boolean_type: INTEGER
		do
			Result := eif_mysql_c_boolean_type
		end

	c_date_type: INTEGER
		do
			Result := eif_mysql_c_date_type
		end

	database_make (i: INTEGER)
		do
		end

	connect (user_name, user_passwd, data_source, application, hostname,
		roleId, rolePassWd, groupId: STRING)
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
			is_error_updated := False
       	end

	disconnect
		do
			eif_mysql_disconnect (mysql_pointer)
		end

	commit
		do
		end

	rollback
		do
		end

	trancount: INTEGER
		do
		end

 	begin
		do
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

feature {NONE} -- Unicode conversion

feature -- Explicit Conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32
			-- UTF8 to UTF32 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			l_ref: INTEGER_32_REF
		do
			from
				i := 1
				nb := a_string.count
				create Result.make (nb)
				create l_ref
			until
				i > nb
			loop
				Result.append_character (read_character_from_utf8 (i, l_ref, a_string))
				i := i + l_ref.item
			end
		ensure
			Result_not_void: Result /= Void
		end

	utf32_to_utf8 (a_string: STRING_32): STRING_8
			-- Convert UTF32 to UTF8.
		require
			a_string_not_void: a_string /= Void
		local
			bytes_written: INTEGER
			i: INTEGER
			l_code: NATURAL_32
			l_string_length: INTEGER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
				bytes_written := 0
			until
				i = 0
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF
					bytes_written := bytes_written + 4
				end
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				create Result.make (bytes_written)
			until
				i > l_string_length
			loop
				l_code := a_string.code (i)
				append_code_point_to_utf8 (l_code, Result)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	append_code_point_to_utf8 (a_code: NATURAL_32; a_string: STRING_8)
			-- Append an unicode code point `a_code' to an utf8 stream.
		require
			a_string_not_void: a_string /= Void
				-- According to ISO/IEC 10646, the maximum unicode point is 10FFFF.
			a_code_is_valid: a_code >= 0 and then a_code <= 0x10FFFF
		do
				if a_code <= 127 then
						-- Of the form 0xxxxxxx.
					a_string.append_code (a_code)
				elseif a_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					a_string.append_code (0xC0 | (a_code |>> 6))
					a_string.append_code (0x80 | (a_code & 0x3F))
				elseif a_code <= 0xFFFF then
						-- Start with 1110xxxx
					a_string.append_code (0xE0 | (a_code |>> 12))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				else -- a_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: a_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					a_string.append_code (0xF0 | (a_code |>> 18))
					a_string.append_code (0x80 | ((a_code |>> 12) & 0x3F))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				end
		ensure
			a_string_appended: (a_code <= 127 implies a_string.count = old a_string.count + 1) and
								((a_code > 127 and a_code <= 0x7FF) implies a_string.count = old a_string.count + 2) and
								((a_code > 0x7FF and a_code <= 0xFFFF) implies a_string.count = old a_string.count + 3) and
								((a_code > 0xFFFF and a_code <= 0x10FFFF) implies a_string.count = old a_string.count + 4)
		end

	read_character_from_utf8 (a_position: INTEGER; a_read_bytes: detachable INTEGER_32_REF; a_string: STRING_8): CHARACTER_32
			-- Read a Unicode character from UTF-8 string.
			-- `a_string' is in UTF-8.
			-- `a_position' is the starting byte point of a character.
			-- `a_read_bytes' is the number of bytes read.
		require
			a_string_not_void: a_string /= Void
			a_position_in_range: a_position > 0 and a_position <= a_string.count
			a_position_valid: a_string.code (a_position).to_natural_8 <= 127 or
								(a_string.code (a_position).to_natural_8 & 0xE0) = 0xC0 or
								(a_string.code (a_position).to_natural_8 & 0xF0) = 0xE0 or
								(a_string.code (a_position).to_natural_8 & 0xF8) = 0xF0 or
								(a_string.code (a_position).to_natural_8 & 0xFC) = 0xF8 or
								(a_string.code (a_position).to_natural_8 & 0xFE) = 0xFC
		local
			l_pos: INTEGER
			l_nat8: NATURAL_8
			l_code: NATURAL_32
		do
			l_pos := a_position
			l_nat8 := a_string.code (l_pos).to_natural_8
			if l_nat8 <= 127 then
					-- Form 0xxxxxxx.
				Result := l_nat8.to_character_32

			elseif (l_nat8 & 0xE0) = 0xC0 then
					-- Form 110xxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
				l_pos := l_pos + 1
				l_nat8 := a_string.code (l_pos).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32

			elseif (l_nat8 & 0xF0) = 0xE0 then
				-- Form 1110xxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x0F).to_natural_32 |<< 12
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 2

			elseif (l_nat8 & 0xF8) = 0xF0 then
				-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x07).to_natural_32 |<< 18
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 12)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 3).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 3

			elseif (l_nat8 & 0xFC) = 0xF8 then
				-- Starts with 111110xx
				-- This seems to be a 5 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 4

			else
				-- Starts with 1111110x
				-- This seems to be a 6 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 5

			end
			if a_read_bytes /= Void then
				a_read_bytes.set_item (l_pos - a_position + 1)
			end
		end

feature {NONE} -- C Externals

	eif_mysql_c_boolean_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_BOOLEAN_TYPE"
		end

	eif_mysql_c_character_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_CHARACTER_TYPE"
		end

	eif_mysql_c_date_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_DATE_TYPE"
		end

	eif_mysql_c_float_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_DOUBLE_TYPE"
		end

	eif_mysql_c_int_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_INTEGER_TYPE"
		end

	eif_mysql_c_int16_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_INTEGER_16_TYPE"
		end

	eif_mysql_c_int64_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_INTEGER_64_TYPE"
		end

	eif_mysql_c_real_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_REAL_TYPE"
		end

	eif_mysql_c_string_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_STRING_TYPE"
		end

	eif_mysql_c_wstring_type: INTEGER
		external
			"C [macro %"eif_mysql.h%"]"
		alias
			"EIF_MYSQL_C_WSTRING_TYPE"
		end

	eif_mysql_column_data (row_ptr: POINTER; ind: INTEGER; ar: POINTER
			len: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_column_length (result_ptr: POINTER; ind: INTEGER): INTEGER
		external
			"C | %"eif_mysql.h%""
		end

	eif_mysql_column_name (result_ptr: POINTER; ind: INTEGER; ar: POINTER):
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

	eif_mysql_free_result (result_ptr: POINTER)
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

note
	copyright:	"Copyright (c) 2010, ITPassion Ltd, Eiffel Software and others"
	license:	"[
					Eiffel Forum License v2
					(see http://www.eiffel.com/licensing/forum.txt)
				]"
	source:		"[
				ITPassion Ltd
				5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
				Telephone 0044-208-742-3422, Fax 0044-208-742-3468
				Website http://www.itpassion.com
				Customer support http://powerdesk.itpassion.com
				]"

end
