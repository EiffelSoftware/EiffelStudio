indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_menuitem_statement -> Menuitem_normal_statement | Menuitem_separator_statement

class S_MORE_MENUITEM_STATEMENT 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "MORE_MENUITEM_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			normal: MENUITEM_NORMAL_STATEMENT
			separator: MENUITEM_SEPARATOR_STATEMENT
		once
			!! Result.make
			Result.forth

			!! normal.make
			put (normal)
			
			!! separator.make
			put (separator)
		end

end -- class S_MORE_MENUITEM_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
