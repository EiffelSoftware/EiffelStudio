indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Else_part -> "#else" Instructions_list

class S_ELSE_PART

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ELSE_PART"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			instructions_list: INSTRUCTIONS_LIST
		once
			!! Result.make
			Result.forth

			keyword ("#else")
			commit

			!! instructions_list.make
			put (instructions_list)
		end

end -- class S_ELSE_PART

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
