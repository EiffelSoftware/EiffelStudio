indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Specific_statement -> specific_control_type id "," x "," y "," width "," height "," Optional_styles_list

class S_SPECIFIC_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "SPECIFIC_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			control_type: SPECIFIC_CONTROL_STATEMENT
			id: IDENTIFIER
			x: IDENTIFIER
			y: IDENTIFIER
			width: IDENTIFIER
			height: IDENTIFIER
			optional_styles: OPTIONAL_STYLES_LIST
		once
			!! Result.make
			Result.forth

			!! control_type.make
			put (control_type)

			!! id.make
			put (id)

			keyword (",")

			!! x.make
			put (x)

			keyword (",")

			!! y.make
			put (y)

			keyword (",")

			!! width.make
			put (width)

			keyword (",")

			!! height.make
			put (height)

			!! optional_styles.make
			put (optional_styles)
		end

end -- class S_SPECIFIC_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
