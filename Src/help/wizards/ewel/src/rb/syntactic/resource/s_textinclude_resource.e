indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Textinclude_resource -> "TEXTINCLUDE" Load_and_mem "BEGIN" Textinclude_data_list "END"

class S_TEXTINCLUDE_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "TEXTINCLUDE_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			load_and_mem: LOAD_AND_MEM
			begin1: BEGIN_BLOCK
			list: TEXTINCLUDE_DATA_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("TEXTINCLUDE")
			commit

			!! load_and_mem.make
			put (load_and_mem)

			!! begin1.make
			put (begin1)

			!! list.make
			put (list)

			!! end1.make
			put (end1)
		end

end -- class S_TEXTINCLUDE_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
