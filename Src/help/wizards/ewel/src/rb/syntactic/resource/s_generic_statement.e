indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Generic_statement -> "CONTROL" text "," id "," class "," Styles_list "," x "," y "," width
--			"," height Optional_extended_styles_list

class S_GENERIC_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "GENERIC_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			text: IDENTIFIER
			id: IDENTIFIER
			class_ident: IDENTIFIER
			Styles_list: STYLES_LIST
			x: IDENTIFIER
			y: IDENTIFIER
			width: IDENTIFIER
			height: IDENTIFIER
			optional: OPTIONAL_EXTENDED_STYLES_LIST
		once
			!! Result.make
			Result.forth

			keyword ("CONTROL")
			commit

			!! text.make
			put (text)

			keyword (",")

			!! id.make
			put (id)

			keyword (",")

			!! class_ident.make
			put (class_ident)

			keyword (",")

			!! Styles_list.make
			put (Styles_list)

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
	
			!! optional.make
			put (optional)
		end

end -- class S_GENERIC_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
