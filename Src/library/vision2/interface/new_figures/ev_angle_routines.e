indexing
	description: "Set of trigonometric routines."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ANGLE_ROUTINES

inherit
	BASIC_ROUTINES
		export
			{NONE} all
		end

	SINGLE_MATH

feature -- Basic operation

	cos (a: EV_ANGLE): REAL is
			-- Trigonometric cosine of `a' degrees
		obsolete
			"use cosine of ev_angle instead"
		do
			Result := cosine (a.radians)
		end

	sin (a: EV_ANGLE): REAL is
			-- Trigonometric sine of `a' degrees
		obsolete
			"use sine of ev_angle instead"
		do
			Result := sine (a.radians)
		end

	mod360 (angle: REAL): REAL is
			-- Convert `angle' to within range of 0 and 360 
		do
			Result := angle
			if angle >= 360 then
				Result := angle - 360.0 * ((angle / 360).truncated_to_integer)
			end
			if angle < 0 then
				Result := angle + 360.0 * ((1 - angle / 360).truncated_to_integer)
			end
		ensure
			Result >= 0
			Result < 360
		end

end -- class EV_ANGLE_ROUTINES

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

