indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Cursor_resource -> "CURSOR" Load_and_mem filename

class CURSOR_RESOURCE

inherit
	S_CURSOR_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			cursor: TDS_CURSOR

		do     
			!! cursor.make
			cursor.set_id (tds.last_token)
			tds.insert_resource (cursor)

			tds.set_current_resource (cursor)
		end

	post_action is
		local
			cursor: TDS_CURSOR
		do
			cursor ?= tds.current_resource
			cursor.set_filename (tds.last_token)
		end

end -- class CURSOR_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
