indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- resource -> Language_resource | Stringtable_resource | Standard_resource 

class S_RESOURCE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			language: LANGUAGE_RESOURCE
			stringtable: STRINGTABLE_RESOURCE
			standard: STANDARD_RESOURCE
		once
			!!Result.make
			Result.forth

			!! language.make
			put (language)

			!! stringtable.make
			put (stringtable)

			!! standard.make
			put (standard)
		end

end -- class S_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
