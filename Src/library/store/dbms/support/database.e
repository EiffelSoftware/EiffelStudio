indexing
	description: "Specification of the database. Generic parameter";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DATABASE

feature

	database_handle_name : STRING is
			-- Database handle name.
		deferred
		end

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN is
			-- Has a database function been called since last update which may have
			-- updated error code, error message or warning message?
		deferred
		end

	found: BOOLEAN is
			-- Is there any record matching the last
			-- selection condition used ?
		deferred
		end

	clear_error is
			-- Reset database error status.
		deferred
		end

feature -- For DATABASE_CHANGE 

	descriptor_is_available: BOOLEAN is
			-- Is a new descritor available?
		deferred
		end

	results_order (no_descriptor: INTEGER): INTEGER is 
			-- Fetch all the rows resulting from the sql query
			-- Default value zero
			-- Only for Sybase
		do
		end

	hide_qualifier(c_temp: STRING): POINTER is
			-- When "qualifier" is used to identify an database object,
			-- we have to hide ":" in the qualifier first, otherwise, it
			-- will be misinterpreted by feature SQL_SCAN::parse
			-- Only for ODBC
		do
		end

	pre_immediate (descriptor, i: INTEGER) is
			-- In IMMEDIATE EXECUTE mode, if the performed SQL statement is
			-- a call to a stored procedure, allocate some area used by the
			-- stored procedure
			-- Only for ODBC
		do
		end

feature -- For DATABASE_FORMAT
	
	date_to_str (object: DATE_TIME): STRING is
			-- String representation in SQL of `object'
			-- For ODBC, ORACLE
		deferred
		end
	
	string_format (object: STRING): STRING is
			-- String representation in SQL of `object'
		deferred
		end

	True_representation: STRING is
			-- Database representation of the boolean True
		deferred
		end

	False_representation: STRING is
			-- Database representation of the boolean False
		deferred
		end

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN is
			-- Should the SQL string be normal parsed,
			-- using SQL_SCAN?
		deferred
		end

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN is
			-- Prepare string `sql' by appending map
			-- variables name from to `sql'. Map variables are used
			-- for set input arguments
			-- For ODBC
		do
		end

	result_order (descriptor: INTEGER) is
			-- Fetch one row resulting from the sql query
			-- Default value zero
			-- For Sybase
		do
		end

	bind_parameter (value: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: STRING) is
			-- Bind the parameters from the `parameters' array with
			-- the values from the `value' array. It has been implemented
			-- for the use of dynamic sql
			-- Only	for ODBC and Oracle, it has to be done for Sybase and Ingres
		do
		end

feature -- For DATABASE_STORE

	put_column_name (repository: DATABASE_REPOSITORY [like Current]; map_table: ARRAY [INTEGER]): STRING is
			-- Add the columns names to sql_string in the feature put
			-- Redefined for ODBC
		do
			Result := ""
		end

	dim_rep_diff (repository_dimension, db_field_count: INTEGER): BOOLEAN is
			-- Is the dimension of the repository different to the field count of the object to insert?
			-- If yes, make a default map_table
			-- Default value False
			-- Only for Sybase
		do
		end

	update_map_table_error (db_handle: HANDLE; map_table: ARRAY [INTEGER]; ind: INTEGER) is 
			-- Set error number as 200
			-- Except for ODBC and for Oracle
		do
			db_handle.status.set (200)
		end

feature -- DATABASE_STRING

	sql_name_string: STRING is
			-- SQL type name of string
		deferred
		end

feature -- DATABASE_REAL

	sql_name_real: STRING is
			-- SQL type name for real
		deferred
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING is
			-- SQL type name for datetime
		deferred
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING is
			-- SQL type name for double
		deferred
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING is
			-- SQL type name for character
		deferred
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING is
			-- SQL type name for integer
		deferred
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING is
			-- SQL type name for boolean
		deferred
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	user_name_ok (uname: STRING): BOOLEAN is
			-- Can the user name be Void?
			-- Yes only for ODBC 
		do
			Result := uname /= Void
		end

	password_ok (upasswd: STRING): BOOLEAN is
			-- Can the user password be Void?
		deferred
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN is
			-- Is name equal to uname and passwd equal to upasswd?
		deferred
		end

feature -- For DATABASE_PROC

	support_proc: INTEGER is
			-- Does the database support stored procedure?
			-- 1 if True, 0 if False
			-- Redefined for ODBC
		do
			Result := 1
		end

	has_row_number: BOOLEAN is 
			-- May the database store the text of a stored procedure in more than one
			-- row?
			-- Default value False
			-- Redefined for Ingres
		do
		end

	support_sql_of_proc: BOOLEAN is
			-- Does the database support SQL attachment to the stored procedure?
		deferred
		end

	support_stored_proc: BOOLEAN is
			-- Does the database support creating a stored procedure?
		deferred
		end

	sql_adapt_db (sql: STRING): STRING is 
			-- Adapt the SQL string for the database
			-- Only for Sybase and ODBC
		do
			Result := sql
		end

	sql_as: STRING is
			-- Creating a stored procedure "as"...
		deferred
		end

	sql_end: STRING is
			-- End of the stored procedure creation string.
		deferred
		end

	sql_execution: STRING is
			-- Begining of the stored procedure execution string.
		deferred
		end

	sql_creation: STRING is
			-- Begining of the stored procedure creation string.
		deferred
		end

	sql_after_exec: STRING is
			-- End of the stored procedure execution string.
		deferred
		end

	support_drop_proc: BOOLEAN is
			-- Does the database support stored procedure dropping from server?
		deferred
		end

	name_proc_lower: BOOLEAN is
			-- Has the name of the stored procedure to be in lower case?
		deferred
		end

	map_var_before: STRING is
			-- Redefined for Sybase
		do
			Result := " ("
		end

	map_var_between: STRING is
			-- @ symbol for ODBC and Sybase
		deferred
		end

	map_var_between_2: STRING is
			-- Equal type
			-- Only for Ingres
		do
			Result := " " 
		end

	map_var_after: STRING is
			-- Redefined for Sybase
		do
			Result := ")"
		end

	Select_text: STRING is
			-- SQL query to get stored procedure text
		deferred
		end

	Select_exists (name: STRING): STRING is
			-- SQL query to test stored procedure existing
		deferred
		end

	store_proc_not_supported is
			-- Display the text saying that the database
			-- does not support stored procedure creating
			-- Redefined for ODBC
		do
		end

	drop_proc_not_supported is
			-- Display the text saying that the database
			-- does not support stored procedure dropping
			-- Redefined for ODBC
		do
		end

	text_not_supported: STRING is	
			-- Display the text saying that the database
			-- does not support stored procedure text retrieving
			-- Redefined for ODBC
		do
		end

	exec_proc_not_supported is	
			-- Display the text saying that the database
			-- does not support stored procedure executing
			-- Redefined for ODBC
		do
		end

	proc_args: BOOLEAN is
			-- True if the execution of the stored procedure is
			-- "execute procedure_name (argument1='sireude')"
			-- False if "execute procedure_name ('sireude')"
			-- Default value False
			-- True for Sybase
		do
		end

feature -- For DATABASE_REPOSITORY

	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING is
			-- String to select the table needed
		deferred
		end

	Max_char_size: INTEGER is
			-- Limit size before being a text
			-- Except for ODBC
		do
			Result := 256
		end
	
	sql_string: STRING is
			-- Database type of a string
			-- with a size less than Max_char_size
		deferred
		end

	sql_string2 (int: INTEGER): STRING is
			-- Database type of a string
			-- with a size more than Max_char_size
		deferred
		end

feature -- For DATABASE_DYN_STORE

	unset_catalog_flag (desc: INTEGER) is
			-- Default value zero
			-- Only for ODBC.
		do
		end

feature -- For database types

	convert_string_type (r_any: ANY; field_name, class_name: STRING): ANY is
			-- Convert `r_any' to the expected object.
			-- By default returns `r_any', redefined in ORACLE to return
			-- an INTEGER_REF when `field_name' is "data_type".
		require
			r_any_not_void: r_any /= Void
			field_name_not_void: field_name /= Void
			class_name_not_void: class_name /= Void
		do
			Result := r_any
		ensure
			Valid_result: Result /= Void
		end

feature -- External features

	get_error_message: POINTER is
			-- Function related with the error processing
		deferred
		end

	get_error_code: INTEGER is
			-- Function related with the error processing
		deferred
		end

	get_warn_message: POINTER is
			-- Function related with the error processing
		deferred
		end

	new_descriptor: INTEGER is
			-- A descriptor is used to store a row fetched by FETCH command
			-- Whenever perform a SELECT statement, allocate a new descriptor
			-- by int_new_descriptor(), the descriptor is freed 
			-- when the SELECT statement terminates.
		deferred
		end

	init_order (no_descriptor: INTEGER; command: STRING) is
			-- In DYNAMICALLY EXECUTE mode perform the SQL statement
			-- But this routine only get things ready for dynamic execution:
			-- 1. get the SQL statement PREPAREd; and check if there are 
			-- warning message for the SQL statement;                 
			-- 2. DESCRIBE the SQL statement and get enough information to 
			-- allocate enough memory space for the corresponding descriptor.                                                
		deferred
		end

	start_order (no_descriptor: INTEGER) is
			-- Finish execution of a SQL statement in DYNAMICLLY EXECUTION mode:                                                         */
			-- 1. if the PREPAREd SQL statement is a NON_SELECT statement, 
			-- just EXECUTE it; otherwise, DEFINE a CURSOR for it and 
			-- OPEN the CURSOR. In the process, if error occurs, do some
			-- clearence;                                              
		deferred
		end

	next_row (no_descriptor: INTEGER) is
			-- A SELECT statement is now being executed in DYNAMIC EXECUTION mode,
			-- the  routine is to FETCH a new tuple from database
			-- and if a new tuple is fetched, return 1 otherwise return 0.
		deferred
		end

	terminate_order (no_descriptor: INTEGER) is
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- so the routine is to do some clearence:                             
			-- 1. if the DYNAMICLLY EXECUTED SQL statement is a NON_SELECT 
			-- statement, just free the memory for ODBCSQLDA and clear 
			-- the cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR
			-- and then do the same clearence.               
			-- 2. return error number.
		deferred
		end

	close_cursor (no_descriptor: INTEGER) is
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- Then if the DYNAMICALLY EXECUTED SQL statement is a SELECT 
			-- statement, then the cursor is closed.
			-- Then one can do an other selection on the previous cursor.
		deferred
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING) is
			-- In IMMEDIATE EXECUTE mode perform the SQL statement, 
			-- and then check if there is warning message for the execution,    
		deferred
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: SPECIAL [CHARACTER]; max_len:INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	sensitive_mixed: BOOLEAN is 
			-- Is the database sensitive to lower or
			-- upper case?
			-- Only for ODBC, Ingres
		do
			Result := True
		end

	identifier_quoter: STRING is
			-- Return the string used to quote identifiers in SQL command,
			-- for example, if the quoter is `, and we want to select on 
			-- table "my table", we should express the query as:  
			-- select * from `My table` 
			-- Only for ODBC
		do
			Result := ""
		end

	qualifier_seperator: STRING is
			-- When "qualifier" and "owner" are used to identifier
			-- a database object, they should be seperated by a string called
			-- "qualifier seperator"
			-- Only for ODBC
		do
			Result := ""
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred	
		end

	get_count (no_descriptor: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- Is last retrieved data null? 
		deferred
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	c_string_type: INTEGER is
			-- String Eiffel type
		deferred
		end

	c_character_type: INTEGER is
			-- Character Eiffel type
		deferred
		end

	c_integer_type: INTEGER is
			-- Integer Eiffel type
		deferred
		end

	c_float_type: INTEGER is
			-- Float Eiffel type
		deferred
		end

   	c_real_type: INTEGER is
			-- Real Eiffel type
		deferred
       	end

	c_boolean_type: INTEGER is
			-- Boolean Eiffel type
		deferred
		end

	c_date_type: INTEGER is
			-- Datetime Eiffel type
		deferred
		end

	database_make (i: INTEGER) is
			-- Initialize database c-module 
		deferred
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING) is
			-- Connect to an ODBC database
		deferred
		end

	disconnect is
			-- Disconnect the current connection with an database
		deferred
		end

	commit is
			-- Commit the current transaction
		deferred
		end

	rollback is
			-- Commit the current transaction
		deferred
		end

	trancount: INTEGER is
			-- Return the number of transactions now active
		deferred
		end

	begin is
			-- Begin a data base transaction
		deferred
		end

end -- class DATABASE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

