indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Icon_statement -> "ICON" text "," id "," x "," y "," More_icon_description

class ICON_STATEMENT

inherit
	S_ICON_STATEMENT
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
		local
			icon: TDS_ICON_STATEMENT
			dialog: TDS_DIALOG
		do     
			!! icon.make
			icon.set_wel_code (true)

			dialog ?= tds.current_resource
			dialog.set_current_control (icon)

			tds.set_identifier_type (Control_text)
		end

	post_action is
		do
			tds.set_identifier_type (Normal)
		end

end -- class ICON_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
