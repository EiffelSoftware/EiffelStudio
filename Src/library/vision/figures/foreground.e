--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- FOREGROUND: Figure who have a foreground color.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FOREGROUND 

feature 

	foreground_color: COLOR;
			-- Foreground color of current figure

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			color_not_void: not (a_color = Void)
		do
			foreground_color := a_color
		end;

end
