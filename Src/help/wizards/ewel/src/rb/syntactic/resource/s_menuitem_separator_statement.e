indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Menuitem_separator_statement -> "SEPARATOR"

class S_MENUITEM_SEPARATOR_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MENUITEM_SEPARATOR_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		once
			!! Result.make
			Result.forth

			keyword ("SEPARATOR")
			commit
		end

end -- class S_MENUITEM_SEPARATOR_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
