--|---------------------------------------------------------------
--|	Copyright (C) Interactive Software Engineering, Inc.        --
--|	 270 Storke Road, Suite 7 Goleta, California 93117          --
--|						 (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- POINT: Description of point (implementation for X).

indexing

	date: "$Date$";
	revision: "$Revision$"

class POINT 

inherit

	OPEN_FIG;

	INTERIOR
		rename
			make as interior_make
		end;

	COORD_XY_FIG
		rename
			duplicate as coord_duplicate
		end;

	COORD_XY_FIG
		redefine
			duplicate
		select
			duplicate
		end

creation

	make

feature 

	make is
			-- Create a point.
		do
			interior_make
		end;

	draw is
			-- Draw current point.
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing);
				drawing.draw_point (Current)
			end
		end;

	duplicate: like Current is
			-- Create a copy of current point.
		do
			Result := coord_duplicate;
			Result.set_foreground_color (foreground_color)
		ensure then
			Result.is_surimposable (Current);
			Result.foreground_color = foreground_color
		end;

invariant

	origin_user_type <= 2

end
