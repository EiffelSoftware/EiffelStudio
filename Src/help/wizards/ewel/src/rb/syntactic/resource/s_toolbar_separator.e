indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_separator -> "SEPARATOR"

class S_TOOLBAR_SEPARATOR

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "TOOLBAR_SEPARATOR"
		end

	production: LINKED_LIST [CONSTRUCT] is
		once
			!! Result.make
			Result.forth

			keyword ("SEPARATOR")
		end

end -- class S_TOOLBAR_SEPARATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
