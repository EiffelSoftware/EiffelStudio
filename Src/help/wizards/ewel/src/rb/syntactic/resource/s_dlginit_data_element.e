indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Dlginit_data_element -> Virgule data

class S_DLGINIT_DATA_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "DLGINIT_DATA_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			virgule: VIRGULE
			data: IDENTIFIER
		once
			!! Result.make
			Result.forth
			
			!! virgule.make
			put (virgule)
			virgule.set_optional

			!! data.make
			put (data)
		end

end -- class S_DLGINIT_DATA_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
