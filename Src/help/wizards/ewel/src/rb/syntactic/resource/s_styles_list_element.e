indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Styles_list_element -> "OR" style

class S_STYLES_LIST_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STYLES_LIST_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			operator: OR_OPERATOR
			style: STYLE
		once
			!! Result.make
			Result.forth

			!! operator.make
			put (operator)

			!! style.make
			put (style)
		end

end -- class S_STYLES_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
