note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SQLITE_RESULT_SET

feature {NONE} -- Initialization

	make (a_statement: like statement)
			-- Initializes a result set for query iteration.
		require
			a_statement_attached: attached a_statement
			a_statement_is_compiled: a_statement.is_compiled
		do
			statement := a_statement
		ensure
			statement_set: statement = a_statement
		end

feature -- Access

	statement: SQLITE_STATEMENT
			-- SQLite statement to iterate results from.

--feature -- Access

--	item: SQLITE_RESULT_ROW
--			-- Item at current position
--		require
--			not_off: not off
--		do

--		end

--feature -- Status report

--	off: BOOLEAN
--			-- Is there no current item?
--		deferred
--		end

--feature -- Cursor movement

--	start
--			-- Move to first position if any.
--		deferred
--		end
--		
--	forth
--		require
--			not_off: not off
--		do
--			
--		end

--feature -- Iteration


--	do_all (action: PROCEDURE [ANY, TUPLE [G]])
--			-- Apply `action' to every item.
--			-- Semantics not guaranteed if `action' changes the structure;
--			-- in such a case, apply iterator to clone of structure instead.
--		require
--			action_exists: action /= Void
--		do
--			linear_representation.do_all (action)
--		end

--feature

--	execute_internal (a_callback: detachable FUNCTION [ANY, TUPLE [row: SQLITE_RESULT_ROW], BOOLEAN]; a_bindings: detachable ARRAY [SQLITE_BIND_ARG [ANY]])
--			-- Performs execution of the SQLite statement with a callback routine for each returned result row.
--			--
--			-- `a_callback': A callback routine accepting a result row as its argument.
--			--               Return True from the function to abort further calls when there is more result data.
--			-- `a_bindings': An array or binding arguments, or Void if the statement does not require any arguments.
--		require
--			is_sqlite_available: is_sqlite_available
--			is_interface_usable: is_interface_usable
--			is_compiled: is_compiled
--			is_connected: is_connected
--			not_is_executing: not is_executing
--			is_accessible: is_accessible
--			database_is_readable: database.is_readable
--			a_bindings_attached: has_arguments implies attached a_bindings
--			a_bindings_count_big_enough: not attached a_bindings or else a_bindings.count.as_natural_32 = arguments_count
--		local
--			l_api: like sqlite_api
--			l_stmt: like internal_stmt
--			l_db: detachable like database
--			l_exception: detachable SQLITE_EXCEPTION
--			l_result: INTEGER
--			l_done: BOOLEAN
--			l_locked: BOOLEAN
--			l_row: SQLITE_RESULT_ROW
--			i_upper, i: INTEGER
--			l_arg_variable: IMMUTABLE_STRING_8
--			l_arg_id: C_STRING
--			l_arg_index: INTEGER
--			l_total_count: NATURAL
--		do
--				-- Perform bindings
--			if attached a_bindings as l_bindings then
--				from
--					i := l_bindings.lower
--					i_upper := l_bindings.upper
--				until
--					i > i_upper
--				loop
--					if attached l_bindings[i] as l_arg then
--						l_arg_variable := l_arg.variable
--						create l_arg_id.make (l_arg_variable)
--						l_arg_index := sqlite3_bind_parameter_index (sqlite_api, internal_stmt, l_arg_id.item)
--						if l_arg_index = 0 and then l_arg_variable[1] = '?' then
--							l_arg_variable := l_arg_variable.substring (2, l_arg_variable.count)
--							if l_arg_variable.is_integer_32 then
--								l_arg_index := l_arg_variable.to_integer_32
--							else
--									-- Contracts in SQLITE_BIND_ARG should make this impossible.
--								check should_never_happen: False end
--							end
--						end

--						if l_arg_index > 0 then
--							l_arg.bind_to_statement (Current, l_arg_index)
--						else
--							-- Silently ignore unknown variables.
--						end
--					end
--					i := i + 1
--				end
--			end

--				-- Change the mark number
--			mark := mark + 1

--			l_api := sqlite_api
--			l_stmt := internal_stmt
--			l_db := database

--				-- Reset cache information
--			reset_all
--			is_executing := True

--				-- Notify pre-execute
--			on_before_execute

--				-- Note the locking sequencing, to ensure access to the error messages
--				-- are not affected by other threads.
--			l_db.lock -- (+1) 1
--			l_locked := True

--			l_total_count := l_db.total_changes_count

--			from
--				create l_row.make (Current)
--				l_result := sqlite3_step (l_api, l_stmt)
--				l_done := l_result = {SQLITE_RESULT_CODE}.done
--			until
--				not sqlite_success (l_result) or l_done
--			loop
--					-- Unlock before any callback because it may need access to the DB using another thread.
--				l_db.unlock -- (-1) 0
--				l_locked := False

--				if attached a_callback then
--						-- Increment the row index
--					l_row.index := l_row.index + 1
--						-- Call back with the result row.
--					is_abort_requested := a_callback.item ([l_row]) or is_abort_requested
--				end


--				if is_connected then
--						-- The callback could have closed the DB connection so the check is needed.
--					l_db.lock -- (+1) 1
--					l_locked := True

--						-- Check abort status
--					l_done := is_abort_requested
--					if l_done then
--							-- Abort the last operation
--						l_db.abort
--					else
--						l_done := l_result /= {SQLITE_RESULT_CODE}.row
--						if not l_done then
--							l_result := sqlite3_step (l_api, l_stmt)
--							l_done := l_result = {SQLITE_RESULT_CODE}.done
--						end
--					end
--				else
--					l_done := True
--				end
--			end

--				-- Fetch any error information, if any, and report it.		
--			if not sqlite_success (l_result) then
--				if is_connected then
--					l_exception := l_db.last_exception
--					if l_locked then
--						l_locked := False
--						l_db.unlock -- (-1) 0
--					end
--				end
--				if not attached l_exception then
--						-- No exception
--					l_exception := sqlite_exception (l_result, Void)
--				end
--				last_exception := l_exception

--					-- Notify post execute
--				on_after_execute

--				l_exception.raise
--			else
--					-- Set the change count
--				internal_changes_count := l_db.total_changes_count - l_total_count

--				if l_locked then
--					l_locked := False
--					l_db.unlock -- (-1) 0
--				end
--				if attached next_statement as l_next then
--						-- There is another statement to execute, process this before unlocking the database.
--					l_next.execute_internal (a_callback, a_bindings)
--				end

--					-- Notify post execute
--				on_after_execute
--			end

--				-- Reset the statement for repeated use.
--			is_executing := False
--			l_result := sqlite3_reset (l_api, l_stmt)
--			check success: sqlite_success (l_result) end
--			if attached a_bindings then
--					-- `sqlite3_reset' does not reset the bindings! We have to do it as a second stage.
--					-- In a future release, when we might allow bindings to be set arbitrarily we might
--					-- not want to reset them. There is a performance gain for clients, because there is
--					-- not object marshalling required for arguments that do not change. Currently we have
--					-- to pass all arguments again when executing, and they are rebound (involving copy
--					-- operations etc.)
--				l_result := sqlite3_clear_bindings (l_api, l_stmt)
--				check success: sqlite_success (l_result) end
--			end
--		ensure
--			not_is_executing: not is_executing
--			mark_increased: mark > old mark
--		rescue
--			if l_locked then
--				check l_db_attached: attached l_db end
--				l_locked := False
--				l_db.unlock
--			end
--			if is_executing then
--				is_executing := False
--				sqlite3_reset (sqlite_api, internal_stmt).do_nothing
--			end
--		end

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
