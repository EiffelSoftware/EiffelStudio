indexing
        description: "Lexical constants that define the token type"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	LEX_CONSTANTS

feature -- Constants

	Identifier, Precompile_directives, Special_identifier,
	Integer_ident, Blanks, Ponctuation, Attributes,
	Specific_control_statement, Parenthesis,
	Begin_block, End_block, Or_op, And_op,
	Equal_op, Not_equal, Lt, Gt, Le, Ge,
	Add, Minus_op, Mult, Div, Unary_Not,
	Nothing: INTEGER is unique

end -- class LEX_CONSTANTS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
