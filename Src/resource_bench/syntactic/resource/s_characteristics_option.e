indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Characteristics_option -> "CHARACTERISTICS" dword

class S_CHARACTERISTICS_OPTION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "CHARACTERISTICS_OPTION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			dword: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("CHARACTERISTICS")
			commit
			
			!! dword.make
			put (dword)
		end

end -- class S_CHARACTERISTICS_OPTION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
