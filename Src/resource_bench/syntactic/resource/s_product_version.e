indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Product_version -> "PRODUCTVERSION" version

class S_PRODUCT_VERSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "PRODUCTVERSION"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			version: VERSION
		once
			!! Result.make
			Result.forth

			keyword ("PRODUCTVERSION")
			commit

			!! version.make
			put (version)
		end

end -- class S_PRODUCT_VERSION

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
