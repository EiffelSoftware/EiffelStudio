indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Menuitem_separator_statement -> "SEPARATOR"

class MENUITEM_SEPARATOR_STATEMENT

inherit
	S_MENUITEM_SEPARATOR_STATEMENT
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			the_item: TDS_MENU_ITEM
			menu: TDS_MENU

		do
			menu ?= tds.current_resource
			menu := menu.current_menu.item

			!! the_item.make
			the_item.set_separator
                				
			menu.insert_item (the_item)
			menu.set_current_item (the_item)
		end

end -- class MENUITEM_SEPARATOR_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
