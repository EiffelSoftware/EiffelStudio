
-- Set of trigonometric routines.

indexing
	copyright: "See notice at end of class"

class ANGLE_ROUT 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end;

	SINGLE_MATH
	
feature -- Basic operation

	cos (a: REAL): REAL is
			-- Trigonometric cosine of `a' degrees
		require
			a_smaller_than_360: a < 360;
          	a_positive: a >= 0
		do
			Result := cosine (double_to_real((Pi*a)/180.0))
		end;

	sin (a: REAL): REAL is
			-- Trigonometric sine of `a' degrees
		require
			a_smaller_than_360: a < 360;
          	a_positive: a >= 0
		do
			Result := sine (double_to_real((Pi*a)/180.0))
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

end -- class ANGLE_ROUT


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
