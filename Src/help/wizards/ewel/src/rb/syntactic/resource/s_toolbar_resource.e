indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Toolbar_resource -> "TOOLBAR" Toolbar_options "BEGIN" Toolbar_list "END"

class S_TOOLBAR_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "TOOLBAR_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			begin1: BEGIN_BLOCK
			options: TOOLBAR_OPTIONS
			list: TOOLBAR_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("TOOLBAR")
			commit

			!! options.make
			put (options)

			!! begin1.make
			put (begin1)

			!! list.make
			put (list)

			!! end1.make
			put (end1)
		end

end -- class S_TOOLBAR_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
