indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Multiline_user_resource -> "BEGIN" Raw_data_list "END"

class S_MULTILINE_USER_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "MULTILINE_USER_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			begin1: BEGIN_BLOCK
			raw_data_list: RAW_DATA_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth
			
			!! begin1.make
			put (begin1)

			!! raw_data_list.make
			put (raw_data_list)

			!! end1.make
			put (end1)
		end

end -- class S_MULTILINE_USER_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
