indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_accelerators_element -> "," identfier

class S_MORE_ACCELERATORS_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MORE_ACCELERATORS_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword (",")

			!! identifier.make
			put (identifier)
		end

end -- class S_MORE_ACCELERATORS_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
