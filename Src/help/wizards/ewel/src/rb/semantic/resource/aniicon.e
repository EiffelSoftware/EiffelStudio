indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
--  Aniicon_resource -> "ANIICON" Load_and_mem filename

class ANIICON_RESOURCE

inherit
	S_ANIICON_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			aniicon: TDS_ANIICON

		do                
			!! aniicon.make
			aniicon.set_id (tds.last_token)
			tds.insert_resource (aniicon)

			tds.set_current_resource (aniicon)
		end

	post_action is
		local
			aniicon: TDS_ANIICON
		do
			aniicon ?= tds.current_resource
			aniicon.set_filename (tds.last_token)
		end

end -- class ANIICON_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
