indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Style_dialog_option -> "STYLE" Styles_list

class S_STYLE_DIALOG_OPTION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STYLE_DIALOG_OPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			Styles_list: STYLES_LIST
		once
			!! Result.make
			Result.forth

			keyword ("STYLE")
			commit

			!! Styles_list.make
			put (Styles_list)
		end

end -- class S_STYLE_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
