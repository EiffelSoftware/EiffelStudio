note
	description: "[
		A row returned from executing a SQLite query statement.
		
		Note: Result rows are the same for the same query, meaning they should not be retained by any
		      client. Upon reciept of a row object any column value of worth should be queried and
		      retained by the client.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_RESULT_ROW

inherit
	SQLITE_SHARED_API

--inherit {NONE}
	SQLITE_INTERNALS

	SQLITE_RESULT_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_STATEMENT_EXTERNALS
		export
			{NONE} all
		end

create {SQLITE_STATEMENT, SQLITE_STATEMENT_ITERATION_CURSOR}
	make

feature {NONE} -- Initialization

	make (a_statement: like statement)
			-- Intialized a result row for a prepared statement.
			--
			-- `a_statement': The statement the result are generated from.
		require
			a_statement_attached: attached a_statement
			a_statement_is_compiled: a_statement.is_compiled
		do
			statement := a_statement
			statement_mark := a_statement.mark
		ensure
			statement_set: statement = a_statement
			statement_mark_set: statement_mark = a_statement.mark
		end

feature -- Access

	statement: SQLITE_STATEMENT
			-- Statement used when generating the row.

	index: NATURAL assign set_index
			-- Row result index (not the row id!)

feature {NONE} -- Access

	statement_mark: NATURAL
			-- The mark of the statement when created.

feature {SQLITE_STATEMENT} -- Element change

	set_index (a_index: NATURAL)
			-- Increments the row index.
			-- Note: Used when processing the results.
			--|
			--|A setter is used instead of in incrementing routine because new rows may be created and a
			--|specific index needs to be set base off of the previously created row.
			--
			-- `a_index': The next index to set.
		require
			a_index_positive: a_index > 0
		do
			index := a_index
		ensure
			index_incremented: index = a_index
		end

feature -- Measurement

	count: NATURAL
			-- Number of returned columns in the row.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
		do
			Result := sqlite3_column_count (sqlite_api, statement.internal_stmt).as_natural_32
		end

feature -- Status report

	is_connected: BOOLEAN
			-- Indicates if the results are still connected to the statement.
			-- Disconnection occurs when a statement is disconnected from the database, which can happen
			-- if the database is closed.
		do
			Result := is_interface_usable and then statement.is_connected and then statement.mark = statement_mark
		ensure
			is_interface_usable: Result implies is_interface_usable
			statement_is_connected: Result implies statement.is_connected
			statement_mark_equal: Result implies statement.mark = statement_mark
		end

	is_null (a_column: NATURAL): BOOLEAN
			-- Determines if a column contains a null value.
			--
			-- `a_column': The column index.
			-- `Result': True if the column contains a null value; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
		do
			Result := type (a_column) = {SQLITE_TYPE}.null
		ensure
			not_result: not Result implies type (a_column) /= {SQLITE_TYPE}.null
		end

feature -- Query

	column_name (a_column: NATURAL): IMMUTABLE_STRING_8
			-- Retrieve the name of a column in a statement.
			--
			-- `a_column': The column index to retrieve a name for.
			-- `Result': A column name, or an
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
		do
			if attached {SQLITE_QUERY_STATEMENT} statement as l_query then
				Result := l_query.column_name (a_column)
			else
				create Result.make_empty
			end
		ensure
			result_attached: attached Result
		end

	value alias "[]" (a_column: NATURAL): detachable ANY
			-- Fetches a value for the column `a_column'.
			-- Unlike the specific type functions such as `string_value', `real_value', ... the result
			-- returns an unconverted best match based on the information held in the database and
			-- result information.
			--
			-- Note: All results are of the highest bit length (64 bit REAL and INTEGER) 
			--
			-- `a_column': The column to retrieve the result for.
			-- `Result': The value object, actual object or Void if no result data was found for the column.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
		local
			l_type: like type
		do
			l_type := type (a_column)
			if l_type /= {SQLITE_TYPE}.null then
				if l_type = {SQLITE_TYPE}.blob then
					Result := blob_value (a_column)
				elseif l_type = {SQLITE_TYPE}.float then
					Result := real_64_value (a_column)
				elseif l_type = {SQLITE_TYPE}.integer then
					Result := integer_64_value (a_column)
				elseif l_type = {SQLITE_TYPE}.text then
					Result := string_value (a_column)
				else
					check unknown_type: False end
				end
			end
		end

	type (a_column: NATURAL): INTEGER
			-- Returns the type of the column.
			--
			-- `a_column': The column to retrieve the result for.
			-- `Result': A column type as described in {SQLITE_TYPE}
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
		do
			Result := sqlite3_column_type (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
		ensure
			valid_type: (create {SQLITE_TYPE}).is_valid_type (Result)
		end

feature -- Query: Value affinity

	blob_value (a_column: NATURAL): detachable MANAGED_POINTER
			-- Retrieves a blob representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		local
			l_size: INTEGER
			p: POINTER
		do
			p := sqlite3_column_blob (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
			if p /= default_pointer then
				l_size := sqlite3_column_bytes (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
				if l_size >= 0 then
					create Result.make_from_pointer (p, l_size)
				end
			end
		end

	integer_value (a_column: NATURAL): INTEGER
			-- Retrieves a {INTEGER_32} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		do
			Result := sqlite3_column_int (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
		end

	integer_64_value (a_column: NATURAL): INTEGER_64
			-- Retrieves a {INTEGER_64} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		do
			Result := sqlite3_column_int64 (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
		end

	string_value (a_column: NATURAL): STRING
			-- Retrieves a {STRING_8} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.	
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		local
			l_string: C_STRING
			l_size: INTEGER
			p: POINTER
		do
			p := sqlite3_column_text (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
			if p = default_pointer then
				create Result.make_empty
			else
				l_size := sqlite3_column_bytes (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
				if l_size >= 0 then
					create l_string.make_by_pointer_and_count (p, l_size)
					Result := l_string.substring_8 (1, l_string.count)
				else
					create Result.make_empty
				end
			end
		end

	real_value (a_column: NATURAL): REAL
			-- Retrieves a {REAL_32} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		do
			Result := real_64_value (a_column).truncated_to_real
		end

	real_64_value (a_column: NATURAL): REAL_64
			-- Retrieves a {REAL_64} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		do
			Result := sqlite3_column_double (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
		end


	is_boolean_value (a_column: NATURAL): BOOLEAN
			-- Retrieves a {INTEGER_32} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		local
			i: INTEGER
		do
			i := sqlite3_column_int (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
			Result := i = 0 or i = 1
		end

	boolean_value (a_column: NATURAL): BOOLEAN
			-- Retrieves a {INTEGER_32} representation of a column result value.
			--
			-- `a_column': The column to retrieve the result for.
		require
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= count
			not_a_column_is_null: not is_null (a_column)
		local
			i: INTEGER
		do
			i := sqlite3_column_int (sqlite_api, statement.internal_stmt, (a_column - 1).as_integer_32)
			if i = 0 then
				Result := False
			elseif i = 1 then
				Result := True
			else
				check is_boolean: False end
			end
		end


--invariant
	--statement_mark_positive: statement_mark > 0
	--statement_mark_small_enough: statement_mark <= statement.mark

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
