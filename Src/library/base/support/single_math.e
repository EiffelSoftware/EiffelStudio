indexing 

	description:
		"Basic mathematical operations, single-precision. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class"

class SINGLE_MATH inherit

	MATH_CONST

feature -- Access

	log_2 (v: REAL): REAL is
			-- Base 2 logarithm of `v'
		require
			v > 0.0
		do
			Result := log (v)/ log (2.0)
		end;
 
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
	
feature {NONE} -- Implementation

	rabs (v: REAL): REAL is
			-- Absolute value of `v'
		do
			Result := math_rfabs (v)
		end;

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

end -- class SINGLE_MATH


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
