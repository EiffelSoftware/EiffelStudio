indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_accelerators -> More_accelerators_element More_accelerators | 

class S_MORE_ACCELERATORS

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
			Result := "MORE_ACCELERATORS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			element: MORE_ACCELERATORS_ELEMENT
			list: MORE_ACCELERATORS
		once
			!! Result.make
			Result.forth

			!! element.make
			put (element)
			
			!! list.make
			put (list)
		end

end -- class S_MORE_ACCELERATORS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
