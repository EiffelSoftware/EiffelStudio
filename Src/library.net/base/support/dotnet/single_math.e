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
		local
			l_a: MATH
		do
			Result := l_a.cos (v).truncated_to_real
		end

	arc_cosine (v: REAL): REAL is
			-- Trigonometric arccosine of `v'
		local
			l_a: MATH
		do
			Result := l_a.acos (v).truncated_to_real
		end

	sine (v: REAL): REAL is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		local
			l_a: MATH
		do
			Result := l_a.sin (v).truncated_to_real
		end

	arc_sine (v: REAL): REAL is
			-- Trigonometric arcsine of `v'
		local
			l_a: MATH
		do
			Result := l_a.asin (v).truncated_to_real
		end

	tangent (v: REAL): REAL is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		local
			l_a: MATH
		do
			Result := l_a.tan (v).truncated_to_real
		end

	arc_tangent (v: REAL): REAL is
			-- Trigonometric arctangent of `v'
		local
			l_a: MATH
		do
			Result := l_a.atan (v).truncated_to_real
		end

	sqrt (v: REAL): REAL is
			-- Square root of `v'
		require
			v >= 0.0
		local
			l_a: MATH
		do
			Result := l_a.sqrt (v).truncated_to_real
		end

	log (v: REAL): REAL is
			-- Natural logarithm of `v'
		require
			v > 0.0
		local
			l_a: MATH
		do
			Result := l_a.log (v).truncated_to_real
		end

	log10 (v: REAL): REAL is
			-- Base 10 logarithm of `v'
		require
			v > 0.0
		local
			l_a: MATH
		do
			Result := l_a.log10 (v).truncated_to_real
		end

	floor (v: REAL): REAL is
			-- Greatest integral value less than or equal to `v'
		local
			l_a: MATH
		do
			Result := l_a.floor (v).truncated_to_real
		end

	ceiling (v: REAL): REAL is
			-- Least integral value greater than or equal to `v'
		local
			l_a: MATH
		do
			Result := l_a.ceiling (v).truncated_to_real
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



