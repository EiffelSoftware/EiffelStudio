indexing
	description: "Oracle specification"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			convert_string_type
		end

	OCI_DEFINITIONS
		export {NONE} all
		end

	PLATFORM
		export {NONE} all
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
				-- Release the last error message, if it wasn't empty
			if error_message_ptr /= default_pointer and error_message_ptr /= empty_string_ptr then
				error_message_ptr.memory_free
			end
			error_message_ptr := empty_string_ptr
			error_code := 0
		end

	insert_auto_identity_column: BOOLEAN is True
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN is
		do
			Result := True
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
				Result := object.twin
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

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN is
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
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ descriptor
			stmt.prepare (sql)
			from
				i := 1
			until
				value.count < i
			loop
				stmt.declare_string_variable (parameters.item (i).out, parameters.item (i).out.count)
				stmt.assign_variable (parameters.item (i).out, value.item (i).out)
				i := i + 1
			end
			is_error_updated := False
		end

	bind_args_value (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; sql: STRING) is
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
			-- `uht' can be empty (for stored procedures).
		local
			stmt: OCI_STATEMENT
			tmp_val: STRING
			c_temp: ANY
		do
			stmt := descriptors @ descriptor
			stmt.prepare (sql)
			c_temp := sql.to_c
			from
				uht.start
			until
				uht.off
			loop
				tmp_val := uht.item (uht.key_for_iteration).out
				stmt.declare_string_variable ((uht.key_for_iteration).out, tmp_val.count)
				stmt.assign_variable ((uht.key_for_iteration).out, tmp_val)
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

	map_var_name (par_name: STRING): STRING is
			--
		do
			Result:= once ""
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
						data_type.set_item (Sqlt_chr)
					elseif r_any.is_equal ("NUMBER") then
						data_type.set_item (Sqlt_num)
					elseif r_any.is_equal ("DATE") then
						data_type.set_item (Sqlt_dat)
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

feature {NONE} -- Database type conversion		

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER is
		do
			inspect
				index
			when Sqlt_chr, Sqlt_afc, Sqlt_lng then
				Result := c_string_type
			when Sqlt_int then
				Result := c_integer_type
			when Sqlt_num, sqlt_flt then
				Result := c_float_type
			when Sqlt_dat then
				Result := c_date_type
			else
				Result := index
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

	Select_text (proc_name: STRING): STRING is
			--
		do
			Result := "select text from user_source where Name = :name and %Type = 'PROCEDURE'"
		end

	Select_exists (name: STRING): STRING is
		do
			Result := "select count (*) from user_objects %
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
		local
			msg: ANY
			cnt: INTEGER
		do
			if not is_error_updated then
--				clear_error
				error_handler.get_error_info (1)
				error_code := error_handler.error_code
				msg := error_handler.message.to_c
				cnt := error_handler.message.count + 1
				error_message_ptr := default_pointer.memory_alloc (cnt)
				error_message_ptr.memory_copy ($msg, cnt)
			end
			Result := error_message_ptr
			is_error_updated := True
		end

	get_error_code: INTEGER is
		do
			if not is_error_updated then
				error_handler.get_error_info (1)
				error_code := error_handler.error_code
			end
				-- Filter out "End of data"
			if error_code /= 1403 then
				Result := error_code
			end
			is_error_updated := True
		end

	get_warn_message: POINTER is
		do
			Result := empty_string_ptr
			is_error_updated := True
		end

	empty_string_ptr: POINTER is
			-- Pointer to a zero-length string
		once
			Result := default_pointer.memory_alloc (1)
			Result.memory_set (0, 1)
		end


	new_descriptor: INTEGER is
		require else
			descriptor_available: is_descriptor_available
		local
			stmt: OCI_STATEMENT
			i: INTEGER
		do
			create stmt.make (env, error_handler)
			from
				i := descriptors.lower
			until
				descriptors @ i = Void
				-- pre-condition guarantees that such value of `i' must exist within the bounds				
			loop
				i := i + 1
			end
			descriptors.put (stmt, i)
			descriptor_count := descriptor_count + 1
			Result := i
			is_error_updated := False
		end

	is_descriptor_available: BOOLEAN is
			-- Is a new descriptor available ?
		do
			Result := descriptor_count < descriptors.count
		end

	init_order (no_descriptor: INTEGER; command: STRING) is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			stmt.prepare (command)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER) is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			stmt.execute (context)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER) is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			if not stmt.eof then
				stmt.fetch_next
			end
			found := not stmt.eof
			if found then
				results.put (stmt.current_row.twin, no_descriptor)
			else
				results.put (Void, no_descriptor)
			end
			is_error_updated := False
		end

	terminate_order (no_descriptor: INTEGER) is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
--			stmt.close
			stmt.free
			descriptors.put (Void, no_descriptor)
			results.put (Void, no_descriptor)
			descriptor_count := descriptor_count - 1
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER) is
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING) is
		local
			stmt: OCI_STATEMENT
		do
			clear_error
			stmt := descriptors @ no_descriptor
			stmt.prepare (command)
			stmt.execute (context)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER is
		local
			stmt: OCI_STATEMENT
			name: STRING
			length: INTEGER
		do
			stmt := descriptors @ no_descriptor
			name := stmt.column (index).name
			length := name.count
			ar.wipe_out
			ar.append (name)
			Result := length
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER is
		local
			value: ANY
			length: INTEGER
			temp_str: STRING
			temp_dbl_ref: DOUBLE_REF
			temp_dbl: DOUBLE
			temp_int_ref: INTEGER_REF
			temp_int: INTEGER
		do
			value := (results @ no_descriptor) @ index
			temp_str ?= value
			if temp_str /= Void then
				length := temp_str.count
				ar.wipe_out
				ar.append (temp_str)
			else
				temp_int_ref ?= value
				if temp_int_ref /= Void then
					length := Integer_bytes;
					temp_int := temp_int_ref.item; ($ar).memory_copy ($temp_int, length)
				else
					temp_dbl_ref ?= value
					if temp_dbl_ref /= Void then
						length := Double_bytes;
						temp_dbl := temp_dbl_ref.item; ($ar).memory_copy ($temp_dbl, length)
					else
						length := 0
					end
				end
			end
			Result := length
		end

	get_count (no_descriptor: INTEGER): INTEGER is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			Result := stmt.column_count
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			Result := stmt.column (ind).data_size
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			Result := stmt.column (ind).data_size
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			stmt: OCI_STATEMENT
		do
			stmt := descriptors @ no_descriptor
			Result := conv_type (0, stmt.column (ind).data_type)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		local
			temp: DOUBLE_REF
		do
			temp ?= (results @ no_descriptor) @ ind
			Result := temp.item.truncated_to_integer
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE is
		local
			temp: DOUBLE_REF
		do
			temp ?= (results @ no_descriptor) @ ind
			Result := temp.item
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL is
		local
			temp: DOUBLE_REF
		do
			temp ?= (results @ no_descriptor) @ ind
			Result := temp.truncated_to_real
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
		local
			temp: STRING
		do
			temp ?= (results @ no_descriptor) @ ind
			Result := temp.is_equal ("Y")
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN is
			-- is last retrieved data null?
		do
			Result := (results @ no_descriptor) @ ind = Void
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			date_data ?= (results @ no_descriptor) @ ind
			if date_data = Void then
				Result := 0
			else
				Result := 1
			end
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.time.hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.time.second
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.time.minute
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.date.year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.date.day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER is
		do
			Result := date_data.date.month
		end

	c_string_type: INTEGER is 1
--		do
--			Result := Sqlt_chr
--		end

	c_character_type: INTEGER is 2
--		do
--			Result := Sqlt_afc
--		end

	c_integer_type: INTEGER is 3
--		do
--			Result := Sqlt_num
--		end

	c_float_type: INTEGER is 4
--		do
--			Result := Sqlt_flt
--		end

   	c_real_type: INTEGER is 5
--		do
--			Result := Sqlt_flt
--		end

	c_boolean_type: INTEGER is 6
--		do
--			Result := Sqlt_afc
--		end

	c_date_type: INTEGER is 7
--		do
--			Result := Sqlt_dat
--		end

	database_make (i: INTEGER) is
		do
			clear_error
			create env.make
			create error_handler.make (env)
			create descriptors.make (1, i)
			create results.make (1, i)
		ensure then
			no_descriptors: descriptor_count = 0
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING) is
		local
			l_hostname,
			l_username: STRING
		do
			if hostname /= Void and then not hostname.is_empty then
				l_hostname := hostname
				l_username := user_name
			elseif user_name.has ('@') then
				l_hostname := user_name.substring (user_name.last_index_of ('@', user_name.count) + 1, user_name.count)
				l_username := user_name.substring (1, user_name.last_index_of ('@', user_name.count) - 1)
			else
				l_hostname := hostname
				l_username := user_name
			end
			create context.logon (env, error_handler, l_username, user_passwd, l_hostname)
			is_error_updated := False
       	end

	disconnect is
		do
			context.logoff
			context := Void
			clear_error
			is_error_updated := False
			found := False
		end

	commit is
		do
			clear_error
			perform_sql ("COMMIT")
			is_error_updated := False
		end

	rollback is
		do
			clear_error
			perform_sql ("ROLLBACK")
			is_error_updated := False
		end

	trancount: INTEGER is
		do
			if context /= Void then
				Result := 1
			else
				Result := 0
			end
		end

 	begin is
		do
		end

feature {NONE} -- Implementation

	repository_name: STRING

	is_proc: BOOLEAN

	error_message_ptr: POINTER

	error_code: INTEGER

	date_data: DATE_TIME

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

	descriptors: ARRAY [OCI_STATEMENT]

	descriptor_count: INTEGER

	results: ARRAY [ARRAY [ANY]]

	env: OCI_ENVIRONMENT

	error_handler: OCI_ERROR_HANDLER

	context: OCI_SERVICE_CONTEXT

	perform_sql (sql: STRING) is
			-- Perform ad-hoc SQL command
		local
			stmt: OCI_STATEMENT
		do
			create stmt.make (env, error_handler)
			stmt.prepare (sql)
			stmt.execute (context)
			stmt.free
			is_error_updated := False
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




end -- class ORACLE_8

