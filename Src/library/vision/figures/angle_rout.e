note

	description: "Set of trigonometric routines"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	ANGLE_ROUT 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end;

	SINGLE_MATH
	
feature -- Basic operation

	cos (a: REAL): REAL
			-- Trigonometric cosine of `a' degrees
		require
			a_smaller_than_360: a < 360;
			a_positive: a >= 0
		do
			Result := cosine (((Pi*a)/180.0).truncated_to_real)
		end;

	sin (a: REAL): REAL
			-- Trigonometric sine of `a' degrees
		require
			a_smaller_than_360: a < 360;
			a_positive: a >= 0
		do
			Result := sine (((Pi*a)/180.0).truncated_to_real)
		end;

	mod360 (angle: REAL): REAL
			-- Convert `angle' to within range of 0 and 360 
		do
			Result := angle;
			if angle >= 360 then
				Result := angle - 360.0 * ((angle / 360).truncated_to_integer)
			end;
			if angle < 0 then
				Result := angle + 360.0 * ((1 - angle / 360).truncated_to_integer)
			end
		ensure
			Result >= 0;
			Result < 360
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ANGLE_ROUT

