indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Extended_style -> [Unary_not] extended_style

class EXTENDED_STYLE

inherit
	S_EXTENDED_STYLE
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			style: TDS_STYLE
		do                
			!! style.make

			tds.set_style (style)
		end

end -- class EXTENDED_STYLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
