indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Style -> [Unary_not] style

class S_STYLE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STYLE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			unary_not: UNARY_NOT
			style: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! unary_not.make
			put (unary_not)
			unary_not.set_optional

			!! style.make
			put (style)
		end

end -- class S_STYLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
