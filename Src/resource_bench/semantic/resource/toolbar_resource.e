indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Toolbar_resource -> "TOOLBAR" Toolbar_options "BEGIN" Toolbar_list "END"

class TOOLBAR_RESOURCE

inherit
	S_TOOLBAR_RESOURCE
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature

	pre_action is
		local
			toolbar: TDS_TOOLBAR
		do     
			!! toolbar.make
			toolbar.set_id (tds.last_token)

			tds.insert_resource (toolbar)
                        tds.set_current_resource (toolbar)
		end

end -- class TOOLBAR_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
