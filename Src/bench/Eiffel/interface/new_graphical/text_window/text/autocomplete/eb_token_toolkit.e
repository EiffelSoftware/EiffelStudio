indexing
	description: "Class that provides a set of test for tokens"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOKEN_TOOLKIT

feature -- basic operations

	is_keyword (a_token: EDITOR_TOKEN):BOOLEAN is
			-- is `a_token' a keyword token ?
		local
			kwt: EDITOR_TOKEN_KEYWORD
		do
			kwt ?= a_token
			Result := kwt /= Void
		end

	is_comment (a_token: EDITOR_TOKEN):BOOLEAN is
			-- is `a_token' a comment token ?
		local
			ct: EDITOR_TOKEN_COMMENT
		do
			ct ?= a_token
			Result := ct /= Void
		end

	is_blank (a_token: EDITOR_TOKEN):BOOLEAN is
			-- is `a_token' a blank token ?
		local
			bt: EDITOR_TOKEN_BLANK
		do
			bt ?= a_token
			Result := bt /= Void
		end

	is_string (a_token: EDITOR_TOKEN):BOOLEAN is
			-- is `a_token' a string token ?
		local
			st: EDITOR_TOKEN_STRING
		do
			st ?= a_token
			Result := st /= Void
		end

	is_eol(a_token: EDITOR_TOKEN):BOOLEAN is
			-- is `a_token' a end-of-line token ?
		local
			eolt: EDITOR_TOKEN_EOL
		do
			eolt ?= a_token
			Result := eolt /= Void
		end

	is_known_infix (token: EDITOR_TOKEN): BOOLEAN is
			-- is token a known binary operator ?
		do
			Result := token_image_is_in_array (token, binary_operators)
		end

	is_known_prefix (token: EDITOR_TOKEN): BOOLEAN is
			-- is token a known unary operator ?
		do
			Result := token_image_is_in_array (token, unary_operators)
		end

	token_image_is_same_as_word (token: EDITOR_TOKEN; word: STRING): BOOLEAN is
			-- Are the token image (except comments) and the word equal (case has no importance)?
		require
			word_not_void: word /= Void
		local
			image: STRING
			comment_token: EDITOR_TOKEN_COMMENT
		do
			if token /= Void then
				comment_token ?= token
				if comment_token = Void then
					image := token.image.as_lower
					Result := image.is_equal (word)
				end
			end
		end

	token_image_is_in_array (token: EDITOR_TOKEN; words: ARRAY[STRING]): BOOLEAN is
			-- Does the token image belong to the list `words' ?
		require
			word_not_void: words /= Void
		local
			image: STRING
			i: INTEGER
		do
			if token /= Void then
				image := token.image.as_lower
				from 
					i := words.lower
				until
					Result or else i > words.upper
				loop
					Result := image.is_equal (words @ i)
					i:= i + 1
				end
			end
		end

	is_beginning_of_expression (token: EDITOR_TOKEN): BOOLEAN is
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

	can_attempt_auto_complete_from_token (token: EDITOR_TOKEN): BOOLEAN is
			-- Is `token' of the correct type that we can attempt to build a feature or class
			-- autocompletion list?
		do
			Result := token /= Void	and not	is_comment (token) and not is_string (token)
				-- TODO: neilc.  I do not see why we should not allow complete in comments or strings, for user convenience.
		end

feature {NONE} -- Constants

	binary_operators: ARRAY [STRING] is 
		once
			Result := <<"@", "^", "*", "/", "//", "\\", "+", "-", "/=", "=", ">", ">=", "<", "<=", "and", "xor", "or", "implies">>
		end

	unary_operators: ARRAY [STRING] is 
		once
			Result := <<"+", "-", "not", "old">>
		end

	opening_separators: ARRAY [STRING] is
		once
			Result := <<":=", "?=", ";", ",","(">>
		end 

	opening_bracket: STRING is "["
	
	closing_bracket: STRING is "]"
	
	opening_brace: STRING is "{"
	
	closing_brace: STRING is "}"
	
	opening_parenthesis: STRING is "("
	
	closing_parenthesis: STRING is ")"
	
	semi_colon: STRING is ";"
	
	colon: STRING is ":"
	
	comma: STRING is ","
	
	period: STRING is "."
	
	equal_sign: STRING is "="
	
	different_sign: STRING is "/="
	
	feature_word: STRING is "feature" 
	
	end_word: STRING is "end"
	
	like_word: STRING is "like"
	
	is_word: STRING is "is"
	
	current_word: STRING is "current"
	
	local_word: STRING is "local"
	
	create_word: STRING is "create"
	
	result_word: STRING is "result"

	precursor_word: STRING is "precursor";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_TOKEN_TOOLKIT
