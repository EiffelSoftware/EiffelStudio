indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_button -> "BUTTON" id_value

class TOOLBAR_BUTTON

inherit
	S_TOOLBAR_BUTTON
		redefine 
			post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	post_action is
		local
			toolbar: TDS_TOOLBAR
			id: TDS_ID
		do
			toolbar ?= tds.current_resource

			!! id
			id.set_id (tds.last_token)

			toolbar.insert_button (id)
		end

end -- class TOOLBAR_BUTTON

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
