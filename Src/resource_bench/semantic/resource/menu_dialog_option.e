indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Menu_dialog_option -> "MENU" menuname

class MENU_DIALOG_OPTION

inherit
	S_MENU_DIALOG_OPTION
		redefine 
			pre_action, post_action
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
	
	pre_action is
		do  
			tds.set_identifier_type (Option_menu)
		end

	post_action is
		do  
			tds.set_identifier_type (Normal)
		end

end -- class MENU_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
