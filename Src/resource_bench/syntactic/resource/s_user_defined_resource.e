indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- User_defined_resource -> typeID Load_and_mem More_user_defined_resource

class S_USER_DEFINED_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "USER_DEFINED_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			typeID: IDENTIFIER
			load_and_mem: LOAD_AND_MEM
			more: MORE_USER_DEFINED_RESOURCE
		once
			!! Result.make
			Result.forth

			!! typeID.make
			put (typeID)

			!! load_and_mem.make
			put (load_and_mem)

			!! more.make
			put (more)
		end

end -- class S_USER_DEFINED_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
