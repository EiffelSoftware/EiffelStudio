indexing

	description:
		"Basic mathematical operations, double-precision. %
		%This class may be used as ancestor by classes needing its %
		%facilities."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_MATH

inherit

	MATH_CONST
		export
			{NONE} all
		end

feature -- Access

	log_2 (v: DOUBLE): DOUBLE is
			-- Base 2 logarithm of `v'
		local
			a: DOUBLE
		do
			a := 2.0;
			Result := log (v) / log (a)
		end;

	cosine (v: DOUBLE): DOUBLE is
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		external
			"C | %"math.h%""
		alias
			"cos"
		end;

	arc_cosine (v: DOUBLE): DOUBLE is
			-- Trigonometric arccosine of radian `v'
			-- in the range [0, pi]
		external
			"C | %"math.h%""
		alias
			"acos"
		end;

	sine (v: DOUBLE): DOUBLE is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		external
			"C | %"math.h%""
		alias
			"sin"
		end;

	arc_sine (v: DOUBLE): DOUBLE is
			-- Trigonometric arcsine of radian `v'
			-- in the range [-pi/2, +pi/2]
		external
			"C | %"math.h%""
		alias
			"asin"
		end;

	tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		external
			"C | %"math.h%""
		alias
			"tan"
		end;

	arc_tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric arctangent of radian `v'
			-- in the range [-pi/2, +pi/2]
		external
			"C | %"math.h%""
		alias
			"atan"
		end;

	sqrt (v: DOUBLE): DOUBLE is
			-- Square root of `v'
		external
			"C | %"math.h%""
		end;

	log (v: DOUBLE): DOUBLE is
			-- Natural logarithm of `v'
		external
			"C | %"math.h%""
		end;

	log10 (v: DOUBLE): DOUBLE is
			-- Base 10 logarithm of `v'
		external
			"C | %"math.h%""
		end;

	floor (v: DOUBLE): DOUBLE is
			-- Greatest integral less than or equal to `v'
		external
			"C | %"math.h%""
		end;

	ceiling (v: DOUBLE): DOUBLE is
			-- Least integral greater than or equal to `v'
		external
			"C | %"math.h%""
		alias
			"ceil"
		end;

feature {NONE} -- Implementation

	dabs (v: DOUBLE): DOUBLE is
			-- Absolute of `v'
		external
			"C | %"math.h%""
		alias
			"fabs"
		end;

end -- class DOUBLE_MATH


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
