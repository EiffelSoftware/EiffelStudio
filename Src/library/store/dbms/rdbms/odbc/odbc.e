indexing
	description: "ODBC specification";
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
			bind_parameter,
			support_proc,
			store_proc_not_supported,
			drop_proc_not_supported,
			text_not_supported,
			exec_proc_not_supported,
			unset_catalog_flag
		end

feature 

	database_handle_name: STRING is "ODBC"

feature -- For DATABASE_STATUS

	is_ok_mat: BOOLEAN

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

feature -- For DATABASE_CHANGE 


	descriptor_is_available: BOOLEAN is 
		do
			Result := odbc_available_descriptor /= 0
		end


	hide_qualifier (tmp_strg: STRING): POINTER is
		local
			c_temp: ANY
		do
			c_temp := tmp_strg.to_c
			Result := odbc_hide_qualifier ($c_temp)
		end

	pre_immediate (descriptor, i: INTEGER): INTEGER is
		do
			Result := odbc_pre_immediate (descriptor, i)
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
			-- String representation in SQL of `object'
		do
			Result := object
			if not is_binary (object) then
				Result.precede ('%'')
				Result.extend ('%'')
			end
		end

	True_representation: STRING is "1"

	False_representation: STRING is "0"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN is False

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN is
		local
			tmp_str: STRING
			c_temp: ANY
		do
			c_temp := sql.to_c
			create tmp_str.make (1)
			tmp_str.from_c (odbc_hide_qualifier ($c_temp))
			tmp_str.left_adjust
			if tmp_str.count > 1 and then (tmp_str.substring (1, 1)).is_equal ("{") then
				if uht.count > 0 then
			--FIXME:must be droppable...		if uhandle.execution_type.immediate_execution then
			--			uhandle.status.set (odbc_pre_immediate (descriptor, uht.count))
			--		else
			--			uhandle.status.set (odbc_init_order (descriptor, $c_temp, uht.count))
			--		end
					if para /= Void then
-- ADDED PGC
						para.release
						para.resize (uht.count)
					else
						create para.make (uht.count)
					end
					bind_args_value (descriptor, uht, uhandle) -- PGC: Pourquoi ???
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
			tmp_c: ANY
			tmp_date: DATE_TIME
			type: INTEGER
			ptr : POINTER_REF
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
					para.set (default_pointer, i)
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
						para.set (odbc_stru_of_date (tmp_date.year, tmp_date.month, tmp_date.day, tmp_date.hour, tmp_date.minute, tmp_date.second, 2), i)
					else
						tmp_str.append ( (object).out)
						para.set (default_pointer, i)
						tmp_c := tmp_str.to_c
						para.set (odbc_str_from_str ($tmp_c), i)
					end
				end -- Null value
		--		uhandle.status.set (odbc_set_parameter (descriptor, i, 1, type, para.get (i)))
				i := i + 1
			end
		end

  
feature -- For DATABASE_STORE

	put_column_name (repository: DATABASE_REPOSITORY [like Current]; map_table: ARRAY [INTEGER]): STRING is
		local
			i, j: INTEGER
		do
			create Result.make (1)
			Result.append (" (")
			i := 0
			from 
				j := 1
			until
				j > repository.dimension
			loop
				if (map_table.item (j) > 0) then
					if (i > 0) then
						Result.append (", ")
					else
						i := 1
					end
					Result.append (repository.column_name (j))
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
			Result := "char ("
		ensure then
			Result.is_equal ("char (")
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
				Result := " timestamp"
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

	support_sql_of_proc: BOOLEAN is False

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

	sql_creation: STRING is "CREATE PROC"

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

	Select_text: STRING is ""

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
			c_tmp: ANY
		do
			c_tmp := rep_qualifier.to_c
			odbc_set_qualifier ($c_tmp)
			c_tmp := rep_owner.to_c
			odbc_set_owner ($c_tmp)
			create Result.make (1)
			Result.append ("SQLColumns (")
			Result.append (repository_name)
			Result.extend (')')
		end

	Max_char_size: INTEGER is 254

feature -- For DATABASE_DYN_STORE

	unset_catalog_flag (desc:INTEGER): INTEGER is
		do	
			Result := odbc_unset_catalog_flag (desc)
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
			c_temp: ANY
		do
			c_temp := command.to_c
			odbc_init_order (no_descriptor, $c_temp, 0)
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

	close_cursor (no_descriptor: INTEGER): INTEGER is
		do
			Result := odbc_close_cursor (no_descriptor)
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
			c_temp: ANY
		do
			c_temp := command.to_c
			odbc_exec_immediate (no_descriptor, $c_temp)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := odbc_put_col_name (no_descriptor, index, $ar)
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := odbc_put_data (no_descriptor, index, $ar)
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
			-- is last retrieved data null? 
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
			c_temp1, c_temp2, c_temp3: ANY	
		do
			c_temp1 := user_name.to_c
			c_temp2 := user_passwd.to_c
			c_temp3 := data_source.to_c
			odbc_connect ($c_temp1, $c_temp2, $c_temp3)
			is_error_updated := False
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

	begin: INTEGER is
		do
			Result := odbc_begin
		end

	database_handle: DATABASE_HANDLE [ODBC] is
		once
			create Result
		end

	support_proc: INTEGER is
		do
			Result := odbc_support_proc
		end

feature {NONE} -- External features

	odbc_get_error_message: POINTER is
			-- C buffer which contains the error_message.
		external
			"C [macro %"odbc.h%"]"
		alias
			"error_message"
		end

	odbc_get_error_code: INTEGER is
			-- C buffer which contains the error code.
		external
			"C [macro %"odbc.h%"]"
		alias
			"error_number"
		end

	odbc_get_warn_message: POINTER is
		external
			"C [macro %"odbc.h%"]"
		alias
			"warn_message"
		end

	odbc_new_descriptor: INTEGER is
		external
			"C"
		end

	odbc_init_order (no_descriptor: INTEGER; command: POINTER; argnum: INTEGER) is
		external
			"C"
		end

	odbc_start_order (no_descriptor: INTEGER) is
		external
			"C"
		end

	odbc_next_row (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_terminate_order (no_descriptor: INTEGER) is
		external
			"C"
		end


	odbc_close_cursor (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end


	odbc_exec_immediate (no_descriptor: INTEGER; command: POINTER) is
		external
			"C"
		end

	odbc_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C"
		end

	odbc_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C"
		end

	odbc_sensitive_mixed: BOOLEAN is
		external
			"C"
		end

	odbc_identifier_quoter: POINTER is
		external
			"C"
		end

	odbc_qualifier_seperator: POINTER is 
		external
			"C"
		end

	odbc_conv_type (index: INTEGER): INTEGER is
		external
			"C"	
		end

	odbc_get_count (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_data_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_col_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_col_type (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_integer_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_float_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C"
		end

	odbc_get_real_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C"
		end

	odbc_get_boolean_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN is
		external
			"C"
		end

	odbc_is_null_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN is
		external
			"C"
		end

	odbc_get_date_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_get_hour: INTEGER is
		external
			"C"
		end

	odbc_get_sec: INTEGER is
		external
			"C"
		end

	odbc_get_min: INTEGER is
		external
			"C"
		end

	odbc_get_year: INTEGER is
		external
			"C"
		end

	odbc_get_day: INTEGER is
		external
			"C"
		end

	odbc_get_month: INTEGER is
		external
			"C"
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
			"C"
		end

	odbc_disconnect is
		external
			"C"
		end

	odbc_commit is
		external
			"C"
		end

	odbc_rollback is
		external
			"C"
		alias
			"odbc_rollback"
		end

	odbc_trancount: INTEGER is
		external
			"C"
		alias
			"odbc_trancount"
		end

	odbc_begin: INTEGER is
		external
			"C"
		alias
			"odbc_begin"
		end

	odbc_support_proc: INTEGER is
		external
			"C"
		end

	odbc_connect (user_name, user_passwd, dbName: POINTER) is
		external
			"C"
		end

	odbc_date_to_str (year, month, day, hour, minute, second, type: INTEGER): POINTER is
		-- Get string format of the TIME (type=0), DATE (type=1) or TIMESTAMP (type=2)
		external
			"C"
		end

	odbc_driver_name: POINTER is
		external
			"C"
		end

	odbc_support_create_proc: INTEGER is
		external
			"C"
		end

	odbc_unset_catalog_flag (desc: INTEGER): INTEGER is
		external
			"C"
		end

	odbc_hide_qualifier (command: POINTER): POINTER is
		external
			"C"
		end

	odbc_pre_immediate (desc, argNum: INTEGER): INTEGER is
		external
		    "C"
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

	bind_args_value (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; uhandle: HANDLE)   is
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
		require
			arguments_mapped: not uht.is_empty
		local 
			i: INTEGER
			tmp_str: STRING
			tmp_c: ANY
			tmp_date: DATE_TIME
			type: INTEGER
		do
			create tmp_str.make (1)
			i := 1
			from
				uht.start
			until
				uht.off
			loop
				type := -1
				if obj_is_string (uht.item (uht.key_for_iteration)) then
					type := c_string_type
				elseif obj_is_integer (uht.item (uht.key_for_iteration)) then
					type := c_integer_type
				elseif obj_is_date (uht.item (uht.key_for_iteration)) then
					type := c_date_type
					tmp_date ?= uht.item (uht.key_for_iteration)
				elseif obj_is_double (uht.item (uht.key_for_iteration)) then
					type := c_float_type
				elseif obj_is_real (uht.item (uht.key_for_iteration)) then
					type := c_real_type
				elseif obj_is_character (uht.item (uht.key_for_iteration)) then
					type := c_character_type
				elseif obj_is_boolean (uht.item (uht.key_for_iteration)) then
					type := c_boolean_type
				end
				tmp_str.wipe_out
				if type = c_date_type  then
					para.set (odbc_stru_of_date (tmp_date.year, tmp_date.month, tmp_date.day, tmp_date.hour, tmp_date.minute, tmp_date.second, 2), i)
				else
					tmp_str.append ( (uht.item (uht.key_for_iteration)).out)
				        tmp_c := tmp_str.to_c
					para.set (odbc_str_from_str ($tmp_c), i)
				end
			--	uhandle.status.set (odbc_set_parameter (descriptor, i, 1, type, para.get (i)))
				uhandle.status.set (odbc_set_parameter (descriptor, uht.key_for_iteration.to_integer, 1, type, para.get (i)))
				i := i + 1
				uht.forth
			end
		end

feature {NONE} -- External features

   	odbc_set_parameter (no_desc, seri, direction, type: INTEGER; value: POINTER): INTEGER is
		external
		    "C"
		end

	odbc_stru_of_date (year, mon, day, hour, minute, sec, mode: INTEGER): POINTER is
		external
		    "C"
		end

	odbc_str_from_str (ptr: POINTER): POINTER is
		external
		    "C"
		end

	odbc_str_len (val: POINTER): INTEGER is
		external
		    "C"
		end

	odbc_str_value (val: POINTER): POINTER is
		external
		    "C"
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
			"C"
		end

	odbc_set_owner (owner: POINTER) is
		external
			"C"
		end


	odbc_available_descriptor : INTEGER is
		external
			"C"
		end

	odbc_clear_error is
		external
			"C"
		end

invariant
		test_false : is_ok_mat = False
end -- class ODBC
