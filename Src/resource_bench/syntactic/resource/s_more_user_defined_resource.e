indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- More_user_defined_resource -> Single_line_user_resource | Multiline_user_resource

class S_MORE_USER_DEFINED_RESOURCE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "MORE_USER_DEFINED_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			single: SINGLE_LINE_USER_RESOURCE
			multiline: MULTILINE_USER_RESOURCE
		once
			!! Result.make
			Result.forth

			!! single.make
			put (single)

			!! multiline.make
			put (multiline)
		end

end -- class S_MORE_USER_DEFINED_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
