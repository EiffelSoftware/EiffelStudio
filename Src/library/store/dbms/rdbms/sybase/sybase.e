indexing
	description: "Sybase specification";
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

feature -- For DATABASE_STATUS

	is_ok_mat: BOOLEAN

feature -- For DATABASE_CHANGE 

	descriptor_is_available: BOOLEAN is 
		do
			Result := (syb_available_descriptor = 1)
		end

	results_order (no_descriptor: INTEGER): INTEGER is
		do
			Result := syb_results_order (no_descriptor)
		end

feature -- For DATABASE_FORMAT
	
	date_to_str (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
		do
			!! Result.make (1)
			Result.append (object.out)
			Result.precede ('%'')
			Result.extend ('%'')
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

	normal_parse: BOOLEAN is True

	result_order (descriptor: INTEGER): INTEGER is
		do
			Result := syb_result_order (descriptor)
		end

feature -- For DATABASE_STORE

	dim_rep_diff (repository_dimension, ufield_count: INTEGER): BOOLEAN is
		do
			Result := repository_dimension /= ufield_count
		end

feature -- DATABASE_STRING

	sql_name_string: STRING is
		once
			Result := "varchar("
		ensure then
			Result.is_equal ("varchar(")
		end

feature -- DATABASE_REAL

	sql_name_real: STRING is
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING is
		once
			Result := "datetime"
		ensure then
			Result.is_equal ("datetime")
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
			Result := "bit"
		ensure then
			textual_outlook: Result.is_equal ("bit")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN is
		do
			Result := upasswd /= Void
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN is
		do
			Result := name.is_equal(uname) and passwd.is_equal(upasswd)
		end

feature -- For DATABASE_PROC

	support_sql_of_proc: BOOLEAN is True

	support_stored_proc: BOOLEAN is True

	sql_adapt_db (sql: STRING): STRING is 
		do
			Result := sql
			Result.replace_substring_all (":", "@")
		end

	sql_as: STRING is " as "

	sql_end: STRING is ""

	sql_execution: STRING is "exec "

	sql_creation: STRING is "create procedure "

	sql_after_exec: STRING is ""

	support_drop_proc: BOOLEAN is True

	name_proc_lower: BOOLEAN is False

	map_var_before: STRING is " "

	map_var_between: STRING is " @"

	map_var_after: STRING is ""

	Select_text: STRING is "select a.text from %
		%syscomments a, sysobjects b where %
		%b.name = :name and b.id = a.id"

	Select_exists (name: STRING): STRING is 
		do
			Result := "select count(*) from %
			%sysobjects where type = 'P' %
			%and name = :name"
		end

	proc_args: BOOLEAN is True

feature -- For DATABASE_REPOSITORY


	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING is
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

	sql_string: STRING is "varchar("
	
	sql_string2 (int: INTEGER): STRING is
		do
			Result := " text"
		end

feature -- External	features

	get_error_message: POINTER is
		do
			Result := syb_get_error_message
		end

	
	get_warn_message: POINTER is 
		do
			Result := syb_get_warn_message
		end

	new_descriptor: INTEGER is
		do
			Result := syb_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: STRING): INTEGER is
		local
			c_temp: ANY
		do
			c_temp := command.to_c
			Result := syb_init_order (no_descriptor, $c_temp)
		end

	start_order (no_descriptor: INTEGER): INTEGER is
		do
			Result := syb_start_order(no_descriptor)
		end

	next_row (no_descriptor: INTEGER): INTEGER is
		do
			Result := syb_next_row(no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER): INTEGER is
		do
			Result := syb_terminate_order(no_descriptor)
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING): INTEGER is
		local
			c_temp: ANY
		do
			c_temp := command.to_c
			Result := syb_exec_immediate($c_temp)
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := syb_put_col_name(no_descriptor, index, $ar)
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
		do
			Result := syb_put_data (no_descriptor, index, $ar)
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
		do
			Result := syb_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER is
		do
			Result := syb_get_count(no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		do
			Result := syb_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
		do
			Result := syb_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		do
			Result := syb_get_boolean_data (no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := syb_get_month
		end

	c_string_type: INTEGER is
		do
			Result := syb_c_string_type
		end

	c_character_type: INTEGER is
		do
			Result := syb_c_character_type
		end

	c_integer_type: INTEGER is
		do
			Result := syb_c_integer_type
		end

	c_float_type: INTEGER is
		do
			Result := syb_c_float_type
		end

   	c_real_type: INTEGER is
		do
			Result := syb_c_real_type
        	end

	c_boolean_type: INTEGER is
		do
			Result := syb_c_boolean_type
		end

	c_date_type: INTEGER is
		do
			Result := syb_c_date_type
		end

	database_make (i: INTEGER) is
		do
			syb_database_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING): INTEGER is
		local
			c_temp1, c_temp2, c_temp3, c_temp4: ANY
		do
			c_temp1 := user_name.to_c
			c_temp2 := user_passwd.to_c
			c_temp3 := application.to_c
			c_temp4 := hostname.to_c

			Result := syb_connect ($c_temp1, $c_temp2, $c_temp3, $c_temp4)
		end

	disconnect: INTEGER is
		do
			Result := syb_disconnect
		end

	commit: INTEGER is
		do
			Result := syb_commit
		end

	rollback: INTEGER is
		do
			Result := syb_rollback
		end

	trancount: INTEGER is
		do
			Result := syb_trancount
		end

	begin: INTEGER is
		do
			Result := syb_begin
		end

	database_handle: DATABASE_HANDLE [SYBASE] is
		once
			!! Result
		end

feature {NONE} -- External features

	syb_get_error_message: POINTER is
		external
			"C"
		end

	syb_get_warn_message: POINTER is
		external
			"C"
		end

	syb_new_descriptor: INTEGER is
		external
			"C"
		end

	syb_init_order (no_descriptor: INTEGER; command: POINTER): INTEGER is
		external
			"C"
		end

	syb_start_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	syb_next_row (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	syb_terminate_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	syb_exec_immediate (command: POINTER): INTEGER is
		external
			"C"
		end

	syb_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C"
		end

	syb_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER is
		external
			"C"
		end

	syb_conv_type (index: INTEGER): INTEGER is
		external
			"C"	
		end

	syb_get_count (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		external
			"C"
		end

	syb_get_real_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		external
			"C"
		end

	syb_get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		external
			"C"
		end

	syb_get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		external
			"C"
		end

	syb_get_hour: INTEGER is
		external
			"C"
		end

	syb_get_sec: INTEGER is
		external
			"C"
		end

	syb_get_min: INTEGER is
		external
			"C"
		end

	syb_get_year: INTEGER is
		external
			"C"
		end

	syb_get_day: INTEGER is
		external
			"C"
		end

	syb_get_month: INTEGER is
		external
			"C"
		end

	syb_c_string_type: INTEGER is
		external
			"C"
		alias
			"c_string_type"
		end

	syb_c_character_type: INTEGER is
		external
			"C"
		alias
			"c_character_type"
		end

	syb_c_integer_type: INTEGER is
		external
			"C"
		alias
			"c_integer_type"
		end

	syb_c_float_type: INTEGER is
		external
			"C"
		alias
			"c_float_type"
		end

   	syb_c_real_type: INTEGER is
		external
			"C"
		alias
			"c_real_type"
        	end

	syb_c_boolean_type: INTEGER is
		external
			"C"
		alias
			"c_boolean_type"
		end

	syb_c_date_type: INTEGER is
		external
			"C"
		alias
			"c_date_type"
		end

	syb_database_make (i: INTEGER) is
		external
			"C"
		alias
			"c_syb_make"
		end


	syb_disconnect: INTEGER is
		external
			"C"
		end

	syb_commit: INTEGER is
		external
			"C"
		end

	syb_rollback: INTEGER is
		external
			"C"
		end

	syb_trancount: INTEGER is
		external
			"C"
		end

	syb_begin: INTEGER is
		external
			"C"
		end

	syb_connect (user_name, user_passwd, appl, host: POINTER): INTEGER is
		external
			"C"
		end

	syb_results_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	syb_result_order (no_descriptor: INTEGER): INTEGER is
		external
			"C"
		end

	is_binary (s: STRING): BOOLEAN is
			-- Is `s' a binary type?
		require
			s_not_void: s /= Void
		do
			Result := s.item (1) = '0' and then s.item (2) = 'x'
		ensure
			result_condition:
				Result implies (s.item (1) = '0' and then s.item (2) = 'x')
		end

	syb_available_descriptor: INTEGER is
		external
			"C"
		end

end -- class SYBASE


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

