note
	description: "[
		A console for interating with SQLite.
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
			create terminal.make (io.output)
			database := a_db
			database.update_action :=  agent on_update
			begin_interaction
		ensure
			database_set: database = a_db
		end

feature -- Access

	database: SQLITE_DATABASE
			-- Database connection.

feature {NONE} -- Access

	terminal: TERMINAL
			-- Terminal maninpulator.
		attribute
			create Result.make (io.output)
		end

	terminal_error: TERMINAL
			-- Terminal maninpulator.
		attribute
			create Result.make (io.error)
		end

	action_map: HASH_TABLE [PROCEDURE [ANY, TUPLE [args: detachable READABLE_STRING_8]], READABLE_STRING_8]
			-- Command names maps to an action.
		once
			create Result.make (1)
			Result.compare_objects
			Result["quit"] := agent on_quit
			Result["help"] := agent on_help
		end

feature {NONE} -- Status report

	is_done: BOOLEAN
			-- Indicates if interaction has complete (user quit)

feature -- Basic operations

	begin_interaction
			-- Begins operations on the database.
		do
			terminal.reset_display
			terminal_error.reset_display

			put_header
			from is_done := False until is_done loop
				read_input
			end

			terminal.reset_display
			terminal_error.reset_display
			io.put_string ("%NGoodbye!%N%N")
		end

feature {NONE} -- Basic operations: Output

	put_header
			-- Puts header information to the console.
		do
			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			terminal.set_foreground_color ({TERMINAL_COLOR}.none)
			io.put_string ("Welcome to the SQLite Terminal%N")
			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)
			io.put_string ("Enter SQLite statements to execute, 'quit' to exit or 'help' for more help.%N%N")
		end

	put_database_report
			-- Puts information pertaining to a last successful operation
		local
			l_count: NATURAL
		do
			l_count := database.changes_count
			if l_count > 0 then
				terminal.set_foreground_color ({TERMINAL_COLOR}.dim_magenta)
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
				io.put_natural (l_count)
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)
				terminal.set_foreground_color ({TERMINAL_COLOR}.magenta)
				io.put_string (" change ")
				if l_count > 1 then
					io.put_string (" were")
				else
					io.put_string (" was")
				end
				io.put_string (" just made to the database.")
				io.new_line
				io.new_line
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)
				terminal.set_foreground_color ({TERMINAL_COLOR}.none)
			end
		end

	put_exception (e: EXCEPTION)
			-- Displays exception information on the console.
			--
			-- `e': The exception object to report.
		do
			terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			terminal_error.set_foreground_color ({TERMINAL_COLOR}.red)
			io.put_string ("Error: ")
			io.error.put_string (e.meaning)
			io.error.new_line
			if attached e.message as l_message and then not l_message.is_empty then
				terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
				io.error.put_string (l_message)
				io.error.new_line
			end
			io.error.new_line
			terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
			terminal_error.set_foreground_color ({TERMINAL_COLOR}.none)
		end

feature {NONE} -- Basic operations

	read_input
			-- Requests user input and processes that input.
		local
			l_input: STRING
			l_done: BOOLEAN
			l_statement: SQLITE_QUERY_STATEMENT
			retried: BOOLEAN
		do
			if not retried then
				terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
				io.put_string ("$> ")
				terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)

				create l_input.make_empty
				from until l_done loop
					io.read_line
					if attached io.last_string as l_fragment then
						l_fragment.left_adjust
						l_fragment.right_adjust
						l_done := process_command (l_fragment)
						if not l_done then
							l_input.append (l_fragment)
							l_done := database.is_complete_statement (l_input)
							if l_done then
								create l_statement.make (l_input, database)
								if l_statement.is_compiled then
									l_statement.execute (agent on_result)
									put_database_report
								else
									if attached l_statement.last_exception as l_exception then
										l_exception.raise
									end
								end
							else
								if not l_input.is_empty then
									l_input.append_character ('%N')
								end
								terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
								io.put_string ("-> ")
								terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
							end
						end
					end
				end
			end
			terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
		rescue
			retried := True
			if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception then
				put_exception (l_exception)
			end
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
			l_default: detachable STRING
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
					terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
					io.put_string (l_response.as_upper)
					terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
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
			io.read_line

			l_response := io.last_string.as_lower
			if l_response.is_empty then
				if attached l_default then
					l_response := l_default
				end
			end

			if l_responses.has (l_response) then
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

	process_command (a_cmd: READABLE_STRING_8): BOOLEAN
			-- Processes a built-in command.
			--
			-- `a_cmd': The command string.
			-- `Result': True if the command was handled; False if there are no matching commands.
		local
			l_cmd: STRING
			l_args: detachable STRING
			i: INTEGER
		do
			create l_cmd.make_from_string (a_cmd)
			l_cmd.to_lower

				-- Split command from any arguments.
			i := l_cmd.index_of (' ', 1)
			if i > 1 then
				l_cmd.keep_head (l_cmd.count - 1)
				create l_args.make_from_string (a_cmd.substring (i, a_cmd.count))
				l_args.left_adjust
			end

			if action_map.has (l_cmd) and then attached action_map[l_cmd] as l_action then
					-- Call the action
				l_action.call ([l_args])
				Result := True
			end
		end

feature {NONE} -- Action handler

	on_help (a_args: detachable READABLE_STRING_8)
			-- Called when the user requests help.
			--
			-- `a_args': Optional arguments.
		do
			terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			io.new_line
			io.put_string ("LiteTerm Help")
			io.new_line
			io.put_string ("-------------")
			io.new_line
			terminal_error.set_text_style ({TERMINAL_TEXT_STYLE}.none)
			io.put_string ("The online help is not yet available, please check back later.")
			io.new_line
			io.new_line
		end

	on_quit (a_args: detachable READABLE_STRING_8)
			-- Called when the user requests to quit.
			--
			-- `a_args': Optional arguments.
		do
			is_done := True
		end

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
				terminal.set_foreground_color ({TERMINAL_COLOR}.dim_magenta)
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
				io.put_string (a_row.column_name (i))
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)
				terminal.set_foreground_color ({TERMINAL_COLOR}.none)
				io.put_string (": ")
				if a_row.type (i) /= {SQLITE_TYPE}.blob then
					io.put_string (a_row.string_value (i))
				else
					io.put_string ("<Blob>")
				end
				io.new_line
				i := i + 1
			end

			i_count := terminal.columns
			if i_count > 0 then
				io.put_string (create {STRING}.make_filled ('-', i_count.to_integer_32))
			else
				io.new_line
			end

			if l_index = 25 or else l_index = 200 then
					-- Safety net.
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
				io.put_natural (l_index)
				terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)
				terminal.set_foreground_color ({TERMINAL_COLOR}.none)
				io.put_string (" results have already been returned.%N")

					-- Check if user wants more results, as we have already seen a lot.
				Result :=  read_response ("Do you want to view the rest", ["y", "n"], "n") = 2
			end
		end

	on_update (a_action: SQLITE_UPDATE_ACTION; a_name: STRING_8; a_table: STRING_8; a_row: INTEGER_64)
			-- Called when an update was made to the database.
			--
			-- `a_action': Update action performed.
			-- `a_name': Database name.
			-- `a_table': Table name.
			-- `a_row': Row Id/index where the update occurred.
		local
			l_update: INTEGER
		do
			terminal.set_foreground_color ({TERMINAL_COLOR}.dim_green)
			io.put_string ("A row (rowId: ")

			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			terminal.set_foreground_color ({TERMINAL_COLOR}.green)
			io.put_integer_64 (a_row)
			terminal.set_foreground_color ({TERMINAL_COLOR}.dim_green)
			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)

			io.put_string (") in table ")

			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			terminal.set_foreground_color ({TERMINAL_COLOR}.green)
			io.put_string (a_table)
			terminal.set_foreground_color ({TERMINAL_COLOR}.dim_green)
			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)

			io.put_string (" was ")

			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.bold)
			l_update := a_action.item
			if l_update = {SQLITE_UPDATE_ACTION}.delete then
				io.put_string ("deleted")
			elseif l_update = {SQLITE_UPDATE_ACTION}.insert then
				io.put_string ("inserted")
			elseif l_update = {SQLITE_UPDATE_ACTION}.update then
				io.put_string ("updated")
			end
			terminal.set_text_style ({TERMINAL_TEXT_STYLE}.none)

			io.put_character ('.')
			io.new_line

			terminal.set_foreground_color ({TERMINAL_COLOR}.none)
		end

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
