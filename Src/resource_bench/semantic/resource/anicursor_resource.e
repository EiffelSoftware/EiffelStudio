indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
--  Anicursor_resource -> "ANICURSOR" Load_and_mem filename

class ANICURSOR_RESOURCE

inherit
	S_ANICURSOR_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			anicursor: TDS_ANICURSOR

		do     
			!! anicursor.make
			anicursor.set_id (tds.last_token)
			tds.insert_resource (anicursor)

			tds.set_current_resource (anicursor)
		end

	post_action is
		local
			anicursor: TDS_ANICURSOR
		do
			anicursor ?= tds.current_resource
			anicursor.set_filename (tds.last_token)
		end

end -- class ANICURSOR_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
