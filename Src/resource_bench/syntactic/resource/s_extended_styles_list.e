indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Extended_tyles_list -> extended_style Normal_extended_styles_list

class S_EXTENDED_STYLES_LIST

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
			Result := "EXTENDED_STYLES_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			extended_style: EXTENDED_STYLE
			list: NORMAL_EXTENDED_STYLES_LIST
		once
			!! Result.make
			Result.forth
			
			!! extended_style.make
			put (extended_style)

			!! list.make
			put (list)
		end

end -- class S_EXTENDED_STYLES_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
