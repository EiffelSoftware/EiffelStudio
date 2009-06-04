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

	SQLITE_SHARED_API

--inherit {NONE}
	SQLITE_INTERNALS
		export
			{NONE} all
		end

	SQLITE_STATEMENT_EXTERNALS
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
		do
			create statement.make_from_string (a_statement)
			db := a_db
			compile
		ensure
			statement_set: statement.same_string (a_statement)
			db_set: db = a_db
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
							if (l_result & {SQLITE_RESULT_CODES}.mask) = {SQLITE_RESULT_CODES}.sqlite_misuse then
									-- Happens when the DB was closed before the statement was finalized.
								check is_closed: db.is_closed end
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

	statement: IMMUTABLE_STRING_8
			-- SQL statement

	db: SQLITE_DATABASE
			-- Database to execute the SQL statement on.

	last_exception: detachable SQLITE_EXCEPTION
			-- Last occuring error, set during compilation.

feature {NONE} -- Access

	compile_statement: STRING
			-- The statement used to compile with, which may be a modified version of `statement'.
		do
			Result := statement
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
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
			-- associated database `db'.
		do
			Result := internal_stmt /= default_pointer
		ensure
			not_internal_stmt_is_null: Result implies internal_stmt /= default_pointer
		end

	is_connected: BOOLEAN
			-- Indicates if the statment is still connected to a database.
			-- Disconnection occurs when a database connection is closed. Even when reopen the statement
			-- will still remain disconnected. Use `ensure_connected' to attempt to reconnect to the
			-- associated database.
		do
			Result := is_compiled and then
				internal_db = db.internal_db
		ensure
			not_internal_stmt_is_null: Result implies (is_compiled and then
				internal_db = db.internal_db)
		end

	has_error: BOOLEAN
			-- Indicates if an error occured during the last operation.
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
			is_executing: db.is_accessible implies is_executing -- Calls on the same thread can guarentee `is_executing'.
		do
			is_abort_requested := True
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
			db_is_accessible: db.is_accessible
			db_is_readable: db.is_readable
		do
			if not is_connected then
					-- Reset internals
				reset

					-- Attempt to recompile
				compile
			end
		ensure
			mark_increased: (not old is_connected) implies (mark > old mark)
		end

feature {NONE} -- Basic operations

	reset
			-- Resets any cached compiled information
		do
			internal_stmt := default_pointer
			internal_db := default_pointer
			is_abort_requested := False

				-- The statement is no longer compiled so invalidate any retained linked
				-- references.
			mark := mark + 1
		ensure
			not_is_compiled: not is_compiled
			not_is_connected: not is_connected
			not_is_abort_requested: not is_abort_requested
			mark_increased: mark > old mark
		end

	compile
			-- Compiles the current statement.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			not_is_connected: not is_connected
			db_is_readable: db.is_readable
		local
			l_db: like db
			l_string: C_STRING
			l_stmt_handle: POINTER
			l_internal_db: POINTER
			l_tail: POINTER
			l_locked: BOOLEAN
			l_result: INTEGER
		do
			create l_string.make (compile_statement)
				-- Note: Preparation does support mulitple statments in one string, but for now this is not supported.

			l_db := db
			l_db.lock
			l_locked := True

			l_internal_db := l_db.internal_db
			l_result := sqlite3_prepare_v2 (sqlite_api, l_internal_db, l_string.item, l_string.count + 1, $l_stmt_handle, $l_tail)
			if sqlite_success (l_result) then
				check no_l_stmt_handle_is_null: l_stmt_handle /= default_pointer end
				internal_stmt := l_stmt_handle
				internal_db := l_internal_db
				last_exception := Void
			else
				internal_stmt := default_pointer
				internal_db := default_pointer
				last_exception := l_db.last_exception
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
				db.unlock
			end
		end

	execute_internal (a_callback: detachable PROCEDURE [ANY, TUPLE [row: SQLITE_RESULT_ROW]]; a_bindings: detachable ANY)
			-- Performs execution of the SQLite statement with a callback routine for each returned result row.
			--
			-- `a_callback': A callback routine accepting a result row as its argument.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			db_is_accessible: db.is_accessible
		local
			l_api: like sqlite_api
			l_stmt: like internal_stmt
			l_db: like db
			l_exception: detachable SQLITE_EXCEPTION
			l_result: INTEGER
			l_done: BOOLEAN
			l_locked: BOOLEAN
			l_row: SQLITE_RESULT_ROW
		do
				-- Change the mark number
			mark := mark + 1

			l_api := sqlite_api
			l_stmt := internal_stmt
			l_db := db

			is_abort_requested := False
			is_executing := True

				-- Note the locking sequencing, to ensure access to the error messages
				-- are not affected by other threads.
			l_db.lock -- (+1) 1
			l_locked := True
			from
				create l_row.make (Current)
				l_result := sqlite3_step (l_api, l_stmt)
			until
				not sqlite_success (l_result) or l_done
			loop
					-- Unlock before any callback because it may need access to the DB using another thread.
				l_db.unlock -- (-1) 0
				l_locked := False

				if attached a_callback then
						-- Call back with the result row.
					a_callback.call ([l_row])
				end

					-- Check abort status
				l_done := is_abort_requested

				if not l_done and is_connected then
						-- The callback could have closed the DB connection so the check is needed.
					l_db.lock -- (+1) 1
					l_locked := True
					l_result := sqlite3_step (l_api, l_stmt)
				end
				l_done := l_done or l_result = {SQLITE_RESULT_CODES}.sqlite_done
			end

				-- Fetch any error information, if any, and report it.
			if l_locked then
				if not sqlite_success (l_result) then
					l_exception := l_db.last_exception
					l_db.unlock -- (-1) 0
					if attached l_exception then
						l_exception.raise
					end
				else
					l_db.unlock -- (-1) 0	
				end
			else
					-- The connection was lost so no error information can be retrieved from the DB.
				check not_is_connected: not is_abort_requested implies not is_connected end
				sqlite_raise_on_failure (l_result)
			end

				-- Reset the statement for repeated use.
			is_executing := False
			l_result := sqlite3_reset (l_api, l_stmt)
			check success: sqlite_success (l_result) end
		ensure
			not_is_executing: not is_executing
			mark_increased: mark > old mark
		rescue
			if is_executing then
				is_executing := False
				sqlite3_reset (sqlite_api, internal_stmt).do_nothing
			end
		end

feature {SQLITE_INTERNALS} -- Implementation

	internal_stmt: POINTER
			-- Pointer to the compiled statement

	internal_db: POINTER
			-- The pointer to the database connection when the statement was compiled.
			--|Used to determine if the database is the same when executing the statement.

invariant
	statement_attached: attached statement
	not_statement_is_empty: not statement.is_empty
	db_attached: attached db
	not_internal_db_is_null: internal_stmt /= default_pointer implies internal_db /= default_pointer
	internal_db_is_null: internal_stmt = default_pointer implies internal_db = default_pointer

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
