indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Dlginit_resource -> "DLGINIT" "BEGIN" dlginit_data_list "END"

class S_DLGINIT_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "DLGINIT_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			begin1: BEGIN_BLOCK
			list: DLGINIT_DATA_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("DLGINIT")
			commit

			!! begin1.make
			put (begin1)

			!! list.make
			put (list)
			
			!! end1.make
			put (end1)
		end

end -- class S_DLGINIT_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
