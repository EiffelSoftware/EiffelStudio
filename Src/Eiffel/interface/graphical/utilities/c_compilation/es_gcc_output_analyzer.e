note
	description: "[
		Analyzes the C compilation output from GCC to produce results.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GCC_OUTPUT_ANALYZER

inherit
	ES_C_COMPILER_OUTPUT_ANALYZER

create
	make

feature {NONE} -- Basic operations

	process_line (a_line: READABLE_STRING_8; a_number: NATURAL_32)
			-- <Precursor>
		local
			l_exp: like function_name_regexp
			l_file_name: STRING
			l_position: STRING
			l_message_type: STRING
			l_message: STRING
			l_line: INTEGER
			i, j: INTEGER
		do
				-- Parse GCC.
			i := a_line.index_of (':', 1)
			if i > 1 then
					-- File name
				l_file_name := a_line.substring (1, i - 1)
				l_file_name.right_adjust
				l_file_name.left_adjust
				if l_file_name /~ file_name then
					process_last_error
					file_name := l_file_name
				end
				j := i + 1

				i := a_line.index_of (':', j)
				if i > j then
						-- Line number/warning
					l_position := a_line.substring (j, i - 1)
					l_position.right_adjust
					l_position.left_adjust
					if l_position.is_integer_32 then
						l_line := l_position.to_integer_32
						if l_line /= line_number then
							if line_number > 0 then
								process_last_error
							end

							file_name := l_file_name
							line_number := l_line
						end

						j := i + 1
						i := a_line.index_of (':', j)
						if i > j then
								-- Message type
							l_message_type := a_line.substring (j, i - 1)
							l_message_type.right_adjust
							l_message_type.left_adjust

							if l_message_type.as_lower.substring_index ("error", 1) > 0 then
								is_error := True
							end
						end
					else
						line_number := 0

							-- Not a line number.
						l_exp := function_name_regexp
						l_exp.match (l_position)
						if l_exp.has_matched then
							function_name := l_exp.captured_substring (0)
						else
							l_message_type := l_position
						end
						l_line := 0
					end

					if attached l_message_type and not l_message_type.is_empty then
							-- Message
						j := i + 1
						l_message := a_line.substring (j , a_line.count)
						l_message.right_adjust
						l_message.left_adjust

						if not l_message.is_empty then
							if not attached message then
								create message.make (100)
							else
								message.append_character (' ')
							end
							message.append (l_message)
							message := message
						end
					end
				else
					process_last_error
				end
			else
				process_last_error
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
