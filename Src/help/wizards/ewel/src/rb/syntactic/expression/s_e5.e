indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- e5 -> Unary_expression | Sub_expression | Defined_test | identifier

class S_E5

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "E5"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			unary_expression: UNARY_EXPRESSION
			sub_expression: SUB_EXPRESSION
			defined_test: DEFINED_TEST
			identifier: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! unary_expression.make
			put (unary_expression)

			!! sub_expression.make
			put (sub_expression)

			!! defined_test.make
			put (defined_test)

			!! identifier.make
			put (identifier)
		end

end -- class S_E5

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
