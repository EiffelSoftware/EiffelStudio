indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Operator : "~"

class
	UNARY_NOT

inherit
	S_UNARY_NOT
		redefine
			action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature

	action is
		do
			inspect
				tds.identifier_type 

			when Option_style, Option_exstyle, Control_style, Control_exstyle then
				tds.last_style.set_desactivate
			end
		end

end -- class UNARY_NOT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
