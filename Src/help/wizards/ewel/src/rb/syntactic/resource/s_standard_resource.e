indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Standard_resource -> nameID Resource_type

class S_STANDARD_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STANDARD_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			nameID: IDENTIFIER
			resource_type: RESOURCE_TYPE
		once
			!! Result.make
			Result.forth

			!! nameID.make
			put (nameID)

			!! resource_type.make
			put (resource_type)
		end

end -- class S_STANDARD_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
