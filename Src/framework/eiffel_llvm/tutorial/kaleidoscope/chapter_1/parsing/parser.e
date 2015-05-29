note
	description: "Parser for Kaleidoscope language."
	date: "$Date$"
	revision: "$Revision$"

class
	PARSER

inherit
	LEXER
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			create binary_operator_precedence.make (10)
			binary_operator_precedence.put (10, '<')
			binary_operator_precedence.put (20, '+')
			binary_operator_precedence.put (20, '-')
			binary_operator_precedence.put (40, '*')
		end

feature {NONE} -- Implementation

	binary_operator_precedence: HASH_TABLE [INTEGER, CHARACTER]
			-- Precedence of binary operator. The highest value correspond
			-- to a more binding operator.

	token_precedence (a_token: INTEGER): INTEGER
			-- Token precedence if it is a binary operator, otherwise -1.
		do
			if last_token.is_valid_character_8_code and then binary_operator_precedence.has (last_token.to_character_8) then
				Result := binary_operator_precedence.item (last_token.to_character_8)
			else
				Result := -1
			end
		end

	report_error (a_error: STRING)
			-- Report `a_error' on standard error.
		do
			io.error.put_string ("Error: " + a_error + "%N")
		end
	
end
