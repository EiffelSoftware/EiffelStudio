indexing 
	description: "Demonstration of PRIMES, RANDOM, FIBONACCI"
	name: countables;
	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class COUNTABLES

create
	make

feature -- Initialization

	make is
		do
			prime_demo
			random_demo
			fibonacci_demo
		end

	c : COUNTABLE [INTEGER]

	prime_demo is
		do
			io.putstring ("%NPrime Demo%N")
			create {PRIMES} c
			display_first_ten
			has_test
		end

	random_demo is
		local
			r: RANDOM
		do 
			io.putstring ("%NRandom Demo%N")
			create {RANDOM} c.make
			display_first_ten
			io.putstring ("Change seed to 1%N")
			create r.set_seed (1)
			c := r
			display_first_ten
			io.putstring ("Change seed to 2%N")
			r.set_seed (2)
			c := r
			display_first_ten
			has_test
		end

	fibonacci_demo is
		do
			io.putstring ("%NFibonacci Demo%N")
			create {FIBONACCI} c
			display_first_ten
			has_test
		end

feature -- Output

	display_first_ten is
		local
			i : INTEGER
		do
			from
				i := 1
			until
				i > 10
			loop
				io.putstring ("Item: ")
				io.putint (i)
				io.putstring (" Value: ")
				io.putint (c.item (i))
				io.new_line
				i := i + 1
			end
		end
	
	has_test is
		local
			i : INTEGER
		do
			from 
				i := 2 
			until
				i > 5
			loop
				io.putstring ("Has: ")
				io.putint (i)
				io.putstring (" is ")
				io.putbool (c.has (i))
				io.new_line
				i := i + 1
			end
		end
				

end -- class COUNTABLES


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

