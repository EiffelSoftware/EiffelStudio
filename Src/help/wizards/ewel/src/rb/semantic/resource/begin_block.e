indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- begin -> "BEGIN" | "{"

class BEGIN_BLOCK

inherit
	S_BEGIN_BLOCK
		redefine
			action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature

	action is
		local
			resource_menu: TDS_MENU
			menu: TDS_MENU
		do
			resource_menu ?= tds.current_resource

			if (resource_menu /= Void) and then (resource_menu.is_popup) then
				!! menu.make

				resource_menu.current_menu.item.current_item.set_popup_menu (menu)	
				resource_menu.current_menu.extend (menu)
                        
				resource_menu.set_is_popup (false)
				tds.set_identifier_type (Normal)
			end
		end

end -- class BEGIN_BLOCK

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
