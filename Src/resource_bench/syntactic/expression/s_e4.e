indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- e4 -> e5 se5

class S_E4

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "E4"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			e5: E5
			se5:SE5
		once
			!! Result.make
			Result.forth

			!! e5.make
			put (e5)

			!! se5.make
			put (se5)
		end

end -- class S_E4

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
