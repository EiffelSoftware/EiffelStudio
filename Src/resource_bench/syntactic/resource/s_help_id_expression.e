indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Help_id_expression -> "," Expression

class S_HELP_ID_EXPRESSION

inherit
	RB_AGGREGATE
		rename
			make as old_make
		end

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "HELP_ID_EXPRESSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			expression: EXPRESSION
		once
			!! Result.make
			Result.forth

			keyword (",")
			commit

			!! expression.make
			put (expression)
		end

end -- class S_HELP_ID_EXPRESSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
