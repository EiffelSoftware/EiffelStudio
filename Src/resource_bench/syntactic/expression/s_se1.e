indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- se1 -> or_operator e1 se1

class S_SE1

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
			Result := "SE1"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			or_op: OR_OPERATOR
			e1: E1
			se1: SE1
		once
			!! Result.make
			Result.forth

			!! or_op.make
			put (or_op)

			!! e1.make
			put (e1)

			!! se1.make
			put (se1)
		end

end -- class S_SE1

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
