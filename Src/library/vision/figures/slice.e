--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- SLICE: Description of slice.

class SLICE 

inherit

	ELLIPSE
		undefine
			make
		redefine
			draw, is_surimposable
		end;

	ANGLE_ROUT
		export
			{NONE} all
		end;

	ARC_FILLABLE

creation

	make

feature 

	angle1: REAL;
			-- Angle which specifies start position of
			-- current arc relative to the orientation

	angle2: REAL;
			-- Angle which specifies end position of
			-- current arc relative to the start of
			-- current arc

	make is
			-- Create a slice.
		do
			!! center.make;
			angle2 := 360
		end;

	draw is
			-- Draw the slice.
		do
			if drawing.is_drawable then
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end
			end
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current slice surimposable to `other' ?
			--| not finished
		require else
			other_exists: not (other = Void)
		do
			Result := center.is_surimposable (other.center) and (radius1 = other.radius1) and (radius2 = other.radius2) and (orientation = other.orientation) and (angle1 = other.angle1) and (angle2 = other.angle2)
		end;

	set_angle1 (an_angle: like angle1) is
			-- Set angle1 to `an_angle'._
		require
			angle1_smaller_than_360: an_angle < 360;
			angle1_positive: an_angle >= 0
		do
			angle1 := an_angle
		ensure
			angle1 = an_angle
		end;

	set_angle2 (an_angle: like angle2) is
			-- Set angle2 to `an_angle'.
		require
			angle2_smaller_than_360: an_angle <= 360;
			angle2_positive: an_angle >= 0
		do
			angle2 := an_angle
		ensure
			angle2 = an_angle
		end;

invariant

	angle1 < 360;
	angle1 >= 0;
	angle2 <= 360;
	angle2 >= 0

end
