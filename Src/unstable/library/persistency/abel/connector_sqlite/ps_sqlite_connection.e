note
	description: "Wrapper for a SQLite connection."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_CONNECTION

inherit

	PS_SQL_CONNECTION

	PS_ABEL_EXPORT

	PS_SQLSTATE_CONVERTER
		export {NONE}
			all
		end

create {PS_SQLITE_DATABASE}
	make

feature {PS_ABEL_EXPORT} -- Settings

	set_autocommit (flag: BOOLEAN)
			-- Enable or disable autocommit
		do
				-- Autocommit has to be disabled with only a single connection, so don't enable it
		end

feature {PS_ABEL_EXPORT} -- Database operations

	execute_sql (statement: STRING)
			-- Execute the SQL statement `statement', and store the result (if any) in `Current.last_result'
			-- In case of an error, it will report it in `last_error' and raise an exception.
		local
			all_statements: LIST [STRING]
			stmt: SQLITE_QUERY_STATEMENT
			result_list: ARRAYED_LIST [PS_SQLITE_ROW]
			res: SQLITE_STATEMENT_ITERATION_CURSOR
		do
				-- By default we can get multiple SQL statements - SQLite somehow handles them differently, therefore split them.
			all_statements := statement.split (';')
			all_statements.do_all (agent {STRING}.trim)
				-- Remove all empty statements, and add a `;' to all non-empty ones (as opposed to MySQL, SQLite needs this character)
			from
				all_statements.start
			until
				all_statements.after
			loop
				if all_statements.item.is_empty then
					all_statements.remove
				else
					all_statements.item.extend (';')
					all_statements.forth
				end
			end
				-- Execute all statements
			across
				all_statements as current_statement
			from
				create last_results.make (all_statements.count)
				create result_list.make (0)
			loop
				create stmt.make (current_statement.item, internal_connection)
				create res.make (stmt) -- This executes the statement

					-- Do error handling
				if attached get_error as l_error then

						-- Print information for easier debugging
					print (current_statement.item + "%N")
					print (l_error.backend_error_message)
					print ("%N")

					last_error := l_error
					l_error.raise
				end

					-- Collect the result (if any)
				from
					create result_list.make (100)
				until
					res.after
				loop
					result_list.extend (create {PS_SQLITE_ROW}.make (res.item))
					res.forth
				end
				last_results.extend (result_list.new_cursor)
			end
				-- Return the cursor of the result list
			last_result := result_list.new_cursor
		rescue
				-- Information to faciliate error handling
			if attached internal_connection.last_exception as ex then
				print ("%N%N" + statement + "%N")
				print (ex.tag)
				print ("%N")
			end
		end

	commit
			-- Commit the currently active transaction.
			-- In case of an error, including a failed commit, it will report it in `last_error' and raise an exception.
		do
			internal_connection.commit
			internal_connection.begin_transaction (False)
		end

	rollback
			-- Rollback the currently active transaction.
			-- In case of an error, it will report it in `last_error' and raise an exception.
		do
			internal_connection.rollback
			internal_connection.begin_transaction (False)
		end

feature {PS_ABEL_EXPORT} -- Database results

	last_result: ITERATION_CURSOR [PS_SQL_ROW]
			-- The result of the last database operation

	last_results: ARRAYED_LIST [ITERATION_CURSOR [PS_SQL_ROW]]
			-- The results from the last multi-statement database operations

	last_error: detachable PS_ERROR
			-- The last occured error

	last_primary_key: INTEGER
			-- <Precursor>
		do
			execute_sql ("SELECT last_insert_rowid()")
			Result := last_result.item.item (1).to_integer
		end

feature {PS_SQLITE_DATABASE} -- Initialization

	make (connection: SQLITE_DATABASE)
			-- Initialization for `Current'.
		do
			internal_connection := connection
			last_error := Void
			last_result := (create {LINKED_LIST [PS_SQL_ROW]}.make).new_cursor
			create last_results.make (0)
		end

	internal_connection: SQLITE_DATABASE

feature {NONE} -- Error handling

	get_error: detachable PS_ERROR
			-- Translate the SQLite specific error to an ABEL error object.
		local
			error_number: INTEGER
		do
			if attached internal_connection.last_exception as exception then

				error_number := exception.result_code

				if error_number = {SQLITE_RESULT_CODE}.ok then
						-- No error
				elseif error_number = {SQLITE_RESULT_CODE}.e_error then
						-- General error.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_internal then
						-- Internal logic error.
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_perm then
						-- No permission.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_abort then
						-- Callback routine requested abort.
					Result := external_routine_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_busy then
						-- The database is locked.
					Result := transaction_aborted_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_locked then
						-- A table is locked.
					Result := transaction_aborted_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_no_mem then
						-- Out of memory.
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_read_only then
						-- Read-only database.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_interrupt then
						-- Operation terminated by interrupt.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_io_err then
						-- I/O error.
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_corrupt then
						-- Database file is corrupt.
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_not_found then
						-- ?
					Result := error
				elseif error_number = {SQLITE_RESULT_CODE}.e_full then
						-- Database file is full.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_cant_open then
						-- Cannot open database file.
					Result := connection_setup_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_protocol then
						-- Lock protocol error.
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_empty then
						-- Empty database.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_schema then
						-- The database schema has changed.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_too_big then
						-- A string or BLOB is too big.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_constraint then
						-- Integrity constraint violation
					Result := integrity_constraint_violation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_mismatch then
						-- Data type mismatch
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_misuse then
						-- Wrong API usage.
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_nolfs then
						-- Missing OS feaures
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_auth then
						-- Authorization denied
					Result := authorization_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_format then
						-- Auxiliary database format error
					Result := backend_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_range then
						-- Parameter in bind() out of range
					Result := operation_error
				elseif error_number = {SQLITE_RESULT_CODE}.e_not_a_db then
						-- File is not a database
					Result := connection_setup_error
				elseif error_number = {SQLITE_RESULT_CODE}.row then
						-- No error
				elseif error_number = {SQLITE_RESULT_CODE}.done then
						-- No error
				else
						-- Some new, unknown error.
					Result := error
				end

				if attached Result then
					Result.set_backend_error (exception.tag)
					Result.set_backend_error_code (error_number)
					Result.set_backend_error (exception)
				end
			end
		end

end
