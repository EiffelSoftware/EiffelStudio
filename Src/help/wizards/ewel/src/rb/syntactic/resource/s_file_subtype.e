indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- File_subtype -> "FILESUBTYPE" filesubtype

class S_FILE_SUBTYPE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FILE_SUBTYPE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			filesubtype: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("FILESUBTYPE")
			commit

			!! filesubtype.make
			put (filesubtype)
		end

end -- class S_FILE_SUBTYPE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
