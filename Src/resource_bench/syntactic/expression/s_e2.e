indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- e2 -> e3 se3

class S_E2

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "E2"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			e3: E3
			se3:SE3
		once
			!! Result.make
			Result.forth

			!! e3.make
			put (e3)

			!! se3.make
			put (se3)
		end

end -- class S_E2

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
