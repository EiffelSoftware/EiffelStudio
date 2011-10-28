note
	description: "[
		Displays help information on a single command or all or them.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_COMMAND

inherit
	COMMAND

	STRING_HANDLER
		export
			{NONE} all
		end

create
	make

feature -- Access

	description: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			Result := "Displays help for built in commands. Use 'help <command>' for more information on the command."
		end

feature -- Basic operations

	execute (a_args: detachable ARRAY [READABLE_STRING_8])
			-- <Precursor>
		local
			l_commands: HASH_TABLE [COMMAND, READABLE_STRING_8]
			l_keys: SORTABLE_ARRAY [READABLE_STRING_8]
			l_writer: like terminal_writer
			l_cmd: STRING
			l_args: detachable ARRAY [READABLE_STRING_8]
			l_max_len: INTEGER
			i, i_count: INTEGER
		do
			l_writer := terminal_writer
			l_commands := interactive_terminal.built_ins
			if attached a_args and then not a_args.is_empty then
					-- Display help for supplied argument
				l_cmd := a_args[a_args.lower]
				l_writer.put_string (l_cmd)
				l_writer.put_string (": ")

				if attached l_commands[l_cmd.as_lower] as l_command then
						-- Trim extra arguments
					if a_args.count > 1 then
						l_args := a_args.subarray (2, a_args.count)
					else
						l_args := Void
					end
					l_command.display_help (l_args)
					l_writer.new_line
					l_writer.new_line
				end
			else
					-- Display help for all commands.
				l_writer.put_string ("Displaying help for all built-in commands:")
				l_writer.new_line
				l_writer.put_string ("------------------------------------------")
				l_writer.new_line

				if l_commands.count > 1 or else not l_commands.has_item (Current) then
					create l_keys.make_from_array (l_commands.current_keys)
					l_keys.compare_objects
					l_keys.sort

					from
						i := 1
						i_count := l_keys.count
					until
						i > i_count
					loop
						l_max_len := l_max_len.max (l_keys[i].count)
						i := i + 1
					end

					from i := 1 until i > i_count loop
						if attached l_commands[l_keys[i]] as l_command then
							create l_cmd.make_filled (' ', l_max_len)
							l_cmd.replace_substring (l_keys[i], 1, l_keys[i].count)

							l_writer.put_string (l_cmd)
							l_writer.put_character (':')
							l_writer.put_character (' ')
							l_writer.put_string (l_command.description)
							l_writer.new_line
						end
						i := i + 1
					end
					l_writer.new_line
				end
			end
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
