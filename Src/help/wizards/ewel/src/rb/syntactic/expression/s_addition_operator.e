indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- addition_operator -> "+" | "-"

class S_ADDITION_OPERATOR

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "ADDITION_OPERATOR"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			add: ADD
			minus: MINUS
		once
			!! Result.make
			Result.forth
			
			!! add.make
			put (add)

			!! minus.make
			put (minus)
		end

end -- class S_ADDITION_OPERATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
