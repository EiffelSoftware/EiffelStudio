indexing
	description: "Oracle specification";
	date: "$Date$"
	revision: "$Revision$"

class 
	ORACLE

inherit
	DATABASE
		redefine
			normal_parse,
			parse,
			update_map_table_error,
			bind_parameter,
			convert_string_type
		end

feature

	database_handle_name: STRING is "ORACLE"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an Oracle function been called since last update which may have
			-- updated error code, error message or warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error is
			-- Reset database error status.
		do
			ora_clear_error
		end

feature -- For DATABASE_CHANGE 

	descriptor_is_available: BOOLEAN is
		do
			Result := ora_available_descriptor = 1
		end

feature -- For DATABASE_FORMAT
	
	date_to_str (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		do
			create Result.make (1)
			Result.append ("to_date ('")
			Result.append (object.formatted_out ("[0]mm/[0]dd/yyyy [0]hh:mi:ss"))
			Result.append ("','MM/DD/YYYY HH24:MI:SS')")
		end
	
	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'.
			-- WARNING: use "IS NULL" if object is empty instead of
			-- "= NULL" which does not work.
		do
			if object /= Void and then not object.is_empty then
				Result := clone (object)
				Result.replace_substring_all ("'", "''")
				if Result.count > Max_char_size then
					Result := break (Result)
				end
				Result.precede ('%'')
				Result.extend ('%'')
			else
				Result := "NULL"
			end
		end

	True_representation: STRING is "'T'"

	False_representation: STRING is "'F'"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN is 
		do
			if is_proc then
				Result := False
				is_proc := False
			else	
				Result := True
			end
		end

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN is
		do
			if uhandle.execution_type.immediate_execution then
				Result := True
			else
				init_order (descriptor, sql)
				bind_args_value (descriptor, uht, sql)
				Result := True
			end
		end

	bind_parameter (value: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: STRING) is
		local
			i: INTEGER
			tmp_c2, tmp_c, c_temp: ANY
		do
			c_temp := sql.to_c
			from
				i:=1
			until
				value.count<i
			loop
				tmp_c := (value.item (i).out).to_c
				tmp_c2 := (parameters.item (i).out).to_c
				ora_set_parameter (descriptor, $c_temp, $tmp_c2, $tmp_c)
				i := i + 1
			end
			is_error_updated := False
		end

	bind_args_value (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; sql: STRING) is
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
			-- `uht' can be empty (for stored procedures).
		local 
			tmp_c, tmp_c2, c_temp: ANY
		do
			c_temp := sql.to_c
			from
				uht.start
			until
				uht.off
			loop
				tmp_c := (uht.item (uht.key_for_iteration).out).to_c
				tmp_c2 := (uht.key_for_iteration).out.to_c
				ora_set_parameter (descriptor, $c_temp, $tmp_c2, $tmp_c)
				uht.forth
			end
			is_error_updated := False
		end

feature -- For DATABASE_STORE

	update_map_table_error (uhandle: HANDLE; map_table: ARRAY [INTEGER]; ind: INTEGER) is 
		do
			map_table.put (0, ind)
		end

feature -- DATABASE_STRING

	sql_name_string: STRING is 
		do
			Result := "VARCHAR2"
		end

feature -- DATABASE_REAL

	sql_name_real: STRING is "FLOAT"

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING is "DATE"

feature -- DATABASE_DOUBLE

	sql_name_double: STRING is "FLOAT" 

feature -- DATABASE_CHARACTER

	sql_name_character: STRING is "CHAR"

feature -- DATABASE_INTEGER

	sql_name_integer: STRING is "NUMBER"

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING is "CHAR"

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN is
		do
			Result := upasswd /= Void
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN is
		do
			Result := name.is_equal (uname) and passwd.is_equal (upasswd)
		end

feature -- For database types

	convert_string_type (r_any: ANY; field_name, class_name: STRING): ANY is
			-- Convert `r_any' to the expected object.
			-- By default returns `r_any', redefined in ORACLE to return
			-- an INTEGER_REF when `field_name' is "data_type".
		local
			data_type: INTEGER_REF
		do
			if field_name.is_equal ("data_type") then
				if class_name.is_equal ("STRING") then
					create data_type
					if r_any.is_equal ("VARCHAR2") or else r_any.is_equal ("CHAR") then
						data_type.set_item (ora_string_type)
					elseif r_any.is_equal ("NUMBER") then
						data_type.set_item (ora_number_type)
					elseif r_any.is_equal ("DATE") then
						data_type.set_item (ora_date_type)
					end
					Result := data_type
				else
					Result := r_any
				end
			elseif field_name.is_equal ("nullable") then
				if class_name.is_equal ("STRING") then
					create data_type
					if r_any.is_equal ("Y") then
						data_type.set_item (1)
					else
						data_type.set_item (0)
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

	support_sql_of_proc: BOOLEAN is True

	support_stored_proc: BOOLEAN is 
		do
			Result := True
			is_proc := True
		end

	sql_as: STRING is " AS BEGIN "

	sql_end: STRING is "; END;"

	sql_execution: STRING is "BEGIN "

	sql_creation: STRING is "create procedure "

	sql_after_exec: STRING is "; END;"

	support_drop_proc: BOOLEAN is True

	name_proc_lower: BOOLEAN is False

	map_var_between: STRING is ""

	Select_text: STRING is "select text from all_source %
			%where Name = :name and %
			%Type = 'PROCEDURE'"

	Select_exists (name: STRING): STRING is 
		do
			Result := "select count (*) from all_objects %
			%where (object_type = 'PROCEDURE') and %
			% (object_name = :name)"
		end

feature -- For DATABASE_REPOSITORY

	Selection_string (rep_qualifier, rep_owner, rep_name: STRING): STRING is 
		do
			repository_name := rep_name
					-- This query request all the Tables of the database
--			Result := "SELECT * FROM ALL_TAB_COLUMNS WHERE Table_Name =:rep order by Column_ID"
					-- This query retrieve only the tables that the user can access.
					-- By default we should use this query.
			Result := "SELECT * FROM USER_TAB_COLUMNS WHERE Table_Name =:rep order by Column_ID"
		end
	
	sql_string: STRING is "VARCHAR2 ("

	sql_string2 (int: INTEGER): STRING is
		do
			Result := "VARCHAR2 ("
			Result.append (int.out)
			Result.append (")")
		end

feature -- External features

	get_error_message: POINTER is
		do
			Result := ora_get_error_message
			is_error_updated := True
		end

	get_error_code: INTEGER is
		do
			Result := ora_get_error_code
			is_error_updated := True
		end

	get_warn_message: POINTER is
		do
			Result := ora_get_warn_message
			is_error_updated := True
		end

	new_descriptor: INTEGER is
		do
			Result := ora_new_descriptor
			is_error_updated := False
		end

	init_order (no_descriptor: INTEGER; command: STRING) is
		local
			c_temp: ANY
		do
			c_temp := command.to_c
			ora_init_order ($c_temp, no_descriptor)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER) is
		do
			ora_start_order (no_descriptor)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER) is
		do
			found := ora_next_row (no_descriptor) = 0
			is_error_updated := False
		end

	terminate_order (no_descriptor: INTEGER) is
		do
			ora_terminate_order (no_descriptor)
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER) is
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING) is
		local
			c_temp: ANY
		do
			c_temp := command.to_c
			ora_exec_immediate (no_descriptor, $c_temp)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL[CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := ora_put_select_name (no_descriptor, index, $ar)
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL[CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := ora_put_data (no_descriptor, index, $ar)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is 
		do
			Result := ora_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER is
		do
			Result := ora_get_count (no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ora_get_data_len (ind, no_descriptor)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ora_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ora_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ora_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		do
			Result := ora_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
		do
			Result := ora_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		do
			Result := ora_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- is last retrieved data null? 
		do
			Result := ora_is_null_data (no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ora_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_hour)
			Result := tmp_strg.to_integer
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_sec)
			Result := tmp_strg.to_integer
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_min)
			Result := tmp_strg.to_integer
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_year)
			Result := tmp_strg.to_integer
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_day)
			Result := tmp_strg.to_integer
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_month)
			Result := tmp_strg.to_integer
		end

	c_string_type: INTEGER is 
		do
			Result := ora_c_string_type
		end

	c_character_type: INTEGER is 
		do
			Result := ora_c_character_type
		end

	c_integer_type: INTEGER is 
		do
			Result := ora_c_integer_type
		end

	c_float_type: INTEGER is 
		do
			Result := ora_c_float_type
		end

   	c_real_type: INTEGER is 
		do
			Result := ora_c_real_type
		end

	c_boolean_type: INTEGER is 
		do
			Result := ora_c_boolean_type
		end

	c_date_type: INTEGER is
		do
			Result := ora_c_date_type
		end

	database_make (i: INTEGER) is
		do
			ora_database_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING) is
        local
			c_temp1, c_temp2: ANY
		do      
			c_temp1 := user_name.to_c
			c_temp2 := user_passwd.to_c
			ora_connect ($c_temp1, $c_temp2)
			is_error_updated := False
       	end

	disconnect is
		do
			ora_disconnect
			is_error_updated := False
			found := False
		end

	commit is
		do
			ora_commit
			is_error_updated := False
		end

	rollback is
		do
			ora_rollback
			is_error_updated := False
		end

	trancount: INTEGER is
		do
			Result := ora_trancount
		end

 	begin is
		do
		end

feature {NONE} -- External features

	repository_name: STRING

	is_proc: BOOLEAN

	ora_get_error_message: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_error_code: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_warn_message: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_new_descriptor: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_init_order (command: POINTER; no_descriptor: INTEGER) is
		external
			"C | %"oracle.h%""
		end

	ora_start_order (no_descriptor: INTEGER) is
		external
			"C | %"oracle.h%""
		end

	ora_next_row (no_descriptor: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_terminate_order (no_descriptor: INTEGER) is
		external
			"C | %"oracle.h%""
		end

	ora_exec_immediate (no_descriptor: INTEGER; command: POINTER) is
		external
			"C (EIF_INTEGER, text *) | %"oracle.h%""
		end

	ora_put_select_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_conv_type (index: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_count (no_descriptor: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_data_len (ind: INTEGER; no_descriptor: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_integer_data (no_descriptor:INTEGER; ind: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_float_data (no_descriptor:INTEGER; ind: INTEGER): DOUBLE is
		external
			"C | %"oracle.h%""
		end

	ora_get_real_data (no_descriptor:INTEGER; ind: INTEGER): REAL is
		external
			"C | %"oracle.h%""
		end

	ora_get_boolean_data (no_descriptor:INTEGER; ind: INTEGER): BOOLEAN is
		external
			"C | %"oracle.h%""
		end

	ora_is_null_data (no_descriptor:INTEGER; ind: INTEGER): BOOLEAN is
		external
			"C | %"oracle.h%""
		end	

	ora_get_date_data (desc: INTEGER; index: INTEGER): INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_get_hour: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_sec: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_min: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_year: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_day: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_get_month: POINTER is
		external
			"C | %"oracle.h%""
		end

	ora_database_make (i: INTEGER) is
		external
			"C | %"oracle.h%""
		alias
			"c_ora_make"
		end

	ora_disconnect is
		external
			"C | %"oracle.h%""
		end

	ora_commit is
		external
			"C | %"oracle.h%""
		end

	ora_rollback is
		external
			"C | %"oracle.h%""
		end

	ora_trancount: INTEGER is
		external
			"C | %"oracle.h%""
		end


	ora_connect (user_name, user_passwd: POINTER) is
		external
			"C (text *, text*) | %"oracle.h%""
		end

	ora_available_descriptor: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_set_parameter (descriptor: INTEGER; sql: POINTER; ph: POINTER; value: POINTER) is
		external
			"C (EIF_INTEGER, text *, text *, char *) | %"oracle.h%""
		end

	ora_string_type: INTEGER is
		external
			"C [macro %"oracle.h%"]"
		alias
			"VARCHAR2_TYPE"
		end

	ora_number_type: INTEGER is
		external
			"C [macro %"oracle.h%"]"
		alias
			"NUMBER_TYPE"
		end

	ora_date_type: INTEGER is
		external
			"C [macro %"oracle.h%"]"
		alias
			"DATE_TYPE"
		end

	ora_c_string_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_character_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_integer_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_float_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_real_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_boolean_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_c_date_type: INTEGER is
		external
			"C | %"oracle.h%""
		end

	ora_clear_error is
		external
			"C | %"oracle.h%""
		end

	break (s: STRING): STRING is
			-- Broken long string using
			-- Oracle's concatenation character.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
		do
			create Result.make (s.count + ( (s.count // Max_char_size) * Concat_string.count))
			from
				i := 1
			until
				i > s.count
			loop
				Result.append (s.substring (i,   s.count.min (i + Max_char_size - 1)))
				i := i + Max_char_size
				if not (i > s.count) then
					Result.append (Concat_string)
				end
			end
		end

	Concat_string: STRING is "'||'"

end -- class ORACLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

