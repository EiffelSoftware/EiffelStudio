indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- MenuEx_resource -> "MENUEX" "BEGIN" ItemsEx_list "END"

class S_MENUEX_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MENUEX_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			begin1: BEGIN_BLOCK
			list: ITEMS_EX_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("MENUEX")
			commit

			!! begin1.make
			put (begin1)

			!! list.make
			put (list)

			!! end1.make
			put (end1)
		end

end -- class S_MENUEX_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
