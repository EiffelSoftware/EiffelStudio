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
			"C | <misc.h>"
		alias
			"chconv"
		end;

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

	bottom_int_div (n1, n2: INTEGER): INTEGER is
			-- Greatest lower bound of the integer division of `n1' by `n2'
		external
			"C | <misc.h>"
		alias
			"bointdiv"
		end;

	up_int_div (n1, n2: INTEGER): INTEGER is
			-- Least upper bound of the integer division
			-- of `n1' by `n2'
		external
			"C | <misc.h>"
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
