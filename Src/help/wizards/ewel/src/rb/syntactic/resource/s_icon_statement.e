indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Icon_statement -> "ICON" text "," id "," x "," y "," More_icon_description

class S_ICON_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ICON_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			text: IDENTIFIER
			id: IDENTIFIER
			x: IDENTIFIER
			y: IDENTIFIER
			more: MORE_ICON_DESCRIPTION
		once
			!! Result.make
			Result.forth

			keyword ("ICON")
			commit

			!! text.make
			put (text)

			keyword (",")

			!! id.make
			put (id)

			keyword (",")

			!! x.make
			put (x)
			
			keyword (",")

			!! y.make
			put (y)
			
			!! more.make
			put (more)
		end

end -- class S_ICON_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
