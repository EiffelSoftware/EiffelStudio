indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- File_flags -> "FILEFLAGS" fileflags

class S_FILE_FLAGS

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FILE_FLAGS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			fileflags: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("FILEFLAGS")
			commit

			!! fileflags.make
			put (fileflags)
		end

end -- class S_FILE_FLAGS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
