indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Accelerators_resource -> "ACCELERATORS" General_options_list "BEGIN" Accelerators_list "END"

class S_ACCELERATORS_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ACCELERATORS_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			begin1: BEGIN_BLOCK
			options: ACCELERATORS_OPTIONS
			list: ACCELERATORS_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("ACCELERATORS")
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

end -- class S_ACCELERATORS_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
