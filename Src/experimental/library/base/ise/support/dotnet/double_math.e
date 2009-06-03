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

	log_2 (v: DOUBLE): DOUBLE
			-- Base 2 logarithm of `v'
		local
			a: DOUBLE
		do
			a := 2.0
			Result := log (v) / log (a)
		end

	cosine (v: DOUBLE): DOUBLE
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := {MATH}.cos (v)
		end

	arc_cosine (v: DOUBLE): DOUBLE
			-- Trigonometric arccosine of radian `v'
			-- in the range [0, pi]
		do
			Result := {MATH}.acos (v)
		end

	sine (v: DOUBLE): DOUBLE
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.sin (v)
		end

	arc_sine (v: DOUBLE): DOUBLE
			-- Trigonometric arcsine of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := {MATH}.asin (v)
		end

	tangent (v: DOUBLE): DOUBLE
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.tan (v)
		end

	arc_tangent (v: DOUBLE): DOUBLE
			-- Trigonometric arctangent of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := {MATH}.atan (v)
		end

	sqrt (v: DOUBLE): DOUBLE
			-- Square root of `v'
		do
			Result := {MATH}.sqrt (v)
		end

	exp (v: DOUBLE): DOUBLE
			-- Exponential of `v'.
		do
			Result := {MATH}.exp (v)
		end

	log (v: DOUBLE): DOUBLE
			-- Natural logarithm of `v'
		do
			Result := {MATH}.log (v)
		end

	log10 (v: DOUBLE): DOUBLE
			-- Base 10 logarithm of `v'
		do
			Result := {MATH}.log_10 (v)
		end

	floor (v: DOUBLE): DOUBLE
			-- Greatest integral less than or equal to `v'
		do
			Result := {MATH}.floor (v)
		end

	ceiling (v: DOUBLE): DOUBLE
			-- Least integral greater than or equal to `v'
		do
			Result := {MATH}.ceiling (v)
		end

	dabs (v: DOUBLE): DOUBLE
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



