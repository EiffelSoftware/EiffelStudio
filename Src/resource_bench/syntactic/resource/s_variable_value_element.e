indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Variable_value_element -> "VALUE" "%"Translation%"" "," langID "," charsetID

class S_VARIABLE_VALUE_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "VARIABLE_VALUE_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			langID: IDENTIFIER
			charsetID: IDENTIFIER
		once
			!! Result.make
			Result.forth
			
			keyword ("VALUE")
			commit

			keyword ("%"Translation%"")
			
			keyword (",")

			!! langID.make
			put (langID)

			keyword (",")

			!! charsetID.make
			put (charsetID)
		end

end -- class S_VARIABLE_VALUE_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
