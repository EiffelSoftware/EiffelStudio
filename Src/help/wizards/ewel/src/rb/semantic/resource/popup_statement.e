indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- PopUp_statement -> "POPUP" text Options_list "BEGIN" Items_list "END"

class POPUP_STATEMENT

inherit
	S_POPUP_STATEMENT
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
			resource_menu: TDS_MENU
			menu_item: TDS_MENU_ITEM
		do         
			!! menu_item.make

			resource_menu ?= tds.current_resource
			resource_menu.set_is_popup (true)
			
			resource_menu := resource_menu.current_menu.item

			resource_menu.insert_item (menu_item)
			resource_menu.set_current_item (menu_item)

			tds.set_identifier_type (Menu_text)
		end

	post_action is
		local
			resource_menu: TDS_MENU
		do
			resource_menu ?= tds.current_resource
			resource_menu.current_menu.remove
		end

end -- class POPUP_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
