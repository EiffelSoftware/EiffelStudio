indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Toolbar_options -> Load_and_mem  width "," height General_options_list

class
	TOOLBAR_OPTIONS

inherit
	S_TOOLBAR_OPTIONS
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature 

	pre_action is
		do                
			tds.set_identifier_type (Toolbar_width)
		end

end -- class TOOLBAR_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
