indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Extended_styles_list_element -> "OR" extended_style

class S_EXTENDED_STYLES_LIST_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EXTENDED_STYLES_LIST_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			operator: OR_OPERATOR
			extended_style: EXTENDED_STYLE
		once
			!! Result.make
			Result.forth

			!! operator.make
			put (operator)

			!! extended_style.make
			put (extended_style)
		end

end -- class S_EXTENDED_STYLES_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
