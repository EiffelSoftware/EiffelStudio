indexing

	description: "[
		Basic mathematical operations, single-precision.
		This class may be used as ancestor by classes needing its facilities
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SINGLE_MATH

inherit

	MATH_CONST

feature -- Access

	log_2 (v: REAL): REAL is
			-- Base 2 logarithm of `v'
		require
			v > 0.0
		do
			Result := log (v) / log (2.0)
		end

	cosine (v: REAL): REAL is
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := math_rcos (v)
		end

	arc_cosine (v: REAL): REAL is
			-- Trigonometric arccosine of `v'
		do
			Result := math_racos (v)
		end

	sine (v: REAL): REAL is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := math_rsin (v)
		end

	arc_sine (v: REAL): REAL is
			-- Trigonometric arcsine of `v'
		do
			Result := math_rasin (v)
		end

	tangent (v: REAL): REAL is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := math_rtan (v)
		end

	arc_tangent (v: REAL): REAL is
			-- Trigonometric arctangent of `v'
		do
			Result := math_ratan (v)
		end

	sqrt (v: REAL): REAL is
			-- Square root of `v'
		require
			v >= 0.0
		do
			Result := math_rsqrt (v)
		end

	log (v: REAL): REAL is
			-- Natural logarithm of `v'
		require
			v > 0.0
		do
			Result := math_rlog (v)
		end

	log10 (v: REAL): REAL is
			-- Base 10 logarithm of `v'
		require
			v > 0.0
		do
			Result := math_rlog10 (v)
		end

	floor (v: REAL): REAL is
			-- Greatest integral value less than or equal to `v'
		do
			Result := math_rfloor (v)
		end

	ceiling (v: REAL): REAL is
			-- Least integral value greater than or equal to `v'
		do
			Result := math_rceil (v)
		end

feature {NONE} -- Implementation

	rabs (v: REAL): REAL is
			-- Absolute value of `v'
		do
			Result := math_rfabs (v)
		end

	math_rcos (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_cos"
		end

	math_racos (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_acos"
		end

	math_rfabs (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_fabs"
		end

	math_rceil (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_ceil"
		end

	math_rfloor (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_floor"
		end

	math_rlog10 (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_log10"
		end

	math_rlog (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_log"
		end

	math_rsqrt (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_sqrt"
		end

	math_rtan (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_tan"
		end

	math_ratan (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_atan"
		end

	math_rsin (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_sin"
		end

	math_rasin (v: REAL): REAL is
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"float_asin"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class SINGLE_MATH



