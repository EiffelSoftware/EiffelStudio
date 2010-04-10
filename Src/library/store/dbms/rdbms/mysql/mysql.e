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
					Result  or else l_descriptor_index = 20
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

	string_format (object: STRING): STRING
			-- String representation in MySQL of `object'
			-- WARNING: use "IS NULL" if object is empty instead of "= NULL"
			--          (which does not work)
		do
			if object = Void then
				Result := "IS NULL"
			else
				Result := "'" + object + "'"
			end
		end

	True_representation: STRING = "'Y'"
			-- String representation in MySQL for the boolean 'true' value

	False_representation: STRING = "'N'"
			-- String representation in MySQL for the boolean 'false' value

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN
			-- Should the SQL string be parsed normally using SQL_SCAN?
		do
			Result := False
		end

	parse (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [ANY]
		ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN
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

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING = "TINYINT(1)"

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upassword: STRING): BOOLEAN
			-- Is the given `upassword' correct?
		do
			Result := upassword /= Void and then not upassword.is_empty
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
					if r_any.is_equal ("varchar") then
						data_type.set_item (c_string_type)
					elseif r_any.is_equal ("double") then
						data_type.set_item (c_float_type)
					elseif r_any.is_equal ("int") then
						data_type.set_item (c_integer_type)
					elseif r_any.is_equal ("datetime") then
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

feature -- External features

	get_error_message: POINTER
			-- The error message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		do
			Result := eif_mysql_get_error_message (mysql_pointer)
			is_error_updated := True
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

	init_order (no_descriptor: INTEGER; command: STRING)
		do
			descriptors.put (command, no_descriptor)
		end

	start_order (no_descriptor: INTEGER)
		local
			l_db_result: POINTER
			l_c_string: C_STRING
		do
			if attached descriptors.item (no_descriptor) as l_descriptor then
				create l_c_string.make (l_descriptor)
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

	exec_immediate (no_descriptor: INTEGER; command: STRING)
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
				Result := last_date_data.substring (12, 2).to_integer
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
				Result := last_date_data.substring (18, 2).to_integer
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
				Result := last_date_data.substring (15, 2).to_integer
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
				Result := last_date_data.substring (9, 2).to_integer
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
				Result := last_date_data.substring (6, 2).to_integer
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

	c_character_type: INTEGER
		do
			Result := eif_mysql_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := eif_mysql_c_int_type
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
			l_user: C_STRING
			l_pass: C_STRING
			l_host: C_STRING
			l_base: C_STRING
		do
			create l_user.make (user_name)
			create l_pass.make (user_passwd)
			create l_host.make (hostname)
			create l_base.make (application)
			mysql_pointer := eif_mysql_connect (l_user.item, l_pass.item,
				l_host.item, l_base.item)
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

	descriptors: ARRAY [detachable STRING]
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

	eif_mysql_connect (user_name, user_passwd, hostname,
		application: POINTER): POINTER
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

end

