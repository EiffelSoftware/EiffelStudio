indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- expression -> e1 se1

class S_EXPRESSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EXPRESSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			e1: E1
			se1: SE1
		once
			!! Result.make
			Result.forth

			!! e1.make
			put (e1)

			!! se1.make
			put (se1)
		end

end -- class S_EXPRESSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
