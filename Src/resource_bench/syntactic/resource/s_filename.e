indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Filename -> filename | Data_block

class S_FILENAME 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "FILENAME"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			filename: IDENTIFIER
			data_block: DATA_BLOCK
		once
			!! Result.make
			Result.forth

			!! filename.make
			put (filename)

			!! data_block.make
			put (data_block)
		end

end -- class S_FILENAME

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
