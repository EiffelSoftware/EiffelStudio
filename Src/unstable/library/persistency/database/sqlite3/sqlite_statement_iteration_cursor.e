note
	description: "[
		Cursor to iterate over SQLITE_STATEMENT execution result
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_STATEMENT_ITERATION_CURSOR

inherit
	ITERATION_CURSOR [SQLITE_RESULT_ROW]

	ITERABLE [SQLITE_RESULT_ROW]

	SQLITE_SHARED_API
		export
			{NONE} all
		end

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
	make,
	make_with_bindings

feature {NONE} -- Initalization

	make (a_statement: SQLITE_STATEMENT)
			-- Initialize the cursor for `a_statement'.
		require
			a_statement_attached: attached a_statement
			a_statement_is_accessible: a_statement.is_accessible
			a_statement_is_connected: a_statement.is_connected
		do
			statement := a_statement
			last_result := {SQLITE_RESULT_CODE}.ok
			start
		ensure
			statement_statement: statement = a_statement
			last_result_is_valid: last_result = {SQLITE_RESULT_CODE}.ok
				or last_result = {SQLITE_RESULT_CODE}.row
				or last_result = {SQLITE_RESULT_CODE}.done
		end

	make_with_bindings (a_statement: SQLITE_STATEMENT; a_bindings: ARRAY [SQLITE_BIND_ARG [ANY]])
			-- Initialize the cursor for `a_statement' using `a_binding'.
		require
			a_statement_attached: attached a_statement
			a_statement_is_accessible: a_statement.is_accessible
			a_statement_is_connected: a_statement.is_connected
			a_bindings_attached: attached a_bindings
			not_a_bindings_is_empty: not a_bindings.is_empty
		do
			bindings := a_bindings
			make (a_statement)
		ensure
			statement_statement: statement = a_statement
			bindings_set: bindings = a_bindings
			last_result_is_valid: last_result = {SQLITE_RESULT_CODE}.ok
				or last_result = {SQLITE_RESULT_CODE}.row
				or last_result = {SQLITE_RESULT_CODE}.done
		end

feature -- Access

	statement: SQLITE_STATEMENT
			-- SQLite statement being iterated over.

	bindings: detachable ARRAY [SQLITE_BIND_ARG [ANY]]
			-- Binding arguments to execute the statement with.

	item: SQLITE_RESULT_ROW
			-- <Precursor>
		do
			check internal_item_set: attached internal_item as l_result then
				Result := l_result
			end
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [SQLITE_RESULT_ROW]
			-- Fresh cursor associated with current structure
		do
			Result := Current
		end

feature {NONE} -- Access

	last_result: INTEGER
			-- Last result code set by `start'/`forth'.

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := not sqlite_success (last_result) or else last_result = {SQLITE_RESULT_CODE}.done
			--has_started and then not attached internal_item
		end

feature {NONE} -- Status report

	has_started: BOOLEAN
			-- Indicates if the cursor has been started yet.

feature -- Cursor movement

	start
			-- <Precursor>
		local
			l_api: like sqlite_api
			l_stmt: POINTER
			l_result: INTEGER
			i_upper, i: INTEGER
			l_arg_variable: IMMUTABLE_STRING_8
			l_arg_id: C_STRING
			l_arg_index: INTEGER
		do
				-- Reset the iternal item
			internal_item := Void

			l_api := sqlite_api
			l_stmt := statement.internal_stmt

				-- Reset statement, for reuse.
			l_result := sqlite3_reset (l_api, l_stmt)
			check success: sqlite_success (l_result) end

				-- Perform bindings
			if attached bindings as l_bindings then
					-- `sqlite3_reset' does not reset the bindings! We have to do it as a second stage.
					-- In a future release, when we might allow bindings to be set arbitrarily we might
					-- not want to reset them. There is a performance gain for clients, because there is
					-- not object marshalling required for arguments that do not change. Currently we have
					-- to pass all arguments again when executing, and they are rebound (involving copy
					-- operations etc.)
				l_result := sqlite3_clear_bindings (l_api, l_stmt)
				check success: sqlite_success (l_result) end

				from
					i := l_bindings.lower
					i_upper := l_bindings.upper
				until
					i > i_upper
				loop
					if attached l_bindings[i] as l_arg then
						l_arg_variable := l_arg.variable
						create l_arg_id.make (l_arg_variable)
						l_arg_index := sqlite3_bind_parameter_index (l_api, l_stmt, l_arg_id.item)
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
							l_arg.bind_to_statement (statement, l_arg_index)
						else
							-- Silently ignore unknown variables.
						end
					end
					i := i + 1
				end
			end

			last_result := l_result

				-- Raise an exception, if there was an exception case.
			sqlite_raise_on_failure (l_result)

			if not after then
					-- Notify the statement that execution has begun.
				statement.on_before_execute

					-- Go to first element.
				forth
			end
		end

	forth
			-- <Precursor>
		local
			l_api: like sqlite_api
			l_stmt: POINTER
			l_db: detachable SQLITE_DATABASE
			l_exception: detachable SQLITE_EXCEPTION
			l_result: INTEGER
			l_done: BOOLEAN
			l_locked: BOOLEAN
		do
			l_api := sqlite_api
			l_stmt := statement.internal_stmt
			l_db := statement.database

				-- Note the locking sequencing, to ensure access to the error messages
				-- are not affected by other threads.
			l_db.lock -- (+1) 1
			l_locked := True

			l_result := sqlite3_step (l_api, l_stmt)
			l_done := l_result = {SQLITE_RESULT_CODE}.done
			if sqlite_success (l_result) then
				create internal_item.make (statement)
			else
				internal_item := Void
				l_exception := l_db.last_exception
			end

				-- Unlock before any callback because it may need access to the DB using another thread.
			l_locked := False
			l_db.unlock -- (-1) 0

				-- Set last result
			last_result := l_result

			if after then
					-- Notify the statement that execution has completed.
				statement.on_after_executed
			end

				-- Raise an exception, if there was an exception case.
			if attached l_exception then
				l_exception.raise
			else
				sqlite_raise_on_failure (l_result)
			end
		rescue
			if l_locked and attached l_db then
				l_locked := False
				l_db.unlock
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_item: detachable like item
			-- Cached version of `item'.
			-- Note: Do not use directly!

feature {NONE} -- Implementation: void-safety helper

	dummy_target: ITERABLE [SQLITE_RESULT_ROW]
			-- Dummy object used to initialize `target' with attached value
		once
			create {SPECIAL [SQLITE_RESULT_ROW]} Result .make_empty (0)
		end

;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
