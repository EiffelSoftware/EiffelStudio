indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Menu_dialog_option -> "MENU" menuname

class S_MENU_DIALOG_OPTION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MENU_DIALOG_OPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			menuname: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("MENU")
			commit

			!! menuname.make
			put (menuname)
		end

end -- class S_MENU_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
