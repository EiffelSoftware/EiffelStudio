indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Raw_data_element -> "," raw_data

class S_RAW_DATA_ELEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "RAW_DATA_ELEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			virgule: VIRGULE
			raw_data: IDENTIFIER
		once
			!! Result.make
			Result.forth

			!! virgule.make
			put (virgule)
			virgule.set_optional

			!! raw_data.make
			put (raw_data)
		end

end -- class S_RAW_DATA_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
