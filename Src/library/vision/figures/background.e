--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- BACKGROUND: Figure who have a background color.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BACKGROUND 

feature 

	background_color: COLOR;
			-- background color of current figure

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color
		ensure
			background_color = a_color
		end

end
