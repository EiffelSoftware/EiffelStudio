indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Control_statement_ex -> General_statement_ex | Icon_statement_ex | Generic_statement_ex

class S_CONTROL_STATEMENT_EX 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "CONTROL_STATEMENT_EX"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			general: GENERAL_STATEMENT
			icon: ICON_STATEMENT
			generic: GENERIC_STATEMENT
		once
			!! Result.make
			Result.forth

			!! general.make
			put (general)

			!! icon.make
			put (icon)

			!! generic.make
			put (generic)
		end

end -- class S_CONTROL_STATEMENT_EX

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
