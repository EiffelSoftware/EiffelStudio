indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Defined_test -> "defined" "(" Identifier ")"

class S_DEFINED_TEST

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "DEFINED_TEST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("defined")
			commit

			keyword ("(")

			!! identifier.make
			put (identifier)

			keyword (")")
		end

end -- class S_DEFINED_TEST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
