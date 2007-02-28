indexing

	description: "[
		Basic mathematical operations, single-precision.
		This class may be used as ancestor by classes needing its facilities
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			Result := l_a.log_10 (v).truncated_to_real
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
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class SINGLE_MATH



