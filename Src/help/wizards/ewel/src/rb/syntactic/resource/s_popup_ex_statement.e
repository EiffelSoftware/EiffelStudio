indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- PopUp_ex_statement -> "POPUP" text More_popup_ex_statement "BEGIN" Items_ex_list "END"

class S_POPUP_EX_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "POPUP_EX_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			text: IDENTIFIER
			more: MORE_POPUP_EX_STATEMENT
			begin1: BEGIN_BLOCK
			items_ex_list: ITEMS_EX_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("POPUP")
			commit

			!! text.make
			put (text)

			!! more.make
			put (more)

			!! begin1.make
			put (begin1)

			!! items_ex_list.make
			put (items_ex_list)

			!! end1.make
			put (end1)
		end

end -- class S_POPUP_EX_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
