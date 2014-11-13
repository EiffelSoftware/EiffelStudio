note
	description: "Null object to meet void safe"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_NULL

inherit
	DATABASE


feature -- Acccess

	database_handle_name: STRING = "NULL"
			-- Handle name

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an NULL function been called since last update which may have
			-- updated error code, error message?

	is_warning_updated: BOOLEAN
			-- Has an ODBC function been called since last update which may have
			-- updated warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
		end

	insert_auto_identity_column: BOOLEAN = False
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?		

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
		do
		end


feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
			-- For ODBC, ORACLE
		do
			create Result.make_empty
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'
		obsolete
			"Use `string_format_32' instead."
		do
			Result := ""
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `object'
		do
			Result := ""
		end

	True_representation: STRING
			-- Database representation of the boolean True
		do
			Result := ""
		end

	False_representation: STRING
			-- Database representation of the boolean False
		do
			Result := ""
		end

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN
			-- Should the SQL string be normal parsed,
			-- using SQL_SCAN?
		do
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
			-- SQL type name of string
		do
			Result := ""
		end

feature -- DATABASE_REAL

	sql_name_real: STRING
			-- SQL type name for real
		do
			Result := ""
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING
			-- SQL type name for datetime
		do
			Result := ""
		end

feature -- DATABASE_DECIMAL

	sql_name_decimal: STRING
			-- SQL type name for decimal
		do
			Result := ""
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING
			-- SQL type name for double
		do
			Result := ""
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING
			-- SQL type name for character
		do
			Result := ""
		end
feature -- DATABASE_INTEGER

	sql_name_integer: STRING
			-- SQL type name for integer
		do
			Result := ""
		end

	sql_name_integer_16: STRING
			-- SQL type name for integer
		do
			Result := ""
		end

	sql_name_integer_64: STRING
			-- SQL type name for integer
		do
			Result := ""
		end
feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING
			-- SQL type name for boolean
		do
			Result := ""
		end

feature -- LOGIN and DATABASE_APPL only for password_ok


	password_ok (upasswd: STRING): BOOLEAN
			-- Can the user password be Void?
		do
			Result := True
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
			-- Is name equal to uname and passwd equal to upasswd?
		do
		end

feature -- For DATABASE_PROC


	support_sql_of_proc: BOOLEAN
			-- Does the database support SQL attachment to the stored procedure?
		do
		end

	support_stored_proc: BOOLEAN
			-- Does the database support creating a stored procedure?
		do
		end

	sql_as: STRING
			-- Creating a stored procedure "as"...
		do
			Result := ""
		end

	sql_end: STRING
			-- End of the stored procedure creation string.
		do
			Result := ""
		end

	sql_execution: STRING
			-- Begining of the stored procedure execution string.
		do
			Result := ""
		end

	sql_creation: STRING
			-- Begining of the stored procedure creation string.
		do
			Result := ""
		end

	sql_after_exec: STRING
			-- End of the stored procedure execution string.
		do
			Result := ""
		end

	support_drop_proc: BOOLEAN
			-- Does the database support stored procedure dropping from server?
		do
		end

	name_proc_lower: BOOLEAN
			-- Has the name of the stored procedure to be in lower case?
		do
		end

	map_var_between: STRING
			-- @ symbol for ODBC and Sybase
		do
			Result := ""
		end

	map_var_name_32 (par_name: READABLE_STRING_GENERAL): STRING_32
			-- Redefined for Sybase
		do
			Result := ""
		end

	Select_text_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
			-- SQL query to get stored procedure text
		do
			Result := ""
		end

	Select_exists_32 (name: READABLE_STRING_GENERAL): STRING_32
			-- SQL query to test stored procedure existing
		do
			Result := ""
		end


	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
			-- String to select the table needed
		do
			Result := ""
		end

	sql_string: STRING
			-- Database type of a string
			-- with a size less than Max_char_size
		do
			Result := ""
		end

	sql_string2 (int: INTEGER): STRING
			-- Database type of a string
			-- with a size more than Max_char_size
		do
			Result := ""
		end

	sql_wstring: STRING
			-- Database type of a string
			-- with a size less than Max_char_size
		do
			Result := ""
		end

	sql_wstring2 (int: INTEGER): STRING
			-- Database type of a string
			-- with a size more than Max_char_size
		do
			Result := ""
		end

feature -- External features

	get_error_message: POINTER
			-- Function related with the error processing
		do
			create Result
		end

	get_error_message_string: STRING_32
			-- Function related with the error processing
		do
			Result := ""
		end

	get_error_code: INTEGER
			-- Function related with the error processing
		do
		end

	get_warn_message: POINTER
			-- Function related with the error processing
		do
			create Result
		end

	get_warn_message_string: STRING_32
			-- Function related with the error processing
		do
			Result := ""
		end

	new_descriptor: INTEGER
			-- A descriptor is used to store a row fetched by FETCH command
			-- Whenever perform a SELECT statement, allocate a new descriptor
			-- by int_new_descriptor(), the descriptor is freed
			-- when the SELECT statement terminates.
		do
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
			-- In DYNAMICALLY EXECUTE mode perform the SQL statement
			-- But this routine only get things ready for dynamic execution:
			-- 1. get the SQL statement PREPAREd; and check if there are
			-- warning message for the SQL statement;
			-- 2. DESCRIBE the SQL statement and get enough information to
			-- allocate enough memory space for the corresponding descriptor.
		do
		end

	start_order (no_descriptor: INTEGER)
			-- Finish execution of a SQL statement in DYNAMICLLY EXECUTION mode:                                                         */
			-- 1. if the PREPAREd SQL statement is a NON_SELECT statement,
			-- just EXECUTE it; otherwise, DEFINE a CURSOR for it and
			-- OPEN the CURSOR. In the process, if error occurs, do some
			-- clearence;
		do
		end

	next_row (no_descriptor: INTEGER)
			-- A SELECT statement is now being executed in DYNAMIC EXECUTION mode,
			-- the  routine is to FETCH a new tuple from database
			-- and if a new tuple is fetched, return 1 otherwise return 0.
		do
		end

	terminate_order (no_descriptor: INTEGER)
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- so the routine is to do some clearence:
			-- 1. if the DYNAMICALLY EXECUTED SQL statement is a NON_SELECT
			-- statement, just free the memory for ODBCSQLDA and clear
			-- the cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR
			-- and then do the same clearence.
			-- 2. return error number.
		do
		end

	close_cursor (no_descriptor: INTEGER)
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- Then if the DYNAMICALLY EXECUTED SQL statement is a SELECT
			-- statement, then the cursor is closed.
			-- Then one can do an other selection on the previous cursor.
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
			-- In IMMEDIATE EXECUTE mode perform the SQL statement,
			-- and then check if there is warning message for the execution,
		do
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end


	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
			--| FIXME
			--| This description really does not explain a thing...
		do
		end

	get_count (no_descriptor: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is last retrieved data null?
		do
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		do
		end

	get_decimal (no_descriptor: INTEGER; ind: INTEGER): detachable TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Function used to get decimal info
		do
		end


	database_make (i: INTEGER)
			-- Initialize database c-module
		do
		end

	connect (user_name, user_passwd, data_source, application, hostname, role_id: STRING; role_passwd: detachable STRING; group_id: STRING)
			-- Connect to database
		do
		end

	connect_by_connection_string (a_connect_string: STRING)
			-- Connect to database by connection string
		do
		end

	disconnect
			-- Disconnect the current connection with an database
		do
		end

	commit
			-- Commit the current transaction
		do
		end

	rollback
			-- Commit the current transaction
		do
		end

	trancount: INTEGER
			-- Return the number of transactions now active
		do
		end

	begin
			-- Begin a data base transaction
		do
		end

end
