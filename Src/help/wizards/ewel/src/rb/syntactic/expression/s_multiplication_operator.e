indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- multiplication_operator -> "*" | "/"

class S_MULTIPLICATION_OPERATOR

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "MULTIPLICATION_OPERATOR"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			mult: MULT
			div: DIV
		once
			!! Result.make
			Result.forth
			
			!! mult.make
			put (mult)
	
			!! div.make
			put (div)
		end

end -- class S_MULTIPLICATION_OPERATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
