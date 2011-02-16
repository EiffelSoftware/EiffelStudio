note
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
			convert_string_type
		end

	STRING_HANDLER

feature

	database_handle_name: STRING = "ORACLE"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an Oracle function been called since last update which may have
			-- updated error code, error message or warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
			ora_clear_error
		end

	insert_auto_identity_column: BOOLEAN = True
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?

feature -- For DATABASE_CHANGE

	descriptor_is_available: BOOLEAN
		do
			Result := ora_available_descriptor = 1
		end

feature -- For DATABASE_FORMAT

	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
		do
			create Result.make (1)
			Result.append ("to_date ('")
			Result.append (object.formatted_out ("[0]mm/[0]dd/yyyy [0]hh:mi:ss"))
			Result.append ("','MM/DD/YYYY HH24:MI:SS')")
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
			-- WARNING: use "IS NULL" if object is empty instead of
			-- "= NULL" which does not work.
		do
			if object /= Void and then not object.is_empty then
				Result := object.as_string_32
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

	True_representation: STRING = "'T'"

	False_representation: STRING = "'F'"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE

	normal_parse: BOOLEAN
		do
			if is_proc then
				Result := False
				is_proc := False
			else
				Result := True
			end
		end

	parse (descriptor: INTEGER; uht: detachable DB_STRING_HASH_TABLE [ANY]; ht_order: detachable ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: READABLE_STRING_GENERAL): BOOLEAN
		do
			if uhandle.execution_type.immediate_execution then
				Result := True
			else
				init_order (descriptor, sql)
				bind_args_value (descriptor, uht, sql)
				Result := True
			end
		end

	bind_parameter (value: ARRAY [ANY]; parameters: ARRAY [ANY]; descriptor: INTEGER; sql: READABLE_STRING_GENERAL)
		local
			i: INTEGER
			tmp_c2, tmp_c, c_temp: SQL_STRING
		do
			create c_temp.make (sql)
			from
				i:=1
			until
				value.count<i
			loop
				create tmp_c.make (value.item (i).out)
				create tmp_c2.make(parameters.item (i).out)
				ora_set_parameter (descriptor, c_temp.item, tmp_c2.item, tmp_c.item)
				i := i + 1
			end
			is_error_updated := False
		end

	bind_args_value (descriptor: INTEGER; uht: detachable DB_STRING_HASH_TABLE [ANY]; sql: READABLE_STRING_GENERAL)
			-- Append map variables name from to `s'.
			-- Map variables are used for set input arguments.
			-- `uht' can be empty (for stored procedures).
		local
			tmp_c, tmp_c2, c_temp: SQL_STRING
		do
			if attached uht as l_u then
				create c_temp.make (database_format (sql.as_string_32))
				from
					l_u.start
				until
					l_u.off
				loop
					if attached {STRING_32} l_u.item_for_iteration as l_s32 then
						create tmp_c.make (database_format (l_s32))
					else
						create tmp_c.make (l_u.item_for_iteration.out)
					end
					create tmp_c2.make (l_u.key_for_iteration)
					ora_set_parameter (descriptor, c_temp.item, tmp_c2.item, tmp_c.item)
					l_u.forth
				end
			end
			is_error_updated := False
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
		do
			Result := "VARCHAR2"
		end

	map_var_name (a_para: STRING): STRING
		do
		 	create Result.make_from_string (":")
			Result.append (a_para)
		end

feature -- DATABASE_REAL

	sql_name_real: STRING = "FLOAT"

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING = "DATE"

feature -- DATABASE_DOUBLE

	sql_name_double: STRING = "FLOAT"

feature -- DATABASE_CHARACTER

	sql_name_character: STRING = "CHAR"

feature -- DATABASE_INTEGER

	sql_name_integer: STRING = "NUMBER"

	sql_name_integer_16: STRING = "NUMBER(5)"

	sql_name_integer_64: STRING = "NUMBER(19)"

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING = "CHAR"

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN
		do
			Result := upasswd /= Void
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
		do
			Result := name.is_equal (uname) and passwd.is_equal (upasswd)
		end

feature -- For database types

	convert_string_type (r_any: ANY; field_name, class_name: STRING): ANY
			-- Convert `r_any' to the expected object.
			-- By default returns `r_any', redefined in ORACLE to return
			-- an INTEGER_REF when `field_name' is "data_type".
		local
			data_type: INTEGER_REF
		do
			if field_name.is_equal ("data_type") then
				if class_name.is_equal (("").generator) then
					create data_type
					if r_any.is_equal ("VARCHAR2") or else r_any.is_equal ("CHAR") then
						data_type.set_item (ora_string_type)
					elseif r_any.is_equal ("NVARCHAR2") or else r_any.is_equal ("NCHAR") then
						data_type.set_item (ora_wstring_type)
					elseif r_any.is_equal ("NUMBER") then
						data_type.set_item (ora_number_type)
					elseif r_any.is_equal ("FLOAT") then
						data_type.set_item (ora_float_type)
					elseif r_any.is_equal ("INT") then
						data_type.set_item (ora_int_type)
					elseif r_any.is_equal ("DATE") then
						data_type.set_item (ora_date_type)
					end
					Result := data_type
				else
					Result := r_any
				end
			elseif field_name.is_equal ("nullable") then
				if class_name.is_equal (("").generator) then
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

	support_sql_of_proc: BOOLEAN = True

	support_stored_proc: BOOLEAN
		do
			Result := True
			is_proc := True
		end

	sql_as: STRING = " AS BEGIN "

	sql_end: STRING = "; END;"

	sql_execution: STRING = "BEGIN "

	sql_creation: STRING = "create procedure "

	sql_after_exec: STRING = "; END;"

	support_drop_proc: BOOLEAN = True

	name_proc_lower: BOOLEAN = False

	map_var_between: STRING = ""

	Select_text (proc_name: STRING): STRING
		do
			Result := "select text from all_source %
			%where Name = :name and %
			%Type = 'PROCEDURE'"
		end

	Select_exists (name: STRING): STRING
		do
			Result := "select count (*) from all_objects %
			%where (object_type = 'PROCEDURE') and %
			% (object_name = :name)"
		end

feature -- For DATABASE_REPOSITORY

	Selection_string (rep_qualifier, rep_owner, rep_name: STRING): STRING
		do
			repository_name := rep_name
					-- This query request all the Tables of the database
--			Result := "SELECT * FROM ALL_TAB_COLUMNS WHERE Table_Name =:rep order by Column_ID"
					-- This query retrieve only the tables that the user can access.
					-- By default we should use this query.
			Result := "SELECT * FROM USER_TAB_COLUMNS WHERE Table_Name =:rep order by Column_ID"
		end

	sql_string: STRING = "VARCHAR2 ("

	sql_string2 (int: INTEGER): STRING
		do
			Result := "VARCHAR2 ("
			Result.append (int.out)
			Result.append (")")
		end

	sql_wstring: STRING = "NVARCHAR2 ("

	sql_wstring2 (int: INTEGER): STRING
		do
			Result := "NVARCHAR2 ("
			Result.append (int.out)
			Result.append (")")
		end

feature -- External features

	get_error_message: POINTER
		do
			Result := ora_get_error_message
			is_error_updated := True
		end

	get_error_message_string: STRING_32
			-- The error message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		local
			l_s: SQL_STRING
		do
			create l_s.make_by_pointer (get_error_message)
			Result := l_s.string
		end

	get_error_code: INTEGER
		do
			Result := ora_get_error_code
			is_error_updated := True
		end

	get_warn_message: POINTER
		do
			Result := ora_get_warn_message
			is_error_updated := True
		end

	get_warn_message_string: STRING_32
			-- The warning message as returned by the RDBMS after the last
			-- action.
			-- This feature also sets is_error_updated to True
		local
			l_s: SQL_STRING
		do
			create l_s.make_by_pointer (get_warn_message)
			Result := l_s.string
		end

	new_descriptor: INTEGER
		do
			Result := ora_new_descriptor
			is_error_updated := False
		end

	init_order (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: SQL_STRING
		do
			create c_temp.make (database_format (command.as_string_32))
			ora_init_order (c_temp.item, no_descriptor)
			is_error_updated := False
		end

	start_order (no_descriptor: INTEGER)
		do
			ora_start_order (no_descriptor)
			is_error_updated := False
		end

	next_row (no_descriptor: INTEGER)
		do
			found := ora_next_row (no_descriptor) = 0
			is_error_updated := False
		end

	terminate_order (no_descriptor: INTEGER)
		do
			ora_terminate_order (no_descriptor)
			is_error_updated := False
		end

	close_cursor (no_descriptor: INTEGER)
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: READABLE_STRING_GENERAL)
		local
			c_temp: SQL_STRING
		do
			create c_temp.make (database_format (command.as_string_32))
			ora_exec_immediate (no_descriptor, c_temp.item)
			is_error_updated := False
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := ora_put_select_name (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end

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
		do
			create l_area.make (max_len)

			Result := ora_put_data (no_descriptor, index, l_area.item)

			check
				Result <= max_len
			end

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

	put_data_32 (no_descriptor: INTEGER; index: INTEGER; ar: STRING_32; max_len:INTEGER): INTEGER
		local
			i: INTEGER
			l_data, l_null: POINTER
			l_area: MANAGED_POINTER
			l_str32: STRING_32
			l_str: STRING
			l_count: INTEGER
		do
			create l_area.make (max_len)
			l_data := l_area.item
			l_count := ora_put_data (no_descriptor, index, l_data)

			create l_str.make (l_count)
			l_str.set_count (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_str.put (l_area.read_character (i - 1), i)
				i := i + 1
			end
			l_str32 := utf8_to_utf32 (l_str)
			ar.wipe_out
			ar.append (l_str32)
			Result := l_str32.count
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := ora_conv_type (index)
		end

	get_count (no_descriptor: INTEGER): INTEGER
		do
			Result := ora_get_count (no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ora_get_data_len (ind, no_descriptor)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ora_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ora_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ora_get_integer_data (no_descriptor, ind)
		end

	get_integer_16_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_16
		do
			Result := ora_get_integer_16_data (no_descriptor, ind)
		end

	get_integer_64_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER_64
		do
			Result := ora_get_integer_64_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := ora_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := ora_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
			Result := ora_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- is last retrieved data null?
		do
			Result := ora_is_null_data (no_descriptor, ind)
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ora_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_hour)
			Result := tmp_strg.to_integer
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_sec)
			Result := tmp_strg.to_integer
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_min)
			Result := tmp_strg.to_integer
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_year)
			Result := tmp_strg.to_integer
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_day)
			Result := tmp_strg.to_integer
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		local
			tmp_strg: STRING
		do
			create tmp_strg.make (0)
			tmp_strg.from_c (ora_get_month)
			Result := tmp_strg.to_integer
		end

	c_string_type: INTEGER
		do
			Result := ora_c_string_type
		end

	c_wstring_type: INTEGER
		do
			Result := ora_c_wstring_type
		end

	c_character_type: INTEGER
		do
			Result := ora_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := ora_c_integer_type
		end

	c_integer_16_type: INTEGER
		do
			Result := ora_c_integer_16_type
		end

	c_integer_64_type: INTEGER
		do
			Result := ora_c_integer_64_type
		end

	c_float_type: INTEGER
		do
			Result := ora_c_float_type
		end

   	c_real_type: INTEGER
		do
			Result := ora_c_real_type
		end

	c_boolean_type: INTEGER
		do
			Result := ora_c_boolean_type
		end

	c_date_type: INTEGER
		do
			Result := ora_c_date_type
		end

	database_make (i: INTEGER)
		do
			ora_database_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId: STRING; rolePassWd: detachable STRING; groupId: STRING)
        local
			c_temp1, c_temp2: C_STRING
		do
			create c_temp1.make (user_name)
			create c_temp2.make (user_passwd)
			ora_connect (c_temp1.item, c_temp2.item)
			is_error_updated := False
       	end

	disconnect
		do
			ora_disconnect
			is_error_updated := False
			found := False
		end

	commit
		do
			ora_commit
			is_error_updated := False
		end

	rollback
		do
			ora_rollback
			is_error_updated := False
		end

	trancount: INTEGER
		do
			Result := ora_trancount
		end

 	begin
		do
		end

feature -- Explicit Conversion

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
			-- Append an unicode code point `a_code' to an utf8 stream.
		require
			a_string_not_void: a_string /= Void
				-- According to ISO/IEC 10646, the maximum unicode point is 10FFFF.
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

	database_format (a_str: STRING_32): STRING_8
			-- Append an unicode code point `a_code' to an utf8 stream.
		require
			a_str_not_void: a_str /= Void
		do
			Result := utf32_to_utf8 (a_str)
		end

feature {NONE} -- External features

	repository_name: detachable STRING

	is_proc: BOOLEAN

	ora_get_error_message: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_error_code: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_warn_message: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_new_descriptor: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_init_order (command: POINTER; no_descriptor: INTEGER)
		external
			"C | %"oracle.h%""
		end

	ora_start_order (no_descriptor: INTEGER)
		external
			"C | %"oracle.h%""
		end

	ora_next_row (no_descriptor: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_terminate_order (no_descriptor: INTEGER)
		external
			"C | %"oracle.h%""
		end

	ora_exec_immediate (no_descriptor: INTEGER; command: POINTER)
		external
			"C (EIF_INTEGER, text *) | %"oracle.h%""
		end

	ora_put_select_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_conv_type (index: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_count (no_descriptor: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_data_len (ind: INTEGER; no_descriptor: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_integer_data (no_descriptor:INTEGER; ind: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_integer_16_data (no_descriptor:INTEGER; ind: INTEGER): INTEGER_16
		external
			"C | %"oracle.h%""
		end

	ora_get_integer_64_data (no_descriptor:INTEGER; ind: INTEGER): INTEGER_64
		external
			"C | %"oracle.h%""
		end

	ora_get_float_data (no_descriptor:INTEGER; ind: INTEGER): DOUBLE
		external
			"C | %"oracle.h%""
		end

	ora_get_real_data (no_descriptor:INTEGER; ind: INTEGER): REAL
		external
			"C | %"oracle.h%""
		end

	ora_get_boolean_data (no_descriptor:INTEGER; ind: INTEGER): BOOLEAN
		external
			"C | %"oracle.h%""
		end

	ora_is_null_data (no_descriptor:INTEGER; ind: INTEGER): BOOLEAN
		external
			"C | %"oracle.h%""
		end

	ora_get_date_data (desc: INTEGER; index: INTEGER): INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_get_hour: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_sec: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_min: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_year: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_day: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_get_month: POINTER
		external
			"C | %"oracle.h%""
		end

	ora_database_make (i: INTEGER)
		external
			"C | %"oracle.h%""
		alias
			"c_ora_make"
		end

	ora_disconnect
		external
			"C | %"oracle.h%""
		end

	ora_commit
		external
			"C | %"oracle.h%""
		end

	ora_rollback
		external
			"C | %"oracle.h%""
		end

	ora_trancount: INTEGER
		external
			"C | %"oracle.h%""
		end


	ora_connect (user_name, user_passwd: POINTER)
		external
			"C (text *, text*) | %"oracle.h%""
		end

	ora_available_descriptor: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_set_parameter (descriptor: INTEGER; sql: POINTER; ph: POINTER; value: POINTER)
		external
			"C (EIF_INTEGER, text *, text *, char *) | %"oracle.h%""
		end

	ora_string_type: INTEGER
		external
			"C [macro %"oracle.h%"]"
		alias
			"VARCHAR2_TYPE"
		end

	ora_wstring_type: INTEGER
			-- No NVARCHAE2_TYPE in OCI 7.0
		do
			Result := ora_string_type
		end

	ora_int_type: INTEGER
		external
			"C [macro %"oracle.h%"]"
		alias
			"INT_TYPE"
		end

	ora_float_type: INTEGER
		external
			"C [macro %"oracle.h%"]"
		alias
			"FLOAT_TYPE"
		end

	ora_number_type: INTEGER
		external
			"C [macro %"oracle.h%"]"
		alias
			"NUMBER_TYPE"
		end

	ora_date_type: INTEGER
		external
			"C [macro %"oracle.h%"]"
		alias
			"DATE_TYPE"
		end

	ora_c_string_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_wstring_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_character_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_integer_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_integer_16_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_integer_64_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_float_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_real_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_boolean_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_c_date_type: INTEGER
		external
			"C | %"oracle.h%""
		end

	ora_clear_error
		external
			"C | %"oracle.h%""
		end

	break (s: STRING_32): STRING_32
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

	Concat_string: STRING_32 = "'||'";

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




end -- class ORACLE


