indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Exstyle_dialog_option -> "EXSTYLE=" Extended_styles_list

class S_EXSTYLE_DIALOG_OPTION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "EXSTYLE_DIALOG_OPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			Extended_styles_list: EXTENDED_STYLES_LIST
		once
			!! Result.make
			Result.forth

			keyword ("EXSTYLE=")
			commit

			!! Extended_styles_list.make
			put (Extended_styles_list)
		end

end -- class S_EXSTYLE_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
