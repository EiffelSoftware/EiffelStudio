note
	description: "Class that provides a set of test for tokens"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOKEN_TOOLKIT

feature -- basic operations

	is_keyword (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a keyword token?
		do
			Result := attached {EDITOR_TOKEN_KEYWORD} a_token
		end

	is_comment (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a comment token?
		do
			Result := attached {EDITOR_TOKEN_COMMENT} a_token
		end

	is_blank (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a blank token?
		do
			Result := attached {EDITOR_TOKEN_BLANK} a_token
		end

	is_string (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a string token?
		do
			Result := attached {EDITOR_TOKEN_STRING} a_token
		end

	is_number (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a number token?
		do
			Result := attached {EDITOR_TOKEN_NUMBER} a_token
		end

	is_character (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' a character token?
		do
			Result := attached {EDITOR_TOKEN_CHARACTER} a_token
		end

	is_eol (a_token: EDITOR_TOKEN): BOOLEAN
			-- is `a_token' a end-of-line token?
		do
			Result := attached {EDITOR_TOKEN_EOL} a_token
		end

	is_known_infix (token: EDITOR_TOKEN): BOOLEAN
			-- is token a known binary operator?
		do
			Result := token_image_is_in_array (token, binary_operators)
		end

	is_known_prefix (token: EDITOR_TOKEN): BOOLEAN
			-- is token a known unary operator?
		do
			Result := token_image_is_in_array (token, unary_operators)
		end

	token_equal (a_token: EDITOR_TOKEN; a_str: STRING): BOOLEAN
			-- Is image of `a_token' the same as `a_str'?
		require
			a_token_not_void: a_token /= Void
			a_str_not_void: a_str /= Void
		do
			Result := a_token.wide_image.same_string_general (a_str)
		end

	token_image_is_same_as_word (token: EDITOR_TOKEN; word: STRING_32): BOOLEAN
			-- Are the token image (except comments) and the word equal (case has no importance)?
		require
			word_not_void: word /= Void
		do
			if token /= Void and then not attached {EDITOR_TOKEN_COMMENT} token then
				Result := token.wide_image.is_case_insensitive_equal (word)
			end
		end

	token_image_is_in_array (token: EDITOR_TOKEN; words: ARRAY [STRING]): BOOLEAN
			-- Does the token image belong to the list `words' ?
		require
			word_not_void: words /= Void
		local
			image: STRING_32
			i: INTEGER
		do
			if token /= Void then
					-- Here because `words' are ACSII strings,
					-- so it is safe to convert to lower case before comparison.
				image := string_32_to_lower_copy_optimized (token.wide_image)
				from
					i := words.lower
				until
					Result or else i > words.upper
				loop
					Result := image.same_string_general (words @ i)
					i:= i + 1
				end
			end
		end

	is_beginning_of_expression (token: EDITOR_TOKEN): BOOLEAN
			-- is `token' the beginning of an expression ?
		do
			Result := token = Void
						or else
					not token.is_text
						or else
					token_image_is_in_array (token, opening_separators)
						or else
					token_image_is_in_array (token, binary_operators)
						or else
					token_image_is_in_array (token, unary_operators)
		end

	can_attempt_auto_complete_from_token (token: EDITOR_TOKEN; a_pos_in_token: INTEGER): BOOLEAN
			-- Is `token' of the correct type that we can attempt to build a feature or class
			-- autocompletion list?
		require
			a_pos_in_token_positive: a_pos_in_token >= 0
		do
			Result := token /= Void
			if Result and then a_pos_in_token > 1 then
				Result := not (is_string (token) or else is_character (token) or else is_number (token))
			end
		end

	string_32_to_lower (a_str: detachable STRING_32): STRING_32
			-- Make all possible char in `a_str' to lower.
			-- |FIXME: We need real Unicode as lower.
			-- |For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			create Result.make_from_string (a_str)
			from
				i := 1
				nb := a_str.count
			until
				i > nb
			loop
				if a_str.item (i).code <= {CHARACTER_8}.max_value then
					Result.put (a_str.item (i).to_character_8.as_lower, i)
				else
					Result.put (a_str.item (i), i)
				end
				i := i + 1
			end
		end

	string_32_to_lower_copy_optimized (a_str: STRING_32): STRING_32
			-- Make all possible char in `a_str' to lower.
			-- |FIXME: We need real Unicode as lower.
			-- |For the moment, only ANSII code are concerned.
			-- Return `a_str' if all characters are lower case, else return a new string.
		local
			i, nb: INTEGER_32
			l_char_8: CHARACTER_8
		do
			Result := a_str
			from
				i := 1
				nb := a_str.count
			until
				i > nb
			loop
				if a_str.item_code (i) <= {CHARACTER_8}.max_value then
					l_char_8 := a_str.item (i).to_character_8
					if l_char_8.is_upper then
						if Result = a_str then
							create Result.make_from_string (a_str)
						end
						Result.put (l_char_8.as_lower, i)
					end
				end
				i := i + 1
			end
		end

	string_32_to_upper (a_str: detachable STRING_32): STRING_32
			-- Make all possible char in `a_str' to upper.
			-- |FIXME: We need real Unicode as upper.
			-- |For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			create Result.make_from_string (a_str)
			from
				i := 1
				nb := a_str.count
			until
				i > nb
			loop
				if a_str.item (i).code <= {CHARACTER_8}.max_value then
					Result.put (a_str.item (i).to_character_8.as_upper, i)
				else
					Result.put (a_str.item (i), i)
				end
				i := i + 1
			end
		end

feature -- Query

	char_32_is_alpha (a_char: CHARACTER_32): BOOLEAN
		do
			if a_char.is_character_8 then
				Result := a_char.to_character_8.is_alpha
			end
		end

	char_32_is_digit (a_char: CHARACTER_32): BOOLEAN
		do
			if a_char.is_character_8 then
				Result := a_char.to_character_8.is_digit
			end
		end

feature {NONE} -- Constants

	binary_operators: ARRAY [STRING]
		once
			Result := <<"@", "^", "*", "/", "//", "\\", "+", "-", "/=", "=", ">", ">=", "<", "<=", "and", "xor", "or", "implies">>
		end

	unary_operators: ARRAY [STRING]
		once
			Result := <<"+", "-", "not", "old">>
		end

	opening_separators: ARRAY [STRING]
		once
			Result := <<":=", "?=", ";", ",","(">>
		end

	opening_bracket: STRING = "["

	closing_bracket: STRING = "]"

	opening_brace: STRING = "{"

	closing_brace: STRING = "}"

	opening_parenthesis: STRING = "("

	closing_parenthesis: STRING = ")"

	semi_colon: STRING = ";"

	colon: STRING = ":"

	comma: STRING = ","

	period: STRING = "."

	equal_sign: STRING = "="

	different_sign: STRING = "/="

	feature_word: STRING = "feature"

	end_word: STRING = "end"

	like_word: STRING = "like"

	is_word: STRING = "is"

	current_word: STRING = "current"

	local_word: STRING = "local"

	create_word: STRING = "create"

	result_word: STRING = "result"

	precursor_word: STRING = "precursor";

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class EB_TOKEN_TOOLKIT
