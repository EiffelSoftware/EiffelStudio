note
	description: "[
		Simple string parser to produce an argument list as those produce via a terminal or shell.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_STRING_PARSER

feature {NONE} -- Access

	block_qualifiers: ARRAY [CHARACTER]
			-- Block characters, allowing breaking characters between block qualifiers.
		once
			Result := <<'"', '%'', '`'>>
		ensure
			not_result_is_empty: not Result.is_empty
		end

	break_characters: ARRAY [CHARACTER]
			-- Break characters, breaking up arguments.
		once
			Result := <<' ', '%T', '%N', '%R'>>
		ensure
			not_result_is_empty: not Result.is_empty
		end

	escape_character: CHARACTER
			-- Default escape character.
		do
			if {PLATFORM}.is_windows then
				Result := '/'
			else
				Result := '\'
			end
		ensure
			result_is_printable: Result.is_printable
			result_is_punctuation: Result.is_punctuation
		end

feature -- Status report

	is_break (c: CHARACTER): BOOLEAN
			-- Determines if a character is an argument breaking character.
			--
			-- `c': Character to test.
			-- `Result': True if the character is a argument break character; False otherwise.
		require
			c_is_printable: c.is_printable
		do
			Result := break_characters.has (c)
		end

feature -- Query

	parse (a_string: READABLE_STRING_8): ARRAY [STRING]
			-- Parsers a string to extract separate arguments.
			--
			-- `a_string': String to parse.
			-- `Result': An array of parsed arguments.
		require
			not_a_string_is_empty: not a_string.is_empty
		local
			l_arg: STRING
			l_args: ARRAYED_LIST [STRING]
			l_blocks: like block_qualifiers
			l_block_char: CHARACTER
			l_escape: like escape_character
			l_escaped: BOOLEAN
			l_new: BOOLEAN
			c: CHARACTER
			i, i_count: INTEGER
		do
			create l_args.make (1)
			l_blocks := block_qualifiers
			l_escape := escape_character

			create l_arg.make (0)
			from
				i := 1
				i_count := a_string.count
			until
				i > i_count
			loop
				c := a_string[i]
				if l_escaped then
						-- Escaped character
					l_escaped := False
					l_arg.append_character (c)
				else
					l_escaped := c = l_escape
					if not l_escaped then
						if l_blocks.has (c) then
							if c = l_block_char then
									-- Complete block
								l_block_char := '%U'
								l_new := True
							elseif l_block_char = '%U' then
									-- New block
								l_block_char := c
							else
									-- Character inside block
								l_arg.append_character (c)
							end
						else
								-- No block
							if is_break (c) and l_block_char = '%U' then
								l_new := True

									-- New argument
								l_args.extend (create {STRING}.make_from_string (l_arg))
								l_arg.wipe_out
							else
								l_arg.append_character (c)
							end
						end
					end
				end
				
				if (l_new or else i = i_count) then
					if not l_arg.is_empty then
						l_args.extend (create {STRING}.make_from_string (l_arg))
					end
					l_arg.wipe_out
					l_new := False
				end

				i := i + 1
			end

			Result := l_args.to_array
		ensure
			not_result_is_empty: not Result.is_empty
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
