indexing
	description: "[
		The default code tokenizer for creating code token object ({CODE_TOKEN}) from a raw code template string.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TOKENIZER

feature -- Basic operations

	tokenize (a_template: !STRING_32; a_factory: !CODE_FACTORY): !DS_ARRAYED_LIST [!CODE_TOKEN]
			-- Tokenizes a code template string.
			--
			-- `a_template': A code template raw string to tokenize.
			-- `a_factory': A token factory used to create the tokenized code nodes.
			-- `Result': The result list of code tokens tokenized from the supplied template.
		require
			not_a_template_is_empty: not a_template.is_empty
		local
			c: CHARACTER_32
			c2, c3: CHARACTER_8
			l_count, i: INTEGER
			l_buffer: !STRING_32
			l_id: !STRING_32
			l_token_id: !CODE_TOKEN_ID
			l_cont: BOOLEAN
			l_escape: BOOLEAN
			l_match_para: BOOLEAN
			l_id_table: DS_HASH_TABLE [!CODE_TOKEN_ID, !STRING_32]
		do
			create Result.make_default
			create l_id_table.make_default

			create l_buffer.make (128)
			from
				i := 1
				l_count := a_template.count
			until
				i > l_count
			loop
				c := a_template.item (i)
				if not l_escape and then c = id_specifier_char then
					i := i + 1
					if i <= l_count then
						if a_template.item (i).is_character_8 then
							c2 := a_template.item (i).to_character_8
						else
								-- Wipe out, so the next test fails.
							create c2
						end
						if c2.is_alpha or c2 = '{' or c2 = '(' then
								-- The start of the indentifier has been located
							if not l_buffer.is_empty then
									-- Create a new text token for anything left in the buffer
								Result.force_last (a_factory.create_text_token (l_buffer.twin))
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
								c := a_template.item (i)
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
									-- Create the new id token
								l_id ?= l_buffer.as_lower
								if l_id_table.has (l_id) then
										-- Create a reference token, because only the first id token should be editable.
									l_token_id ?= l_id_table.item (l_id)
									Result.force_last (a_factory.create_id_ref_token (l_token_id))
								else
										-- Creates an editable id token
									if l_id.as_string_8.is_equal ({CODE_TOKEN_NAMES}.cursor_token_name) then
										l_token_id := a_factory.create_cursor_token
									else
										l_token_id := a_factory.create_id_token (l_id)
									end

									Result.force_last (l_token_id)
									l_id_table.put (l_token_id, l_id)
								end
								l_buffer.wipe_out
							end
						else
							l_buffer.append_character (c)
						end
					else
						l_buffer.append_character (c)
					end
				elseif c.code = 10 then
					if not l_buffer.is_empty then
						Result.force_last (a_factory.create_text_token (l_buffer.twin))
					end
					l_buffer.wipe_out

						-- Create a new line
					Result.force_last (a_factory.create_eol_token)
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
				Result.force_last (a_factory.create_text_token (l_buffer))
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants

	id_specifier_char: CHARACTER = '$'
			-- Prefix specifier to code template replacable identifiers.

	esc_specifier_char: CHARACTER = '%%'
			-- Escape character prefix, use when escaping `id_specifier_char'

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
