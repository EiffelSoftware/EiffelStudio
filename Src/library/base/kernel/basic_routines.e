--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class BASIC_ROUTINES

feature -- Conversion

	charconv (i: INTEGER): CHARACTER is
			-- Character corresponding to ascii code `i'
		external
			"C"
		alias
			"chconv"
		end;

	charcode (c: CHARACTER): INTEGER is
			-- Integer ascii code corresponding to `c'
		external
			"C"
		alias
			"chcode"
		end;

	integer_to_real (n: INTEGER): REAL is
			-- Real conversion of `n'
		external
			"C"
		alias
			"conv_ir"
		end;

	real_to_integer (r: REAL): INTEGER is
			-- Integer conversion (truncation) of `r'
		external
			"C"
		alias
			"conv_ri"
		end;

	double_to_real (d: DOUBLE): REAL is
			-- Real conversion (truncation) of `d'
		external
            "C"
        alias
            "conv_dr"
		end;

	real_to_double (r: REAL): DOUBLE is
			-- Double conversion of `r'
		do
			Result := r
		end;

feature -- Numeric

	abs (n: INTEGER): INTEGER is
			-- Absolute value of `n'
		do
			if n < 0 then
				Result := -n
			else
				Result := n
			end
		ensure
			Result >= 0
		end;

	sign (n: INTEGER): INTEGER is
			-- Sign of `n':
			-- -1 if `n' < 0
			--  0 if `n' = 0
			-- +1 if `n' > 0
		do
			if n < 0 then
				Result := -1
			elseif n > 0 then
				Result := +1
			end
		ensure
			(n < 0) = (Result = -1);
			(n = 0) = (Result = 0);
			(n > 0) = (Result = +1)
		end;
		
	max (n1, n2: INTEGER): INTEGER is
			-- Maximum of `n1' and `n2'
		do
			if n1 > n2 then
				Result := n1
			else
				Result := n2
			end;
		ensure
			(n2 >= n1) = (Result = n2) or else (n1 > n2) = (Result = n1)
		end;

	min (n1, n2: INTEGER): INTEGER is
			-- Minimum of `n1' and `n2'
		do
			if n1 < n2 then
				Result := n1
			else
				Result := n2
			end
		ensure
			(n2 <= n1) = (Result = n2) or else (n1 < n2) = (Result = n1)
		end;

	rsign (r: REAL): INTEGER is
			-- Sign of `r':
			-- -1 if `r' < 0
			--  0 if `r' = 0
			-- +1 if `r' > 0
		do
			if r < 0 then
				Result := -1
			elseif r > 0 then
				Result := +1
			end
		ensure
			(r < 0) = (Result = -1);
			(r = 0) = (Result = 0);
			(r > 0) = (Result = +1)
		end;
		
	rmax (r1, r2: REAL): REAL is
			-- Maximum of `r1' and `r2'
		do
			if r1 > r2 then
				Result := r1
			else
				Result := r2
			end
		ensure
			(r2 >= r1) = (Result = r2) or else (r1 > r2) = (Result = r1)
		end;

	rmin (r1, r2: REAL): REAL is
			-- Minimum of `r1' and `r2'
		do
			if r1 < r2 then
				Result := r1
			else
				Result := r2
			end
		ensure
			(r2 <= r1) = (Result = r2) or else (r1 < r2) = (Result = r1)
		end;

	bottom_int_div (n1, n2: INTEGER): INTEGER is
			-- Integer part of the integer division of `n1' by `n2'
		external
			"C"
		alias
			"bointdiv"
		end;
	
	up_int_div (n1, n2: INTEGER): INTEGER is
			-- Upper bound of the integer division of `n1' by `n2'
		external
			"C"
		alias
			"upintdiv"
		end;

end
