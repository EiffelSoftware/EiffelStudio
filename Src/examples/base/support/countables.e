indexing 
	description: "Demonstration of PRIMES, RANDOM, FIBONACCI"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COUNTABLES


