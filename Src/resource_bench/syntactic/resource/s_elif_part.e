indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Elif_part -> "#else" Boolean_expression Instructions_list Second_part

class S_ELIF_PART

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ELIF_PART"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			expression: BOOLEAN_EXPRESSION
			instructions_list: INSTRUCTIONS_LIST
			second_part: SECOND_PART
		once
			!! Result.make
			Result.forth

			keyword ("#elif")
			commit

			!! expression.make
			put (expression)

			!! instructions_list.make
			put (instructions_list)

			!! second_part.make
			put (second_part)
		end

end -- class S_ELIF_PART

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
