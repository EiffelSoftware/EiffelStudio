indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Even_more_popup_ex -> Type_expression State_and_helpID_expressions

class S_EVEN_MORE_POPUP_EX

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EVEN_MORE_POPUP_EX"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			type: TYPE_EXPRESSION
			state_and_helpId: STATE_AND_HELPID_EXPRESSIONS
		once
			!! Result.make
			Result.forth

			!! type.make
			put (type)

			!! state_and_helpId.make
			put (state_and_helpId)
		end

end -- class S_EVEN_MORE_POPUP_EX

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
