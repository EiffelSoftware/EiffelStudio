indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Dlginit_data_list -> Dlginit_data_element Dlginit_data_list

class S_DLGINIT_DATA_LIST

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
			Result := "DLGINIT_DATA_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			element: DLGINIT_DATA_ELEMENT
			list: DLGINIT_DATA_LIST
		once
			!! Result.make
			Result.forth

			!! element.make
			put (element)

			!! list.make
			put (list)
		end

end -- class S_DLGINIT_DATA_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
