indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Font_dialog_option -> "FONT" pointsize "," typeface  More_font_options

class FONT_DIALOG_OPTION

inherit
	S_FONT_DIALOG_OPTION
		redefine 
			pre_action, post_action
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
			tds.set_identifier_type (Option_font_size)
		end

	post_action is
		do  
			tds.set_identifier_type (Normal)
		end

end -- class FONT_DIALOG_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
