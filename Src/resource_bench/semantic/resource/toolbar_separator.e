indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_separator -> "SEPARATOR"

class TOOLBAR_SEPARATOR

inherit
	S_TOOLBAR_SEPARATOR
		redefine 
			post_action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

creation
	make

feature 

	post_action is
		local
			toolbar: TDS_TOOLBAR
		do
			toolbar ?= tds.current_resource
			toolbar.insert_button (Void)
		end

end -- class TOOLBAR_SEPARATOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
