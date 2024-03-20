note
	description: "Interface used to implement CMS Storage based on SQL statement."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_SQL_I


feature -- Access

	api: detachable CMS_API
			-- Associated CMS api.
		deferred
		end

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

	has_error: BOOLEAN
			-- Last operation reported error.
		do
			Result := error_handler.has_error
		end

	reset_error
			-- Reset errors.
		do
			error_handler.reset
		end

feature -- Execution

	sql_begin_transaction
			-- Start a database transtaction.
		deferred
		end

	sql_rollback_transaction
			-- Rollback updates in the database.
		deferred
		end

	sql_commit_transaction
			-- Commit updates in the database.
		deferred
		end

	sql_post_execution
			-- Post database execution.
			-- note: execute after each `sql_query' and `sql_change'.
		deferred
		end

feature -- Operation

	check_sql_query_validity (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
		local
			l_sql_params: STRING_TABLE [READABLE_STRING_8]
			i,j,n: INTEGER
			s: READABLE_STRING_8
		do
			create l_sql_params.make_caseless (0)
			from
				i := 1
				n := a_sql_statement.count
			until
				i > n
			loop
				i := a_sql_statement.index_of (':', i)
				if i = 0 then
					i := n -- exit
				elseif
					a_sql_statement [i-1] = '%''
					or else  a_sql_statement [i-1] = '%"'
					or else a_sql_statement [i-1] = ' '
					or else a_sql_statement [i-1] = '='
					or else a_sql_statement [i-1] = '('
				then
					from
						j := i + 1
					until
						j > n or not (a_sql_statement[j].is_alpha_numeric or a_sql_statement[j] = '_')
					loop
						j := j + 1
					end
					s := a_sql_statement.substring (i + 1, j - 1)
					l_sql_params.force (s, s)
				end
				i := i + 1
			end
			if a_params = Void then
				if not l_sql_params.is_empty then
					check False end
					error_handler.add_custom_error (-1, "invalid query", "missing value for sql parameters")
				end
			else
				across
					a_params as ic
				loop
					if l_sql_params.has (ic.key) then
						l_sql_params.remove (ic.key)
					else
						error_handler.add_custom_error (-1, "useless value", {STRING_32} "value for unexpected parameter [" + ic.key.to_string_32 + "]")
					end
				end
				across
					l_sql_params as ic
				loop
					error_handler.add_custom_error (-1, "invalid query", "missing value for sql parameter [" + ic.item + "]")
				end
			end
		end

	sql_query (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute sql query `a_sql_statement' with optional parameters `a_params'.
		deferred
		end

	sql_finalize
			-- Finalize sql query (i.e destroy previous query statement.
		deferred
		end

	sql_insert (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute sql insert `a_sql_statement' with optional parameters `a_params'.
		deferred
		end

	sql_modify (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute sql modify `a_sql_statement' with optional parameters `a_params'.
		deferred
		end

	sql_delete (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute sql delete `a_sql_statement' with optional parameters `a_params'.
		deferred
		end

	sql_finalize_query (a_sql_statement: READABLE_STRING_8)
		do
			sql_finalize_statement (a_sql_statement)
		end

	sql_finalize_insert (a_sql_statement: READABLE_STRING_8)
		do
			sql_finalize_statement (a_sql_statement)
		end

	sql_finalize_modify (a_sql_statement: READABLE_STRING_8)
		do
			sql_finalize_statement (a_sql_statement)
		end

	sql_finalize_delete (a_sql_statement: READABLE_STRING_8)
		do
			sql_finalize_statement (a_sql_statement)
		end

	sql_finalize_statement (a_sql_statement: READABLE_STRING_8)
		do
			sql_finalize
			if
				has_error and then
				attached api as l_cms_api
			then
				if not is_logging_database_error then
					is_logging_database_error := True
					l_cms_api.log_error ("database", generator + "." + l_cms_api.html_encoded (error_handler.as_string_representation) + "%N<p>SQL=%""+  l_cms_api.html_encoded (a_sql_statement) +"%"</p>", Void)
					is_logging_database_error := False
				end
			end
		end

	is_logging_database_error: BOOLEAN

feature -- Helper

	to_fully_escaped_json_string (s: READABLE_STRING_8): STRING_8
			-- Ensure `s` is correctly escaped so that databases do not complain.
		local
			i,n: INTEGER
			c: INTEGER_32
			l_in_string: BOOLEAN
			l_was_backslash: BOOLEAN
		do
			n := s.count
			create Result.make (n)
			from
				i := 1
			until
				i > n
			loop
				c := s[i].code
				if s[i] = '"' and not l_was_backslash then
					l_in_string := not l_in_string
					Result.append_character (s[i])
				elseif l_in_string then
					if c < 0x20 or 0x7F < c then
						Result.append_string ("\u")
						Result.append_string (c.to_natural_32.to_hex_string.as_lower)
					else
						Result.append_character (s[i])
					end
				else
					Result.append_character (s[i])
				end
				l_was_backslash := s[i] = '\'
				i := i + 1
			end
		end

	sql_script_content (a_path: PATH): detachable STRING
			-- Content of sql script located at `a_path'.
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_path (a_path)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
					f.start
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

	sql_execute_file_script (a_path: PATH; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute SQL script from `a_path' and with optional parameters `a_params'.
		do
			if attached sql_script_content (a_path) as sql then
				sql_execute_script (sql, a_params)
			end
		end

	sql_execute_script (a_sql_script: STRING; a_params: detachable STRING_TABLE [detachable ANY])
			-- Execute SQL script.
			-- i.e: multiple SQL statements.
		local
			i: INTEGER
			err: BOOLEAN
			err_msg: STRING_32
			cl: CELL [INTEGER]
			l_sql: READABLE_STRING_8
		do
			reset_error
			sql_begin_transaction
-- Issue on MySQL with multiple statements
--			sql_change (a_sql_script, Void)
			from
				i := 1
				create cl.put (0)
			until
				i > a_sql_script.count or err
			loop
				if attached next_sql_statement (a_sql_script, i, cl) as s then
					if not s.is_whitespace then
						l_sql := sql_statement (s)
						if s.starts_with ("INSERT") then
							sql_insert (l_sql, a_params)
							sql_finalize_insert (l_sql)
						else
							sql_modify (l_sql, a_params)
							sql_finalize_modify (l_sql)
						end
						if has_error then
							if err_msg = Void then
								create err_msg.make_empty
							else
								err_msg.append_character ('%N')
							end
							err_msg.append (error_handler.as_string_representation)
							err := True
						end
						reset_error
					end
					i := i + cl.item
				else
					i := a_sql_script.count + 1
				end
			end
			if err then
				sql_rollback_transaction
				error_handler.add_custom_error (-1, "execute_sql_script error", err_msg)
			else
				sql_commit_transaction
			end
		end

	sql_table_exists (a_table_name: READABLE_STRING_8): BOOLEAN
			-- Does table `a_table_name' exists?
		local
			l_sql: READABLE_STRING_8
		do
			reset_error
			l_sql := "SELECT count(*) FROM " + a_table_name + " ;"
			sql_query (l_sql, Void)
			Result := not has_error
				-- FIXME: find better solution
			sql_finalize_query (l_sql)
			reset_error
		end

	sql_table_items_count (a_table_name: READABLE_STRING_8): INTEGER_64
			-- Number of items in table `a_table_name'?
		local
			l_sql: READABLE_STRING_8
		do
			reset_error
			l_sql := "SELECT count(*) FROM " + a_table_name + " ;"
			sql_query (l_sql, Void)
			if not has_error then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (l_sql)
		end

feature -- Access

	sql_start
			-- Set the cursor on first element.
		require
			no_error: not has_error
		deferred
		end

	sql_after: BOOLEAN
			-- Are there no more items to iterate over?
		require
			no_error: not has_error
		deferred
		end

	sql_forth
			-- Fetch next row from last sql execution, if any.
		require
			no_error: not has_error
		deferred
		end

	sql_valid_item_index (a_index: INTEGER): BOOLEAN
		deferred
		end

	sql_item (a_index: INTEGER): detachable ANY
		require
			no_error: not has_error
			valid_index: sql_valid_item_index (a_index)
		deferred
		end

	sql_read_natural_64 (a_index: INTEGER): NATURAL_64
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {NATURAL_64} l_item as i then
				Result := i
			elseif attached {NATURAL_64_REF} l_item as l_value then
				Result := l_value.item
			else
				Result := sql_read_integer_64 (a_index).to_natural_64
			end
		end

	sql_read_integer_64 (a_index: INTEGER): INTEGER_64
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {INTEGER_64} l_item as i then
				Result := i
			elseif attached {INTEGER_64_REF} l_item as l_value then
				Result := l_value.item
			else
				Result := sql_read_integer_32 (a_index).to_integer_64
			end
		end

	sql_read_integer_32 (a_index: INTEGER): INTEGER_32
			-- Retrieved value at `a_index' position in `item'.
		deferred
		end

	sql_read_string_8, sql_read_string (a_index: INTEGER): detachable READABLE_STRING_8
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {READABLE_STRING_8} l_item as l_string then
				Result := l_string
			elseif
				attached {READABLE_STRING_32} l_item as l_string_32 and then
				l_string_32.is_valid_as_string_8
			then
				Result := l_string_32.to_string_8
			elseif attached {BOOLEAN} l_item as l_boolean then
				Result := l_boolean.out
			elseif attached {BOOLEAN_REF} l_item as l_boolean_ref then
				Result := l_boolean_ref.item.out
			else
				check is_string_nor_null: l_item = Void end
			end
		end

	sql_read_string_32 (a_index: INTEGER): detachable READABLE_STRING_32
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
			utf: UTF_CONVERTER
		do
			-- FIXME: handle string_32 !
			l_item := sql_item (a_index)
			if attached {READABLE_STRING_32} l_item as l_string then
				Result := l_string
			elseif attached {READABLE_STRING_8} l_item as l_string_8 then
				Result := utf.utf_8_string_8_to_string_32 (l_string_8)
			else
				if attached sql_read_string (a_index) as s8 then
					Result := s8.to_string_32 -- FIXME: any escape?
				else
					check is_string_nor_null: l_item = Void end
				end
			end
		end

	sql_read_date_time (a_index: INTEGER): detachable DATE_TIME
			-- Retrieved value at `a_index' position in `item'.
		deferred
		end

	sql_read_boolean (a_index: INTEGER): detachable BOOLEAN
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {BOOLEAN} l_item as l_boolean then
				Result := l_boolean
			elseif attached {BOOLEAN_REF} l_item as l_boolean_ref then
				Result := l_boolean_ref.item
			else
				check is_boolean: False end
			end
		end

feature -- Conversion

	sql_statement (a_statement: READABLE_STRING_8): READABLE_STRING_8
			-- Statement normalized for underlying SQL database.
		deferred
		end

feature -- Parameters helpers

	sql_parameters (nb: INTEGER; d: detachable ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]): STRING_TABLE [detachable ANY]
		do
			create Result.make (nb)
			if d /= Void then
				sql_append_parameters (d, Result)
			end
		end

	sql_append_parameters (d: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]; a_params: STRING_TABLE [detachable ANY])
		do
			across
				d as ic
			loop
				if attached ic.item as l_item then
					a_params.put (l_item.value, l_item.name)
				end
			end
		end

feature {NONE} -- Implementation

	next_sql_statement (a_script: STRING; a_start_index: INTEGER; a_offset: CELL [INTEGER]): detachable STRING_8
		local
			i,j,n: INTEGER
			c: CHARACTER
			l_end: INTEGER
			l_removals: detachable ARRAYED_LIST [TUPLE [start_index,end_index: INTEGER]]
		do
			from
				i := a_start_index
				n := a_script.count
			until
				i > n or a_script[i] = ';'
			loop
				c := a_script[i]
				inspect c
				when '-' then
					if i < n and then a_script[i + 1] = '-' then
							-- Commented line "--" until New Line
						j := a_script.index_of ('%N', i)
						if j = 0 then
							j := n
						else
--							j := j
						end
						if l_removals = Void then
							create l_removals.make (1)
						end
						l_removals.force ([i,j])
						i := j
					end
				when '/' then
					if i < n and then a_script[i + 1] = '*' then
							-- Commented text "/*" until closing "*/"
						j := a_script.substring_index ("*/", i)

						if j = 0 then
							j := n
						else
							j := j + 1 -- Include '/'
						end
						if l_removals = Void then
							create l_removals.make (1)
						end
						l_removals.force ([i,j])
						i := j
					end
				when '`', '"', '%'' then
					from
						j := i
						l_end := 0
					until
						l_end > 0 or j > n
					loop
						j := a_script.index_of (c, i + 1)
						if j > i then
							if a_script [j - 1] /= '\' then
								l_end := j
							end
						else
							l_end := i
						end
					end
					if l_end > 0 then
						i := l_end
					else
						i := j
					end
				else

				end
				i := i + 1
			end
			if i <= n and i > a_start_index then
				Result := a_script.substring (a_start_index, i)
				a_offset.replace (Result.count)
				if l_removals /= Void then
					j := 0
					across
						l_removals as ic
					loop
						Result.remove_substring (ic.item.start_index - j - a_start_index + 1, ic.item.end_index - j - a_start_index + 1)
						j := j + ic.item.end_index - ic.item.start_index + 1
					end
--					a_offset.replace (a_offset.item  j)
				end
			end
		end

note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
