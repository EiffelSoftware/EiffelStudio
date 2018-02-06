note
	description: "[
		An SQLite statement associated with a database connection.
		
		Note: If a database connection is closed the statement can no longer be used. In some cases,
		      when a connection is reopened the statement will recompile itself for use with the new
		      connection. However, this is not guarenteed to work. As such, please use caution when
		      caching statements when database connections are open and closed.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_STATEMENT

inherit
	DISPOSABLE

	SQLITE_BINDING_HELPERS

	SQLITE_SHARED_API

--inherit {NONE}
	SQLITE_INTERNALS
		export
			{NONE} all
		end

	SQLITE_DATABASE_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_STATEMENT_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_BIND_ARG_MARSHALLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_statement: READABLE_STRING_8; a_db: SQLITE_DATABASE)
			-- Initializes a SQL statement for a database.
			--
			-- `a_statement': SQL statement to compile.
			-- `a_db': A database to compile the statement with.
		require
			is_sqlite_available: is_sqlite_available
			a_statement_attached: attached a_statement
			not_a_statement_is_empty: not a_statement.is_empty
			a_db_attached: attached a_db
			a_db_is_accessible: a_db.is_accessible
			a_db_is_readable: a_db.is_readable
			a_statement_is_complete: a_db.is_complete_statement (a_statement)
		do
			create statement_string.make_from_string (a_statement)
			create string.make_from_string (a_statement)
			database := a_db
			if {PLATFORM}.is_thread_capable then
				internal_thread_id := get_current_thread_id.to_integer_32
			end
			compile
		ensure
			string_set: string.same_string (a_statement)
			statement_string_attached: attached statement_string
			not_statement_string_is_empty: not statement_string.is_empty
			database_set: database = a_db
		end

feature -- Clean up

	cleanup
			-- Cleanup Current statement.
		do
			dispose
		end

feature {NONE} -- Clean up	

	dispose
			-- <Precursor>
		local
			l_stmt: like internal_stmt
			l_db: like internal_db
			l_api: like sqlite_api
			l_result: INTEGER
		do
			if not is_in_final_collect then
				l_stmt := internal_stmt
				if l_stmt /= default_pointer and then is_sqlite_available then
						-- Check to be sure that the statement is still alive in the db.
						-- Get the statement's database, if not null then it's alive.
						--
						-- Normally this cannot happen as SQLite prevents the DB from being closed until all
						-- prepared statements have been finalized. Because of the GC statements may have not
						-- yet been collected when a connection is closed. It is SQLite's documentation
						-- recommendation to clean up all prepared statements when closing the DB, as such a
						-- statement might not be valid anymore.
					l_api := sqlite_api
					l_db := sqlite3_db_handle (l_api, l_stmt)
					if l_db /= default_pointer then
							-- The statement is still connected with the database
						if l_db = internal_db then
							l_result := sqlite3_finalize (l_api, l_stmt)
							if (l_result & {SQLITE_RESULT_CODE}.mask) = {SQLITE_RESULT_CODE}.e_misuse then
									-- Happens when the DB was closed before the statement was finalized.
								check is_closed: database.is_closed end
							else
								check succeess: sqlite_success (l_result) end
							end
						else
							check False end
						end
					end

				end
				internal_stmt := default_pointer
				internal_db := default_pointer
			end
		ensure then
			not_is_compiled: not is_compiled
			not_is_connected: not is_connected
			internal_stmt_is_null: internal_stmt = default_pointer
			internal_db_is_null: internal_db = default_pointer
		end

feature -- Access

	string: IMMUTABLE_STRING_8
			-- The full statement string passed during initialization.
			-- May contain multiple SQLite statements.

	database: SQLITE_DATABASE
			-- Database to execute the SQL statement on.

	statement_string: IMMUTABLE_STRING_8
			-- The actual compiled database string.
			-- This may not be the same as `string' because statements string can be composed of
			-- of multiple statements. After compilation this will contain a single statement.

	next_statement: detachable SQLITE_STATEMENT
			-- Next statement in the chain, when the supplied SQLite statement contained multiple SQLite
			-- statements.

feature -- Access: Error handling

	last_exception: detachable SQLITE_EXCEPTION
			-- Last occurring error, set during compilation.

feature -- Access: Cursor

	execute_new: SQLITE_STATEMENT_ITERATION_CURSOR
			-- Execute the SQLite statement.
		require
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			is_accessible: is_accessible
			not_has_arguments: not has_arguments
		do
			create Result.make (Current)
		ensure
			result_attached: attached Result
		end

	execute_new_with_arguments (a_arguments: ITERABLE [detachable ANY]): SQLITE_STATEMENT_ITERATION_CURSOR
			-- Executes the SQLite statement with bound set of arguments.
			--
			-- `a_arguments': The bound arguments to call the SQLite query statement with.
			--                Valid arguments are those that descent {SQLITE_BIND_ARG} or
			--                {READABLE_STRING_8}, or of type {INTEGER_*}, {NATURAL_*} (with the expection
			--                of {NATURAL_64}), or {MANAGED_POINTER} (for blobs).
			--                Note: If *not* using {SQLITE_BIND_ARG}, the SQLite statement should use ?NNN
			--                      arguments and not named arguments.
			--                      see http://sqlite.org/c3ref/bind_blob.html
		require
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			is_accessible: is_accessible
			has_arguments: has_arguments
			a_arguments_attached: attached a_arguments
--			a_arguments_count_correct: a_arguments.count.as_natural_32 = arguments_count
			a_arguments_is_valid_arguments: is_valid_arguments (a_arguments)
		do
			create Result.make_with_bindings (Current, new_binding_argument_array (a_arguments))
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Access

	compile_statement_string: READABLE_STRING_8
			-- The statement used to compile with, which may be a modified version of `statement'.
		do
			Result := statement_string
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature -- Measurement

	arguments_count: NATURAL
			-- Number of arguments required to be bound to execute the statement.
		do
			Result := sqlite3_bind_parameter_count (sqlite_api, internal_stmt).as_natural_32
		end

	changes_count: NATURAL
			-- The number of changes executing this statement caused
		do
			Result := internal_changes_count
			if attached next_statement as l_next then
				Result := Result + l_next.changes_count
			end
		end

feature {SQLITE_RESULT_ROW} -- Measurement

	mark: NATURAL
			-- The edition mark of the statement.
			-- A new mark is generated for each execution of recompilation.

feature -- Status report

	is_executing: BOOLEAN
			-- Indicates if the statement is currently be executed.

	is_compiled: BOOLEAN
			-- Indicates if the statement was successfully compiled, and if it is compiled with the
			-- associated database `database'.
		do
			Result := internal_stmt /= default_pointer
		ensure
			not_internal_stmt_is_null: Result implies internal_stmt /= default_pointer
		end

	is_connected: BOOLEAN
			-- Indicates if the statement is still connected to a database.
			-- Disconnection occurs when a database connection is closed. Even when reopen the statement
			-- will still remain disconnected. Use `ensure_connected' to attempt to reconnect to the
			-- associated database.
		do
			Result := is_compiled and then
				internal_db = database.internal_db
		ensure
			not_internal_stmt_is_null: Result implies (is_compiled and then
				internal_db = database.internal_db)
		end

	is_accessible: BOOLEAN
			-- Indicates if the statement is accessible on the current thread.
		do
			Result := is_interface_usable and then database.is_accessible
			if Result then
				if {PLATFORM}.is_thread_capable then
					Result := internal_thread_id = get_current_thread_id.to_integer_32
				else
					Result := True
				end
			end

		ensure
			true_result: not {PLATFORM}.is_thread_capable implies (Result and database.is_accessible)
			same_internal_thread_id: (Result and {PLATFORM}.is_thread_capable) implies internal_thread_id = get_current_thread_id.to_integer_32
		end

	has_arguments: BOOLEAN
			-- Indicates if the statement has required arguments to execute.
		do
			Result := arguments_count > 0
		ensure
			has_arguments: Result = (arguments_count > 0)
		end

	has_error: BOOLEAN
			-- Indicates if an error occurred during the last operation.
		do
			Result := last_exception /= Void
		ensure
			last_exception_attached: Result implies last_exception /= Void
		end

feature {NONE} -- Status report

	is_abort_requested: BOOLEAN
			-- Indicates if an abort is requested for the currently executed statement.

feature -- Basic operations

	abort
			-- Aborts an executing statement.
			-- Note: Unlike most of the routines, this can be called from another thread.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_executing: is_accessible implies is_executing -- Calls on the same thread can guarentee `is_executing'.
		do
			is_abort_requested := True

			if attached next_statement as l_next then
				l_next.abort
			end
		ensure
			is_abort_requested: is_abort_requested
		end

	ensure_connected
			-- Attempts to ensure a statement is connected to the associated database.
			-- Note: This helper routine can be used prior to executing the statement to ensure the
			--       statement is compiled for use with the associated database. Statements become
			--       disconnected when the assoicated database is closed. Even when reopening the database
			--       a reconnection must be made.
			--
			--       Calling this routine will not reopen the database!
			--       Reconnection is not guarenteed!
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
		do
			if not is_connected then
					-- Wipe out internals
				reset_compilation_data

					-- Attempt to recompile
				compile
			end

			if attached next_statement as l_next then
				l_next.ensure_connected
			end
		ensure
			mark_increased: (not old is_connected) implies (mark > old mark)
		end

feature {SQLITE_STATEMENT} -- Basic operations: Execution

	reset
			-- Resets any cached information from the last execution.
		require
			not_is_executing: not is_executing
		do
			is_abort_requested := False
			internal_changes_count := 0
			last_exception := Void
		ensure
			not_is_abort_requested: not is_abort_requested
			internal_changes_count_reset: internal_changes_count = 0
			last_exception_detached: not attached last_exception
			not_has_error: not has_error
		end

	reset_all
			-- Resets any cached information from the last execution for all statements.
		require
			not_is_executing: not is_executing
		do
			reset
			if attached next_statement as l_next then
				l_next.reset_all
			end
		ensure
			not_is_abort_requested: not is_abort_requested
			internal_changes_count_reset: internal_changes_count = 0
			last_exception_detached: not attached last_exception
			not_has_error: not has_error
		end

	execute_internal (a_callback: detachable FUNCTION [TUPLE [row: SQLITE_RESULT_ROW], BOOLEAN]; a_bindings: detachable ARRAY [SQLITE_BIND_ARG [ANY]])
			-- Performs execution of the SQLite statement with a callback routine for each returned result row.
			--
			-- `a_callback': A callback routine accepting a result row as its argument.
			--               Return True from the function to abort further calls when there is more result data.
			-- `a_bindings': An array or binding arguments, or Void if the statement does not require any arguments.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			is_accessible: is_accessible
			database_is_readable: database.is_readable
			a_bindings_attached: has_arguments implies attached a_bindings
			a_bindings_count_big_enough: not attached a_bindings or else a_bindings.count.as_natural_32 = arguments_count
		local
			l_api: like sqlite_api
			l_stmt: like internal_stmt
			l_db: detachable like database
			l_exception: detachable SQLITE_EXCEPTION
			l_result: INTEGER
			l_done: BOOLEAN
			l_locked: BOOLEAN
			l_row: SQLITE_RESULT_ROW
			i_upper, i: INTEGER
			l_arg_variable: IMMUTABLE_STRING_8
			l_arg_id: C_STRING
			l_arg_index: INTEGER
			l_total_count: NATURAL
		do
				-- Perform bindings
			if a_bindings /= Void then
				from
					i := a_bindings.lower
					i_upper := a_bindings.upper
				until
					i > i_upper
				loop
					if attached a_bindings[i] as l_arg then
						l_arg_variable := l_arg.variable
						create l_arg_id.make (l_arg_variable)
						l_arg_index := sqlite3_bind_parameter_index (sqlite_api, internal_stmt, l_arg_id.item)
						if l_arg_index = 0 and then l_arg_variable[1] = '?' then
							l_arg_variable := l_arg_variable.substring (2, l_arg_variable.count)
							if l_arg_variable.is_integer_32 then
								l_arg_index := l_arg_variable.to_integer_32
							else
									-- Contracts in SQLITE_BIND_ARG should make this impossible.
								check should_never_happen: False end
							end
						end

						if l_arg_index > 0 then
							l_arg.bind_to_statement (Current, l_arg_index)
						else
							-- Silently ignore unknown variables.
						end
					end
					i := i + 1
				end
			end

				-- Change the mark number
			mark := mark + 1

			l_api := sqlite_api
			l_stmt := internal_stmt
			l_db := database

				-- Reset cache information
			reset_all
			is_executing := True

				-- Notify pre-execute
			on_before_execute

				-- Note the locking sequencing, to ensure access to the error messages
				-- are not affected by other threads.
			l_db.lock -- (+1) 1
			l_locked := True

			l_total_count := l_db.total_changes_count

			from
				create l_row.make (Current)
				l_result := sqlite3_step (l_api, l_stmt)
				l_done := l_result = {SQLITE_RESULT_CODE}.done
			until
				not sqlite_success (l_result) or l_done
			loop
					-- Unlock before any callback because it may need access to the DB using another thread.
				l_db.unlock -- (-1) 0
				l_locked := False

				if attached a_callback then
						-- Increment the row index
					l_row.index := l_row.index + 1
						-- Call back with the result row.
					is_abort_requested := a_callback.item ([l_row]) or is_abort_requested
				end


				if is_connected then
						-- The callback could have closed the DB connection so the check is needed.
					l_db.lock -- (+1) 1
					l_locked := True

						-- Check abort status
					l_done := is_abort_requested
					if l_done then
							-- Abort the last operation
						l_db.abort
					else
						l_done := l_result /= {SQLITE_RESULT_CODE}.row
						if not l_done then
							l_result := sqlite3_step (l_api, l_stmt)
							l_done := l_result = {SQLITE_RESULT_CODE}.done
						end
					end
				else
					l_done := True
				end
			end

				-- Fetch any error information, if any, and report it.		
			if not sqlite_success (l_result) then
				if is_connected then
					l_exception := l_db.last_exception
					if l_locked then
						l_locked := False
						l_db.unlock -- (-1) 0
					end
				end
				if not attached l_exception then
						-- No exception
					l_exception := sqlite_exception (l_result, Void)
				end
				last_exception := l_exception

					-- Notify post execute
				on_after_executed

				l_exception.raise
			else
					-- Set the change count
				internal_changes_count := l_db.total_changes_count - l_total_count

				if l_locked then
					l_locked := False
					l_db.unlock -- (-1) 0
				end
				if attached next_statement as l_next then
						-- There is another statement to execute, process this before unlocking the database.
					l_next.execute_internal (a_callback, a_bindings)
				end

					-- Notify post execute
				on_after_executed
			end

				-- Reset the statement for repeated use.
			is_executing := False
			l_result := sqlite3_reset (l_api, l_stmt)
			check success: sqlite_success (l_result) end
			if attached a_bindings then
					-- `sqlite3_reset' does not reset the bindings! We have to do it as a second stage.
					-- In a future release, when we might allow bindings to be set arbitrarily we might
					-- not want to reset them. There is a performance gain for clients, because there is
					-- not object marshalling required for arguments that do not change. Currently we have
					-- to pass all arguments again when executing, and they are rebound (involving copy
					-- operations etc.)
				l_result := sqlite3_clear_bindings (l_api, l_stmt)
				check success: sqlite_success (l_result) end
			end
		ensure
			not_is_executing: not is_executing
			mark_increased: mark > old mark
		rescue
			if l_locked then
				if l_db /= Void then
					l_db.unlock
				else
					check l_db_attached: False end
				end
				l_locked := False
			end
			if is_executing then
				is_executing := False
				sqlite3_reset (sqlite_api, internal_stmt).do_nothing
			end
		end

feature {NONE} -- Basic operations: Compilation

	reset_compilation_data
			-- Clears any cached information related to the preperation/compilation of the statement
		do
			internal_stmt := default_pointer
			internal_db := default_pointer
			reset

				-- The statement is no longer compiled so invalidate any retained linked
				-- references.
			mark := mark + 1
		ensure
			not_is_compiled: not is_compiled
			not_is_connected: not is_connected
			not_is_abort_requested: not is_abort_requested
			internal_changes_count_reset: internal_changes_count = 0
			last_exception_detached: not attached last_exception
			mark_increased: mark > old mark
			not_has_error: not has_error
		end

	compile
			-- Compiles the current statement.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			not_is_connected: not is_connected
			not_has_error: not has_error
			database_is_readable: database.is_readable
			database: database.is_readable
		local
			l_db: like database
			l_string: C_STRING
			l_next_string: STRING
			l_next_statement: SQLITE_STATEMENT
			l_stmt_handle: POINTER
			l_internal_db: POINTER
			l_tail: POINTER
			l_locked: BOOLEAN
			l_result: INTEGER
		do
			create l_string.make (compile_statement_string)

			l_db := database
			l_db.lock
			l_locked := True

			l_internal_db := l_db.internal_db
				-- FIXME: SQLITE_BUSY may be returned and so we should retry preparation until a default/specified timeout.
			l_result := sqlite3_prepare_v2 (sqlite_api, l_internal_db, l_string.item, l_string.count + 1, $l_stmt_handle, $l_tail)
			if l_stmt_handle /= default_pointer then
				internal_stmt := l_stmt_handle
				internal_db := l_internal_db
				last_exception := Void

				if l_tail /= default_pointer then
						-- There is more to process, which means there should not already be a next statement because
						-- this is the first compilation.
					check next_statement_detached: not attached next_statement end
					create l_string.make_shared_from_pointer (l_tail)
					l_next_string := l_string.string
					if not l_next_string.is_empty then
							-- Create the next statement string, with only the compiled statement
						create statement_string.make_from_string (statement_string.substring (1, statement_string.count - l_next_string.count))

							-- Remove ; from the start of the statement, if it exists.
						l_next_string.prune_all_leading (';')
							-- Remove extra whitespace
						l_next_string.left_adjust
						if not l_next_string.is_empty then
							create l_next_statement.make (l_next_string, l_db)
							if l_next_statement.has_error then
									-- An error occurred so the entire statement should be considered uncompiled
								reset_compilation_data

									-- Use statement's last exception and not the database's because of future/redefined error
									-- processing could manipulate this.
								last_exception := l_next_statement.last_exception
							else
								next_statement := l_next_statement
							end
						end

					end
				end
			else
				reset_compilation_data
				if sqlite_success (l_result) then
						-- Happens when there statement is a empty one.
					last_exception := sqlite_exception ({SQLITE_RESULT_CODE}.e_misuse, "no statement: syntax error")
				else
					last_exception := l_db.last_exception
				end
			end

			l_locked := False
			l_db.unlock
		ensure
			not_internal_db_is_null: is_compiled implies internal_db /= default_pointer
			internal_db_is_null: not is_compiled implies internal_db = default_pointer
			last_exception_attached: not is_compiled implies attached last_exception
			last_exception_attached: is_compiled implies not attached last_exception
		rescue
			if l_locked then
				l_locked := False
				database.unlock
			end
		end

feature {SQLITE_STATEMENT_ITERATION_CURSOR} -- Action handlers

	on_before_execute
			-- Called before a statement has been executed.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_connected: is_connected
			not_has_error: not has_error
			is_accessible: is_accessible
			database_is_readable: database.is_readable
		do
			is_executing := True
		ensure
			is_executing: is_executing
		end

	on_after_executed
			-- Called after a statement has been executed, successfully or not.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
		do
			is_executing := False
		ensure
			not_is_executing: not is_executing
		end

feature {SQLITE_INTERNALS} -- Implementation

	internal_stmt: POINTER
			-- Pointer to the compiled statement

	internal_db: POINTER
			-- The pointer to the database connection when the statement was compiled.
			--| Used to determine if the database is the same when executing the statement.

	internal_changes_count: NATURAL
			-- Mutable version of `changes_count'.
			-- Note: Do not use directly!

feature {NONE} -- Implementation

	internal_thread_id: INTEGER
			-- The thread the database was connected using.
			--| In non multi-threaded systems this will always be 0.

feature {NONE} -- Externals

	get_current_thread_id: POINTER
			-- Returns a pointer to the thread-id of the thread.
		require
			is_thread_capable: {PLATFORM}.is_thread_capable
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_thread_id"
		end

invariant
	database_attached: attached database
	statement_attached: attached statement_string
	not_statement_is_empty: not statement_string.is_empty
	string_attached: attached string
	not_string_is_empty: not string.is_empty
	not_internal_db_is_null: internal_stmt /= default_pointer implies internal_db /= default_pointer
	internal_db_is_null: internal_stmt = default_pointer implies internal_db = default_pointer
	internal_thread_id_set: {PLATFORM}.is_thread_capable implies internal_thread_id /= 0

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
