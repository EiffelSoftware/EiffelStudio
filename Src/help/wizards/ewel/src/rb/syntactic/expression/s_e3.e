indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- e3 -> e4 se4

class S_E3

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "E3"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			e4: E4
			se4:SE4
		once
			!! Result.make
			Result.forth

			!! e4.make
			put (e4)

			!! se4.make
			put (se4)
		end

end -- class S_E3

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
