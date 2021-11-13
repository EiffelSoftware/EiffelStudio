note
	description: "Checks whether a string contains a valid Eiffel type."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_TYPE_NAME_SYNTAX_CHECKER

inherit
	SYNTAX_STRINGS
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create {STRING_32} current_parsed_string.make_empty
		end

feature -- Status report

	is_valid_class_type_name (a_class_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_class_type' a valid class type?
			-- according to ECMA-367 Section 8.11.1
		require
			class_type_not_void: a_class_type /= Void
		do
			current_position_in_input := 1
			current_parsed_string := a_class_type
			current_token := tkn_start
			consume_start
				-- Ensures that there is not more token after the end of input
				-- and that there were no errors (i.e. current_token /= tkn_error).
			Result := is_end_of_input and current_token = tkn_empty
		end

feature {NONE} -- Implementation of is_valid_class_type

-- This simple grammar is used to build a recursive descent parser
--	S -> Type
--  Type -> Id Generics
--	Gnerics -> '[' Type TypeList
--	Generics -> empty
--	TypeList -> ']'
--	TypeList -> ',' Type TypeList

	consume_start
			-- Start parsing
		do
			-- Set current_charachter manually to a start symbol
			current_character := 'S'
			consume_current_character
			consume_current_token
			consume_type
		end

	consume_type
			-- Consume a type
		do
			if current_token = tkn_id then
				consume_current_token
				consume_generics
			else
				current_token := tkn_error
			end
		end

	consume_generics
			-- Consume generics
		do
			if current_token = tkn_left_bracket then
				consume_current_token
				consume_type
				consume_type_list
			else
				-- ok, no generics
			end
		end

	consume_type_list
			-- Consume a type list
		do
			if current_token = tkn_right_bracket then
				consume_current_token
			elseif current_token = tkn_comma then
				consume_current_token
				consume_type
				consume_type_list
			else
				current_token := tkn_error
			end
		end

-- Tokens: 'Id'  '['  ']'  ','  'empty' and error

	tkn_start: INTEGER = 1
	tkn_id: INTEGER = 2
	tkn_left_bracket: INTEGER = 3
	tkn_right_bracket: INTEGER = 4
	tkn_comma: INTEGER = 5
	tkn_empty: INTEGER = 6
	tkn_error: INTEGER = 7

	-- THIS IS NOT MT SAVE
	current_position_in_input: INTEGER
		-- remembers the current position in the string (lexer state)

	current_parsed_string: READABLE_STRING_GENERAL
		-- The string for the lexer.

	current_token: INTEGER
		-- States the current token.

	is_end_of_input: BOOLEAN
			-- Is all the input consumed?
		do
			Result := current_position_in_input >  current_parsed_string.count
		end

	current_character: CHARACTER_32
			-- Current character used by the the lexer.
			-- require: not is_eof

	eof: CHARACTER = '%/0/'
			-- Denotes End Of File.

	is_eof: BOOLEAN
			-- Is end of input reached?
		do
			Result := current_character = eof
		end

	consume_current_character
			-- Consume current character.
		require
			not_eof: current_character /= eof
		do
			if is_end_of_input then
				current_character := eof
			else
				current_character := current_parsed_string.item (current_position_in_input)
				current_position_in_input := current_position_in_input + 1
			end
		end

	consume_current_token
			-- Consume the current token.
		local
			l_consumed_token: STRING_32
		do
			if current_token /= tkn_error then

				-- first consume white space
				from
				until
					not current_character.is_space or is_eof
				loop
					consume_current_character
				end

				if not is_eof then

					inspect current_character
					when  '[' then
						current_token := tkn_left_bracket
						consume_current_character
					when  ']' then
						current_token := tkn_right_bracket
						consume_current_character
					when  ',' then
						current_token := tkn_comma
						consume_current_character
					else
						if current_character.is_alpha then
							-- ok, eat one...
							current_token := tkn_id
							-- consume as much character as you can	
							from
								create l_consumed_token.make (20)
							until
								is_eof or not (current_character.is_alpha_numeric or (current_character = '_'))
							loop
								l_consumed_token.append_character (current_character)
								consume_current_character
							end
								-- Error when get a keyword token.
							if keywords.has (l_consumed_token) then
								current_token := tkn_error
							end
						else
							current_token := tkn_error
						end
					end
				else
					current_token := tkn_empty
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
