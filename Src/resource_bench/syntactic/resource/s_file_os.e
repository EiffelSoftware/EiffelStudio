indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- FILE_OS -> "FILEOS" fileos

class S_FILE_OS

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FILE_OS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			fileos: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("FILEOS")
			commit

			!! fileos.make
			put (fileos)
		end

end -- class S_FILE_OS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
