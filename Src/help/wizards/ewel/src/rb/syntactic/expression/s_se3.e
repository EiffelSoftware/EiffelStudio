indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- se3 -> comparison_operator e3 se3

class S_SE3

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
			Result := "SE3"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			comparison: COMPARISON_OPERATOR
			e3: E3
			se3: SE3
		once
			!! Result.make
			Result.forth

			!! comparison.make
			put (comparison)

			!! e3.make
			put (e3)

			!! se3.make
			put (se3)
		end

end -- class S_SE3

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
