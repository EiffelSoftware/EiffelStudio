--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Set of trigonometric routines.

class ANGLE_ROUT 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end;

	SINGLE_MATH
	
feature 

	cos (a: REAL): REAL is
			-- Trigonometric cosine of `a' degrees
		require
			a_smaller_than_360: a < 360;
          	a_positive: a >= 0
		do
			Result := cosine ((Pi*a)/180)
		end;

	sin (a: REAL): REAL is
			-- Trigonometric sine of `a' degrees
		require
			a_smaller_than_360: a < 360;
          	a_positive: a >= 0
		do
			Result := sine ((Pi*a)/180)
		end;

	mod360 (angle: REAL): REAL is
			-- Convert `angle' to within range of 0 and 360 
		do
			Result := angle;
			if angle >= 360 then
				Result := angle-360.0*real_to_integer (angle/360)
			end;
			if angle < 0 then
				Result := angle+360.0*real_to_integer (1-angle/360)
			end
		ensure
			Result >= 0;
			Result < 360
		end;

end
