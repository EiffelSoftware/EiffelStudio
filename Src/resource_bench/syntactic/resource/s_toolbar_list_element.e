indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_list_element -> Toolbar_button | Toolbar_separator

class S_TOOLBAR_LIST_ELEMENT

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "TOOLBAR_LIST_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			button: TOOLBAR_BUTTON
			separator: TOOLBAR_SEPARATOR
		once
			!! Result.make
			Result.forth

			!! button.make
			put (button)

			!! separator.make
			put (separator)
		end

end -- class S_TOOLBAR_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
