--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Definition of a structure (x, y).

indexing

	date: "$Date$";
	revision: "$Revision$"

class COORD_XY 

feature 

	x: INTEGER;
			-- Value of horizontal position.

	y: INTEGER;
			-- Value of vertical position.

	set (new_x, new_y: INTEGER) is
			-- Set position
		do
			x := new_x;
			y := new_y
		ensure
			x = new_x and y = new_y
		end

end
