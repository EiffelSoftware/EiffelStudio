indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- se4 -> addition_operator e4 se4

class S_SE4

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
			Result := "SE4"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			addition: ADDITION_OPERATOR
			e4: E4
			se4: SE4
		once
			!! Result.make
			Result.forth

			!! addition.make
			put (addition)

			!! e4.make
			put (e4)

			!! se4.make
			put (se4)
		end

end -- class S_SE4

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
