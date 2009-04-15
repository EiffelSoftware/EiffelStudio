note
	description: "[
		Base class for supporting string expansion using the Eiffel/Make variable token style.
		
		Variable tokens can be specified using $ID, $(ID) or ${ID} within a string and will be expanded
		based on the retrieval of a matching variable. Implement `variable' and `variable_32' to support
		variable retrieval.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRING_EXPANDER

feature -- Query

	expand_string (a_string: READABLE_STRING_8; a_keep: BOOLEAN): STRING
			-- Expands a 8-bit string and replaces any variable values.
			--
			-- `a_string': The string to expand.
			-- `a_keep'  : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'  : An expanded string with the match variable expanded.
		require
			a_string_attached: a_string /= Void
		local
			c: CHARACTER
			c2, c3: CHARACTER
			l_count, i: INTEGER
			l_buffer: STRING
			l_id: STRING
			l_cont: BOOLEAN
			l_escape: BOOLEAN
			l_match_para: BOOLEAN
			l_id_table: HASH_TABLE [STRING, STRING]
		do
			create Result.make (a_string.count)
			create l_id_table.make (13)
			create l_buffer.make (128)
			from
				i := 1
				l_count := a_string.count
			until
				i > l_count
			loop
				c := a_string.item (i)
				if not l_escape and then c = id_specifier_char then
					i := i + 1
					if i <= l_count then
						c2 := a_string.item (i)
						if c2.is_alpha or c2 = '{' or c2 = '(' then
								-- The start of the indentifier has been located
							if not l_buffer.is_empty then
									-- Create a new text token for anything left in the buffer
								Result.append (l_buffer)
								l_buffer.wipe_out
							end

								-- Now locate the indentifier name
							l_match_para := not c2.is_alpha
							if not l_match_para then
								l_buffer.append_character (c2)
							end

							i := i + 1
							l_cont := True
							from until not l_cont or i > l_count loop
								c := a_string.item (i)
								if l_match_para then
									l_cont := not (c2 = '{' and c = '}' or c2 = '(' and c = ')')
								else
									c3 := c.to_character_8
									l_cont := c3.is_alpha or c3.is_digit or c3 = '_'
								end
								if l_cont then
									l_buffer.append_character (c)
									i := i + 1
								elseif not l_match_para then
										-- Back step to ensure that `c' is included in the next top-level iteration, unless it's a parathensis closing character
									i := i - 1
								end
							end

							if not l_buffer.is_empty then
									-- Replace the variable
								l_id := l_buffer
								if l_id_table.has (l_id) and then attached l_id_table.item (l_id) as l_value then
									Result.append (l_value)
								elseif attached variable (l_id) as l_value then
									Result.append (l_value)
									l_id_table.put (l_value, l_id)
								elseif a_keep then
										-- No variable found, preserve the variable.
									Result.append_character (id_specifier_char)
									Result.append_character ('{')
									Result.append (l_buffer)
									Result.append_character ('}')
								end
								l_buffer.wipe_out
							end
						else
								-- There was a $ followed by a non-alpha char. Just skip the $ because it wasn't escaped.
							l_buffer.append_character (c2)
						end
					else
						l_buffer.append_character (c)
					end
				elseif c = esc_specifier_char then
						-- Toggle the escape character
					l_escape := not l_escape
					if not l_escape then
						l_buffer.append_character (c)
					end
				else
					l_buffer.append_character (c)
				end

				if c /= esc_specifier_char then
						-- Reset the escape character flag
					l_escape := False
				end

				i := i + 1
			end

			if not l_buffer.is_empty then
				Result.append (l_buffer)
			end
		ensure
			result_attached: Result /= Void
		end

	expand_string_32 (a_string: READABLE_STRING_32; a_keep: BOOLEAN): STRING_32
			-- Expands a 32-bit string and replaces any variable values.
			--
			-- `a_string': The string to expand.
			-- `a_keep'  : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'  : An expanded string with the match variable expanded.
		require
			a_string_attached: a_string /= Void
		local
			c: CHARACTER_32
			c2, c3: CHARACTER_8
			l_count, i: INTEGER
			l_buffer: STRING_32
			l_id: STRING
			l_cont: BOOLEAN
			l_escape: BOOLEAN
			l_match_para: BOOLEAN
			l_id_table: HASH_TABLE [STRING_32, STRING]
		do
			create Result.make (a_string.count)
			create l_id_table.make (13)
			create l_buffer.make (128)
			from
				i := 1
				l_count := a_string.count
			until
				i > l_count
			loop
				c := a_string.item (i)
				if not l_escape and then c = id_specifier_char then
					i := i + 1
					if i <= l_count then
						if a_string.item (i).is_character_8 then
							c2 := a_string.item (i).to_character_8
						else
								-- Wipe out, so the next test fails.
							create c2
						end
						if c2.is_alpha or c2 = '{' or c2 = '(' then
								-- The start of the indentifier has been located
							if not l_buffer.is_empty then
									-- Create a new text token for anything left in the buffer
								Result.append (l_buffer)
								l_buffer.wipe_out
							end

								-- Now locate the indentifier name
							l_match_para := not c2.is_alpha
							if not l_match_para then
								l_buffer.append_character (c2)
							end

							i := i + 1
							l_cont := True
							from until not l_cont or i > l_count loop
								c := a_string.item (i)
								if l_match_para then
									l_cont := not (c2 = '{' and c = '}' or c2 = '(' and c = ')')
								else
									l_cont := c.is_character_8
									if l_cont then
										c3 := c.to_character_8
										l_cont := c3.is_alpha or c3.is_digit or c3 = '_'
									end
								end
								if l_cont then
									l_buffer.append_character (c)
									i := i + 1
								elseif not l_match_para then
										-- Back step to ensure that `c' is included in the next top-level iteration, unless it's a parathensis closing character
									i := i - 1
								end
							end

							if not l_buffer.is_empty then
									-- Replace the variable
								if l_buffer.is_string_8 then
									l_id := l_buffer.as_string_8
									if l_id_table.has (l_id) and then attached l_id_table.item (l_id) as l_value then
										Result.append (l_value)
									elseif attached variable_32 (l_id) as l_value then
										Result.append (l_value)
										l_id_table.put (l_value, l_id)
									elseif a_keep then
											-- No variable found, preserve the variable.
										Result.append_character (id_specifier_char)
										Result.append_character ('{')
										Result.append (l_buffer)
										Result.append_character ('}')
									end
								elseif a_keep then
										-- The variable is invalid, preserve the variable.
									Result.append_character (id_specifier_char)
									Result.append_character ('{')
									Result.append (l_buffer)
									Result.append_character ('}')
								end
								l_buffer.wipe_out
							end
						else
								-- There was a $ followed by a non-alpha char. Just skip the $ because it wasn't escaped.
							l_buffer.append_character (c2)
						end
					else
						l_buffer.append_character (c)
					end
				elseif c = esc_specifier_char then
						-- Toggle the escape character
					l_escape := not l_escape
					if not l_escape then
						l_buffer.append_character (c)
					end
				else
					l_buffer.append_character (c)
				end

				if c /= esc_specifier_char then
						-- Reset the escape character flag
					l_escape := False
				end

				i := i + 1
			end

			if not l_buffer.is_empty then
				Result.append (l_buffer)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Query

	variable (a_id: READABLE_STRING_8): detachable STRING
			-- Fetches a variable using a variable id name.
			--
			-- `a_id': A variable identifier name.
			-- `Result': A variable value or Void if the variable was not found.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

	variable_32 (a_id: READABLE_STRING_32): detachable STRING_32
			-- Fetches a variable using a variable id name.
			--
			-- `a_id': A variable identifier name.
			-- `Result': A variable value or Void if the variable was not found.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

feature {NONE} -- Constants

	id_specifier_char: CHARACTER
			-- Prefix specifier to code template replacable identifiers.
		do
			Result := '$'
		end

	esc_specifier_char: CHARACTER
			-- Escape character prefix, use when escaping `id_specifier_char'
		do
			Result := '%%'
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
