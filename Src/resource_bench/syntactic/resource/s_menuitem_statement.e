indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- MenuItem_statement -> "MENUITEM" More_menuitem_statement

class S_MENUITEM_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MENUITEM_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			more: MORE_MENUITEM_STATEMENT
		once
			!! Result.make
			Result.forth

			keyword ("MENUITEM")
			commit

			!! more.make
			put (more)
		end

end -- class S_MENUITEM_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
