--|---------------------------------------------------------------
--|	Copyright (C) Interactive Software Engineering, Inc.        --
--|	 270 Storke Road, Suite 7 Goleta, California 93117          --
--|						 (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- CLIP: Description of a clip.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CLIP 

feature 

	set (a_coin: COORD_XY; a_width, a_height: INTEGER) is
			-- Set the clip
		require
			a_coin_exists: not (a_coin = Void);
			a_width_positive: a_width >= 0;
			a_height_positive: a_height >= 0
		do
			upper_left := a_coin;
			width := a_width;
			height := a_height
		end; -- set

	upper_left: COORD_XY;
			-- Upper-left coiner of the clip area

	width: INTEGER;
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area

end
