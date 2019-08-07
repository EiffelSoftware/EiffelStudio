note
	description: "Sybase specification"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SYBASE

inherit
	DATABASE
		redefine
			results_order,
			result_order,
			dim_rep_diff,
			sql_adapt_db,
			map_var_before,
			map_var_after,
			proc_args
		end

	STRING_HANDLER

feature -- Access

	database_handle_name: STRING = "SYBASE"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has Sybase function been called since last update which may have
			-- updated error code, error message?

	is_warning_updated: BOOLEAN = True
			-- No warning implemented in C code.

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
		end

	insert_auto_identity_column: BOOLEAN
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?
		do
			check
				to_be_implemented: False
			end
		end

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
		do
			Result := (syb_available_descriptor = 1)
		end

	results_order (no_descriptor: INTEGER): INTEGER
		do
			Result := syb_results_order (no_descriptor)
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
		do
			create Result.make (1)
			Result.append (object.out)
			Result.precede ('%'')
			Result.extend ('%'')
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'
		obsolete
			"Use `string_format_32' instead [2017-11-30]."
		do
			Result := string_format_32 (object).as_string_8_conversion
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `object'
		do
			if attached object as l_s then
				Result := l_s.as_string_32
				if not is_binary (Result) then
					Result.precede ({CHARACTER_32}'%'')
					Result.extend ({CHARACTER_32}'%'')
				end
			else
				Result := {STRING_32}"IS NULL"
			end
		end

	True_representation: STRING = "1"

	False_representation: STRING = "0"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN = True

	result_order (descriptor: INTEGER)
		do
			last_error_code := syb_result_order (descriptor)
		end

feature -- Access

	last_error_code: INTEGER
			-- Last error returned by Handle.

	get_error_code: INTEGER
		do
			Result := last_error_code
		end


feature -- For DATABASE_STORE

	dim_rep_diff (repository_dimension, ufield_count: INTEGER): BOOLEAN
		do
			Result := repository_dimension /= ufield_count
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
		once
			Result := "varchar(500)"
		ensure then
			Result.is_equal ("varchar(500)")
		end

feature -- DECIMAL

	sql_name_decimal: STRING
			-- SQL type name for decimal
		once
			Result := " decimal"
		end

feature -- DATABASE_REAL

	sql_name_real: STRING
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING
		once
			Result := "datetime"
		ensure then
			Result.is_equal ("datetime")
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING
		once
			Result := "char(1)"
		ensure then
			Result.is_equal ("char(1)")
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING
		once
			Result := "int"
		ensure then
			Result.is_equal ("int")
		end

	sql_name_integer_16: STRING
		once
			Result := "smallint"
		ensure then
			Result.is_equal ("smallint")
		end

	sql_name_integer_64: STRING
		once
			Result := "bigint"
		ensure then
			Result.is_equal ("bigint")
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING
		once
			Result := "bit"
		ensure then
			textual_outlook: Result.is_equal ("bit")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN
		do
			Result := upasswd /= Void
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
		do
			Result := name.is_equal(uname) and passwd.is_equal(upasswd)
		end

feature -- For DATABASE_PROC

	support_sql_of_proc: BOOLEAN = True

	support_stored_proc: BOOLEAN = True

	sql_adapt_db (sql: STRING): STRING
		do
			Result := sql
			Result.replace_substring_all (":", "@")
		end

	sql_as: STRING = " as "

	sql_end: STRING = ""

	sql_execution: STRING = "exec "

	sql_creation: STRING = "create procedure "

	sql_after_exec: STRING = ""

	support_drop_proc: BOOLEAN = True

	name_proc_lower: BOOLEAN = False

	map_var_before: STRING = " "

	map_var_between: STRING = " @"

	map_var_name_32 (a_para: READABLE_STRING_GENERAL): STRING_32
			-- Map variable string for late bound stored procedure execution
		do
			create Result.make (a_para.count + 1)
			Result.append ({STRING_32}":")
			Result.append_string_general (a_para)
		end

	map_var_after: STRING = ""

	Select_text_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := {STRING_32}"select a.text from syscomments a, sysobjects b where b.name = :name and b.id = a.id"
		end

	Select_exists_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := {STRING_32}"select count(*) from %
			%sysobjects where type = 'P' %
			%and name = :name"
		end

	proc_args: BOOLEAN = True

feature -- For DATABASE_REPOSITORY


	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
		do
			Result := "select owner_id = sysobjects.uid, %
			%table_id = sysobjects.id, table_name = sysobjects.name, %
			%table_type = sysobjects.type, creation_date = %
			%sysobjects.crdate, column_name = syscolumns.name, %
			%column_id = colid, data_type = syscolumns.type, %
			%data_length = length, status from sysobjects, %
			%syscolumns where sysobjects.id = syscolumns.id and %
			%sysobjects.name = :rep"
		end

	sql_string: STRING = "varchar("

	sql_string2 (int: INTEGER): STRING
		do
			Result := " text"
		end

	sql_wstring: STRING = "unichar ("

	sql_wstring2 (int: INTEGER): STRING
		do
			Result := " unitext"
		end

feature -- External	features

	get_error_message: POINTER
		do
			Result := syb_get_error_message
		end

	get_error_message_string: STRING_32
		local
			l_s: C_STRING
		do
			create l_s.make_by_pointer (syb_get_error_message)
			Result := l_s.string
		end

	get_warn_message: POINTER
		do
			Result := syb_get_warn_message
		end

	get_warn_message_string: STRING_32
		local
			l_s: C_STRING
		do
			create l_s.make_by_pointer (syb_get_warn_message)
			Result := l_s.string
		end

	new_descriptor: INTEGER
		do
			Result := syb_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: C_STRING
		do
			create c_temp.make (utf32_to_utf8 (command.as_string_32))

			last_error_code := syb_init_order (no_descriptor, c_temp.item)
		end

	start_order (no_descriptor: INTEGER)
		do
			last_error_code := syb_start_order(no_descriptor)
		end

	next_row (no_descriptor: INTEGER)
		do
			found := (syb_next_row(no_descriptor) = 0)
		end

	terminate_order (no_descriptor: INTEGER)
		do
				-- We don't bother to change `last_error_code' because `syb_terminate_order'
				-- at C side always return 0, which wipes out actual last error.
			syb_terminate_order(no_descriptor).do_nothing
		end

	close_cursor (no_descriptor: INTEGER)
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: C_STRING
		do
			create c_temp.make (utf32_to_utf8 (command.as_string_32))
			last_error_code := syb_exec_immediate(c_temp.item)
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := syb_put_col_name(no_descriptor, index, l_area.item)

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

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := syb_put_data (no_descriptor, index, l_area.item)

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

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32; max_len:INTEGER): INTEGER
		local
			l_sql_string: SYBASE_SQL_STRING
			l_area: MANAGED_POINTER
		do
			create l_area.make (max_len)
			Result := syb_put_data (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end

			Result := Result // {SYBASE_SQL_STRING}.character_size

			ar.grow (Result)
			ar.set_count (Result)
			create l_sql_string.make_shared_from_pointer_and_count (l_area.item, Result)
			l_sql_string.read_substring_into (ar, 1, Result)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := syb_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER
		do
			Result := syb_get_count(no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_integer_data (no_descriptor, ind)
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
		do
			Result := syb_get_integer_16_data (no_descriptor, ind)
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
		do
			Result := syb_get_integer_64_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := syb_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := syb_get_real_data (no_descriptor, ind).truncated_to_real
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
			Result := syb_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- is last retrieved data null?
		do
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := syb_get_month
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
			syb_database_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING)
		local
			c_temp1, c_temp2, c_temp3, c_temp4: C_STRING
		do
			create c_temp1.make (user_name)
			create c_temp2.make (user_passwd)
			create c_temp3.make (application)
			create c_temp4.make (hostname)

			last_error_code := syb_connect (c_temp1.item, c_temp2.item, c_temp3.item, c_temp4.item)
		end

	connect_by_connection_string (a_connect_string: STRING)
			-- Connect to database by connection string
		do
		end

	disconnect
		do
			last_error_code := syb_disconnect
			found := False
		end

	commit
		do
			last_error_code := syb_commit
		end

	rollback
		do
			last_error_code := syb_rollback
		end

	trancount: INTEGER
		do
			Result := syb_trancount
		end

	begin
		do
			last_error_code := syb_begin
		end

feature {NONE} -- External features

	syb_get_error_message: POINTER
		external
			"C"
		end

	syb_get_warn_message: POINTER
		external
			"C"
		end

	syb_new_descriptor: INTEGER
		external
			"C"
		end

	syb_init_order (no_descriptor: INTEGER; command: POINTER): INTEGER
		external
			"C"
		end

	syb_start_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	syb_next_row (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	syb_terminate_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	syb_exec_immediate (command: POINTER): INTEGER
		external
			"C"
		end

	syb_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C"
		end

	syb_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C"
		end

	syb_conv_type (index: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_count (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
		external
			"C"
		end

	syb_get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
		external
			"C"
		end

	syb_get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		external
			"C"
		end

	syb_get_real_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		external
			"C"
		end

	syb_get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		external
			"C"
		end

	syb_get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C"
		end

	syb_get_hour: INTEGER
		external
			"C"
		end

	syb_get_sec: INTEGER
		external
			"C"
		end

	syb_get_min: INTEGER
		external
			"C"
		end

	syb_get_year: INTEGER
		external
			"C"
		end

	syb_get_day: INTEGER
		external
			"C"
		end

	syb_get_month: INTEGER
		external
			"C"
		end

	syb_database_make (i: INTEGER)
		external
			"C"
		alias
			"c_syb_make"
		end

	syb_disconnect: INTEGER
		external
			"C"
		end

	syb_commit: INTEGER
		external
			"C"
		end

	syb_rollback: INTEGER
		external
			"C"
		end

	syb_trancount: INTEGER
		external
			"C"
		end

	syb_begin: INTEGER
		external
			"C"
		end

	syb_connect (user_name, user_passwd, appl, host: POINTER): INTEGER
		external
			"C"
		end

	syb_results_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	syb_result_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	is_binary (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a binary type?
		require
			s_not_void: s /= Void
		do
			Result := s.code (1) = ('0').natural_32_code and then s.code (2) = ('x').natural_32_code
		ensure
			result_condition:
				Result implies (s.code (1) = ('0').natural_32_code and then s.code (2) = ('x').natural_32_code)
		end

	syb_available_descriptor: INTEGER
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class SYBASE


