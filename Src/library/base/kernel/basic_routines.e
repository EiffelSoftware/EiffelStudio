indexing

	description: "Some useful facilities on objects of basic types";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	BASIC_ROUTINES

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
		obsolete "Instead of charcode (c) use c.code"
		do
			Result := c.code
		end;

	integer_to_real (n: INTEGER): REAL is
			-- Real conversion of `n'
		obsolete
			"Use target := `n'"
		do
			Result := n
		end;

	real_to_integer (r: REAL): INTEGER is
			-- Integer conversion (truncation) of `r'

		obsolete "Instead of real_to_integer (r) use r.truncated_to_integer"
		do
			Result := r.truncated_to_integer
		end;

	double_to_real (d: DOUBLE): REAL is
			-- Real conversion (truncation) of `d'
		obsolete "Instead of double_to_real (d) use d.truncated_to_real"
		do
			Result := d.truncated_to_real
		end;

	real_to_double (r: REAL): DOUBLE is
			-- Double conversion of `r'
		obsolete
			"Use target := `r' instead."
		do
			Result := r
		end;

	double_to_integer (d: DOUBLE): INTEGER is
			-- Integer conversion (truncation) of `d'
		obsolete "Instead of double_to_integer (d) use d.truncated_to_integer"
		do
			Result := d.truncated_to_integer
		end

feature -- Basic operations

	abs (n: INTEGER): INTEGER is
			-- Absolute value of `n'
		do
			if n < 0 then
				Result := -n
			else
				Result := n
			end
		ensure
			non_negative_result: Result >= 0
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
			correct_negative: (n < 0) = (Result = -1);
			correct_zero: (n = 0) = (Result = 0);
			correct_positive: (n > 0) = (Result = +1)
		end;

	max (n1, n2: INTEGER): INTEGER is
			-- Maximum of `n1' and `n2'
		obsolete "Replace max (a, b) with a.max (b)"
		do
			Result := n1.max (n2)
		ensure
			is_maximum: (n2 >= n1) = (Result = n2) or else (n1 > n2) = (Result = n1)
		end;

	min (n1, n2: INTEGER): INTEGER is
			-- Minimum of `n1' and `n2'
		obsolete "Replace min (a, b) with a.min (b)"
		do
			Result := n1.min (n2)
		ensure
			is_minimum: (n2 <= n1) = (Result = n2) or else (n1 < n2) = (Result = n1)
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
			correct_negative: (r < 0) = (Result = -1);
			correct_zero: (r = 0) = (Result = 0);
			correct_positive: (r > 0) = (Result = +1)
		end;

	rmax (r1, r2: REAL): REAL is
			-- Maximum of `r1' and `r2'
		obsolete "Replace rmax (a, b) with a.max (b)"
		do
			Result := r1.max (r2)
		ensure
			is_maximum: (r2 >= r1) = (Result = r2) or else (r1 > r2) = (Result = r1)
		end;

	rmin (r1, r2: REAL): REAL is
			-- Minimum of `r1' and `r2'
		obsolete "Replace rmin (a, b) with a.min (b)"
		do
			Result := r1.min (r2)
		ensure
			is_minimum: (r2 <= r1) = (Result = r2) or else (r1 < r2) = (Result = r1)
		end;

	bottom_int_div (n1, n2: INTEGER): INTEGER is
			-- Greatest lower bound of the integer division of `n1' by `n2'
		external
			"C"
		alias
			"bointdiv"
		end;

	up_int_div (n1, n2: INTEGER): INTEGER is
			-- Least upper bound of the integer division
			-- of `n1' by `n2'
		external
			"C"
		alias
			"upintdiv"
		end;

end -- class BASIC_ROUTINES


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
