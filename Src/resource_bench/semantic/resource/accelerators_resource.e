indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Accelerators_resource -> "ACCELERATORS" General_options_list "BEGIN" Accelerators_list "END"

class ACCELERATORS_RESOURCE

inherit
	S_ACCELERATORS_RESOURCE
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			accelerators: TDS_ACCELERATORS

		do     
			!! accelerators.make
			accelerators.set_id (tds.last_token)

			tds.insert_resource (accelerators)
			tds.set_current_resource (accelerators)
		end -- pre_action

end -- class ACCELERATORS_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
