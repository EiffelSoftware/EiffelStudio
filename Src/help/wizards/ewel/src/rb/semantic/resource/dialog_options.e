indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Dialog_options -> Load_and_mem "," x "," y "," width "," height General_options_list
--		     More_dialog_options_list

class DIALOG_OPTIONS

inherit
	S_DIALOG_OPTIONS
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
			tds.set_identifier_type (Dialog_x)
		end

end -- class DIALOG_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
