indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Item -> MenuItem_statement | PopUp_statement

class S_ITEM 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "ITEM"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			menuitem: MENUITEM_STATEMENT
			popup: POPUP_STATEMENT
		once
			!! Result.make
			Result.forth

			!! menuitem.make
			put (menuitem)

			!! popup.make
			put (popup)
		end

end -- class S_ITEM

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
