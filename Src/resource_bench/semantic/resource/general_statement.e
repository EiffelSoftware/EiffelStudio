indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- General_statement -> control_type text "," id "," x "," y "," width "," height "," Optional_styles_list

class GENERAL_STATEMENT

inherit
	S_GENERAL_STATEMENT
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
			tds.set_identifier_type (Control_type)
		end

	post_action is
		do     
			tds.set_identifier_type (Normal)
		end

end -- class GENERAL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
