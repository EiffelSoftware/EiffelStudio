indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Font_dialog_option -> "FONT" pointsize "," typeface More_font_options

class S_FONT_DIALOG_OPTION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FONT_DIALOG_OPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			pointsize: IDENTIFIER
			typeface: IDENTIFIER
			more: MORE_FONT_OPTIONS
		once
			!! Result.make
			Result.forth

			keyword ("FONT")
			commit

			!! pointsize.make
			put (pointsize)

			keyword (",")

			!! typeface.make
			put (typeface)

			!! more.make
			put (more)
		end

end -- class S_FONT_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
