indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- State_and_helpID_expressions -> State_expression HelpID_expression

class S_STATE_AND_HELPID_EXPRESSIONS

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STATE_AND_HELPID_EXPRESSIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			state: STATE_EXPRESSION
			helpID: HELP_ID_EXPRESSION
		once
			!! Result.make
			Result.forth

			!! state.make
			put (state)

			!! helpID.make
			put (helpID)
		end

end -- class S_STATE_AND_HELPID_EXPRESSIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
