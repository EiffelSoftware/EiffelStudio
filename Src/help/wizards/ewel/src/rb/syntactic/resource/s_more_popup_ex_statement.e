indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_popup_ex_statement -> Id_expression Even_more_popup_ex

class S_MORE_POPUP_EX_STATEMENT

inherit
	RB_AGGREGATE
		rename
			make as old_make
		end

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "MORE_POPUP_EX_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			id: ID_EXPRESSION
			more: EVEN_MORE_POPUP_EX
		once
			!! Result.make
			Result.forth

			!! id.make
			put (id)

			!! more.make
			put (more)
		end

end -- class S_MORE_POPUP_EX_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
