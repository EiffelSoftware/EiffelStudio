note
	description: "[
		Basic mathematical operations, double-precision.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_MATH

inherit
	MATH_CONST

feature -- Access

	log_2 (v: REAL_64): REAL_64
			-- Base 2 logarithm of `v'
		do
			Result := log (v) / log ({REAL_64} 2.0)
		end

	cosine (v: REAL_64): REAL_64
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := {MATH}.cos (v)
		end

	arc_cosine (v: REAL_64): REAL_64
			-- Trigonometric arccosine of radian `v'
			-- in the range [0, pi]
		do
			Result := {MATH}.acos (v)
		end

	sine (v: REAL_64): REAL_64
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.sin (v)
		end

	arc_sine (v: REAL_64): REAL_64
			-- Trigonometric arcsine of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := {MATH}.asin (v)
		end

	tangent (v: REAL_64): REAL_64
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.tan (v)
		end

	arc_tangent (v: REAL_64): REAL_64
			-- Trigonometric arctangent of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := {MATH}.atan (v)
		end

	sqrt (v: REAL_64): REAL_64
			-- Square root of `v'
		do
			Result := {MATH}.sqrt (v)
		end

	exp (v: REAL_64): REAL_64
			-- Exponential of `v'.
		do
			Result := {MATH}.exp (v)
		end

	log (v: REAL_64): REAL_64
			-- Natural logarithm of `v'
		do
			Result := {MATH}.log (v)
		end

	log10 (v: REAL_64): REAL_64
			-- Base 10 logarithm of `v'
		do
			Result := {MATH}.log_10 (v)
		end

	floor (v: REAL_64): REAL_64
			-- Greatest integral less than or equal to `v'
		do
			Result := {MATH}.floor (v)
		end

	ceiling (v: REAL_64): REAL_64
			-- Least integral greater than or equal to `v'
		do
			Result := {MATH}.ceiling (v)
		end

	dabs (v: REAL_64): REAL_64
			-- Absolute of `v'
		do
			Result := {MATH}.abs_double (v)
		end

note
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



end -- class DOUBLE_MATH



