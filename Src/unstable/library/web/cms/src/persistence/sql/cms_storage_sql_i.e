note
	description: "Interface used to implement CMS Storage based on SQL statement."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_SQL_I

inherit
	SHARED_LOGGER

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
			s: STRING
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
				else
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
						error_handler.add_custom_error (-1, "useless value", "value for unexpected parameter [" + ic.key + "]")
					end
				end
				across
					l_sql_params as ic
				loop
					error_handler.add_custom_error (-1, "invalid query", "missing value for sql parameter [" + ic.item + "]")
				end
			end
		end

	sql_query (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		deferred
		end

	sql_change (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		deferred
		end

feature -- Helper

	sql_execute_file_script (a_path: PATH)
			-- Execute SQL script from `a_path'.
		local
			f: PLAIN_TEXT_FILE
			sql: STRING
		do
			create f.make_with_path (a_path)
			if f.exists and then f.is_access_readable then
				create sql.make (f.count)
				f.open_read
				from
					f.start
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					sql.append (f.last_string)
				end
				f.close
				sql_execute_script (sql)
			end
		end

	sql_execute_script (a_sql_script: STRING)
			-- Execute SQL script.
			-- i.e: multiple SQL statements.
		do
			reset_error
--			sql_begin_transaction
			sql_change (a_sql_script, Void)
--			sql_commit_transaction
		end

	sql_table_exists (a_table_name: READABLE_STRING_8): BOOLEAN
			-- Does table `a_table_name' exists?
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_table_name, "tbname")
			sql_query ("SELECT count(*) FROM :tbname ;", l_params)
			Result := not has_error
				-- FIXME: find better solution
			reset_error
		end

	sql_table_items_count (a_table_name: READABLE_STRING_8): INTEGER_64
			-- Number of items in table `a_table_name'?
		local
			l_params: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_params.make (1)
			l_params.force (a_table_name, "tbname")
			sql_query ("SELECT count(*) FROM :tbname ;", l_params)
			if not has_error then
				Result := sql_read_integer_64 (1)
			end
		end

feature -- Access		

	sql_rows_count: INTEGER
			-- Number of rows for last sql execution.	
		deferred
		end

	sql_start
			-- Set the cursor on first element.
		deferred
		end

	sql_after: BOOLEAN
			-- Are there no more items to iterate over?	
		deferred
		end

	sql_forth
			-- Fetch next row from last sql execution, if any.
		deferred
		end

	sql_valid_item_index (a_index: INTEGER): BOOLEAN
		deferred
		end

	sql_item (a_index: INTEGER): detachable ANY
		require
			valid_index: sql_valid_item_index (a_index)
		deferred
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
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {INTEGER_32} l_item as i then
				Result := i
			elseif attached {INTEGER_32_REF} l_item as l_value then
				Result := l_value.item
			else
				check is_integer_32: False end
			end
		end

	sql_read_string (a_index: INTEGER): detachable STRING
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {READABLE_STRING_8} l_item as l_string then
				Result := l_string
			elseif attached {BOOLEAN} l_item as l_boolean then
				Result := l_boolean.out
			elseif attached {BOOLEAN_REF} l_item as l_boolean_ref then
				Result := l_boolean_ref.item.out
			else
				check is_string_nor_null: l_item = Void end
			end
		end

	sql_read_string_32 (a_index: INTEGER): detachable STRING_32
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
		do
			-- FIXME: handle string_32 !
			l_item := sql_item (a_index)
			if attached {READABLE_STRING_32} l_item as l_string then
				Result := l_string
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
		local
			l_item: like sql_item
		do
			l_item := sql_item (a_index)
			if attached {DATE_TIME} l_item as dt then
				Result := dt
			else
				check is_date_time_nor_null: l_item = Void end
			end
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

end
