indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- e1 -> e2 se2

class S_E1

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "E1"
		end


	production: LINKED_LIST [CONSTRUCT] is
		local
			e2: E2
			se2:SE2
		once
			!! Result.make
			Result.forth

			!! e2.make
			put (e2)

			!! se2.make
			put (se2)
		end

end -- class S_E1

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
