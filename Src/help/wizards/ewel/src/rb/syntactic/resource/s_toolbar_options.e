indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_options -> Load_and_mem  width "," height General_options_list

class S_TOOLBAR_OPTIONS

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "TOOLBAR_OPTIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			load_and_mem: LOAD_AND_MEM
			width: IDENTIFIER
			height: IDENTIFIER
			general_options: GENERAL_OPTIONS_LIST
		once
			!! Result.make
			Result.forth

			!! load_and_mem.make
			put (load_and_mem)
			
			!! width.make
			put (width)

			keyword (",")

			!! height.make
			put (height)

			!! general_options.make
			put (general_options)
		end

end -- class S_TOOLBAR_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
