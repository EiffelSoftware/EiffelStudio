indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_icon_description -> "," width "," height "," Styles_list Optional_extended_styles_list

class S_MORE_ICON_DESCRIPTION

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
			Result := "MORE_ICON_DESCRIPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			width: IDENTIFIER
			height: IDENTIFIER
			optional: OPTIONAL_STYLES_LIST
		once
			!! Result.make
			Result.forth

			keyword (",")
			commit

			!! width.make
			put (width)

			keyword (",")

			!! height.make
			put (height)

			!! optional.make
			put (optional)
		end

end -- class S_MORE_ICON_DESCRIPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
