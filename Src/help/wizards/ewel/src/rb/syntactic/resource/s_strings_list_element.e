indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Strings_list_element -> stringID "," string_value

class S_STRINGS_LIST_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STRINGS_LIST_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			stringID: IDENTIFIER
			virgule: VIRGULE
			string_value: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! stringID.make
			put (stringID)

			!! virgule.make
			put (virgule)
			virgule.set_optional

			!! string_value.make
			put (string_value)
		end

end -- class S_STRINGS_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
