indexing
	description: "Ingres specification";
	date: "$Date$";
	revision: "$Revision$"

class 
	INGRES

inherit
	DATABASE
		redefine
			has_row_number,
			sensitive_mixed,
			parse,
			map_var_between_2,
			proc_args
		end

feature -- Access

	database_handle_name: STRING is "SYBASE"

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
		end


feature -- For DATABASE_CHANGE 

	descriptor_is_available: BOOLEAN is True

feature -- For DATABASE_FORMAT
	
	date_to_str (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		do
			Result := object.formatted_out("mm/dd/yyyy [0]hh:[0]mi:[0]ss")
			Result.precede ('%'')
			Result.extend ('%'')
		end
	
	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'
		do
			Result := object
			Result.precede ('%'')
			Result.extend ('%'')
		end

	True_representation: STRING is "%'1%'"

	False_representation: STRING is "%'0%'"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE, DATABASE_PROC

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
			Result := true
		end

feature -- Access

	last_error_code: INTEGER
			-- Last error returned by Handle.

	get_error_code: INTEGER is
		do
			Result := last_error_code
		end

feature -- DATABASE_STRING

	sql_name_string: STRING is
		once
			Result := "char(255)"
		ensure then
			Result.is_equal ("char(255)")
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
		once
			Result := "date"
		ensure then
			Result.is_equal ("date")
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
			Result := "char(1)"
		ensure then
			Result.is_equal ("char(1)")
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING is
		once
			Result := "int"
		ensure then
			Result.is_equal ("int")
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING is
		once
			Result := "text"
		ensure then
			textual_outlook: Result.is_equal ("text")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN is
		do
			Result := True
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN is
		do
			Result := name.is_equal(uname) and passwd.is_equal(upasswd)
		end

feature -- For DATABASE_PROC

	has_row_number: BOOLEAN is True

	support_sql_of_proc: BOOLEAN is True

	support_stored_proc: BOOLEAN is
		do
			Result := True
			is_proc := True
		end

	sql_as: STRING is " as begin "

	sql_end: STRING is "; end "

	sql_execution: STRING is "execute procedure "

	sql_after_exec: STRING is ""

	sql_creation: STRING is "create procedure "

	support_drop_proc: BOOLEAN is True

	name_proc_lower: BOOLEAN is True

	map_var_between: STRING is ""

	map_var_between_2: STRING is " = "

	Select_text: STRING is "select text_segment %
		%from iiprocedures where %
		%procedure_name = :name and  text_sequence = :seq"

	Select_exists (name: STRING): STRING is
		do
			Result := "select count(*) from %
		%iiprocedures where procedure_name = :name "
		end

	proc_args: BOOLEAN is True

feature -- For DATABASE_REPOSITORY

	sensitive_mixed: BOOLEAN is False

	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING is
		do
			Result := " select owner = t.table_owner, t.table_name, %
		% t.table_type, c.column_name, column_id=c.column_sequence, %
		% c.column_nulls, column_typename = c.column_datatype, %
		% data_type = c.column_ingdatatype, data_length = column_length %
		% from iitables t, iicolumns c %
		% where t.table_name = c.table_name %
		% and t.table_name = :rep  order by column_id"
		end

	sql_string: STRING is "text("

	sql_string2 (int: INTEGER): STRING is
		do
			Result := "text("
			Result.append(int.out)
			Result.append(")")
		end

feature -- External

	get_error_message: POINTER is
		do
			Result := ing_get_error_message
		end

	get_warn_message: POINTER is
		do
			Result := ing_get_warn_message
		end

	new_descriptor: INTEGER is
		do
			Result := ing_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: STRING) is
		local
			c_temp: ANY
		do
			c_temp := command.to_c
			last_error_code := ing_init_order (no_descriptor, $c_temp)
		end

	start_order (no_descriptor: INTEGER) is
		do
			last_error_code := ing_start_order(no_descriptor)
		end

	next_row (no_descriptor: INTEGER) is
		do
			last_error_code := ing_next_row(no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER) is
		do
			last_error_code := ing_terminate_order(no_descriptor)
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
			last_error_code := ing_exec_immediate($c_temp)
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := ing_put_col_name(no_descriptor, index, $ar, max_len)
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := ing_put_data (no_descriptor, index, $ar, max_len)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
		do
			Result := ing_conv_type (indicator, index)
		end

	get_count (no_descriptor: INTEGER): INTEGER is
		do
			Result := ing_get_count(no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		do
			Result := ing_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
		do
			Result := ing_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		do
			Result := ing_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- is last retrieved data null? 
		do
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := ing_get_month
		end

	c_string_type: INTEGER is
		do
			Result := ing_c_string_type
		end

	c_character_type: INTEGER is
		do
			Result := ing_c_character_type
		end

	c_integer_type: INTEGER is
		do
			Result := ing_c_integer_type
		end

	c_float_type: INTEGER is
		do
			Result := ing_c_float_type
		end

   	c_real_type: INTEGER is
		do
			Result := ing_c_real_type
       	end

	c_boolean_type: INTEGER is
		do
			Result := ing_c_boolean_type
		end

	c_date_type: INTEGER is
		do
			Result := ing_c_date_type
		end

	database_make (i: INTEGER) is
		do
			c_ing_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING) is
        	local
            		c_temp1, c_temp2, c_temp3, c_temp4, c_temp5, c_temp6: ANY
        	do
            		c_temp1 := user_name.to_c
            		c_temp2 := user_passwd.to_c
         			c_temp3 := roleId.to_c
            		c_temp4 := rolePassWd.to_c
            		c_temp5 := groupId.to_c
            		c_temp6 := data_source.to_c
            		last_error_code := ing_connect ($c_temp1, $c_temp2, $c_temp3, $c_temp4, $c_temp5, $c_temp6)
		end

	disconnect is
		do
			last_error_code := ing_disconnect
		end

	commit is
		do
			last_error_code := ing_commit
		end

	rollback is
		do
			last_error_code := ing_rollback
		end

	trancount: INTEGER is
		do
			Result := ing_trancount
		end

	begin is
		do
			last_error_code := ing_begin
		end

feature {NONE} -- External features

	is_proc: BOOLEAN

	ing_get_error_message: POINTER is
		external
			"C"
		end

	ing_get_warn_message: POINTER is
		external
			"C"
		end

	ing_new_descriptor: INTEGER is
		external
			"C"
		end

	ing_init_order (no_descriptor: INTEGER; command: POINTER): INTEGER is
		external
			"C"
		end

	ing_start_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	ing_next_row (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	ing_terminate_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	ing_exec_immediate (command: POINTER): INTEGER is
		external
			"C"
		end

	ing_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER; max_len:INTEGER): INTEGER is
		external
			"C"
		end

	ing_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER; max_len:INTEGER): INTEGER is
		external
			"C"
		end

	ing_conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_count (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_data_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_col_len (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_col_type (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_integer_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_float_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C"
		end

	ing_get_real_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE is
		external
			"C"
		end

	ing_get_boolean_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN is
		external
			"C"
		end

	ing_get_date_data (no_descriptor: INTEGER ind: INTEGER): INTEGER is
		external
			"C"
		end

	ing_get_hour: INTEGER is
		external
			"C"
		end

	ing_get_sec: INTEGER is
		external
			"C"
		end

	ing_get_min: INTEGER is
		external
			"C"
		end

	ing_get_year: INTEGER is
		external
			"C"
		end

	ing_get_day: INTEGER is
		external
			"C"
		end

	ing_get_month: INTEGER is
		external
			"C"
		end

	ing_c_string_type: INTEGER is
		external
			"C"
		alias
			"c_string_type"
		end

	ing_c_character_type: INTEGER is
		external
			"C"
		alias
			"c_character_type"
		end

	ing_c_integer_type: INTEGER is
		external
			"C"
		alias
			"c_integer_type"
		end

	ing_c_float_type: INTEGER is
		external
			"C"
		alias
			"c_float_type"
		end

   	ing_c_real_type: INTEGER is
		external
			"C"
		alias
			"c_real_type"
        	end

	ing_c_boolean_type: INTEGER is
		external
			"C"
		alias
			"c_boolean_type"
		end

	ing_c_date_type: INTEGER is
		external
			"C"
		alias
			"c_date_type"
		end

	c_ing_make (i: INTEGER) is
		external
			"C"
		end


	ing_disconnect: INTEGER is
		external
			"C"
		end

	ing_commit: INTEGER is
		external
			"C"
		end

	ing_rollback: INTEGER is
		external
			"C"
		end

	ing_trancount: INTEGER is
		external
			"C"
		end

	ing_begin: INTEGER is
		external
			"C"
		end

	ing_connect (user_name, user_passwd, role, rolePassWd, group, dbName: POINTER): INTEGER is
		external
			"C"
		end

end -- class INGRES


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

