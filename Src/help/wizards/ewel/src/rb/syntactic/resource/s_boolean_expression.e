indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Boolean_expression -> Expression

class S_BOOLEAN_EXPRESSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "BOOLEAN_EXPRESSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			expression: EXPRESSION
		once
			!!Result.make
			Result.forth
			
			!! expression.make
			put (expression)
		end

end -- class S_BOOLEAN_EXPRESSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
