indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Extended_style -> [Unary_not] extended_style

class S_EXTENDED_STYLE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EXTENDED_STYLE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			unary_not: UNARY_NOT
			extended_style: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! unary_not.make
			put (unary_not)
			unary_not.set_optional
			
			!! extended_style.make
			put (extended_style)
		end

end -- class S_EXTENDED_STYLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
