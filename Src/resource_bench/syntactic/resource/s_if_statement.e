indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- If_statement -> "#if" Boolean_expression Instructions_list Second_part "#endif"

class S_IF_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "IF_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			boolean_expression: BOOLEAN_EXPRESSION
			instructions_list: INSTRUCTIONS_LIST
			second_part: SECOND_PART
		once
			!! Result.make
			Result.forth

			keyword ("#if")
			commit

			!! boolean_expression.make
			put (boolean_expression)

			!! instructions_list.make
			put (instructions_list)

			!! second_part.make
			put (second_part)

			keyword ("#endif")
		end

end -- class S_IF_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
