indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- HelpID -> "," identifier

class S_HELP_ID

inherit
	RB_AGGREGATE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "HELP_ID"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword (",")
			commit

			!! identifier.make
			put (identifier)
		end

end -- class S_HELP_ID

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
