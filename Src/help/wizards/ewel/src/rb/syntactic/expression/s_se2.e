indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- se2 -> and_operator e2 se2

class S_SE2

inherit
	RB_AGGREGATE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "SE2"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			and_op: AND_OPERATOR
			e2: E2
			se2: SE2
		once
			!! Result.make
			Result.forth

			!! and_op.make
			put (and_op)

			!! e2.make
			put (e2)

			!! se2.make
			put (se2)
		end

end -- class S_SE2

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
