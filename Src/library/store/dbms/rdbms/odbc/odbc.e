indexing
	description: "ODBC specification"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ODBC

inherit
	DATABASE

		redefine
			sensitive_mixed,
			identifier_quoter,
			qualifier_seperator,
			parse,
			put_column_name,
			update_map_table_error,
			user_name_ok,
			hide_qualifier,
			pre_immediate,
			sql_adapt_db,
			Max_char_size,
			support_proc,
			store_proc_not_supported,
			drop_proc_not_supported,
			text_not_supported,
			exec_proc_not_supported,
			unset_catalog_flag
		end

	STRING_HANDLER

feature

	database_handle_name: STRING is "ODBC"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an ODBC function been called since last update which may have
			-- updated error code, error message or warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error is
			-- Reset database error status.
		do
			odbc_clear_error
		end

	insert_auto_identity_column: BOOLEAN is False
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?		

feature -- For DATABASE_CHANGE


	descriptor_is_available: BOOLEAN is
		do
			Result := odbc_available_descriptor /= 0
		end


	hide_qualifier (tmp_strg: STRING): POINTER is
		local
			c_temp: C_STRING
		do
			create c_temp.make (tmp_strg)
			Result := odbc_hide_qualifier (c_temp.item)
		end

	pre_immediate (descriptor, i: INTEGER) is
		do
			odbc_pre_immediate (descriptor, i)
			is_error_updated := False
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		do
			create Result.make (1)
			Result.from_c (odbc_date_to_str (object.year, object.month, object.day, object.hour, object.minute, object.second, 2))
			Result.prepend ("{ts %'")
			Result.append ("%'}")
		end

	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'.
		do
			if object /= Void and then not object.is_empty then
				if not is_binary (object) then
					Result := object.twin
					Result.replace_substring_all ("'", "''")
					Result.precede ('%'')
					Result.extend ('%'')
				end
			else
				Result := "NULL"
			end
		end

	True_representation: STRING is "1"

	False_representation: STRING is "0"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN is False

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN is
		local
			tmp_str: STRING
			c_temp: C_STRING
		do
			create c_temp.make (sql)
			create tmp_str.make (1)
			tmp_str.from_c (odbc_hide_qualifier (c_temp.item))
			tmp_str.left_adjust
			if tmp_str.count > 1 and then (tmp_str.substring (1, 1)).is_equal ("{") then
				if uht.count > 0 then
					if uhandle.execution_type.immediate_execution then
						odbc_pre_immediate (descriptor, uht.count)
					else
						odbc_init_order (descriptor, c_temp.item, uht.count)
					end
					is_error_updated := False
					if para /= Void then
-- ADDED PGC
						para.release
						para.resize (uht.count)
					else
						create para.make (uht.count)
					end
--
					bind_args_value (descriptor, uht, ht_order) -- PGC: Pourquoi ???
				end
--				if para /= Void then
--					para.release
--				end
				Result := True
			else
 				Result := False
			end
		end

	bind_parameter (table: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: STRING) is
		local
			i: INTEGER
			object : ANY
			tmp_str: STRING
			tmp_c: C_STRING
			tmp_date: DATE_TIME
			type: INTEGER
			ptr : POINTER_REF
			l_managed_pointer: MANAGED_POINTER
		do
			if para /= Void then
				para.release
				para.resize (table.count)
			else
				create para.make (table.count)
			end
			create tmp_str.make (1)
			from
				i := table.lower
			until
				i > table.upper
			loop
				type := -1
				object := table.item (i)
				ptr ?= object
				if ptr /= Void then -- NULL value
					para.set (Void, i)
				else
					if obj_is_string (object) then
						type := c_string_type
					elseif obj_is_integer (object) then
						type := c_integer_type
					elseif obj_is_date (object) then
						type := c_date_type
						tmp_date ?= object
					elseif obj_is_double (object) then
						type := c_float_type
					elseif obj_is_real (object) then
						type := c_real_type
					elseif obj_is_character (object) then
						type := c_character_type
					elseif obj_is_boolean (object) then
						type := c_boolean_type
					end
					tmp_str.wipe_out
					if type = c_date_type  then
						create l_managed_pointer.make (c_timestamp_struct_size)
						odbc_stru_of_date (l_managed_pointer.item, tmp_date.year, tmp_date.month,
							tmp_date.day, tmp_date.hour, tmp_date.minute, tmp_date.second, tmp_date.fractional_second.truncated_to_integer)
						para.set (l_managed_pointer, i)
					else
						tmp_str.append ( (object).out)
						create tmp_c.make (tmp_str)
						para.set (tmp_c.managed_data, i)
					end
				end -- Null value
				odbc_set_parameter (descriptor, i, 1, type,  odbc_get_col_len (descriptor, i), 0, para.get (i))
				is_error_updated := False
				i := i + 1
			end
		end


feature -- For DATABASE_STORE

	put_column_name (repository: DATABASE_REPOSITORY [like Current]; map_table: ARRAY [INTEGER]; obj: ANY): STRING is
		local
			i, j: INTEGER
			table: DB_TABLE
		do
			create Result.make (1)
			Result.append (" (")
			i := 0
			table ?= obj
			from
				j := 1
			until
				j > repository.dimension
			loop
				if (map_table.item (j) > 0) then
					if (i > 0) then
						Result.append (", ")
					end
					if table /= Void then
						if not (table.table_description.identity_column = j) then
							Result.append (repository.column_name (j))
							i := 1
						end
					else
						Result.append (repository.column_name (j))
						i := 1
					end
				end
				j := j + 1
 			end
			Result.append (") ")
		end

	update_map_table_error (uhandle: HANDLE; map_table: ARRAY [INTEGER]; ind: INTEGER) is
		do
			map_table.put (0, ind)
		end

feature -- DATABASE_STRING

	sql_name_string: STRING is
		once
			Result := "varchar (500)"
		ensure then
			Result.is_equal ("varchar (500)")
		end

feature -- DATABASE_REAL

	sql_name_real: STRING is
		once
			Result := "real"
		ensure then
			Result.is_equal ("real")
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING is
		local
			sep: STRING
		once
			create sep.make (1)
			sep.from_c (odbc_driver_name)
			if sep.substring_index ("Oracle", 1) /= 0 or sep.substring_index ("INGRES", 1) /= 0 then
				Result := " date"
			else
				Result := " datetime"
			end
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING is
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING is
		once
			Result := "char (1)"
		ensure then
			Result.is_equal ("char (1)")
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING is
		once
			Result := "integer"
		ensure then
			Result.is_equal ("integer")
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING is
		once
			Result := "bit"
		ensure then
			textual_outlook: Result.is_equal ("bit")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok and user_name_ok

	user_name_ok (uname: STRING): BOOLEAN is
		do
			Result := True
		end

	password_ok (upasswd: STRING): BOOLEAN is
		do
			Result := True
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN is
		do
			Result := True
		end

feature -- For DATABASE_PROC

	support_sql_of_proc: BOOLEAN is True

	text_not_supported: STRING is
		local
			driver_name: STRING
		do
			create driver_name.make (1)
			driver_name.from_c (odbc_driver_name)
			create Result.make (1)
			io.new_line
			io.put_string ("== Try to Get Text of Stored Procedure through EiffelStore on ODBC ==")
			io.new_line
			io.put_string ("Sorry, the ")
			io.put_string (driver_name)
			io.put_string (" driver does not support such function at present.")
			io.new_line
			io.put_string ("=====================================================================")
			io.new_line
		end

	support_stored_proc: BOOLEAN is
		do
			Result := odbc_support_create_proc = 1
		end

	sql_adapt_db (sql: STRING): STRING is
		do
			sql.replace_substring_all (":", "@")
			Result := sql
		end

	store_proc_not_supported is
		local
			driver_name: STRING
		do
			create driver_name.make (1)
			driver_name.from_c (odbc_driver_name)
			io.new_line
			io.put_string ("===== Try to Create Stored Procedure through EiffelStore on ODBC =====")
			io.new_line
			io.put_string ("Sorry, the ")
			io.put_string (driver_name)
			io.put_string (" driver does not support such function at present.")
			io.new_line
			io.put_string ("======================================================================")
			io.new_line
		end

	sql_as: STRING is " as "

	sql_end: STRING is ""

	sql_creation: STRING is "CREATE PROC "

	sql_execution: STRING is "{CALL "

	sql_after_exec: STRING is " }"

	exec_proc_not_supported is
		local
			driver_name: STRING
		do
			create driver_name.make (1)
			driver_name.from_c (odbc_driver_name)
			io.new_line
			io.put_string ("Sorry, the ")
			io.put_string (driver_name)
			io.put_string (" driver does not support such function at present.")
			io.new_line
		end

	support_drop_proc: BOOLEAN is
		do
			Result := odbc_support_create_proc = 1
		end

	drop_proc_not_supported is
		local
			driver_name: STRING
		do
			create driver_name.make (1)
			driver_name.from_c (odbc_driver_name)
			io.new_line
			io.put_string ("===== Try to Drop Stored Procedure through EiffelStore on ODBC =====")
			io.new_line
			io.put_string ("Sorry, the ")
			io.put_string (driver_name)
			io.put_string (" driver does not support such function at present.")
			io.new_line
			io.put_string ("====================================================================")
			io.new_line
		end

	name_proc_lower: BOOLEAN is True

	map_var_between: STRING is "@"

	map_var_name (par_name: STRING): STRING is
			-- Map variable string for late bound stored procedure execution
		once
			Result := "?"
		end

	Select_text (proc_name: STRING): STRING is
			--
		do
			Result := "SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = '" +
				proc_name + "' ORDER BY ROUTINE_NAME"
		end

	Select_exists (name: STRING): STRING is
		do
			create Result.make (10)
			Result.append ("SQLProcedures (")
			Result.append (name)
			Result.extend (')')
		end

feature -- For DATABASE_REPOSITORY

	sql_string: STRING is "char ("

	sql_string2 (int: INTEGER): STRING is
		do
			Result := "char ("
			Result.append (int.out)
			Result.append (")")
		end

	selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING is
		local
			c_tmp: C_STRING
		do
			create c_tmp.make (rep_qualifier)
			odbc_set_qualifier (c_tmp.item)
			create c_tmp.make (rep_owner)
			odbc_set_owner (c_tmp.item)
			create Result.make (1)
			Result.append ("SQLColumns (")
			Result.append (repository_name)
			Result.extend (')')
		end

	Max_char_size: INTEGER is 254

feature -- For DATABASE_DYN_STORE

	unset_catalog_flag (desc:INTEGER) is
		do
			odbc_unset_catalog_flag (desc)
		end

feature -- External

	get_error_message: POINTER is
		do
			Result := odbc_get_error_message
		end

	get_error_code: INTEGER is
		do
			Result := odbc_get_error_code
			is_error_updated := True
		end

	get_warn_message: POINTER is
		do
			Result := odbc_get_warn_message
		end

	new_descriptor: INTEGER is
		do
			Result := odbc_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: STRING) is
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			odbc_init_order (no_descriptor, c_temp.item, 0)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER) is
		do
			odbc_start_order (no_descriptor)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER) is
		do
			found := odbc_next_row (no_descriptor) = 0
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER) is
		do
			odbc_close_cursor (no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER) is
		do
			if para /= Void then
				para.release
			end
			odbc_terminate_order (no_descriptor)
			is_error_updated := False
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING) is
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			odbc_exec_immediate (no_descriptor, c_temp.item)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER is
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := odbc_put_col_name (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end

			ar.set_count (Result)

			from
				i := 1
			until
				i > Result
			loop
				ar.put (l_area.read_integer_8 (i - 1).to_character, i)
				i := i + 1
			end
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER is
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := odbc_put_data (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end

			ar.set_count (Result)

			from
				i := 1
			until
				i > Result
			loop
				ar.put (l_area.read_integer_8 (i - 1).to_character, i)
				i := i + 1
			end
		end

	sensitive_mixed: BOOLEAN is
		do
			Result := odbc_sensitive_mixed
		end

	identifier_quoter: STRING is
		do
			create Result.make (1)
			Result.from_c (odbc_identifier_quoter)
		end

	qualifier_seperator: STRING is
		do
			create Result.make (1)
			Result.from_c (odbc_qualifier_seperator)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
		do
			Result := odbc_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER is
		do
			Result := odbc_get_count (no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		do
			Result := odbc_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
		do
			Result := odbc_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		do
			Result := odbc_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- Is last retrieved data null?
		do
			Result := odbc_is_null_data (no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := odbc_get_month
		end

	c_string_type: INTEGER is
		do
			Result := odbc_c_string_type
		end

	c_character_type: INTEGER is
		do
			Result := odbc_c_character_type
		end

	c_integer_type: INTEGER is
		do
			Result := odbc_c_integer_type
		end

	c_float_type: INTEGER is
		do
			Result := odbc_c_float_type
		end

   	c_real_type: INTEGER is
		do
			Result := odbc_c_real_type
        	end

	c_boolean_type: INTEGER is
		do
			Result := odbc_c_boolean_type
		end

	c_date_type: INTEGER is
		do
			Result := odbc_c_date_type
		end

	database_make (i: INTEGER) is
		do
			c_odbc_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING) is
		require else
			data_source_set: data_source /= Void
		local
			c_temp1, c_temp2, c_temp3: C_STRING
		do
			create c_temp1.make (user_name)
			create c_temp2.make (user_passwd)
			create c_temp3.make (data_source)
			odbc_connect (c_temp1.item, c_temp2.item, c_temp3.item)
			is_error_updated := False
--			initialize_date_type_values
		end

	disconnect is
		do
			odbc_disconnect
			is_error_updated := False
			found := False
		end

	commit is
		do
			odbc_commit
			is_error_updated := False
		end

	rollback is
		do
			odbc_rollback
			is_error_updated := False
		end

	trancount: INTEGER is
		do
			Result := odbc_trancount
		end

	begin is
		do
			odbc_begin
		end

	support_proc: INTEGER is
		do
			Result := odbc_support_proc
		end

feature {NONE} -- External features

	odbc_get_error_message: POINTER is
			-- C buffer which contains the error_message.
		external
			"C use %"odbc.h%""
		end

	odbc_get_error_code: INTEGER is
			-- C buffer which contains the error code.
		external
			"C use %"odbc.h%""
		end

	odbc_get_warn_message: POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_new_descriptor: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_init_order (no_descriptor: INTEGER; command: POINTER; argnum: INTEGER) is
		external
			"C use %"odbc.h%""
		end

	odbc_start_order (no_descriptor: INTEGER) is
		external
			"C use %"odbc.h%""
		end

	odbc_next_row (no_descriptor: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_terminate_order (no_descriptor: INTEGER) is
		external
			"C use %"odbc.h%""
		end


	odbc_close_cursor (no_descriptor: INTEGER) is
		external
			"C use %"odbc.h%""
		end


	odbc_exec_immediate (no_descriptor: INTEGER; command: POINTER) is
		external
			"C use %"odbc.h%""
		end

	odbc_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_sensitive_mixed: BOOLEAN is
		external
			"C use %"odbc.h%""
		end

	odbc_identifier_quoter: POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_qualifier_seperator: POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_conv_type (index: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_count (no_descriptor: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_data_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_type (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_integer_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_float_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C use %"odbc.h%""
		end

	odbc_get_real_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C use %"odbc.h%""
		end

	odbc_get_boolean_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN is
		external
			"C use %"odbc.h%""
		end

	odbc_is_null_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN is
		external
			"C use %"odbc.h%""
		end

	odbc_get_date_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_hour: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_sec: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_min: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_year: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_day: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_get_month: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_c_string_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"STRING_TYPE"
		end

	odbc_c_character_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"CHARACTER_TYPE"
		end

	odbc_c_integer_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"INTEGER_TYPE"
		end

	odbc_c_float_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"FLOAT_TYPE"
		end

   	odbc_c_real_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"REAL_TYPE"
      	end

	odbc_c_boolean_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"BOOLEAN_TYPE"
		end

	odbc_c_date_type: INTEGER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"DATE_TYPE"
		end

	c_odbc_make (i: INTEGER) is
		external
			"C use %"odbc.h%""
		end

	odbc_disconnect is
		external
			"C use %"odbc.h%""
		end

	odbc_commit is
		external
			"C use %"odbc.h%""
		end

	odbc_rollback is
		external
			"C use %"odbc.h%""
		alias
			"odbc_rollback"
		end

	odbc_trancount: INTEGER is
		external
			"C use %"odbc.h%""
		alias
			"odbc_trancount"
		end

	odbc_begin is
		external
			"C use %"odbc.h%""
		alias
			"odbc_begin"
		end

	odbc_support_proc: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_connect (user_name, user_passwd, dbName: POINTER) is
		external
			"C use %"odbc.h%""
		end

	odbc_date_to_str (year, month, day, hour, minute, second, type: INTEGER): POINTER is
		-- Get string format of the TIME (type=0), DATE (type=1) or TIMESTAMP (type=2)
		external
			"C use %"odbc.h%""
		end

	odbc_driver_name: POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_support_create_proc: INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_unset_catalog_flag (desc: INTEGER) is
		external
			"C use %"odbc.h%""
		end

	odbc_hide_qualifier (command: POINTER): POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_pre_immediate (desc, argNum: INTEGER) is
		external
		    "C use %"odbc.h%""
		end

	is_binary (s: STRING): BOOLEAN is
			-- Is `s' a binary type?
		require
			s_not_void: s /= Void
		do
			Result := s.count > 2 and then s.item (1) = '0' and then s.item (2) = 'x'
		ensure
			result_condition:
				Result implies (s.count > 2 and then s.item (1) = '0' and then s.item (2) = 'x')
		end

	para: DB_PARA_ODBC

	bind_args_value (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; ht_order: ARRAYED_LIST [STRING]) is
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
		require
			arguments_mapped: not uht.is_empty
		local
			i,
			type: INTEGER
			tmp_str,
			l_string: STRING
			l_any: ANY
			tmp_date: DATE_TIME

			l_managed_pointer: MANAGED_POINTER
			l_c_string: C_STRING
			l_platform: PLATFORM

			l_val_string: STRING
			l_val_int: INTEGER_REF
			l_val_double: DOUBLE_REF
			l_val_real: REAL_REF
			l_val_bool: BOOLEAN_REF
			l_val_char: CHARACTER_REF

			l_value_count: INTEGER
		do
			create tmp_str.make (1)
			create l_platform
			i := 1
			from
				ht_order.start
				pointers.wipe_out
			until
				ht_order.off
			loop
				type := -1
				l_string := ht_order.item
				l_any := uht.item (l_string)
				if obj_is_string (l_any) then
					type := c_string_type
					l_val_string ?= l_any
					create l_c_string.make (l_val_string)
					pointers.extend (l_c_string.item)
					l_value_count := l_c_string.count
					l_managed_pointer := l_c_string.managed_data
				elseif obj_is_integer (l_any) then
					type := c_integer_type
					l_val_int ?= l_any
					create l_managed_pointer.make (l_platform.integer_bytes)
					l_managed_pointer.put_integer_32 (l_val_int.item, 0)
					pointers.extend (l_managed_pointer.item)
					l_value_count := l_platform.integer_bytes
				elseif obj_is_date (l_any) then
					type := c_date_type
					tmp_date ?= l_any
					create l_managed_pointer.make (c_timestamp_struct_size)
					odbc_stru_of_date (l_managed_pointer.item, tmp_date.year, tmp_date.month, tmp_date.day,
						 tmp_date.hour, tmp_date.minute, tmp_date.second, tmp_date.fractional_second.truncated_to_integer)
					l_value_count := c_timestamp_struct_size
				elseif obj_is_double (l_any) then
					type := c_float_type
					l_val_double ?= l_any
					create l_managed_pointer.make (l_platform.double_bytes)
					l_managed_pointer.put_real_64 (l_val_double.item, 0)
					pointers.extend (l_managed_pointer.item)
					l_value_count := l_platform.double_bytes
				elseif obj_is_real (l_any) then
					type := c_real_type
					l_val_real ?= l_any
					create l_managed_pointer.make (l_platform.real_bytes)
					l_managed_pointer.put_real_32 (l_val_real.item, 0)
					pointers.extend (l_managed_pointer.item)
					l_value_count := l_platform.real_bytes
				elseif obj_is_character (l_any) then
					type := c_character_type
					l_val_char ?= l_any
					create l_managed_pointer.make (l_platform.character_bytes)
					l_managed_pointer.put_character (l_val_char.item, 0)
					pointers.extend (l_managed_pointer.item)
					l_value_count := l_platform.character_bytes
				elseif obj_is_boolean (l_any) then
					type := c_boolean_type
					l_val_bool ?= l_any
					create l_managed_pointer.make (l_platform.boolean_bytes)
					l_managed_pointer.put_boolean (l_val_bool.item, 0)
					pointers.extend (l_managed_pointer.item)
					l_value_count := l_platform.boolean_bytes
				else
					 -- Should we attempt to insert NULL here since the type was not found and hence value was
					 -- most likely Void?
				end

				if type = -1 then
					print ("stop please")
				end

				check
					valid_type: type > 0
				end

				tmp_str.wipe_out

				para.set (l_managed_pointer, i)

				if l_value_count = 0 then
					l_value_count := 1
				end

				odbc_set_parameter (descriptor, i, 1, type, 100, l_value_count, para.get (i))

				is_error_updated := False
				i := i + 1
				ht_order.forth
			end
		end


	pointers: ARRAYED_LIST [POINTER] is
			--
		do
			create Result.make (10)
		end


feature {NONE} -- External features

   	odbc_set_parameter (no_desc, seri, direction, type, collength, value_count: INTEGER; value: POINTER) is
		external
		    "C use %"odbc.h%""
		end

	odbc_stru_of_date (a_date: POINTER; year, mon, day, hour, minute, sec, fraction: INTEGER) is
		external
		    "C inline use %"sql.h%""
		alias
			"[
				{
					((TIMESTAMP_STRUCT *)$a_date)->year = $year;
					((TIMESTAMP_STRUCT *)$a_date)->month = $mon;
					((TIMESTAMP_STRUCT *)$a_date)->day = $day;
					((TIMESTAMP_STRUCT *)$a_date)->hour = $hour;
					((TIMESTAMP_STRUCT *)$a_date)->minute = $minute;
					((TIMESTAMP_STRUCT *)$a_date)->second = $sec;
					((TIMESTAMP_STRUCT *)$a_date)->fraction = $fraction;
				}
			]"
		end

	c_timestamp_struct_size: INTEGER is
		external
			"C inline use %"sql.h%""
		alias
			"sizeof(TIMESTAMP_STRUCT)"
		end

	odbc_str_from_str (ptr: POINTER): POINTER is
		external
			"C use %"odbc.h%""
		end

	odbc_str_len (val: POINTER): INTEGER is
		external
		    "C use %"odbc.h%""
		end

	odbc_str_value (val: POINTER): POINTER is
		external
		    "C use %"odbc.h%""
		end

	obj_is_integer (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: INTEGER_REF
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_real (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: REAL_REF
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_double (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: DOUBLE_REF
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_string (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: STRING
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_character (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: CHARACTER_REF
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_boolean (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: BOOLEAN_REF
		do
			test ?= obj
			Result := test /= Void
		end

	obj_is_date (obj: ANY): BOOLEAN is
		require
			argument_not_null: obj /= Void
		local
			test: DATE_TIME
		do
			test ?= obj
			Result := test /= Void
		end

--	obj_is_pointer (obj : ANY) : BOOLEAN is
--		require
--			argument_not_null: obj /= Void
--		local
--			test : POINTER_REF
--		do
--			test ?= obj
--			Result := test /= Void
--		end

	odbc_set_qualifier (qlf: POINTER) is
		external
			"C use %"odbc.h%""
		end

	odbc_set_owner (owner: POINTER) is
		external
			"C use %"odbc.h%""
		end


	odbc_available_descriptor : INTEGER is
		external
			"C use %"odbc.h%""
		end

	odbc_clear_error is
		external
			"C use %"odbc.h%""
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ODBC


