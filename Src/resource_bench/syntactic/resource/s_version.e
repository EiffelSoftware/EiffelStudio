indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Version -> identifier, identifier, identifier, identifier

class S_VERSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "VERSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			hi_dw1: IDENTIFIER
			lo_dw1: IDENTIFIER
			hi_dw2: IDENTIFIER
			lo_dw2: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! hi_dw1.make
			put (hi_dw1)

			keyword (",")

			!! lo_dw1.make
			put (lo_dw1)

			keyword (",")

			!! hi_dw2.make
			put (hi_dw2)

			keyword (",")

			!! lo_dw2.make
			put (lo_dw2)
		end

end -- class S_VERSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
