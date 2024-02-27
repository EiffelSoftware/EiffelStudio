note
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_SQLITE3

inherit
	CMS_STORAGE_SQL
		redefine
			sql_read_string_32
		end

	CMS_CORE_STORAGE_SQL_I
		redefine
			sql_read_string_32
		end

	CMS_USER_STORAGE_SQL_I
		redefine
			sql_read_string_32
		end

	SQLITE_BIND_ARG_MARSHALLER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (db: SQLITE_DATABASE)
		do
			sqlite := db
			create error_handler.make
		end

	sqlite: SQLITE_DATABASE
			-- Associated SQLite database.

feature -- Status report

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := has_user
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		do
			Result := sqlite.is_interface_usable
		end

feature -- Basic operation

	close
			-- Close/disconnect current storage.
		do
			sqlite.close
		end

feature -- Execution

	transaction_depth: INTEGER

	sql_begin_transaction
			-- Start a database transtaction.
		local
			retried: BOOLEAN
		do
			if retried then
					-- Issue .. db locked?
				sql_rollback_transaction
				error_handler.add_custom_error (-1, "db error", "Unable to begin transaction..")
			else
				if transaction_depth = 0 then
					sqlite.begin_transaction (False)
				end
				transaction_depth := transaction_depth + 1
				debug ("roc_storage")
					print ("# sql_begin_transaction (depth="+ transaction_depth.out +").%N")
				end
			end
		rescue
			retried := True
			retry
		end

	sql_rollback_transaction
			-- Rollback updates in the database.
		do
			if sqlite.is_in_transaction then
				sqlite.rollback
			end
			transaction_depth := transaction_depth - 1
			debug ("roc_storage")
				print ("# sql_rollback_transaction (depth="+ transaction_depth.out +").%N")
			end
		end

	sql_commit_transaction
			-- Commit updates in the database.
		do
			if sqlite.is_in_transaction then
				sqlite.commit
			end
			transaction_depth := transaction_depth - 1
			debug ("roc_storage")
				print ("# sql_commit_transaction (depth="+ transaction_depth.out +").%N")
			end
		end

	sql_post_execution
			-- Post database execution.
			-- note: execute after each `sql_query' and `sql_change'.
		do
			debug ("roc_storage")
				print ("# sql_post_execution.%N")
			end
			if sqlite.has_error then
				-- FIXME
--				write_critical_log (generator + ".post_execution Error occurred!")
			end
		end

feature -- Operation

	last_statement: detachable SQLITE_STATEMENT

	last_sqlite_result_cursor: detachable SQLITE_STATEMENT_ITERATION_CURSOR

	sql_query (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		local
			st: SQLITE_QUERY_STATEMENT
		do
			debug ("roc_storage")
				print ("> sql_query (" +a_sql_statement + ").%N")
			end
			last_sqlite_result_cursor := Void
			create st.make (a_sql_statement, sqlite)
			last_statement := st
			if st.is_compiled then
				if a_params /= Void then
					check st.has_arguments end
					last_sqlite_result_cursor := st.execute_new_with_arguments (sqlite_arguments (a_params))
				else
					last_sqlite_result_cursor := st.execute_new
				end
			else
				if attached st.last_exception as e then
					error_handler.add_custom_error (1, "invalid query", {STRING_32} "query compilation failed! [" + e.tag + "]")
				else
					error_handler.add_custom_error (1, "invalid query", "query compilation failed!")
				end
			end
			debug ("roc_storage")
				print ("< sql_query (" +a_sql_statement + ").%N")
			end
		end

	sql_finalize
			-- Finalize sql query (i.e destroy previous query statement.
		do
			debug ("roc_storage")
				print ("> sql_finalize.%N")
			end
			if attached last_statement as st then
				st.cleanup
			end
			if attached last_sqlite_result_cursor as cur then
				if cur.statement /= last_statement then
					check should_not_occurs: False end
					cur.statement.cleanup
				end
				last_sqlite_result_cursor := Void
			end
			last_statement := Void
			debug ("roc_storage")
				print ("< sql_finalize.%N")
			end
		end

	sql_insert (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		local
			st: SQLITE_INSERT_STATEMENT
		do
			debug ("roc_storage")
				print ("> sql_insert (" +a_sql_statement + ").%N")
			end
			last_sqlite_result_cursor := Void
			create st.make (a_sql_statement, sqlite)
			last_statement := st
			if st.is_compiled then
				if a_params /= Void then
					check st.has_arguments end
					last_sqlite_result_cursor := st.execute_new_with_arguments (sqlite_arguments (a_params))
				else
					last_sqlite_result_cursor := st.execute_new
				end
			else
				error_handler.add_custom_error (1, "invalid query", "query compilation failed!")
			end
			debug ("roc_storage")
				print ("< sql_insert (" +a_sql_statement + ").%N")
			end
		end

	sql_modify (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		local
			st: SQLITE_MODIFY_STATEMENT
		do
			debug ("roc_storage")
				print ("> sql_modify (" +a_sql_statement + ").%N")
			end
			last_sqlite_result_cursor := Void
			create st.make (a_sql_statement, sqlite)
			last_statement := st
			if st.is_compiled then
				if a_params /= Void then
					check st.has_arguments end
					last_sqlite_result_cursor := st.execute_new_with_arguments (sqlite_arguments (a_params))
				else
					last_sqlite_result_cursor := st.execute_new
				end
			else
				error_handler.add_custom_error (1, "invalid query", "query compilation failed!")
			end
			debug ("roc_storage")
				print ("< sql_modify (" +a_sql_statement + ").%N")
			end
		end

	sql_delete (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
			-- <Precursor>
		do
			sql_modify (a_sql_statement, a_params)
		end

	sqlite_arguments (a_params: STRING_TABLE [detachable ANY]): ARRAYED_LIST [SQLITE_BIND_ARG [ANY]]
		local
			k: READABLE_STRING_GENERAL
			k8: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			create Result.make (a_params.count)
			across
				a_params as ic
			loop
				k := ic.key
				if k.is_valid_as_string_8 then
					k8 := k.to_string_8
				else
					k8 := utf.utf_32_string_to_utf_8_string_8 (k)
				end
				if attached {DATE_TIME} ic.item as dt then
					Result.force (new_binding_argument (date_time_to_string (dt), ":" + k8))
				elseif attached {READABLE_STRING_32} ic.item as s32 then
					Result.force (new_binding_argument (utf.utf_32_string_to_utf_8_string_8 (s32), ":" + k8))
				else
					Result.force (new_binding_argument (ic.item, ":" + k8))
				end
			end
		end

	date_time_to_string (dt: DATE_TIME): STRING
		do
			create Result.make (16)
			Result.append_integer (dt.year)
			Result.append_character ('-')
			if dt.month <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.month)
			Result.append_character ('-')
			if dt.day <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.day)
			Result.append_character (' ')
			if dt.hour <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.hour)
			Result.append_character (':')
			if dt.minute <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.minute)
			Result.append_character (':')
			if dt.second <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.second)
		end

	string_to_date_time (a_string: READABLE_STRING_GENERAL): DATE_TIME
		local
			y,m,d: INTEGER
			h,min,sec: INTEGER
			s: detachable READABLE_STRING_GENERAL
			i,j: INTEGER
		do
			i := 1
				-- YYYY
			j := a_string.index_of ('-', i)
			s := a_string.substring (i, j - 1)
			y := s.to_integer
			i := j + 1
				-- /MM
			j := a_string.index_of ('-', i)
			s := a_string.substring (i, j - 1)
			m := s.to_integer
			i := j + 1
				-- /DD
			j := a_string.index_of (' ', i)
			s := a_string.substring (i, j - 1)
			d := s.to_integer
			i := j + 1
				-- %THour
			j := a_string.index_of (':', i)
			s := a_string.substring (i, j - 1)
			h := s.to_integer
			i := j + 1
				-- :Min
			j := a_string.index_of (':', i)
			s := a_string.substring (i, j - 1)
			min := s.to_integer
			i := j + 1
				-- :Sec
			j := a_string.count + 1
			s := a_string.substring (i, j - 1)
			sec := s.to_integer

			create Result.make (y,m,d,h,min,sec)
		end

feature -- Access		

	sql_start
			-- <Precursor>.
		do
			-- sqlite cursor `last_sqlite_result_cursor', already at first position if any.
		end

	sql_after: BOOLEAN
			-- <Precursor>.
		do
			if attached last_sqlite_result_cursor as l_cursor then
				Result := l_cursor.after
			end
		end

	sql_forth
			-- <Precursor>.
		do
			if attached last_sqlite_result_cursor as l_cursor then
				l_cursor.forth
			end
		end

	sql_valid_item_index (a_index: INTEGER): BOOLEAN
		local
			l_row: SQLITE_RESULT_ROW
		do
			if attached last_sqlite_result_cursor as l_cursor then
				l_row := l_cursor.item
				Result := a_index > 0 and a_index.to_natural_32 <= l_row.count
			end
		end

	sql_item (a_index: INTEGER): detachable ANY
		local
			l_row: SQLITE_RESULT_ROW
		do
			if attached last_sqlite_result_cursor as l_cursor then
				l_row := l_cursor.item
				Result := l_row.value (a_index.to_natural_32)
			end
		end

	sql_read_string_32 (a_index: INTEGER): detachable READABLE_STRING_32
			-- <Precursor>
		local
			utf: UTF_CONVERTER
		do
			Result := Precursor (a_index)
			if Result = Void then
				if attached sql_read_string (a_index) as s8 then
					Result := utf.utf_8_string_8_to_string_32 (s8)
				end
			end
		end

	sql_read_integer_32 (a_index: INTEGER): INTEGER_32
			-- Retrieved value at `a_index' position in `item'.
		local
			l_item: like sql_item
			i64: INTEGER_64
		do
			l_item := sql_item (a_index)
			if attached {INTEGER_32} l_item as i then
				Result := i
			elseif attached {INTEGER_32_REF} l_item as l_value then
				Result := l_value.item
			else
				if attached {INTEGER_64} l_item as i then
					i64 := i
				elseif attached {INTEGER_64_REF} l_item as l_value then
					i64 := l_value.item
				else
					check is_integer_32: False end
				end
				if i64 <= {INTEGER_32}.max_value then
					Result := i64.to_integer_32
				else
					check is_integer_32: False end
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
			elseif attached {READABLE_STRING_GENERAL} l_item as s then
				Result := string_to_date_time (s)
			else
				check is_date_time_nor_null: l_item = Void end
			end
		end

feature -- Conversion

	sql_statement (a_statement: READABLE_STRING_8): READABLE_STRING_8
			-- <Precursor>.
		local
			i: INTEGER
			s: STRING_8
		do
			Result := a_statement
			from
				i := 1
			until
				i = 0
			loop
				i := a_statement.substring_index ("KEY AUTO_INCREMENT", i)
				if i > 0 then
					create s.make_from_string (a_statement)
					s.remove (i + 8)
					Result := s
					i := i + 14
				end
			end
		end

end
