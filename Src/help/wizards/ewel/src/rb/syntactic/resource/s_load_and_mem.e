indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Load_and_mem -> attributes Load_and_mem |

class S_LOAD_AND_MEM

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
			Result := "LOAD_AND_MEM"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			attributes: ATTRIBUTES
			list: LOAD_AND_MEM
		once
			!! Result.make
			Result.forth

			!! attributes.make
			put (attributes)

			!! list.make
			put (list)
		end

end -- class S_LOAD_AND_MEM

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
