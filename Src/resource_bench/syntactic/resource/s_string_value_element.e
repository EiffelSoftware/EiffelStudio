indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- String_value_element -> "VALUE" string_name "," string_value 

class S_STRING_VALUE_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STRING_VALUE_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			string_name: IDENTIFIER
			string_value: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("VALUE")
			commit

			!! string_name.make
			put (string_name)

			keyword (",")

			!! string_value.make
			put (string_value)
		end

end -- class S_STRING_VALUE_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
