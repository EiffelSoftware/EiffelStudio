indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	XXX

inherit
	AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "xxx"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local

		once
			!! Result.make
			Result.forth

			!! tto.make
			put (tto)
		end

end -- class XXX

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
