indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Menuitem_normal_statement -> text "," result Options_list

class S_MENUITEM_NORMAL_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MENUITEM_NORMAL_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			text: IDENTIFIER
			result_ident: IDENTIFIER
			options: OPTIONS_LIST
		once
			!! Result.make
			Result.forth

			!! text.make
			put (text)

			keyword (",")

			!! result_ident.make
			put (result_ident)

			!! options.make
			put (options)
		end

end -- class S_MENUITEM_NORMAL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
