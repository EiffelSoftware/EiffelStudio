indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Strings_list -> Strings_list_element Strings_list |

class S_STRINGS_LIST

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
			Result := "STRINGS_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			element: STRINGS_LIST_ELEMENT
			list: STRINGS_LIST
		once
			!! Result.make
			Result.forth

			!! element.make
			put (element)

			!! list.make
			put (list)
		end

end -- class S_STRINGS_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
