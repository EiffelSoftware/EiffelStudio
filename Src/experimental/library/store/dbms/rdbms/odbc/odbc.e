note
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

	database_handle_name: STRING = "ODBC"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an ODBC function been called since last update which may have
			-- updated error code, error message or warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
			odbc_clear_error
		end

	insert_auto_identity_column: BOOLEAN = False
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?		

feature -- For DATABASE_CHANGE


	descriptor_is_available: BOOLEAN
		do
			Result := odbc_available_descriptor /= 0
		end


	hide_qualifier (tmp_strg: STRING): POINTER
		local
			c_temp: C_STRING
		do
			create c_temp.make (tmp_strg)
			Result := odbc_hide_qualifier (c_temp.item)
		end

	pre_immediate (descriptor, i: INTEGER)
		do
			odbc_pre_immediate (descriptor, i)
			is_error_updated := False
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
		do
				-- Format shall be {ts 'yyyy-mm-dd hh:mm:ss'}
			create Result.make (30)
			Result.append ("{ts '")
			Result.append (object.formatted_out (once "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss"))
			Result.append ("'}")
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'.
		do
			if object /= Void and then not object.is_empty then
				if not is_binary (object) then
					Result := object.twin
					Result.replace_substring_all ("\", "\\")
					Result.replace_substring_all ("'", "''")
					Result.precede ('%'')
					Result.extend ('%'')
				else
					-- FIXME: fool compiler and bug here
					Result := "NULL"
				end
			else
				Result := "NULL"
			end
		end

	True_representation: STRING = "1"

	False_representation: STRING = "0"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN = False

	parse (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [ANY]; ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN
		local
			tmp_str: STRING
			c_temp: C_STRING
			l_para: like para
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
					l_para := para
					if l_para /= Void then
-- ADDED PGC
						l_para.release
						l_para.resize (uht.count)
					else
						create l_para.make (uht.count)
						para := l_para
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

	bind_parameter (table: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: STRING)
		local
			i: INTEGER
			object : ANY
			tmp_str: STRING
			tmp_c: C_STRING
			tmp_date: detachable DATE_TIME
			type: INTEGER
			l_managed_pointer: MANAGED_POINTER
			l_para: like para
		do
			l_para := para
			if l_para /= Void then
				l_para.release
				l_para.resize (table.count)
			else
				create l_para.make (table.count)
				para := l_para
			end
			create tmp_str.make (1)
			from
				i := table.lower
			until
				i > table.upper
			loop
				type := -1
				object := table.item (i)
				if attached {POINTER_REF} object as ptr then -- NULL value
					l_para.set (Void, i)
				else
					if obj_is_string (object) then
						type := c_string_type
					elseif obj_is_integer (object) then
						type := c_integer_type
					elseif obj_is_date (object) then
						type := c_date_type
						if attached {DATE_TIME} object as l_tmp_date then
							tmp_date := l_tmp_date
						else
							check False end -- implied by `obj_is_date (object)'
						end
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
						check tmp_date /= Void end -- Implied by `type = c_date_type'
						odbc_stru_of_date (l_managed_pointer.item, tmp_date.year, tmp_date.month,
							tmp_date.day, tmp_date.hour, tmp_date.minute, tmp_date.second, tmp_date.fractional_second.truncated_to_integer)
						l_para.set (l_managed_pointer, i)
					else
						tmp_str.append ( (object).out)
						create tmp_c.make (tmp_str)
						l_para.set (tmp_c.managed_data, i)
					end
				end -- Null value
				odbc_set_parameter (descriptor, i, 1, type,  odbc_get_col_len (descriptor, i), 0, l_para.get (i))
				is_error_updated := False
				i := i + 1
			end
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
		once
			Result := "varchar (500)"
		ensure then
			Result.is_equal ("varchar (500)")
		end

feature -- DATABASE_REAL

	sql_name_real: STRING
		once
			Result := "real"
		ensure then
			Result.is_equal ("real")
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING
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

	sql_name_double: STRING
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING
		once
			Result := "char (1)"
		ensure then
			Result.is_equal ("char (1)")
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING
		once
			Result := "integer"
		ensure then
			Result.is_equal ("integer")
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING
		once
			Result := "bit"
		ensure then
			textual_outlook: Result.is_equal ("bit")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok and user_name_ok

	user_name_ok (uname: STRING): BOOLEAN
		do
			Result := True
		end

	password_ok (upasswd: STRING): BOOLEAN
		do
			Result := True
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
		do
			Result := True
		end

feature -- For DATABASE_PROC

	support_sql_of_proc: BOOLEAN = True

	text_not_supported: STRING
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

	support_stored_proc: BOOLEAN
		do
			Result := odbc_support_create_proc = 1
		end

	sql_adapt_db (sql: STRING): STRING
		do
			sql.replace_substring_all (":", "@")
			Result := sql
		end

	store_proc_not_supported
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

	sql_as: STRING = " as "

	sql_end: STRING = ""

	sql_creation: STRING = "CREATE PROC "

	sql_execution: STRING = "{CALL "

	sql_after_exec: STRING = " }"

	exec_proc_not_supported
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

	support_drop_proc: BOOLEAN
		do
			Result := odbc_support_create_proc = 1
		end

	drop_proc_not_supported
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

	name_proc_lower: BOOLEAN
		do
			Result := not sensitive_mixed
		end

	map_var_between: STRING = "@"

	map_var_name (par_name: STRING): STRING
			-- Map variable string for late bound stored procedure execution
		once
			Result := "?"
		end

	Select_text (proc_name: STRING): STRING
			--
		do
			Result := "SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = '" +
				proc_name + "' ORDER BY ROUTINE_NAME"
		end

	Select_exists (name: STRING): STRING
		do
			create Result.make (10)
			Result.append ("SQLProcedures (")
			Result.append (name)
			Result.extend (')')
		end

feature -- For DATABASE_REPOSITORY

	sql_string: STRING = "char ("

	sql_string2 (int: INTEGER): STRING
		do
			Result := "char ("
			Result.append (int.out)
			Result.append (")")
		end

	selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
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

	Max_char_size: INTEGER = 254

feature -- For DATABASE_DYN_STORE

	unset_catalog_flag (desc:INTEGER)
		do
			odbc_unset_catalog_flag (desc)
		end

feature -- External

	get_error_message: POINTER
		do
			Result := odbc_get_error_message
		end

	get_error_code: INTEGER
		do
			Result := odbc_get_error_code
			is_error_updated := True
		end

	get_warn_message: POINTER
		do
			Result := odbc_get_warn_message
		end

	new_descriptor: INTEGER
		do
			Result := odbc_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: STRING)
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			odbc_init_order (no_descriptor, c_temp.item, 0)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER)
		do
			odbc_start_order (no_descriptor)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER)
		do
			found := odbc_next_row (no_descriptor) = 0
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER)
		do
			odbc_close_cursor (no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER)
		local
			l_para: like para
		do
			l_para := para
			if l_para /= Void then
				l_para.release
			end
			odbc_terminate_order (no_descriptor)
			is_error_updated := False
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING)
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			odbc_exec_immediate (no_descriptor, c_temp.item)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := odbc_put_col_name (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end
			ar.resize (Result)
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
			l_data, l_null: POINTER
		do
			Result := odbc_put_data (no_descriptor, index, $l_data)
			ar.resize (Result)
			ar.set_count (Result)
			if Result > 0 then
				create l_area.share_from_pointer (l_data, Result)
				from
					i := 1
				until
					i > Result
				loop
					ar.put (l_area.read_integer_8 (i - 1).to_character_8, i)
					i := i + 1
				end
			end
			if l_data /= l_null then
					-- `odbc_put_data' allocate some memory, we need to free it.
				l_data.memory_free
			end
		end

	sensitive_mixed: BOOLEAN
		do
			Result := odbc_sensitive_mixed
		end

	identifier_quoter: STRING
		do
			create Result.make (1)
			Result.from_c (odbc_identifier_quoter)
		end

	qualifier_seperator: STRING
		do
			create Result.make (1)
			Result.from_c (odbc_qualifier_seperator)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := odbc_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER
		do
			Result := odbc_get_count (no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := odbc_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := odbc_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
			Result := odbc_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is last retrieved data null?
		do
			Result := odbc_is_null_data (no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_month
		end

	c_string_type: INTEGER
		do
			Result := odbc_c_string_type
		end

	c_character_type: INTEGER
		do
			Result := odbc_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := odbc_c_integer_type
		end

	c_float_type: INTEGER
		do
			Result := odbc_c_float_type
		end

   	c_real_type: INTEGER
		do
			Result := odbc_c_real_type
        	end

	c_boolean_type: INTEGER
		do
			Result := odbc_c_boolean_type
		end

	c_date_type: INTEGER
		do
			Result := odbc_c_date_type
		end

	database_make (i: INTEGER)
		do
			c_odbc_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING)
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

	disconnect
		do
			odbc_disconnect
			is_error_updated := False
			found := False
		end

	commit
		do
			odbc_commit
			is_error_updated := False
		end

	rollback
		do
			odbc_rollback
			is_error_updated := False
		end

	trancount: INTEGER
		do
			Result := odbc_trancount
		end

	begin
		do
			odbc_begin
		end

	support_proc: BOOLEAN
		do
			Result := odbc_support_proc = 1
		end

feature {NONE} -- External features

	odbc_get_error_message: POINTER
			-- C buffer which contains the error_message.
		external
			"C use %"odbc.h%""
		end

	odbc_get_error_code: INTEGER
			-- C buffer which contains the error code.
		external
			"C use %"odbc.h%""
		end

	odbc_get_warn_message: POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_new_descriptor: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_init_order (no_descriptor: INTEGER; command: POINTER; argnum: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_start_order (no_descriptor: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_next_row (no_descriptor: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_terminate_order (no_descriptor: INTEGER)
		external
			"C use %"odbc.h%""
		end


	odbc_close_cursor (no_descriptor: INTEGER)
		external
			"C use %"odbc.h%""
		end


	odbc_exec_immediate (no_descriptor: INTEGER; command: POINTER)
		external
			"C use %"odbc.h%""
		end

	odbc_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_put_data (no_descriptor: INTEGER; index: INTEGER; ar: TYPED_POINTER [POINTER]): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_sensitive_mixed: BOOLEAN
		external
			"C use %"odbc.h%""
		end

	odbc_identifier_quoter: POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_qualifier_seperator: POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_conv_type (index: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_count (no_descriptor: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_data_len (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_len (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_type (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_integer_data (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_float_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C use %"odbc.h%""
		end

	odbc_get_real_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C use %"odbc.h%""
		end

	odbc_get_boolean_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN
		external
			"C use %"odbc.h%""
		end

	odbc_is_null_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN
		external
			"C use %"odbc.h%""
		end

	odbc_get_date_data (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_hour: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_sec: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_min: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_year: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_day: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_month: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_c_string_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"STRING_TYPE"
		end

	odbc_c_character_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"CHARACTER_TYPE"
		end

	odbc_c_integer_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"INTEGER_TYPE"
		end

	odbc_c_float_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"FLOAT_TYPE"
		end

   	odbc_c_real_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"REAL_TYPE"
      	end

	odbc_c_boolean_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"BOOLEAN_TYPE"
		end

	odbc_c_date_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"DATE_TYPE"
		end

	c_odbc_make (i: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_disconnect
		external
			"C use %"odbc.h%""
		end

	odbc_commit
		external
			"C use %"odbc.h%""
		end

	odbc_rollback
		external
			"C use %"odbc.h%""
		alias
			"odbc_rollback"
		end

	odbc_trancount: INTEGER
		external
			"C use %"odbc.h%""
		alias
			"odbc_trancount"
		end

	odbc_begin
		external
			"C use %"odbc.h%""
		alias
			"odbc_begin"
		end

	odbc_support_proc: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_connect (user_name, user_passwd, dbName: POINTER)
		external
			"C use %"odbc.h%""
		end

	odbc_driver_name: POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_support_create_proc: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_unset_catalog_flag (desc: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_hide_qualifier (command: POINTER): POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_pre_immediate (desc, argNum: INTEGER)
		external
		    "C use %"odbc.h%""
		end

	is_binary (s: STRING): BOOLEAN
			-- Is `s' a binary type?
		require
			s_not_void: s /= Void
		do
			Result := s.count > 2 and then s.item (1) = '0' and then s.item (2) = 'x'
		ensure
			result_condition:
				Result implies (s.count > 2 and then s.item (1) = '0' and then s.item (2) = 'x')
		end

	para: detachable DB_PARA_ODBC

	bind_args_value (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [ANY]; ht_order: ARRAYED_LIST [STRING])
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
		require
			uht_not_void: uht /= Void
			arguments_mapped: not uht.is_empty
		local
			i,
			type: INTEGER
			tmp_str,
			l_string: STRING
			l_any: detachable ANY
			tmp_date: DATE_TIME
			l_managed_pointer: detachable MANAGED_POINTER
			l_c_string: C_STRING
			l_platform: PLATFORM
			l_value_count: INTEGER
			l_para: like para
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
				check l_any /= Void end -- FIXME: bug here?
				if obj_is_string (l_any) then
					type := c_string_type
					if attached {STRING} l_any as l_val_string then
						create l_c_string.make (l_val_string)
						pointers.extend (l_c_string.item)
						l_value_count := l_c_string.count
						l_managed_pointer := l_c_string.managed_data
					else
						check False end -- implied by `obj_is_string (l_any)'
					end
				elseif obj_is_integer (l_any) then
					type := c_integer_type
					if attached {INTEGER_REF} l_any as l_val_int then
						create l_managed_pointer.make (l_platform.integer_bytes)
						l_managed_pointer.put_integer_32 (l_val_int.item, 0)
						pointers.extend (l_managed_pointer.item)
						l_value_count := l_platform.integer_bytes
					else
						check False end -- implied by `obj_is_integer (l_any)'
					end
				elseif obj_is_date (l_any) then
					type := c_date_type
					if attached {DATE_TIME} l_any as l_tmp_date then
						tmp_date := l_tmp_date
						create l_managed_pointer.make (c_timestamp_struct_size)
						odbc_stru_of_date (l_managed_pointer.item, tmp_date.year, tmp_date.month, tmp_date.day,
							 tmp_date.hour, tmp_date.minute, tmp_date.second, tmp_date.fractional_second.truncated_to_integer)
						l_value_count := c_timestamp_struct_size
					else
						check False end -- implied by `obj_is_date (l_any)'
					end
				elseif obj_is_double (l_any) then
					type := c_float_type
					if attached {DOUBLE_REF} l_any as l_val_double then
						create l_managed_pointer.make (l_platform.double_bytes)
						l_managed_pointer.put_real_64 (l_val_double.item, 0)
						pointers.extend (l_managed_pointer.item)
						l_value_count := l_platform.double_bytes
					else
						check False end -- implied by `obj_is_double (l_any)'
					end
				elseif obj_is_real (l_any) then
					type := c_real_type
					if attached {REAL_REF} l_any as l_val_real then
						create l_managed_pointer.make (l_platform.real_bytes)
						l_managed_pointer.put_real_32 (l_val_real.item, 0)
						pointers.extend (l_managed_pointer.item)
						l_value_count := l_platform.real_bytes
					else
						check False end -- implied by `obj_is_real (l_any)'
					end
				elseif obj_is_character (l_any) then
					type := c_character_type
					if attached {CHARACTER_REF} l_any as l_val_char then
						create l_managed_pointer.make (l_platform.character_bytes)
						l_managed_pointer.put_character (l_val_char.item, 0)
						pointers.extend (l_managed_pointer.item)
						l_value_count := l_platform.character_bytes
					else
						check False end -- implied by `obj_is_character (l_any)'
					end
				elseif obj_is_boolean (l_any) then
					type := c_boolean_type
					if attached {BOOLEAN_REF} l_any as l_val_bool  then
						create l_managed_pointer.make (l_platform.boolean_bytes)
						l_managed_pointer.put_boolean (l_val_bool.item, 0)
						pointers.extend (l_managed_pointer.item)
						l_value_count := l_platform.boolean_bytes
					else
						check False end -- implied by `obj_is_boolean (l_any)'
					end
				else
					 -- Should we attempt to insert NULL here since the type was not found and hence value was
					 -- most likely Void?
				end

				check l_para /= Void end -- FIXME: bug?
				if type = -1 then
					l_para.set (Void, i)
				else
					check l_managed_pointer /= Void end -- implied by `type /= -1' and previous codes
					l_para.set (l_managed_pointer, i)
				end

				tmp_str.wipe_out
				if l_value_count = 0 then
					l_value_count := 1
				end

				odbc_set_parameter (descriptor, i, 1, type, 100, l_value_count, l_para.get (i))

				is_error_updated := False
				i := i + 1
				ht_order.forth
			end
		end


	pointers: ARRAYED_LIST [POINTER]
			--
		do
			create Result.make (10)
		end


feature {NONE} -- External features

   	odbc_set_parameter (no_desc, seri, direction, type, collength, value_count: INTEGER; value: POINTER)
		external
		    "C use %"odbc.h%""
		end

	odbc_stru_of_date (a_date: POINTER; year, mon, day, hour, minute, sec, fraction: INTEGER)
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

	c_timestamp_struct_size: INTEGER
		external
			"C inline use %"sql.h%""
		alias
			"sizeof(TIMESTAMP_STRUCT)"
		end

	odbc_str_from_str (ptr: POINTER): POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_str_len (val: POINTER): INTEGER
		external
		    "C use %"odbc.h%""
		end

	odbc_str_value (val: POINTER): POINTER
		external
		    "C use %"odbc.h%""
		end

	obj_is_integer (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {INTEGER_REF} obj
		end

	obj_is_real (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {REAL_REF} obj
		end

	obj_is_double (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {DOUBLE_REF} obj
		end

	obj_is_string (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {STRING} obj
		end

	obj_is_character (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {CHARACTER_REF} obj
		end

	obj_is_boolean (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {BOOLEAN_REF} obj
		end

	obj_is_date (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {DATE_TIME} obj
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

	odbc_set_qualifier (qlf: POINTER)
		external
			"C use %"odbc.h%""
		end

	odbc_set_owner (owner: POINTER)
		external
			"C use %"odbc.h%""
		end


	odbc_available_descriptor : INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_clear_error
		external
			"C use %"odbc.h%""
		end

note
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


