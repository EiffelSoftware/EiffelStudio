indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Font_resource -> "FONT" Load_and_mem filename

class FONT_RESOURCE

inherit
	S_FONT_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			font: TDS_FONT
		do     
			!! font.make
			font.set_id (tds.last_token)
			tds.insert_resource (font)

			tds.set_current_resource (font)
		end

	post_action is
		local
			font: TDS_FONT
		do
			font ?= tds.current_resource
			font.set_filename (tds.last_token)
		end

end -- class FONT_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
