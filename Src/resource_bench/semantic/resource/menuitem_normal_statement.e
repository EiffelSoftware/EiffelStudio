indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Menuitem_normal_statement -> text "," result Options_list

class MENUITEM_NORMAL_STATEMENT

inherit
	S_MENUITEM_NORMAL_STATEMENT
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

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
                				
			menu.insert_item (the_item)
			menu.set_current_item (the_item)

			tds.set_identifier_type (Menu_text)
		end

	post_action is
		do
			tds.set_identifier_type (Normal)
		end

end -- class MENUITEM_NORMAL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
