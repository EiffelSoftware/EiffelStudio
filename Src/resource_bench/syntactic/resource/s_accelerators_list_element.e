indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Accelerators_list_element -> event "," id_value More_accelerators

class S_ACCELERATORS_LIST_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ACCELERATORS_LIST_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			event: IDENTIFIER
			id_value: IDENTIFIER
			more: MORE_ACCELERATORS
		once
			!! Result.make
			Result.forth

			!! event.make
			put (event)

			keyword (",")

			!! id_value.make
			put (id_value)

			!! more.make
			put (more)
		end

end -- class S_ACCELERATORS_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
