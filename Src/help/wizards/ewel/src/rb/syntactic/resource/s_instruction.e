indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Instruction -> Resource | Define_statement | Include_statement | Undef_statement | If_statement
--                Ifdef_statement | Ifndef_statement | Pragma_statement

class S_INSTRUCTION

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "INSTRUCTION"
		end

feature

	production: LINKED_LIST [CONSTRUCT] is
		local
			resource: RESOURCE
			define_statement: DEFINE_STATEMENT
			include_statement: INCLUDE_STATEMENT
			undef_statement: UNDEF_STATEMENT
			if_statement: IF_STATEMENT
			ifdef_statement: IFDEF_STATEMENT
			ifndef_statement: IFNDEF_STATEMENT
			pragma_statement: PRAGMA_STATEMENT
		once
			!! Result.make
			Result.forth

			!! resource.make
			put (resource)

			!! define_statement.make
			put (define_statement)

			!! include_statement.make
			put (include_statement)

			!! undef_statement.make
			put (undef_statement)

			!! if_statement.make
			put (if_statement)

			!! ifdef_statement.make
			put (ifdef_statement)

			!! ifndef_statement.make
			put (ifndef_statement)

			!! pragma_statement.make
			put (pragma_statement)
		end

end -- class S_INSTRUCTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
