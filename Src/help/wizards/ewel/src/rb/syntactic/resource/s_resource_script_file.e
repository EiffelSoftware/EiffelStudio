indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Lines of the form 
-- This is the top construct of the resource script language
-- Resource_script_file -> Instructions_list

class S_RESOURCE_SCRIPT_FILE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "RESOURCE_SCRIPT_FILE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			instructions_list: INSTRUCTIONS_LIST
		once
			!!Result.make
			Result.forth

			!! instructions_list.make
			put (instructions_list)
		end

end -- class S_RESOURCE_SCRIPT_FILE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
