indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Pragma_statement -> "#pragma" Nothing

class S_PRAGMA_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "PRAGMA_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			nothing: NOTHING
		once
			!! Result.make
			Result.forth

			keyword ("#pragma")
			commit

			!! nothing.make
			put (nothing)
		end

end -- class S_PRAGMA_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
