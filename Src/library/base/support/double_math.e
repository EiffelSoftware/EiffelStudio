indexing

	description:
		"Basic mathematical operations, double-precision. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class"

class DOUBLE_MATH inherit

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
			"C"
		alias
			"cos"
		end;

	arc_cosine (v: DOUBLE): DOUBLE is
			-- Trigonometric arccosine of `v'
		external
			"C"
		alias
			"acos"
		end;

	sine (v: DOUBLE): DOUBLE is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		external
			"C"
		alias
			"sin"
		end;

	arc_sine (v: DOUBLE): DOUBLE is
			-- Trigonometric arcsine of `v'
		external
			"C"
		alias
			"asin"
		end;

	tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		external
			"C"
		alias
			"tan"
		end;

	arc_tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric arctangent of `v'
		external
			"C"
		alias
			"atan"
		end;

	sqrt (v: DOUBLE): DOUBLE is
			-- Square root of `v'
		external
			"C"
		end;
	
	log (v: DOUBLE): DOUBLE is
			-- Natural logarithm of `v'
		external
			"C"
		end;

	log10 (v: DOUBLE): DOUBLE is
			-- Base 10 logarithm of `v'
		external
			"C"
		end;
	
	floor (v: DOUBLE): DOUBLE is
			-- Greatest integral less than or equal to `v'
		external
			"C"
		end;

	ceiling (v: DOUBLE): DOUBLE is
			-- Least integral greater than or equal to `v'
		external
			"C"
		alias
			"ceil"
		end;

feature {NONE} -- Implementation

	dabs (v: DOUBLE): DOUBLE is
			-- Absolute of `v'
		external
			"C"
		alias
			"fabs"
		end;

end -- class DOUBLE_MATH


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
