indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Load_and_mem -> attributes Load_and_mem |

class LOAD_AND_MEM

inherit
	S_LOAD_AND_MEM
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 
	pre_action is
		do
			if (tds.current_resource.load_and_mem_attributes = Void) then
				tds.current_resource.make_load_and_mem_attributes
			end
		end

end -- class LOAD_AND_MEM

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
