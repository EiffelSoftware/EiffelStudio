--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Integer constants, as used for polynomials

class POLY_INTEGER 

inherit

	INT_CONSTANT
		redefine
			action
		end;

	POLYNOM

create

	make

feature {NONE}

	action is
		do
			info.set_child_value (token.string_value.to_integer)
		end -- action

end -- class INT_CONSTANT
