indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Menu_resource -> "MENU" Menu_options "BEGIN" Items_list "END"

class MENU_RESOURCE

inherit
	S_MENU_RESOURCE
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			menu: TDS_MENU
		do     
			!! menu.make
			menu.set_id (tds.last_token)
			tds.insert_resource (menu)

			tds.set_current_resource (menu)

			menu.make_current_menu
			menu.current_menu.extend (menu)
		end

end -- class MENU_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
