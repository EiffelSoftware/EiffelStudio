indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Items_list -> Item Items_list | 

class S_ITEMS_LIST

inherit
	RB_AGGREGATE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "ITEMS_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			menu_item: ITEM
			list: ITEMS_LIST
		once
			!! Result.make
			Result.forth

			!! menu_item.make
			put (menu_item)

			!! list.make
			put (list)
		end

end -- class S_ITEMS_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
