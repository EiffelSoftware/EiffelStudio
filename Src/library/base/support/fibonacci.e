indexing

	description:
		"The Fibonacci number sequence"

	status: "See notice at end of class"
	names: fibonacci;
	date: "$Date$"
	revision: "$Revision$"

class FIBONACCI inherit

	COUNTABLE_SEQUENCE [INTEGER]
		rename
			has as is_fibonacci
		redefine
			i_th, is_fibonacci
		end

feature -- Access

	First: INTEGER is 1

	Second: INTEGER is 1

	higher_fibonacci (n: INTEGER): INTEGER is
			-- Lowest Fibonacci number greater than or equal to `n'
		do
			if n <= First then
				Result := First
			else
					-- `n' > First
				from
					Result := n
				until
					is_fibonacci (Result)
				loop
					Result := Result + 1
				end
			end
		end

	lower_fibonacci (n: INTEGER): INTEGER is
			-- Greatest Fibonacci number lower than or equal to `n'
		require
			argument_big_enough: n >= Second
		do
			if n = Second then
				Result := Second
			else
					-- `n' > Second
				from
					Result := n - 1
				until
					is_fibonacci (Result)
				loop
					Result := Result - 1
				end
			end
		end

	all_lower_fibonacci (n: INTEGER): ARRAY [BOOLEAN] is
			-- Array of `n' boolean values, where the
			-- value at index `i' is true if and only if
			-- `i' is a Fibonacci number.
		local
			i, j: INTEGER
		do
			from
				create Result.make (1, n)
				j := 1
				i := i_th (j)
			until
				i > n
			loop
				Result.put (True, i)
				j := j + 1
				i := i_th (j)
			end
		end

	is_fibonacci (n: INTEGER): BOOLEAN is
			-- Is `n' a Fibonacci number?
		local
			to_test, count: INTEGER
		do
			if n <= First then
				Result := False
			elseif n = First then
				Result := True
			else
				from
					count := First
					to_test := i_th (count)
				until
					to_test >= n
				loop
					count := count + 1
					to_test := i_th (count)
				end
				Result := to_test = n
			end
		end

	i_th (i: INTEGER): INTEGER is
			-- The `i'-th Fibonacci number
		local
			count: INTEGER
			last, second_last: INTEGER
		do
			if i = 1 then
				Result := First
			elseif i = 2 then
				Result := Second
			else
				from
					last := Second
					second_last := First
					count := 2
				until
					count = i
				loop
					Result := last + second_last
					second_last := last
					last := Result
					count := count + 1
				end
			end
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

end -- class FIBONACCI



