indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Control_statement -> Icon_statement | Generic_statement | Specific_statement | General_statement

class S_CONTROL_STATEMENT 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "CONTROL_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			icon: ICON_STATEMENT
			generic: GENERIC_STATEMENT
			specific: SPECIFIC_STATEMENT
			general: GENERAL_STATEMENT
		once
			!! Result.make
			Result.forth

			!! icon.make
			put (icon)

			!! generic.make
			put (generic)

			!! specific.make
			put (specific)

			!! general.make
			put (general)
		end

end -- class S_CONTROL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
