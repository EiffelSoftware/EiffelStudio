indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Even_more_menuitem_ex -> Type_expression State_expression

class S_EVEN_MORE_MENUITEM_EX

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EVEN_MORE_MENUITEM_EX"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			type: TYPE_EXPRESSION
			state: STATE_EXPRESSION
		once
			!! Result.make
			Result.forth
			
			!! type.make
			put (type)

			!! state.make
			put (state)
		end

end -- class S_EVEN_MORE_MENUITEM_EX

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
