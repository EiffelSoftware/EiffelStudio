indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Styles_list -> style Normal_styles_list

class STYLES_LIST

inherit
	S_STYLES_LIST
		redefine 
			post_action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

	TDS_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy
		end

creation
	make

feature 

	post_action is
		do    
			if (tds.identifier_type = Generic_control_style) then
				tds.set_identifier_type (Generic_control_x)
			end
		end

end -- class STYLES_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
