indexing

	description: "Some useful facilities on objects of basic types"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_ROUTINES

feature -- Conversion

	charconv (i: INTEGER): CHARACTER is
			-- Character corresponding to ascii code `i'
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"chconv"
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
		end

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
			correct_negative: (n < 0) = (Result = -1)
			correct_zero: (n = 0) = (Result = 0)
			correct_positive: (n > 0) = (Result = +1)
		end

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
			correct_negative: (r < 0) = (Result = -1)
			correct_zero: (r = 0) = (Result = 0)
			correct_positive: (r > 0) = (Result = +1)
		end

	bottom_int_div (n1, n2: INTEGER): INTEGER is
			-- Greatest lower bound of the integer division of `n1' by `n2'
		external
			"C | %"eif_misc.h%""
		alias
			"bointdiv"
		end

	up_int_div (n1, n2: INTEGER): INTEGER is
			-- Least upper bound of the integer division
			-- of `n1' by `n2'
		external
			"C | %"eif_misc.h%""
		alias
			"upintdiv"
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

end -- class BASIC_ROUTINES



