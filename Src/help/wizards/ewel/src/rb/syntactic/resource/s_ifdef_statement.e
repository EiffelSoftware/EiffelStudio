indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Ifdef_statement -> "#ifdef" identifier Instructions_list Second_part "#endif"

class S_IFDEF_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "IFDEF_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			identifier: IDENTIFIER
			instructions_list: INSTRUCTIONS_LIST
			second_part: SECOND_PART
		once
			!! Result.make
			Result.forth

			keyword ("#ifdef")
			commit

			!! identifier.make
			put (identifier)

			!! instructions_list.make
			put (instructions_list)

			!! second_part.make
			put (second_part)

			keyword ("#endif")
		end

end -- class S_IFDEF_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
