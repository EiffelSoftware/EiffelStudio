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

	process_line (a_line: READABLE_STRING_32; a_number: NATURAL_32)
			-- <Precursor>
		local
			l_exp: like function_name_regexp
			l_file_name: STRING_32
			l_position: STRING_32
			l_position_8: STRING_8
			l_message_type: STRING_32
			l_message: STRING_32
			l_line: INTEGER
			i, j: INTEGER
		do
				-- Parse GCC.
			i := a_line.index_of (':', 1)
			if i > 1 then
					-- File name
				l_file_name := a_line.substring (1, i - 1)
				string_general_left_adjust (l_file_name)
				string_general_right_adjust (l_file_name)
				if l_file_name /~ file_name and then l_file_name.substring (1, dot_text_offset.count.min (l_file_name.count)) /~ dot_text_offset then
					process_last_error
					file_name := l_file_name
				end
				j := i + 1

				i := a_line.index_of (':', j)
				if i > j then
						-- Line number/warning
					l_position := a_line.substring (j, i - 1)
					string_general_left_adjust (l_position)
					string_general_right_adjust (l_position)
					l_position_8 := l_position.as_string_8
					if l_position_8.is_integer_32 or else l_position.substring (1, dot_text_offset.count.min (l_position.count)) ~ dot_text_offset then
						if l_position_8.is_integer_32 then
							l_line := l_position_8.to_integer_32
							if l_line /= line_number then
								if line_number > 0 then
									process_last_error
								end

								file_name := l_file_name
								line_number := l_line
							end
						end

						j := i + 1
						i := a_line.index_of (':', j)
						if i > j then
								-- Message type
							l_message_type := a_line.substring (j, i - 1)
							string_general_left_adjust (l_message_type)
							string_general_right_adjust (l_message_type)
								-- Before looking for "warning", converting to STRING_8 is fine.
							if l_message_type.is_integer_8 then
									-- It is a column string so we check after the next colon.
								j := i + 1
								i := a_line.index_of (':', j)
								if i > j then
									l_message_type := a_line.substring (j, i - 1)
									string_general_left_adjust (l_message_type)
									string_general_right_adjust (l_message_type)
								end
							end
							if l_message_type.as_lower.has_substring (once {STRING_32} "warning") then
								is_error := False
							elseif l_message_type.as_lower.has_substring (once {STRING_32} "error") then
								is_error := True
							else
									-- It is neither a warning nor an error.
								l_message_type := Void
							end
						end
					else
						line_number := 0
						if l_position.as_lower.has_substring (once {STRING_32} "warning") then
							is_error := False
						elseif l_position.as_lower.has_substring (once {STRING_32} "error") then
							is_error := True
						else
								-- It is neither a warning nor an error.
							l_message_type := Void
						end

							-- Not a line number.
						l_exp := function_name_regexp
							-- Before looking for "F[0-9]+_[0-9]+", converting to STRING_8 is fine.
						l_exp.match (l_position.as_string_8)
						if l_exp.has_matched then
							function_name := l_exp.captured_substring (0)
						else
							l_message_type := l_position
						end
					end

					if attached l_message_type and not l_message_type.is_empty then
							-- Message
						j := i + 1
						l_message := a_line.substring (j , a_line.count)
						string_general_left_adjust (l_message)
						string_general_right_adjust (l_message)

						if not l_message.is_empty then
							if not attached message then
								create message.make (100)
							else
								message.append_character (' ')
							end
							message.append (l_message)
						end
					end
				else
					process_last_error
				end
			else
				process_last_error
			end
		end

feature {NONE} -- Constants

	dot_text_offset: STRING_32
		once
			Result := "(.text+"
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
