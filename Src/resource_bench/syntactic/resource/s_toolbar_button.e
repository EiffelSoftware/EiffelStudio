indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_button -> "BUTTON" id_value

class S_TOOLBAR_BUTTON

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "TOOLBAR_BUTTON"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			id_value: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("BUTTON")

			!! id_value.make
			put (id_value)
		end

end -- class S_TOOLBAR_BUTTON

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
