indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Rcdata_resource -> "RCDATA" Rcdata_options "BEGIN" Raw_data_list "END"

class S_RCDATA_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "RCDATA_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			options: RCDATA_OPTIONS
			begin1: BEGIN_BLOCK
			list: RAW_DATA_LIST
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("RCDATA")
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

end -- class S_RCDATA_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
