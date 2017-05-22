note
	description: "Specification of the database. Generic parameter"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DATABASE

feature

	database_handle_name : STRING
			-- Database handle name.
		deferred
		end

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has a database function been called since last update which may have
			-- updated error code, error message?
		deferred
		end

	is_warning_updated: BOOLEAN
			-- Has a database function been called since last update which may have
			-- warnings?
		deferred
		end

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?
		deferred
		end

	clear_error
			-- Reset database error status.
		deferred
		end

	insert_auto_identity_column: BOOLEAN
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?
		deferred
		end

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
			-- Is a new descritor available?
		deferred
		end

	results_order (no_descriptor: INTEGER): INTEGER
			-- Fetch all the rows resulting from the sql query
			-- Default value zero
			-- Only for Sybase
		do
		end

	hide_qualifier (c_temp: READABLE_STRING_GENERAL): POINTER
			-- When "qualifier" is used to identify an database object,
			-- we have to hide ":" in the qualifier first, otherwise, it
			-- will be misinterpreted by feature SQL_SCAN::parse
			-- Only for ODBC
		require
			c_temp_not_void: c_temp /= Void
		do
		end

	pre_immediate (descriptor, i: INTEGER)
			-- In IMMEDIATE EXECUTE mode, if the performed SQL statement is
			-- a call to a stored procedure, allocate some area used by the
			-- stored procedure
			-- Only for ODBC
		do
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
			-- For ODBC, ORACLE
		require
			object_not_void: object /= Void
		deferred
		end

	string_format (object: detachable STRING): STRING
			-- String representation in SQL of `object'
		obsolete
			"Use `string_format_32' instead [2017-11-30]."
		deferred
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `object'
		deferred
		end

	True_representation: STRING
			-- Database representation of the boolean True
		deferred
		end

	False_representation: STRING
			-- Database representation of the boolean False
		deferred
		end

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN
			-- Should the SQL string be normal parsed,
			-- using SQL_SCAN?
		deferred
		end

	parse (descriptor: INTEGER; uht: detachable DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]; uhandle: HANDLE; sql: READABLE_STRING_GENERAL; dynamic: BOOLEAN): BOOLEAN
			-- Prepare string `sql' by appending map
			-- variables name from to `sql'. Map variables are used
			-- `dynamic', True if a dynamic parse is required. False, the argument is simply ignored.
			-- for set input arguments
			-- For ODBC
		require
			uhandle_not_void: uhandle /= Void
			sql_not_void: sql /= Void
		do
		end

	result_order (descriptor: INTEGER)
			-- Fetch one row resulting from the sql query
			-- Default value zero
			-- For Sybase
		do
		end

	bind_arguments (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_GENERAL])
			-- Bind arguments to current statement.
		do
		end

	dyn_sql_colon_style: BOOLEAN
			-- Is dynamic SQL in colon style?
			-- i.e. "SELECT * FROM t WHERE price = :price"
			-- Otherwise it will be question mark style.
			-- i.e. "SELECT * FROM t WHERE price = ?"
		do
		end

feature -- For DATABASE_STORE

	put_column_name (repository: DATABASE_REPOSITORY [like Current]; map_table: ARRAY [INTEGER]; obj: ANY): STRING
			-- Add the columns names to sql_string in the feature put
		require
			repository_not_void: repository /= Void
			map_table_not_void: map_table /= Void
			obj_not_void: obj /= Void
		local
			i, j, nb: INTEGER
			l_identity_index: INTEGER
		do
			create Result.make (25)
			Result.append_character (' ');
			Result.append_character ('(')
			if attached {DB_TABLE} obj as table and then not insert_auto_identity_column then
					-- There was an explicit requirement from the database to exclude
					-- the identity column from the statement.
				l_identity_index := table.table_description.identity_column
			else
					-- No such requirement, we simply assign `-1' so that we add
					-- all the columns.
				l_identity_index := -1
			end

			from
				j := 1
				nb := repository.dimension
			until
				j > nb
			loop
				if map_table.item (j) > 0 then
					if i /= 0 then
						Result.append_character (',')
						Result.append_character (' ')
					end
					if l_identity_index /= j and then attached repository.column_name (j) as l_column_name then
						Result.append (l_column_name)
						i := 1
					end
				end
				j := j + 1
 			end
			Result.append_character (')'); Result.append_character (' ')
		end

	dim_rep_diff (repository_dimension, db_field_count: INTEGER): BOOLEAN
			-- Is the dimension of the repository different to the field count of the object to insert?
			-- If yes, make a default map_table
			-- Default value False
			-- Only for Sybase
		do
		end

	update_map_table_error (db_handle: HANDLE; map_table: ARRAY [INTEGER]; ind: INTEGER)
			-- Except for ODBC and for Oracle
		do
				-- Put signaling value.
			map_table.put (0, ind)
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
			-- SQL type name of string
		deferred
		end

feature -- DATABASE_REAL

	sql_name_real: STRING
			-- SQL type name for real
		deferred
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING
			-- SQL type name for datetime
		deferred
		end

feature -- DATABASE_DECIMAL

	sql_name_decimal: STRING
			-- SQL type name for decimal
		deferred
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING
			-- SQL type name for double
		deferred
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING
			-- SQL type name for character
		deferred
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING
			-- SQL type name for integer
		deferred
		end

	sql_name_integer_16: STRING
			-- SQL type name for integer
		deferred
		end

	sql_name_integer_64: STRING
			-- SQL type name for integer
		deferred
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING
			-- SQL type name for boolean
		deferred
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	user_name_ok (uname: STRING): BOOLEAN
			-- Can the user name be Void?
			-- Yes only for ODBC
		require
			uname_not_void: uname /= Void
		do
			Result := uname /= Void
		end

	password_ok (upasswd: STRING): BOOLEAN
			-- Can the user password be Void?
		require
			upasswd_not_void: upasswd /= Void
		deferred
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
			-- Is name equal to uname and passwd equal to upasswd?
		require
			name_not_void: name /= Void
			passwd_not_void: passwd /= Void
			uname_not_void: uname /= Void
			upasswd_not_void: upasswd /= Void
		deferred
		end

	is_connection_string_supported: BOOLEAN
			-- Support login by connect string?
		do
			Result := False
		end

feature -- For DATABASE_PROC

	support_proc: BOOLEAN
			-- Does the database support stored procedure?
			-- 1 if True, 0 if False
			-- Redefined for ODBC
		do
			Result := True
		end

	has_row_number: BOOLEAN
			-- May the database store the text of a stored procedure in more than one
			-- row?
			-- Default value False
			-- Redefined for Ingres
		do
		end

	support_sql_of_proc: BOOLEAN
			-- Does the database support SQL attachment to the stored procedure?
		deferred
		end

	support_stored_proc: BOOLEAN
			-- Does the database support creating a stored procedure?
		deferred
		end

	sql_adapt_db (sql: STRING): STRING
			-- Adapt the SQL string for the database
			-- Only for Sybase and ODBC
		require
			sql_not_void: sql /= Void
		do
			Result := sql
		end

	sql_adapt_db_32 (sql: STRING_32): STRING_32
			-- Adapt the SQL string for the database
			-- Only for Sybase and ODBC
		require
			sql_not_void: sql /= Void
		do
			Result := sql
		end

	sql_as: STRING
			-- Creating a stored procedure "as"...
		deferred
		end

	sql_end: STRING
			-- End of the stored procedure creation string.
		deferred
		end

	sql_execution: STRING
			-- Begining of the stored procedure execution string.
		deferred
		end

	sql_creation: STRING
			-- Begining of the stored procedure creation string.
		deferred
		end

	sql_after_exec: STRING
			-- End of the stored procedure execution string.
		deferred
		end

	support_drop_proc: BOOLEAN
			-- Does the database support stored procedure dropping from server?
		deferred
		end

	name_proc_lower: BOOLEAN
			-- Has the name of the stored procedure to be in lower case?
		deferred
		end

	map_var_before: STRING
			-- Redefined for Sybase
		do
			Result := " ("
		end

	map_var_between: STRING
			-- @ symbol for ODBC and Sybase
		deferred
		end

	map_var_between_2: STRING
			-- Equal type
			-- Only for Ingres
		do
			Result := " "
		end

	map_var_after: STRING
			-- Redefined for Sybase
		do
			Result := ")"
		end

	no_args: STRING
			-- No augument. i.e. "()"
			-- Redefined for MySQL
		do
			create Result.make_empty
		end

	map_var_name (par_name: STRING): STRING
			-- Redefined for Sybase
		obsolete
			"Use `map_var_name_32' instead [2017-11-30]."
		require
			par_name_not_void: par_name /= Void
		do
			Result := map_var_name_32 (par_name).as_string_8_conversion
		end

	Select_text (proc_name: STRING): STRING
			-- SQL query to get stored procedure text
		obsolete
			"Use `Select_text_32' instead  [2017-11-30]."
		require
			proc_name_not_void: proc_name /= Void
		do
			Result := Select_text_32 (proc_name).as_string_8_conversion
		end

	Select_exists (name: STRING): STRING
			-- SQL query to test stored procedure existing
		obsolete
			"Use `Select_exists_32' instead  [2017-11-30]."
		require
			name_not_void: name /= Void
		do
			Result := Select_exists_32 (name).as_string_8_conversion
		end

	map_var_name_32 (par_name: READABLE_STRING_GENERAL): STRING_32
			-- Redefined for Sybase
		require
			par_name_not_void: par_name /= Void
		deferred
		end

	Select_text_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
			-- SQL query to get stored procedure text
		require
			proc_name_not_void: proc_name /= Void
		deferred
		end

	Select_exists_32 (name: READABLE_STRING_GENERAL): STRING_32
			-- SQL query to test stored procedure existing
		require
			name_not_void: name /= Void
		deferred
		end

	store_proc_not_supported
			-- Display the text saying that the database
			-- does not support stored procedure creating
			-- Redefined for ODBC
		do
		end

	drop_proc_not_supported
			-- Display the text saying that the database
			-- does not support stored procedure dropping
			-- Redefined for ODBC
		do
		end

	text_not_supported: STRING_32
			-- Display the text saying that the database
			-- does not support stored procedure text retrieving
			-- Redefined for ODBC
		do
			create Result.make_empty
		end

	exec_proc_not_supported
			-- Display the text saying that the database
			-- does not support stored procedure executing
			-- Redefined for ODBC
		do
		end

	proc_args: BOOLEAN
			-- True if the execution of the stored procedure is
			-- "execute procedure_name (argument1='sireude')"
			-- False if "execute procedure_name ('sireude')"
			-- Default value False
			-- True for Sybase
		do
		end

feature -- For DATABASE_REPOSITORY

	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
			-- String to select the table needed
		require
			rep_qualifier_not_void: rep_qualifier /= Void
			rep_owner_not_void: rep_owner /= Void
			repository_name_not_void: repository_name /= Void
		deferred
		end

	Max_char_size: INTEGER
			-- Limit size before being a text
			-- Except for ODBC
		do
			Result := 256
		end

	sql_string: STRING
			-- Database type of a string
			-- with a size less than Max_char_size
		deferred
		end

	sql_string2 (int: INTEGER): STRING
			-- Database type of a string
			-- with a size more than Max_char_size
		deferred
		end

	sql_wstring: STRING
			-- Database type of a string
			-- with a size less than Max_char_size
		deferred
		end

	sql_wstring2 (int: INTEGER): STRING
			-- Database type of a string
			-- with a size more than Max_char_size
		deferred
		end

feature -- For database types

	is_convert_string_type_required: BOOLEAN
			-- Is `convert_string_type' required to be called on `Current' when converting database field to an Eiffel object.
			-- Currently used in {DATABASE_SELECTION}.cursor_to_object.
		do
			Result := True
		end

	convert_string_type (r_any: ANY; field_name, class_name: STRING): ANY
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

feature {NONE} -- Unicode conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32
			-- UTF8 to UTF32 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			l_ref: INTEGER_32_REF
		do
			from
				i := 1
				nb := a_string.count
				create Result.make (nb)
				create l_ref
			until
				i > nb
			loop
				Result.append_character (read_character_from_utf8 (i, l_ref, a_string))
				i := i + l_ref.item
			end
		ensure
			Result_not_void: Result /= Void
		end

	utf32_to_utf8 (a_string: STRING_32): STRING_8
			-- Convert UTF32 to UTF8.
		require
			a_string_not_void: a_string /= Void
		local
			bytes_written: INTEGER
			i: INTEGER
			l_code: NATURAL_32
			l_string_length: INTEGER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
				bytes_written := 0
			until
				i = 0
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF
					bytes_written := bytes_written + 4
				end
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				create Result.make (bytes_written)
			until
				i > l_string_length
			loop
				l_code := a_string.code (i)
				append_code_point_to_utf8 (l_code, Result)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	append_code_point_to_utf8 (a_code: NATURAL_32; a_string: STRING_8)
			-- Append a Unicode code point `a_code' to a UTF-8 stream.
		require
			a_string_not_void: a_string /= Void
				-- According to ISO/IEC 10646, the maximum Unicode point is 10FFFF.
			a_code_is_valid: a_code >= 0 and then a_code <= 0x10FFFF
		do
				if a_code <= 127 then
						-- Of the form 0xxxxxxx.
					a_string.append_code (a_code)
				elseif a_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					a_string.append_code (0xC0 | (a_code |>> 6))
					a_string.append_code (0x80 | (a_code & 0x3F))
				elseif a_code <= 0xFFFF then
						-- Start with 1110xxxx
					a_string.append_code (0xE0 | (a_code |>> 12))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				else -- a_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: a_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					a_string.append_code (0xF0 | (a_code |>> 18))
					a_string.append_code (0x80 | ((a_code |>> 12) & 0x3F))
					a_string.append_code (0x80 | ((a_code |>> 6) & 0x3F))
					a_string.append_code (0x80 | (a_code & 0x3F))
				end
		ensure
			a_string_appended: (a_code <= 127 implies a_string.count = old a_string.count + 1) and
								((a_code > 127 and a_code <= 0x7FF) implies a_string.count = old a_string.count + 2) and
								((a_code > 0x7FF and a_code <= 0xFFFF) implies a_string.count = old a_string.count + 3) and
								((a_code > 0xFFFF and a_code <= 0x10FFFF) implies a_string.count = old a_string.count + 4)
		end

	read_character_from_utf8 (a_position: INTEGER; a_read_bytes: detachable INTEGER_32_REF; a_string: STRING_8): CHARACTER_32
			-- Read a Unicode character from UTF-8 string.
			-- `a_string' is in UTF-8.
			-- `a_position' is the starting byte point of a character.
			-- `a_read_bytes' is the number of bytes read.
		require
			a_string_not_void: a_string /= Void
			a_position_in_range: a_position > 0 and a_position <= a_string.count
			a_position_valid: a_string.code (a_position).to_natural_8 <= 127 or
								(a_string.code (a_position).to_natural_8 & 0xE0) = 0xC0 or
								(a_string.code (a_position).to_natural_8 & 0xF0) = 0xE0 or
								(a_string.code (a_position).to_natural_8 & 0xF8) = 0xF0 or
								(a_string.code (a_position).to_natural_8 & 0xFC) = 0xF8 or
								(a_string.code (a_position).to_natural_8 & 0xFE) = 0xFC
		local
			l_pos: INTEGER
			l_nat8: NATURAL_8
			l_code: NATURAL_32
		do
			l_pos := a_position
			l_nat8 := a_string.code (l_pos).to_natural_8
			if l_nat8 <= 127 then
					-- Form 0xxxxxxx.
				Result := l_nat8.to_character_32

			elseif (l_nat8 & 0xE0) = 0xC0 then
					-- Form 110xxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
				l_pos := l_pos + 1
				l_nat8 := a_string.code (l_pos).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32

			elseif (l_nat8 & 0xF0) = 0xE0 then
				-- Form 1110xxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x0F).to_natural_32 |<< 12
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 2

			elseif (l_nat8 & 0xF8) = 0xF0 then
				-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
				l_code := (l_nat8 & 0x07).to_natural_32 |<< 18
				l_nat8 := a_string.code (l_pos + 1).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 12)
				l_nat8 := a_string.code (l_pos + 2).to_natural_8
				l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
				l_nat8 := a_string.code (l_pos + 3).to_natural_8
				l_code := l_code | (l_nat8 & 0x3F).to_natural_32
				Result := l_code.to_character_32
				l_pos := l_pos + 3

			elseif (l_nat8 & 0xFC) = 0xF8 then
				-- Starts with 111110xx
				-- This seems to be a 5 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 4

			else
				-- Starts with 1111110x
				-- This seems to be a 6 bytes character,
				-- but UTF-8 is restricted to 4, then substitute with a space
				Result := ' '
				l_pos := l_pos + 5

			end
			if a_read_bytes /= Void then
				a_read_bytes.set_item (l_pos - a_position + 1)
			end
		end

feature -- External features

	get_error_message: POINTER
			-- Function related with the error processing
		deferred
		end

	get_error_message_string: STRING_32
			-- Function related with the error processing
		deferred
		end

	get_error_code: INTEGER
			-- Function related with the error processing
		deferred
		end

	no_error_code: INTEGER
			-- Code indicating no error
			-- In ODBC, MySQL, Oracle, Sybase, zero means no error. It may vary in coming implementations.
		do
			Result := 0
		end

	get_warn_message: POINTER
			-- Function related with the error processing
		deferred
		end

	get_warn_message_string: STRING_32
			-- Function related with the error processing
		deferred
		end

	new_descriptor: INTEGER
			-- A descriptor is used to store a row fetched by FETCH command
			-- Whenever perform a SELECT statement, allocate a new descriptor
			-- by int_new_descriptor(), the descriptor is freed
			-- when the SELECT statement terminates.
		deferred
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
			-- In DYNAMICALLY EXECUTE mode perform the SQL statement
			-- But this routine only get things ready for dynamic execution:
			-- 1. get the SQL statement PREPAREd; and check if there are
			-- warning message for the SQL statement;
			-- 2. DESCRIBE the SQL statement and get enough information to
			-- allocate enough memory space for the corresponding descriptor.
		deferred
		end

	start_order (no_descriptor: INTEGER)
			-- Finish execution of a SQL statement in DYNAMICLLY EXECUTION mode:                                                         */
			-- 1. if the PREPAREd SQL statement is a NON_SELECT statement,
			-- just EXECUTE it; otherwise, DEFINE a CURSOR for it and
			-- OPEN the CURSOR. In the process, if error occurs, do some
			-- clearence;
		deferred
		end

	next_row (no_descriptor: INTEGER)
			-- A SELECT statement is now being executed in DYNAMIC EXECUTION mode,
			-- the  routine is to FETCH a new tuple from database
			-- and if a new tuple is fetched, return 1 otherwise return 0.
		deferred
		end

	terminate_order (no_descriptor: INTEGER)
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- so the routine is to do some clearence:
			-- 1. if the DYNAMICALLY EXECUTED SQL statement is a NON_SELECT
			-- statement, just free the memory for ODBCSQLDA and clear
			-- the cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR
			-- and then do the same clearence.
			-- 2. return error number.
		deferred
		end

	close_cursor (no_descriptor: INTEGER)
			-- A SQL has been performed in DYNAMIC EXECUTION mode,
			-- Then if the DYNAMICALLY EXECUTED SQL statement is a SELECT
			-- statement, then the cursor is closed.
			-- Then one can do an other selection on the previous cursor.
		deferred
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
			-- In IMMEDIATE EXECUTE mode perform the SQL statement,
			-- and then check if there is warning message for the execution,
		deferred
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		require
			ar_not_void: ar /= Void
		deferred
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32; max_len:INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	sensitive_mixed: BOOLEAN
			-- Is the database sensitive to lower or
			-- upper case?
			-- Only for ODBC, Ingres
		do
			Result := True
		end

	identifier_quoter: STRING_32
			-- Return the string used to quote identifiers in SQL command,
			-- for example, if the quoter is `, and we want to select on
			-- table "my table", we should express the query as:
			-- select * from `My table`
			-- Only for ODBC
		do
			Result := {STRING_32} ""
		end

	qualifier_separator: STRING_32
			-- When "qualifier" and "owner" are used to identifier
			-- a database object, they should be separated by a string called
			-- "qualifier separator"
			-- Only for ODBC
		do
			Result := {STRING_32} ""
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
			--| FIXME
			--| This description really does not explain a thing...
		deferred
		end

	get_count (no_descriptor: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is last retrieved data null?
		deferred
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
			-- Function used to get data from structure SQLDA filled  by FETCH clause.
		deferred
		end

	get_decimal (no_descriptor: INTEGER; ind: INTEGER): detachable TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Function used to get decimal info
		deferred
		end

	database_make (i: INTEGER)
			-- Initialize database c-module
		deferred
		end

	connect (user_name, user_passwd, data_source, application, hostname, role_id: STRING; role_passwd: detachable STRING; group_id: STRING)
			-- Connect to database
		deferred
		end

	connect_by_connection_string (a_connect_string: STRING)
			-- Connect to database by connection string
		deferred
		end

	disconnect
			-- Disconnect the current connection with an database
		deferred
		end

	commit
			-- Commit the current transaction
		deferred
		end

	rollback
			-- Commit the current transaction
		deferred
		end

	trancount: INTEGER
			-- Return the number of transactions now active
		deferred
		end

	begin
			-- Begin a data base transaction
		deferred
		end

	is_affected_row_count_supported: BOOLEAN
			-- Is `affected_row_count' supported?
		do
			Result := False
		end

	affected_row_count: INTEGER
			-- The number of rows changed, deleted, or inserted by the last statement
		require
			is_affected_row_count_supported: is_affected_row_count_supported
		do
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

end -- class DATABASE
