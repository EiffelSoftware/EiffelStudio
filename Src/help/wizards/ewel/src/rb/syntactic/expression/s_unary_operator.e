indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- unary_operator -> "~" | "-"

class S_UNARY_OPERATOR

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "UNARY_OPERATOR"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			minus: MINUS
			unary_not: UNARY_NOT
		once
			!! Result.make
			Result.forth
	
			!! minus.make
			put (minus)
			
			!! unary_not.make
			put (unary_not)
		end

end -- class S_UNARY_OPERATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
