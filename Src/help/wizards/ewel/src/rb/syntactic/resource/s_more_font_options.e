indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_font_options -> "," weight "," italic

class S_MORE_FONT_OPTIONS

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
			Result := "MORE_FONT_OPTIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			weight: IDENTIFIER
			italic: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword (",")
			commit

			!! weight.make
			put (weight)

			keyword (",")

			!! italic.make
			put (italic)
		end

end -- class S_MORE_FONT_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
