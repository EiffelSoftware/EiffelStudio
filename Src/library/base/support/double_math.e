--|---------------------------------------------------------------
--|   Copyright (C) 1989 Interactive Software Engineering, Inc. --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Double precision basic mathematical features.

class DOUBLE_MATH 

inherit

	MATH_CONST
		export
			{NONE} all
		end
	
feature 

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
	
feature 

	log_2 (v: DOUBLE): DOUBLE is
			-- Base 2 logarithm of `v'
		local
			a: DOUBLE
		do
			a := 2.0;
			Result := log (v) / log (a)
		end;

feature {NONE}

	dabs (v: DOUBLE): DOUBLE is
			-- Absolute of `v'
		external
			"C"
		alias
			"fabs"
		end;

end
