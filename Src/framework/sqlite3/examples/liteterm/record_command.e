note
	description: "[
		Comamnd to record statements in the interactive terminal.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RECORD_COMMAND

inherit
	COMMAND
		redefine
			display_help
		end

create
	make


feature -- Access

	description: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			Result := "Records all entered statements."
		end

feature {NONE} -- Access

	record_file_name: STRING_8
			-- Recorded record file name
		attribute
			Result := "recorded.sql"
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	execute (a_args: detachable ARRAY [READABLE_STRING_8])
			-- <Precursor>
		local
			l_writer: like terminal_writer
			l_arg: READABLE_STRING_8
			l_recorder: detachable STATEMENT_RECORDER
			l_file_name: READABLE_STRING_8
			l_file: PLAIN_TEXT_FILE
			l_result: NATURAL
		do
			l_writer := terminal_writer
			if attached a_args and then not a_args.is_empty then
				l_arg := a_args[1].as_lower
				if l_arg ~ start_argument then
					if a_args.count >= 2 then
						l_file_name := a_args[2]
					else
						create {STRING}l_file_name.make_from_string (record_file_name)
					end

						-- Create the file to record to.
					create l_file.make (l_file_name)
					if l_file.exists then
							-- File already exists, check what user wants to do.
						l_result := interactive_terminal.read_response ("The file already exists! Append/Overwrite/Cancel", ["A", "O", "C"], "A")
						if l_result = 1 then
							l_file.open_append
						elseif l_result = 2 then
							l_file.create_read_write
						end
					else
						l_file.create_read_write
					end

					if not l_file.is_closed then
							-- Set file name for next default.
						create record_file_name.make_from_string (l_file.name)

						l_recorder := interactive_terminal.statement_recorder
						if attached l_recorder then
								-- Close the existing recorder
							l_recorder.writer.close
						end
						create l_recorder.make (interactive_terminal, l_file)
						interactive_terminal.statement_recorder := l_recorder
					else
						interactive_terminal.put_error ("Cancelled last operation to file '${1}'", [l_file_name])
					end
				elseif l_arg ~ stop_argument then
					l_recorder := interactive_terminal.statement_recorder
					if attached l_recorder then
							-- Close the existing recorder
						l_recorder.writer.close
					end
					interactive_terminal.statement_recorder := Void
				else
					interactive_terminal.put_error ("Unrecognized record argument '${1}'", [a_args[1]])
				end
			else
				if interactive_terminal.is_recording then
					l_writer.put_string ("Statements are currently being recorded.")
					l_writer.new_line
					l_writer.put_string ("Use 'record stop' to stop recording.")
				else
					l_writer.put_string ("Statements are not being recorded to a file.")
					l_writer.new_line
					l_writer.put_string ("Use 'record start [file name]' to start recording.")
				end
				l_writer.new_line
			end
		end

	display_help (a_args: detachable ARRAY [READABLE_STRING_8])
			-- Displays command help.
			--
			-- `a_args': The arguments to use with the help command.
		local
			l_writer: like terminal_writer
		do
			Precursor (a_args)
			l_writer := terminal_writer
			l_writer.new_line
			l_writer.put_string ("To begin record, use 'record start [file name]' where [file name] is an optional")
			l_writer.new_line
			l_writer.put_string ("file to record the statements into. To stop a recording session use `record")
			l_writer.new_line
			l_writer.put_string ("stop'. To view the status of a recorded session use `record' with no arguments.")
		end

feature {NONE} -- Constants

	start_argument: STRING = "start"
	stop_argument: STRING = "stop"

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
