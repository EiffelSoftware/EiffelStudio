indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Textinclude_data_list -> data Textinclude_data_list

class S_TEXTINCLUDE_DATA_LIST

inherit
	RB_AGGREGATE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "TEXTINCLUDE_DATA_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			data: IDENTIFIER
			list: TEXTINCLUDE_DATA_LIST
		once
			!! Result.make
			Result.forth

			!! data.make
			put (data)

			!! list.make
			put (list)
		end

end -- class S_TEXTINCLUDE_DATA_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
