indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- VersionInfo_resource -> "VERSIONINFO" Fixed_info "BEGIN" Block_info "END"

class S_VERSIONINFO_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "VERSIONINFO_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			fixed_info: FIXED_INFO
			begin1: BEGIN_BLOCK
			block_info: BLOCK_INFO
			end1: END_BLOCK
		once
			!! Result.make
			Result.forth

			keyword ("VERSIONINFO")
			commit

			!! fixed_info.make
			put (fixed_info)

			!! begin1.make
			put (begin1)

			!! block_info.make
			put (block_info)

			!! end1.make
			put (end1)
		end

end -- class S_VERSIONINFO_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
