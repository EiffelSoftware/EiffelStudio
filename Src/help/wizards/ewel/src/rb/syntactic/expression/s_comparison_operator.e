indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- comparison_operator -> "=" | "<>" | "<" | ">" | "<=" | ">="

class S_COMPARISON_OPERATOR

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "COMPARISON_OPERATOR"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			equal_op: EQUAL_OP
			not_equal: NOT_EQUAL
			lt: LT
			gt: GT
			le: LE
			ge: GE
		once
			!! Result.make
			Result.forth
	
			!! equal_op.make
			put (equal_op)

			!! not_equal.make
			put (not_equal)

			!! lt.make
			put (lt)

			!! gt.make
			put (gt)

			!! le.make
			put (le)

			!! ge.make
			put (ge)
		end

end -- class S_COMPARISON_OPERATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
