indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- se5 -> multiplication_operator e5 se5

class S_SE5

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
			Result := "SE5"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			multiplication: MULTIPLICATION_OPERATOR
			e5: E5
			se5: SE5
		once
			!! Result.make
			Result.forth

			!! multiplication.make
			put (multiplication)

			!! e5.make
			put (e5)

			!! se5.make
			put (se5)
		end

end -- class S_SE5

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
