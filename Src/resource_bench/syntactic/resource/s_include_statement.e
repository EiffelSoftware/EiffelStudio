indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Define_statement -> "#include" identifier

class S_INCLUDE_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "INCLUDE_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("#include")
			commit

			!! identifier.make
			put (identifier)
		end

end -- class S_INCLUDE_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
