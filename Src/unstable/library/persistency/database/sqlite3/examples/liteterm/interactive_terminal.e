note
	description: "[
		A terminal for interating with SQLite databases, such as queries and updates.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERACTIVE_TERMINAL

create
	make

feature {NONE} -- Initialization

	make (a_db: like database)
			-- Initialize a console with an opened database connection.
			--
			-- `a_db': Opened database connection.
		require
			a_db_is_readable: a_db.is_readable
		do
			database := a_db
			database.update_action :=  agent on_update
		ensure
			database_set: database = a_db
		end

feature -- Access

	database: SQLITE_DATABASE
			-- Database connection.

	built_ins: HASH_TABLE [COMMAND, READABLE_STRING_8]
			-- Table of built in commands indexed by a command name.
			--
			-- Key: Command name, in lower case.
			-- Value: Command object to perform.
		do
			if attached internal_built_ins as l_result then
				Result := l_result
			else
				Result := create_built_ins
				internal_built_ins := Result
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result = built_ins
		end

feature -- Access: Output

	terminal_writer: FILE
			-- File used to write to terminal.
		do
			Result := io.output
		end

	terminal_error_writer: FILE
			-- File used to write to the error terminal.
		do
			Result := io.error
		end

feature {RECORD_COMMAND} -- Access

	statement_recorder: detachable STATEMENT_RECORDER assign set_statement_recorder
			-- Recorder used to record user entered statements.

feature {RECORD_COMMAND} -- Element change

	set_statement_recorder (a_recorder: like statement_recorder)
			-- Sets or unsets the statement recorder to use to record user entered statements.
			--
			-- `a_recorder': Recorder or Void to stop recording.
		local
			l_old_recorder: like statement_recorder
			l_writer: like terminal_writer
		do
			l_old_recorder := statement_recorder
			l_writer := terminal_writer

			statement_recorder := a_recorder
			if attached a_recorder then
				l_writer.put_string ("Recording started for file ")
				l_writer.put_string (a_recorder.writer.path.name.as_string_8)
				l_writer.new_line
			elseif attached l_old_recorder then
				l_writer.put_string ("Recording stopped for file ")
				l_writer.put_string (l_old_recorder.writer.path.name.as_string_8)
				l_writer.new_line
			end
		ensure
			statement_recorder_set: statement_recorder = a_recorder
		end

feature -- Status report

	is_interactive: BOOLEAN
			-- Indicates if the terminal is currently interactive (i.e. `begin_interaction' was called)

feature {RECORD_COMMAND} -- Status report

	is_recording: BOOLEAN
			-- Indicates if the terminal is recording all SQLite statements.
		do
			Result := attached statement_recorder
		ensure
			statement_recorder_attached: Result implies attached statement_recorder
		end

feature {NONE} -- Status report

	is_done: BOOLEAN
			-- Indicates if interaction has complete (user quit)

feature -- Basic operations

	begin_interaction
			-- Begins operations on the database.
		require
			not_is_interactive: not is_interactive
		do
				-- Reset interactive state as the run loop has completed.
			is_interactive := True

			put_header
			from is_done := False until is_done loop
				process_input
			end

				-- Reset interactive state as the run loop has completed.
			is_interactive := False

			io.put_string ("%NGoodbye!%N%N")
		ensure
			not_is_interactive: not is_interactive
		end

	end_interaction
			-- Ends any interactive operations on the database.
		require
			is_interactive: is_interactive
		do
			is_interactive := False
			is_done := True

			if attached statement_recorder as l_recorder then
					-- Close and remove the recorder.
				l_recorder.writer.close
				statement_recorder := Void
			end
		ensure
			not_is_interactive: not is_interactive
			is_done: is_done
			not_is_recording: not is_recording
		end

feature -- Basic operations: Output

	put_error (a_error: READABLE_STRING_8; a_args: detachable TUPLE)
			-- Displays an error on the terminal.
			--
			-- `a_error': The error message to display.
			-- `a_args': Arguments to replace in the error string.
		local
			l_writer: like terminal_writer
			l_vars: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			i_count, i: INTEGER
		do
			if attached a_args then
				i_count := a_args.count
				create l_vars.make (i_count)
				l_vars.compare_objects
				from i := 1 until i > i_count loop
					if attached a_args[i] as l_arg then
						l_vars[i.out] := l_arg.out
					else
						l_vars[i.out] := ""
					end
					i := i + 1
				end
			else
				create l_vars.make (0)
			end

			l_writer := terminal_error_writer
			l_writer.put_string ("Error: ")
			l_writer.put_string (a_error)
			l_writer.new_line
			terminal_writer.new_line
		end

	put_exception (e: EXCEPTION)
			-- Displays exception information on the console.
			--
			-- `e': The exception object to report.
		do
			io.put_string ("Error: ")
			io.error.put_string (e.tag.as_string_32)
			io.error.new_line
			if attached e.description as l_message and then not l_message.is_empty then
				io.error.put_string (l_message.as_string_8)
				io.error.new_line
			end
			io.error.new_line
		end

feature {NONE} -- Basic operations: Output

	put_header
			-- Puts header information to the console.
		do
			io.put_string ("Welcome to the SQLite Terminal%N")
			io.put_string ("Enter SQLite statements to execute, 'quit' to exit or 'help' for more help.%N%N")
		end

	put_statement_report (a_statement: SQLITE_STATEMENT)
			-- Puts information pertaining to a last successful operation
		require
			a_statement_is_connected: a_statement.is_connected
		local
			l_count: NATURAL
		do
			l_count := a_statement.changes_count
			if l_count > 0 then
				io.put_natural (l_count)
				io.put_string (" change ")
				if l_count > 1 then
					io.put_string (" were")
				else
					io.put_string (" was")
				end
				io.put_string (" just made to the database.")
				io.new_line
				io.new_line
			end
		end

feature -- Basic operations: Input

	read (a_prompt: detachable READABLE_STRING_8; a_empty_is_valid: BOOLEAN): detachable STRING
			-- Attempts to read a line from the default input.
			-- Note: When returning Void, the input cannot be read from.
			--
			-- `a_prompt': An optional prompt to display.
			-- `a_empty_is_valid': True to accept empty user input; False to guarentee a non empty string.
		require
			is_interactive: is_interactive
		local
			l_writer: like terminal_writer
			l_tries: INTEGER
			l_done: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_writer := terminal_writer
				if attached a_prompt and then not a_prompt.is_empty then
					l_writer.put_string (a_prompt)
					l_writer.put_character (' ')
				end

				from until l_done loop
					io.read_line
					l_tries := l_tries + 1
					l_done := io.last_character = '%U' and l_tries = 5
					if not l_done then
						Result := io.last_string
						Result.left_adjust
						Result.right_adjust
						l_done := not Result.is_empty or a_empty_is_valid
						if not l_done and attached a_prompt and then not a_prompt.is_empty then
							l_writer.put_string (a_prompt)
							l_writer.put_character (' ')
						end
					else
						terminal_error_writer.put_string ("The current terminal cannot accept user input. Shutting down...%N")
						Result := Void
						end_interaction
					end
				end
			else
				Result := Void
				end_interaction
			end
		ensure
			not_result_is_empty: (attached Result and a_empty_is_valid) implies not Result.is_empty
		rescue
			retried := True
			retry
		end

	read_response (a_question: READABLE_STRING_8; a_responses: TUPLE; a_default: detachable READABLE_STRING_8): NATURAL
			-- Reads a response from the user, from a tuple of valid responses.
			--
			-- `a_question': A question to ask.
			-- `a_responses': A tuple of objects to use as valid responses.
			-- `a_default': An optional default response, if one if not provided.
		require
			not_a_question_is_empty: not a_question.is_empty
			not_a_responses_is_empty: not a_responses.is_empty
			not_a_default_is_empty: attached a_default implies not a_default.is_empty
		local
			i_count, i: INTEGER
			l_default: STRING
			l_response: STRING
			l_responses: ARRAYED_LIST [STRING]
		do
			i_count := a_responses.count

				-- Create response string list, used to match responses later
			create l_responses.make (i_count)
			l_responses.compare_objects
			from i := 1 until i > i_count loop
				if attached a_responses.item (i) as l_item then
					l_responses.extend (l_item.out.as_lower)
				end
				i := i + 1
			end

			if attached a_default then
					-- Set the default
				l_default := a_default.string.as_lower
			end

				-- Ask the question
			io.put_string (a_question)
			io.put_string (" [")
			from l_responses.start until l_responses.after loop
				l_response := l_responses.item
				if l_response ~ l_default then
					io.put_string (l_response.as_upper)
				else
					io.put_string (l_response)
				end
				if not l_responses.islast then
					io.put_character ('|')
				end
				l_responses.forth
			end
			io.put_string ("]? ")

				-- Get and parse result
			l_response := read (Void, True)
			if l_response /= Void and then l_response.is_empty then
				if attached l_default then
					l_response := l_default
				end
			end

			if l_response /= Void and then l_responses.has (l_response) then
				l_responses.start
				l_responses.search (l_response)
				if not l_responses.after then
					Result := l_responses.index.to_natural_32
				end
			end
			if Result = 0 then
					-- Not a valid response
				Result := read_response (a_question, a_responses, a_default)
			else
				io.new_line
			end
		end

feature {NONE} -- Basic operations: Input

	process_input
			-- Requests user input and processes that input.
		local
			l_input: STRING
			l_done: BOOLEAN
			l_prompt: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_input.make_empty
				l_prompt := "$>"
				from until l_done loop
					if attached read (l_prompt, False) as l_fragment then
						l_done := process_command (l_fragment)
						if not l_done then
							l_input.append (l_fragment)
							l_done := database.is_complete_statement (l_input)
							if l_done then
								process_statement (l_input).do_nothing
							else
								if not l_input.is_empty then
									l_input.append_character ('%N')
								end
								l_prompt := "->"
							end
						end
					else
						l_done := True
					end
				end
			end
		rescue
			retried := True
			if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception then
				put_exception (l_exception)
			end
			retry
		end

	process_statement (a_sql: READABLE_STRING_8): BOOLEAN
			-- Processes a user entered statement.
			--
			-- `a_statement': The command string.
			-- `Result': True if the statement was executed correctly; False if there was an error.
		require
			a_sql_is_empty: not a_sql.is_empty
			a_sql_is_complete: database.is_complete_statement (a_sql)
		local
			l_statement: SQLITE_QUERY_STATEMENT
		do
			create l_statement.make (a_sql, database)
			if l_statement.is_compiled then
				if attached statement_recorder as l_recorder then
					l_recorder.record (l_statement)
				end
				l_statement.execute (agent on_result)
				put_statement_report (l_statement)
				Result := True
			else
				if attached l_statement.last_exception as l_exception then
					l_exception.raise
				end
			end
		end

	process_command (a_cmd: READABLE_STRING_8): BOOLEAN
			-- Processes a built-in command.
			--
			-- `a_cmd': The command string.
			-- `Result': True if the command was handled; False if there are no matching commands.
		local
			l_cmd: STRING
			l_args: detachable STRING
			l_arguments: detachable ARRAY [STRING]
			i: INTEGER
		do
			create l_cmd.make_from_string (a_cmd)
			l_cmd.to_lower

				-- Split command from any arguments.
			i := l_cmd.index_of (' ', 1)
			if i > 1 then
				l_cmd.keep_head (i - 1)
				create l_args.make_from_string (a_cmd.substring (i, a_cmd.count))
				l_args.left_adjust
				if not l_args.is_empty then
					l_arguments := (create {ARGUMENT_STRING_PARSER}).parse (l_args)
				end
			end

			if built_ins.has (l_cmd) and then attached built_ins[l_cmd] as l_command then
					-- Call the action
				l_command.execute (l_arguments)
				Result := True
			end
		end

feature {NONE} -- Action handler

	on_result (a_row: SQLITE_RESULT_ROW): BOOLEAN
			-- Called when a new result row is available.
			--
			-- `a_row': SQLite result row from last executed statement.
		local
			l_index: NATURAL
			i_count, i: NATURAL
		do
			l_index := a_row.index

				-- Display columns
			from
				i := 1
				i_count := a_row.count
			until
				i > i_count
			loop
				io.put_string (a_row.column_name (i))
				io.put_string (": ")
				if a_row.type (i) /= {SQLITE_TYPE}.blob then
					io.put_string (a_row.string_value (i))
				else
					io.put_string ("<Blob>")
				end
				io.new_line
				i := i + 1
			end

			io.new_line

			if l_index = 25 or else l_index = 200 then
					-- Safety net.
				io.put_natural (l_index)
				io.put_string (" results have already been returned.%N")

					-- Check if user wants more results, as we have already seen a lot.
				Result :=  read_response ("Do you want to view the rest", ["y", "n"], "n") = 2
			end
		end

	on_update (a_action: INTEGER; a_name: STRING_8; a_table: STRING_8; a_row: INTEGER_64)
			-- Called when an update was made to the database.
			--
			-- `a_action': Update action performed.
			-- `a_name': Database name.
			-- `a_table': Table name.
			-- `a_row': Row Id/index where the update occurred.
		require
			is_valid_update_action: (create {SQLITE_UPDATE_ACTION}).is_valid_update_action (a_action)
		local
			l_update: INTEGER
		do
			io.put_string ("A row (rowId: ")
			io.put_integer_64 (a_row)
			io.put_string (") in table ")
			io.put_string (a_table)
			io.put_string (" was ")
			l_update := a_action
			if l_update = {SQLITE_UPDATE_ACTION}.delete then
				io.put_string ("deleted")
			elseif l_update = {SQLITE_UPDATE_ACTION}.insert then
				io.put_string ("inserted")
			elseif l_update = {SQLITE_UPDATE_ACTION}.update then
				io.put_string ("updated")
			end
			io.put_character ('.')
			io.new_line
		end

feature {NONE} -- Factory

	create_built_ins: like built_ins
			-- Creates a new table of built in commands
		do
			create Result.make (3)
			Result["record"] := create {RECORD_COMMAND}.make (Current)
			Result["quit"] := create {QUIT_COMMAND}.make (Current)
			Result["help"] := create {HELP_COMMAND}.make (Current)
		end

feature {NONE} -- Implementation: Internal cache

	internal_built_ins: detachable like built_ins
			-- Cached version of `built_ins'
			-- Note: Do not use directly!

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
