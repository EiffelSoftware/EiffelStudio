--|---------------------------------------------------------------
--|	Copyright (C) Interactive Software Engineering, Inc.		--
--|	 270 Storke Road, Suite 7 Goleta, California 93117		  --
--|						 (805) 685-1006									 --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Closed figures (e.g. circles, polygons)
-- Such figures may be filled with a fill pattern.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class CLOSED_FIG 

inherit

	FIGURE

feature 

	center: COORD_XY_FIG is
			-- Center of the closed figure
		deferred
		end;

	interior: INTERIOR;
			-- Type of the interior
			-- Void if the figure shouldn't be filled

	path: PATH;
			-- Type of path
			-- Void if the path of the figure shouldn't be drawn

	set_origin_to_center is
			-- Set origin to `center'
		deferred
		end;

	set_interior (an_interior: INTERIOR) is
			-- Set `interior' to `an_interior'.
		do
			interior := an_interior
		ensure
			interior = an_interior
		end;

	set_path (a_path: PATH) is
			-- Set `path' to `a_path'.
		do
			path := a_path
		ensure
			path = a_path
		end

end
