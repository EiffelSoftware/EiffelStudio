indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Single_line_user_resource -> filename

class S_SINGLE_LINE_USER_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "SINGLE_LINE_USER_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			filename: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! filename.make
			put (filename)
		end

end -- class SINGLE_LINE_USER_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
