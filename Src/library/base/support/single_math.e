--|---------------------------------------------------------------
--|   Copyright (C) 1989 Interactive Software Engineering, Inc. --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Single precision basic mathematical features.

class SINGLE_MATH 

inherit

	MATH_CONST

feature 

	cosine (v: REAL): REAL is
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := math_rcos (v)
		end;

	arc_cosine (v: REAL): REAL is
			-- Trigonometric arccosine of `v'
		do
			Result := math_racos (v)
		end;

	sine (v: REAL): REAL is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := math_rsin (v)
		end;

	arc_sine (v: REAL): REAL is
			-- Trigonometric arcsine of `v'
		do
			Result := math_rasin (v)
		end;

	tangent (v: REAL): REAL is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := math_rtan (v)
		end;

	arc_tangent (v: REAL): REAL is
			-- Trigonometric arctangent of `v'
		do
			Result := math_ratan (v)
		end;

	sqrt (v: REAL): REAL is
			-- Square root of `v'
		require
			v >= 0.0
		do
			Result := math_rsqrt (v)
		end;
	
	log (v: REAL): REAL is
			-- Natural logarithm of `v'
		require
			v > 0.0
		do
			Result := math_rlog (v)
		end;

	log10 (v: REAL): REAL is
			-- Base 10 logarithm of `v'
		require
			v > 0.0
		do
			Result := math_rlog10 (v)
		end;
	
	floor (v: REAL): REAL is
			-- Greatest integral value less than or equal to `v'
		do
			Result := math_rfloor (v)
		end;

	ceiling (v: REAL): REAL is
			-- Least integral value greater than or equal to `v'
		do
			Result := math_rceil (v)
		end;
	
feature {NONE}

	rabs (v: REAL): REAL is
			-- Absolute value of `v'
		do
			Result := math_rfabs (v)
		end;

feature 

	log_2 (v: REAL): REAL is
			-- Base 2 logarithm of `v'
		require
			v > 0.0
		do
			Result := log (v)/ log (2.0)
		end;

feature {NONE} -- External features

	math_rcos (v: REAL): REAL is
		external
			"C"
		end;

	math_racos (v: REAL): REAL is
		external
			"C"
		end;

	math_rfabs (v: REAL): REAL is
		external
			"C"
		end;

	math_rceil (v: REAL): REAL is
		external
			"C"
		end;

	math_rfloor (v: REAL): REAL is
		external
			"C"
		end;

	math_rlog10 (v: REAL): REAL is
		external
			"C"
		end;

	math_rlog (v: REAL): REAL is
		external
			"C"
		end;

	math_rsqrt (v: REAL): REAL is
		external
			"C"
		end;

	math_rtan (v: REAL): REAL is
		external
			"C"
		end;

	math_ratan (v: REAL): REAL is
		external
			"C"
		end;

	math_rsin (v: REAL): REAL is
		external
			"C"
		end;

	math_rasin (v: REAL): REAL is
		external
			"C"
		end;

end
