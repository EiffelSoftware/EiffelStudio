indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Icon_resource -> "ICON" Load_and_mem filename

class ICON_RESOURCE

inherit
	S_ICON_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			icon: TDS_ICON
		do     
			!! icon.make
			icon.set_id (tds.last_token)
			tds.insert_resource (icon)

			tds.set_current_resource (icon)
		end

	post_action is
		local
			icon: TDS_ICON
		do
			icon ?= tds.current_resource
			icon.set_filename (tds.last_token)
		end

end -- class ICON_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
