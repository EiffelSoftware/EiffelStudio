indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- PopUp_statement -> "POPUP" text Options_list "BEGIN" Items_list "END"

class S_POPUP_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "POPUP_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			text: IDENTIFIER
			options: OPTIONS_LIST
			begin1: BEGIN_BLOCK
			items_list: ITEMS_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("POPUP")
			commit

			!! text.make
			put (text)

			!! options.make
			put (options)

			!! begin1.make
			put (begin1)

			!! items_list.make
			put (items_list)

			!! end1.make
			put (end1)
		end

end -- class S_POPUP_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
