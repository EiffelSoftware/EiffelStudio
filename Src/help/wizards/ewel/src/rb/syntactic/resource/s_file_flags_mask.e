indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- File_flags_mask -> "FILEFLAGSMASK" fileflagsmask

class S_FILE_FLAGS_MASK

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FILE_FLAGS_MASK"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			fileflagsmask: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("FILEFLAGSMASK")
			commit

			!! fileflagsmask.make
			put (fileflagsmask)
		end

end -- class S_FILE_FLAGS_MASK

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
