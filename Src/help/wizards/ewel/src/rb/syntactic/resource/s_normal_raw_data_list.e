indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Normal_raw_data_list -> Raw_data_element Normal_raw_data_list |

class S_NORMAL_RAW_DATA_LIST

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
			Result := "NORMAL_RAW_DATA_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			raw_data_item: RAW_DATA_ELEMENT
			list: NORMAL_RAW_DATA_LIST
		once
			!! Result.make
			Result.forth

			!! raw_data_item.make
			put (raw_data_item)

			!! list.make
			put (list)
		end

end -- class S_NORMAL_RAW_DATA_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
