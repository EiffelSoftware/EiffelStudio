indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Styles_list -> style Normal_styles_list

class S_STYLES_LIST

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
			Result := "STYLES_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			style: STYLE
			list: NORMAL_STYLES_LIST
		once
			!! Result.make
			Result.forth

			!! style.make
			put (style)

			!! list.make
			put (list)
		end

end -- class S_STYLES_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
