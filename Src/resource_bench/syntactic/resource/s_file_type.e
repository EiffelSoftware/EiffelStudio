indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- FILE_TYPE -> "FILETYPE" filetype

class S_FILE_TYPE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FILE_TYPE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			filetype: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("FILETYPE")
			commit

			!! filetype.make
			put (filetype)
		end

end -- class S_FILE_TYPE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
