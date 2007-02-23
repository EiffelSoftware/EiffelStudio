indexing

	description: "Some useful facilities on objects of basic types"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_ROUTINES

feature -- Conversion

	charconv (i: INTEGER): CHARACTER is
			-- Character corresponding to ascii code `i'
		do
			Result := i.to_character_8
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
		local
			d: INTEGER
		do
			d := n1 // n2
			if (n1 >= 0) /= (n2 > 0) then
				if n1 \\ n2 = 0 then
					Result := d
				else
					Result := d - 1
				end
			else
				Result := d
			end
		end

	up_int_div (n1, n2: INTEGER): INTEGER is
			-- Least upper bound of the integer division
			-- of `n1' by `n2'
		local
			d: INTEGER
		do
			d := n1 // n2
			if (n1 >= 0) = (n2 > 0) then
				if n1 \\ n2 = 0 then
					Result := d
				else
					Result := d + 1
				end
			else
				Result := d
			end
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



end -- class BASIC_ROUTINES



