indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Stringtable_resource -> "STRINGTABLE" Stringtable_options "BEGIN" Strings_list "END"

class S_STRINGTABLE_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "STRINGTABLE_RESOURCE"
		end

feature

	production: LINKED_LIST [CONSTRUCT] is
		local
			options: STRINGTABLE_OPTIONS
			begin1: BEGIN_BLOCK
			strings_list: STRINGS_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("STRINGTABLE")
			commit

			!! options.make
			put (options)

			!! begin1.make
			put (begin1)

			!! strings_list.make
			put (strings_list)

			!! end1.make
			put (end1)
		end

end -- class S_STRINGTABLE_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
