indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Unary_expression -> Unary_operator e5

class S_UNARY_EXPRESSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "UNARY_EXPRESSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			unary_operator: UNARY_OPERATOR
			e5: E5
		once
			!! Result.make
			Result.forth

			!! unary_operator.make
			put (unary_operator)

			!! e5.make
			put (e5)
		end

end -- class S_UNARY_EXPRESSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
