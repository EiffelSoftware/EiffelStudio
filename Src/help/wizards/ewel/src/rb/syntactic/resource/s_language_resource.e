indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Language_resource -> "LANGUAGE" language "," sublanguage

class S_LANGUAGE_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "LANGUAGE_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			language: IDENTIFIER
			sublanguage: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("LANGUAGE")
			commit

			!! language.make
			put (language)

			keyword (",")

			!! sublanguage.make
			put (sublanguage)
		end

end -- class S_LANGUAGE_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
