indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Define_statement -> "#define" identifier identifier

class S_DEFINE_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "DEFINE_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
			value: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("#define")
			commit

			!! identifier.make
			put (identifier)

			!! value.make
			put (value)
			value.set_optional
		end

end -- class S_DEFINE_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
