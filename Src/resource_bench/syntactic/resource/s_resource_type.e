indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Resource_type -> Single_line | Multiline | User_defined_resource 

class S_RESOURCE_TYPE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "RESOURCE_TYPE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			single_line: SINGLE_LINE
			multiline: MULTILINE
			user: USER_DEFINED_RESOURCE
		once
			!! Result.make
			Result.forth

			!! single_line.make
			put (single_line)

			!! multiline.make
			put (multiline)

			!! user.make
			put (user)
                end

end -- class S_RESOURCE_TYPE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
