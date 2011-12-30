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
			sql_adapt_db_32,
			Max_char_size,
			support_proc,
			store_proc_not_supported,
			drop_proc_not_supported,
			text_not_supported,
			exec_proc_not_supported,
			unset_catalog_flag,
			is_convert_string_type_required,
			is_connection_string_supported
		end

	DISPOSABLE

	STRING_HANDLER

	GLOBAL_SETTINGS

feature -- Access

	database_handle_name: STRING = "ODBC"

	is_convert_string_type_required: BOOLEAN = False
		-- <Precursor>

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an ODBC function been called since last update which may have
			-- updated error code, error message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
			odbc_clear_error (con_context_pointer)
		end

	insert_auto_identity_column: BOOLEAN = False
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?		

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
		do
			Result := odbc_available_descriptor (con_context_pointer) /= 0
		end

	hide_qualifier (tmp_strg: STRING): POINTER
		local
			c_temp: SQL_STRING
		do
			create c_temp.make (tmp_strg)
			Result := odbc_hide_qualifier (c_temp.item, c_temp.count)
		end

	pre_immediate (descriptor, i: INTEGER)
		do
			odbc_pre_immediate (con_context_pointer, descriptor, i)
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
		obsolete
			"Use `string_format_32' instead."
		do
			Result := string_format_32 (object)
		end

	string_format_32 (object: detachable READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `object'.
		do
			if object /= Void and then not object.is_empty then
				if not is_binary (object) then
					Result := object.as_string_32.twin
					Result.replace_substring_all ("\", "\\")
					Result.replace_substring_all ("'", "''")
					Result.precede ('%'')
					Result.extend ('%'')
				else
					-- FIXME: fool compiler and bug here
					Result := {STRING_32} "NULL"
				end
			else
				Result := {STRING_32} "NULL"
			end
		end

	True_representation: STRING = "1"

	False_representation: STRING = "0"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN = False

	parse (descriptor: INTEGER; uht: detachable DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_32]; uhandle: HANDLE; sql: READABLE_STRING_GENERAL): BOOLEAN
		local
			tmp_str: STRING_32
			c_temp: SQL_STRING
			l_ptr: POINTER
			l_para: like para
		do
			create c_temp.make (sql)
				-- This routine manipulates buffer information but does not allocate memory.
			l_ptr := odbc_hide_qualifier (c_temp.item, c_temp.count)

			tmp_str := c_temp.string
			tmp_str.left_adjust
			if tmp_str.count > 1 and then (tmp_str.item (1) = {CHARACTER_32} '{') then
				if uht /= Void then
					if uhandle.execution_type.immediate_execution then
						odbc_pre_immediate (con_context_pointer, descriptor, uht.count)
					else
						odbc_init_order (con_context_pointer, descriptor, c_temp.item, c_temp.count, uht.count)
					end
					is_error_updated := False
					if uht.count > 0 then
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
				end
--				if para /= Void then
--					para.release
--				end
				Result := True
			else
 				Result := False
			end

				-- Clean up memory
			c_temp.set_count (0)
			tmp_str.resize (0)
			tmp_str.adapt_size
		end

	bind_parameter (table: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: STRING)
		local
			i: INTEGER
			object : ANY
			tmp_str: STRING
			tmp_c: SQL_STRING
			tmp_date: detachable DATE_TIME
			type: INTEGER
			l_managed_pointer: MANAGED_POINTER
			l_para: like para
			l_decimal_t: detachable like convert_to_decimal
			l_nat64: NATURAL_64
			l_pointer: MANAGED_POINTER
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
					elseif is_decimal_used and then obj_is_decimal (object) then
						type := c_decimal_type
						l_decimal_t := convert_to_decimal (object)
					end
					tmp_str.wipe_out
					if type = c_date_type  then
						create l_managed_pointer.make (c_timestamp_struct_size)
						check tmp_date /= Void end -- Implied by `type = c_date_type'
						odbc_stru_of_date (l_managed_pointer.item, tmp_date.year, tmp_date.month,
							tmp_date.day, tmp_date.hour, tmp_date.minute, tmp_date.second, tmp_date.fractional_second.truncated_to_integer)
						l_para.set (l_managed_pointer, i)
					elseif is_decimal_used and then type = c_decimal_type then
						create l_managed_pointer.make (c_numeric_struct_size)
						if attached l_decimal_t as l_d then
							if l_d.digits.is_natural_64 then
								l_nat64 := l_d.digits.to_natural_64
							end
							l_pointer := natural_64_to_odbc_numeric_string (l_nat64)
							odbc_stru_of_numeric (l_managed_pointer.item, l_pointer.item, l_pointer.count, l_d.sign, l_d.precision, l_d.scale)
							l_para.set (l_managed_pointer, i)
						end -- Implied by `type = c_decimal_type'
					else
						tmp_str.append ( (object).out)
						create tmp_c.make (tmp_str)
						l_para.set (tmp_c.managed_data, i)
					end
				end -- Null value
				odbc_set_parameter (con_context_pointer, descriptor, i, 1, type,  odbc_get_col_len (con_context_pointer, descriptor, i), 0, l_para.get (i))
				is_error_updated := False
				i := i + 1
			end
		end

	natural_64_to_odbc_numeric_string (a_natural: NATURAL_64): MANAGED_POINTER
			-- Natural 64 to odbc numeric string
			-- Convert `a_natural' from four byte `0x00001234' into two byte 0x1234.
		local
			l_pointer: MANAGED_POINTER
			i: INTEGER
			l_c: NATURAL_8
			l_found_d: BOOLEAN
			l_position: INTEGER
		do
			create l_pointer.make (9)
			l_pointer.put_natural_64_be (a_natural, 0)
				-- Remove leading 0x0.
			create Result.make (9)
			from
				i := 0
				l_position := 0
			until
				i > 7
			loop
				l_c := l_pointer.read_natural_8 (i)
				if l_c /= 0 or l_found_d then
					Result.put_natural_8 (l_c, l_position)
					l_position := l_position + 1
					l_found_d := True
				end
				i := i + 1
			end
			Result.resize (l_position)
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

feature -- DATABASE_DECIMAL

	sql_name_decimal: STRING
			-- SQL type name for decimal
		once
			Result := " decimal"
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

	sql_name_integer_16: STRING
		once
			Result := "smallint"
		ensure then
			Result.is_equal ("smallint")
		end

	sql_name_integer_64: STRING
		once
			Result := "bigint"
		ensure then
			Result.is_equal ("bigint")
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

	is_connection_string_supported: BOOLEAN
			-- Support login by connect string?
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

	sql_adapt_db_32 (sql: STRING_32): STRING_32
		do
			sql.replace_substring_all ({STRING_32}":", {STRING_32}"@")
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

	map_var_name_32 (par_name: READABLE_STRING_GENERAL): STRING_32
			-- Map variable string for late bound stored procedure execution
		once
			Result := {STRING_32}"?"
		end

	Select_text_32 (proc_name: READABLE_STRING_GENERAL): STRING_32
			--
		do
			Result := {STRING_32}"SELECT ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = '" +
				proc_name.as_string_32 + {STRING_32}"' ORDER BY ROUTINE_NAME"
		end

	Select_exists_32 (name: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make (10)
			Result.append ({STRING_32}"SQLProcedures (")
			Result.append (name.as_string_32)
			Result.extend ({CHARACTER_32}')')
		end

feature -- For DATABASE_REPOSITORY

	sql_string: STRING = "char ("

	sql_string2 (int: INTEGER): STRING
		do
			Result := "char ("
			Result.append (int.out)
			Result.append (")")
		end

	sql_wstring: STRING = "nchar ("

	sql_wstring2 (int: INTEGER): STRING
		do
			Result := "nchar ("
			Result.append (int.out)
			Result.append (")")
		end

	selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
		local
			c_tmp: SQL_STRING
		do
			create c_tmp.make (rep_qualifier)
			odbc_set_qualifier (c_tmp.item, c_tmp.count)
			create c_tmp.make (rep_owner)
			odbc_set_owner (c_tmp.item, c_tmp.count)
			create Result.make (1)
			Result.append ("SQLColumns (")
			Result.append (repository_name)
			Result.extend (')')
		end

	Max_char_size: INTEGER = 254

feature -- For DATABASE_DYN_STORE

	unset_catalog_flag (desc:INTEGER)
		do
			odbc_unset_catalog_flag (con_context_pointer, desc)
		end

feature -- External

	get_error_message: POINTER
		do
			Result := odbc_get_error_message (con_context_pointer)
		end

	get_error_message_string: STRING_32
		local
			l_s: SQL_STRING
		do
			create l_s.make_by_pointer_and_count (
				odbc_get_error_message (con_context_pointer),
				odbc_get_error_message_count (con_context_pointer) * {SQL_STRING}.character_size
				)
			Result := l_s.string
		end

	get_error_code: INTEGER
		do
			Result := odbc_get_error_code (con_context_pointer)
			is_error_updated := True
		end

	get_warn_message: POINTER
		do
			Result := odbc_get_warn_message (con_context_pointer)
		end

	get_warn_message_string: STRING_32
		local
			l_s: SQL_STRING
		do
			create l_s.make_by_pointer_and_count (
				odbc_get_warn_message (con_context_pointer),
				odbc_get_warn_message_count (con_context_pointer) * {SQL_STRING}.character_size
				)
			Result := l_s.string
		end

	new_descriptor: INTEGER
		do
			Result := odbc_new_descriptor (con_context_pointer)
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: SQL_STRING
		do
			create c_temp.make (command)
			odbc_init_order (con_context_pointer, no_descriptor, c_temp.item, c_temp.count, 0)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER)
		do
			odbc_set_decimal_presicion_and_scale (con_context_pointer, default_decimal_presicion, default_decimal_scale)
			odbc_start_order (con_context_pointer, no_descriptor)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER)
		do
			found := odbc_next_row (con_context_pointer, no_descriptor) = 0
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER)
		do
			odbc_close_cursor (con_context_pointer, no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER)
		local
			l_para: like para
		do
			l_para := para
			if l_para /= Void then
				l_para.release
			end
			odbc_terminate_order (con_context_pointer, no_descriptor)
			is_error_updated := False
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: SQL_STRING
		do
			create c_temp.make (command)
			odbc_exec_immediate (con_context_pointer, no_descriptor, c_temp.item, c_temp.count)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len: INTEGER): INTEGER
			-- <Precursor>
		local
			l_area: MANAGED_POINTER
			l_str: SQL_STRING
		do
			create l_area.make (max_len)
			Result := odbc_put_col_name (con_context_pointer, no_descriptor, index, l_area.item)

			l_str := temporary_reusable_sql_string
			l_str.set_shared_from_pointer_and_count (l_area.item, Result * {SQL_STRING}.character_size)

			check
				Result <= max_len
			end
			ar.grow (Result)
			ar.set_count (Result)

			l_str.read_substring_into (ar, 1, Result)

				-- Free buffer immediately.
			l_area.resize (0)
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len: INTEGER): INTEGER
			-- <Precursor>
		local
			l_area: MANAGED_POINTER
			i: INTEGER
			l_data, l_null: POINTER
			l_str_area: SPECIAL [CHARACTER_8]
		do
			Result := odbc_put_data (con_context_pointer, no_descriptor, index, $l_data)
			ar.grow (Result)
			ar.set_count (Result)
			if Result > 0 then
				l_area := temporary_reusable_managed_pointer
				l_area.set_from_pointer (l_data, Result)

				l_str_area := ar.area
				from
					i := 0
				until
					i = Result
				loop
					l_str_area [i] := l_area.read_integer_8 (i).to_character_8
					i := i + 1
				end
			end
			if l_data /= l_null then
					-- `odbc_put_data' allocate some memory, we need to free it.
				l_data.memory_free
			end
		end

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32; max_len: INTEGER): INTEGER
			-- <Precursor>
		local
			l_sql_string: SQL_STRING
			l_data, l_null: POINTER
		do
			Result := odbc_put_data (con_context_pointer, no_descriptor, index, $l_data) // {SQL_STRING}.character_size
			ar.grow (Result)
			ar.set_count (Result)

			l_sql_string := temporary_reusable_sql_string
			l_sql_string.set_shared_from_pointer_and_count (l_data, Result * {SQL_STRING}.character_size)

			l_sql_string.read_substring_into (ar, 1, Result)
			if l_data /= l_null then
					-- `odbc_put_data' allocate some memory, we need to free it.
				l_data.memory_free
			end
		end

	sensitive_mixed: BOOLEAN
		do
			Result := odbc_sensitive_mixed
		end

	identifier_quoter: STRING_32
		do
			create Result.make (1)
			Result.from_c (odbc_identifier_quoter)
		end

	qualifier_seperator: STRING_32
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
			Result := odbc_get_count (con_context_pointer, no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_data_len (con_context_pointer, no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_col_len (con_context_pointer, no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_col_type (con_context_pointer, no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_integer_data (con_context_pointer, no_descriptor, ind)
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
		do
			Result := odbc_get_integer_16_data (con_context_pointer, no_descriptor, ind)
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
		do
			Result := odbc_get_integer_64_data (con_context_pointer, no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := odbc_get_float_data (con_context_pointer, no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := odbc_get_real_data (con_context_pointer, no_descriptor, ind).truncated_to_real
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
			Result := odbc_get_boolean_data (con_context_pointer, no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- Is last retrieved data null?
		do
			Result := odbc_is_null_data (con_context_pointer, no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_date_data (con_context_pointer, no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_hour (con_context_pointer)
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_sec (con_context_pointer)
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_min (con_context_pointer)
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_year (con_context_pointer)
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_day (con_context_pointer)
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := odbc_get_month (con_context_pointer)
		end

	get_decimal (no_descriptor: INTEGER; ind: INTEGER): detachable TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Function used to get decimal info
		local
			l_c_decimal: MANAGED_POINTER
			l_r: INTEGER
		do
			create l_c_decimal.make (c_numeric_struct_size)
			l_r := odbc_get_decimal (con_context_pointer, no_descriptor, ind, l_c_decimal.item)

			Result := [odbc_decimal_get_val (l_c_decimal.item).out, odbc_decimal_get_sign (l_c_decimal.item), odbc_decimal_get_precision (l_c_decimal.item), odbc_decimal_get_scale (l_c_decimal.item)]
		end

	c_string_type: INTEGER
		do
			Result := odbc_c_string_type
		end

	c_wstring_type: INTEGER
		do
			Result := odbc_c_wstring_type
		end

	c_character_type: INTEGER
		do
			Result := odbc_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := odbc_c_integer_type
		end

	c_integer_16_type: INTEGER
		do
			Result := odbc_c_integer_16_type
		end

	c_integer_64_type: INTEGER
		do
			Result := odbc_c_integer_64_type
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

	c_decimal_type: INTEGER
		do
			Result := odbc_c_decimal_type
		end

	database_make (i: INTEGER)
		do
			con_context_pointer := c_odbc_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING)
		require else
			data_source_set: data_source /= Void
		local
			c_temp1, c_temp2, c_temp3: SQL_STRING
		do
			create c_temp1.make (user_name)
			create c_temp2.make (user_passwd)
			create c_temp3.make (data_source)
			odbc_connect (con_context_pointer, c_temp1.item, c_temp1.count, c_temp2.item, c_temp2.count, c_temp3.item, c_temp3.count)
			is_error_updated := False
--			initialize_date_type_values
		end

	connect_by_connection_string (a_connect_string: STRING)
			-- Connect to database by connection string
		local
			l_string: SQL_STRING
		do
			create l_string.make (a_connect_string)
			odbc_connect_by_connection_string (con_context_pointer, l_string.item, l_string.count)
			is_error_updated := False
		end

	disconnect
		do
			odbc_disconnect (con_context_pointer)
			is_error_updated := False
			found := False
		end

	commit
		do
			odbc_commit (con_context_pointer)
			is_error_updated := False
		end

	rollback
		do
			odbc_rollback (con_context_pointer)
			is_error_updated := False
		end

	trancount: INTEGER
		do
			Result := odbc_trancount (con_context_pointer)
		end

	begin
		do
			odbc_begin (con_context_pointer)
		end

	support_proc: BOOLEAN
		do
			Result := odbc_support_proc = 1
		end

feature {NONE} -- Access

	con_context_pointer: POINTER
			-- Pointer to C structure of CON_CONTEXT

feature {NONE} -- Implementation

	temporary_reusable_sql_string: SQL_STRING
			-- Reusable sql string for temporary data manipulation.
		once
			create Result.make_empty (0)
		end

	temporary_reusable_managed_pointer: MANAGED_POINTER
		once
			create Result.share_from_pointer (default_pointer, 0)
		end

feature {NONE} -- Disposal

	dispose
			-- Free allocated memory.
		do
			if con_context_pointer /= default_pointer then
				odbc_free_connection (con_context_pointer)
				con_context_pointer := default_pointer
			end
		end

feature {NONE} -- External features

	odbc_get_error_message (a_con: POINTER): POINTER
			-- C buffer which contains the error_message.
		external
			"C use %"odbc.h%""
		end

	odbc_get_error_message_count (a_con: POINTER): INTEGER
			-- C buffer which contains the error_message.
		external
			"C use %"odbc.h%""
		end

	odbc_get_error_code (a_con: POINTER): INTEGER
			-- C buffer which contains the error code.
		external
			"C use %"odbc.h%""
		end

	odbc_get_warn_message (a_con: POINTER): POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_get_warn_message_count (a_con: POINTER): INTEGER
			-- C buffer which contains the error_message.
		external
			"C use %"odbc.h%""
		end

	odbc_new_descriptor (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_init_order (a_con: POINTER; no_descriptor: INTEGER; command: POINTER; char_count: INTEGER; argnum: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_start_order (a_con: POINTER; no_descriptor: INTEGER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_next_row (a_con: POINTER; no_descriptor: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_terminate_order (a_con: POINTER; no_descriptor: INTEGER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_close_cursor (a_con: POINTER; no_descriptor: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_exec_immediate (a_con: POINTER; no_descriptor: INTEGER; command: POINTER; char_count: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_put_col_name (a_con: POINTER; no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_put_data (a_con: POINTER; no_descriptor: INTEGER; index: INTEGER; ar: TYPED_POINTER [POINTER]): INTEGER
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

	odbc_get_count (a_con: POINTER; no_descriptor: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_data_len (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_len (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_col_type (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_integer_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_integer_16_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER_16
		external
			"C use %"odbc.h%""
		end

	odbc_get_integer_64_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER_64
		external
			"C use %"odbc.h%""
		end

	odbc_get_float_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C use %"odbc.h%""
		end

	odbc_get_real_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C use %"odbc.h%""
		end

	odbc_get_boolean_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): BOOLEAN
		external
			"C use %"odbc.h%""
		end

	odbc_is_null_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): BOOLEAN
		external
			"C use %"odbc.h%""
		end

	odbc_get_date_data (a_con: POINTER; no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_hour (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_sec (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_min (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_year (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_day (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_month (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_get_decimal (a_con: POINTER; no_descriptor: INTEGER; ind: INTEGER; p: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_c_string_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"STRING_TYPE"
		end

	odbc_c_wstring_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"WSTRING_TYPE"
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

	odbc_c_integer_16_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"INTEGER_16_TYPE"
		end

	odbc_c_integer_64_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"INTEGER_64_TYPE"
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

	odbc_c_decimal_type: INTEGER
		external
			"C [macro %"odbc.h%"]"
		alias
			"DECIMAL_TYPE"
		end

	c_odbc_make (i: INTEGER): POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_disconnect (a_con: POINTER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_commit (a_con: POINTER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_rollback (a_con: POINTER)
		external
			"C blocking use %"odbc.h%""
		alias
			"odbc_rollback"
		end

	odbc_trancount (a_con: POINTER): INTEGER
		external
			"C use %"odbc.h%""
		alias
			"odbc_trancount"
		end

	odbc_begin (a_con: POINTER)
		external
			"C blocking use %"odbc.h%""
		alias
			"odbc_begin"
		end

	odbc_support_proc: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_connect (a_con, user_name: POINTER; name_count:INTEGER; user_passwd: POINTER; passwd_count: INTEGER; dbName: POINTER; dbname_count: INTEGER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_connect_by_connection_string (a_con, a_string: POINTER; str_count: INTEGER)
		external
			"C blocking use %"odbc.h%""
		end

	odbc_driver_name: POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_support_create_proc: INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_unset_catalog_flag (a_con: POINTER; desc: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_hide_qualifier (command: POINTER; char_count: INTEGER): POINTER
		external
			"C use %"odbc.h%""
		end

	odbc_pre_immediate (a_con: POINTER; desc, argNum: INTEGER)
		external
		    "C use %"odbc.h%""
		end

	odbc_free_connection (a_con: POINTER)
		external
		    "C blocking use %"odbc.h%""
		end

	odbc_set_decimal_presicion_and_scale (a_con: POINTER; a_precision, a_scale: INTEGER)
		external
		    "C use %"odbc.h%""
		end

	is_binary (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a binary type?
		require
			s_not_void: s /= Void
		do
			Result := s.count > 2 and then s.code (1) = ('0').natural_32_code and then s.code (2) = ('x').natural_32_code
		ensure
			result_condition:
				Result implies (s.count > 2 and then s.code (1) = ('0').natural_32_code and then s.code (2) = ('x').natural_32_code)
		end

	para: detachable DB_PARA_ODBC

	bind_args_value (descriptor: INTEGER; uht: DB_STRING_HASH_TABLE [detachable ANY]; ht_order: detachable ARRAYED_LIST [READABLE_STRING_32])
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
			l_sql_string: SQL_STRING -- UCS-2, two byte
			l_c_string: C_STRING -- single byte
			l_platform: PLATFORM
			l_value_count: INTEGER
			l_para: like para
			l_decimal_t: like convert_to_decimal
			l_nat64: NATURAL_64
			l_pointer: MANAGED_POINTER
		do
			create tmp_str.make (1)
			create l_platform
			i := 1
			if ht_order /= Void then
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
							l_value_count := l_c_string.bytes_count
							l_managed_pointer := l_c_string.managed_data
						else
							check False end -- implied by `obj_is_string (l_any)'
						end
					elseif obj_is_string_32 (l_any) then
						type := c_wstring_type
						if attached {STRING_32} l_any as l_string_32 then
							create l_sql_string.make (l_string_32)
							pointers.extend (l_sql_string.item)
							l_value_count := l_sql_string.bytes_count
							l_managed_pointer := l_sql_string.managed_data
						else
							check False end -- implied by `obj_is_string (l_any)'
						end
					elseif obj_is_integer (l_any) then
						type := c_integer_type
						if attached {INTEGER_REF} l_any as l_val_int then
							create l_managed_pointer.make (l_platform.integer_32_bytes)
							l_managed_pointer.put_integer_32 (l_val_int.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.integer_32_bytes
						else
							check False end -- implied by `obj_is_integer (l_any)'
						end
					elseif obj_is_integer_16 (l_any) then
						type := c_integer_16_type
						if attached {INTEGER_16_REF} l_any as l_val_int16 then
							create l_managed_pointer.make (l_platform.integer_16_bytes)
							l_managed_pointer.put_integer_16 (l_val_int16.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.integer_16_bytes
						else
							check False end -- implied by `obj_is_integer (l_any)'
						end
					elseif obj_is_integer_64 (l_any) then
						type := c_integer_64_type
						if attached {INTEGER_64_REF} l_any as l_val_int64 then
							create l_managed_pointer.make (l_platform.integer_64_bytes)
							l_managed_pointer.put_integer_64 (l_val_int64.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.integer_64_bytes
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
							create l_managed_pointer.make (l_platform.real_64_bytes)
							l_managed_pointer.put_real_64 (l_val_double.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.real_64_bytes
						else
							check False end -- implied by `obj_is_double (l_any)'
						end
					elseif obj_is_real (l_any) then
						type := c_real_type
						if attached {REAL_REF} l_any as l_val_real then
							create l_managed_pointer.make (l_platform.real_32_bytes)
							l_managed_pointer.put_real_32 (l_val_real.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.real_32_bytes
						else
							check False end -- implied by `obj_is_real (l_any)'
						end
					elseif obj_is_character (l_any) then
						type := c_character_type
						if attached {CHARACTER_REF} l_any as l_val_char then
							create l_managed_pointer.make (l_platform.character_8_bytes)
							l_managed_pointer.put_character (l_val_char.item, 0)
							pointers.extend (l_managed_pointer.item)
							l_value_count := l_platform.character_8_bytes
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
					elseif is_decimal_used and then obj_is_decimal (l_any) then
						type := c_decimal_type
						l_decimal_t := convert_to_decimal (l_any)
						create l_managed_pointer.make (c_numeric_struct_size)
						if l_decimal_t.digits.is_natural_64 then
							l_nat64 := l_decimal_t.digits.to_natural_64
						end
						l_pointer := natural_64_to_odbc_numeric_string (l_nat64)
						odbc_stru_of_numeric (l_managed_pointer.item, l_pointer.item, l_pointer.count, l_decimal_t.sign, l_decimal_t.precision, l_decimal_t.scale)
						l_value_count := c_numeric_struct_size
					else
						 -- Should we attempt to insert NULL here since the type was not found and hence value was
						 -- most likely Void?
					end

					l_para := para
					check l_para_not_void: l_para /= Void end
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

					odbc_set_parameter (con_context_pointer, descriptor, i, 1, type, 100, l_value_count, l_para.get (i))

					is_error_updated := False
					i := i + 1
					ht_order.forth
				end
			end
		end

	pointers: ARRAYED_LIST [POINTER]
			--
		do
			create Result.make (10)
		end

feature {NONE} -- External features

   	odbc_set_parameter (a_con: POINTER; no_desc, seri, direction, type, collength, value_count: INTEGER; value: POINTER)
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

	odbc_stru_of_numeric (a_numeric: POINTER; digits: POINTER; digits_length: INTEGER; sign, precision, scale: INTEGER)
			-- `sign' /= 0, positive
		external
		    "C inline use %"sql.h%""
		alias
			"[
				{
					memset (((SQL_NUMERIC_STRUCT *)$a_numeric)->val, 0, SQL_MAX_NUMERIC_LEN);
					memcpy (((SQL_NUMERIC_STRUCT *)$a_numeric)->val, (SQLCHAR *)$digits, $digits_length);
					((SQL_NUMERIC_STRUCT *)$a_numeric)->precision = $precision;
					((SQL_NUMERIC_STRUCT *)$a_numeric)->sign = (SQLCHAR)$sign;
					((SQL_NUMERIC_STRUCT *)$a_numeric)->scale = $scale;
				}
			]"
		end

	odbc_decimal_get_val (a_numeric: POINTER): NATURAL_64
		external
		    "C inline use %"sql.h%""
		alias
			"[
				return (strhextoval((SQL_NUMERIC_STRUCT *)$a_numeric));
			]"
		end

	odbc_decimal_get_sign (a_numeric: POINTER): INTEGER
		external
		    "C inline use %"sql.h%""
		alias
			"[
				return ((SQL_NUMERIC_STRUCT *)$a_numeric)->sign;
			]"
		end

	odbc_decimal_get_precision (a_numeric: POINTER): INTEGER
		external
		    "C inline use %"sql.h%""
		alias
			"[
				return ((SQL_NUMERIC_STRUCT *)$a_numeric)->precision;
			]"
		end

	odbc_decimal_get_scale (a_numeric: POINTER): INTEGER
		external
		    "C inline use %"sql.h%""
		alias
			"[
				return ((SQL_NUMERIC_STRUCT *)$a_numeric)->scale;
			]"
		end

	c_timestamp_struct_size: INTEGER
		external
			"C inline use %"sql.h%""
		alias
			"sizeof(TIMESTAMP_STRUCT)"
		end

	c_numeric_struct_size: INTEGER
		external
			"C inline use %"sql.h%""
		alias
			"sizeof(SQL_NUMERIC_STRUCT)"
		end

	obj_is_integer (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {INTEGER_REF} obj
		end

	obj_is_integer_16 (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {INTEGER_16_REF} obj
		end

	obj_is_integer_64 (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {INTEGER_64_REF} obj
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

	obj_is_string_32 (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {STRING_32} obj
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

	obj_is_decimal (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := is_decimal_function.item ([obj])
		end

	convert_to_decimal (obj: ANY): TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
		require
			is_decimal: obj_is_decimal (obj)
		do
			Result := decimal_factor_function.item ([obj])
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

	odbc_set_qualifier (qlf: POINTER; char_count: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_set_owner (owner: POINTER; char_count: INTEGER)
		external
			"C use %"odbc.h%""
		end

	odbc_available_descriptor (a_con: POINTER) : INTEGER
		external
			"C use %"odbc.h%""
		end

	odbc_clear_error (a_con: POINTER)
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


