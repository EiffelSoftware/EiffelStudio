indexing

	description:
		"Pseudo random number properties based on linear congruential method";

	copyright: "See notice at end of class";
	names: random;
	date: "$Date$";
	revision: "$Revision$"

class RANDOM inherit

	COUNTABLE [INTEGER];

	BASIC_ROUTINES
		export
			{NONE} all
		end;

	DOUBLE_MATH
		export
			{NONE} all
		end

creation
	make, set_seed

feature -- Initialization

	make is
		do
			set_seed (123_457)
		end

	set_seed (s : INTEGER) is
			-- Set `seed' to `s'
		require
			non_negative: s >= 0
		do
			seed := s
			last_result := seed
			last_item := 0
		end

feature -- Access

	modulus : INTEGER is
			-- Default value 2^31 -1 = 2,147,483,647
			-- May be redefined for a new generator	
		once
			Result := 2_147_483_647
		end

	multiplier : INTEGER is 
			-- Default value 7^5 = 16,807
			-- May be redefined for a new generator	
		once
			Result := 16_807
		end

	increment : INTEGER is 
			-- Default value 0
			-- May be redefined for a new generator	
		once
			Result :=  0
		end

	seed : INTEGER
			-- Default value 123,457
			-- May be redefined for a new generator.	
			--| change the value in `make' 

	next_random (n: INTEGER): INTEGER is
			-- Next random number after n
			-- in pseudo-random order
		require
			in_range: (n < modulus) and (n >= 0)
		do
			Result := randomize (n)
		ensure
			in_range: (Result < modulus) and (Result >= 0)
		end;

	has (n: INTEGER) : BOOLEAN is
			-- Will `n' be a random number?
		do
			Result := (n < modulus) and (n >= 0)
		ensure then
			only_: Result = (n < modulus and n >= 0)
		end

	item (i: INTEGER): INTEGER is
			-- The `i'-th random number
		local
			count: INTEGER
		do
			if i >= last_item then
				-- No need to start from beginning
				Result := last_result
				count := last_item
			else
				-- Start from scratch
				Result := seed
			end
			from
			until
				count = i 
			loop
				Result := randomize (Result)
				count := count + 1
			end
			last_result := Result
			last_item := i
		ensure then
			in_range: (Result < modulus) and (Result >= 0)
		end;

feature {NONE} -- Inapplicable

	linear_representation: LINEAR [INTEGER] is
		do
		end;

feature {NONE} -- Implementation

	randomize (xn : INTEGER) : INTEGER is
			-- Give Xn+1 given Xn
		local
			x: DOUBLE
		do
			x := double_mod (dmul * xn + dinc, dmod)
			debug
				io.putstring ("Randomize: ")
				io.putdouble (x)
				io.putstring (" returns: ")
			end
			Result := double_to_integer (x)
			debug
				io.putint (Result)
				io.new_line
			end
		end

	double_mod (x,m :DOUBLE) : DOUBLE is
			-- mod function for doubles
		do
			Result := x - (floor (x / m) * m)
		end

	last_item : INTEGER 
			-- last `item' requested 
			--| this can be used for optimising 
			--| calls to item.

	last_result: INTEGER
			-- value from last call to `item'

	dmod: DOUBLE is
			-- Double value for modulus 
		once	
			Result := modulus
		end

	dmul: DOUBLE is
			-- Double value for multiplier
		once	
			Result := multiplier
		end

	dinc: DOUBLE is
			-- Double value for increment
		once	
			Result := increment
		end

invariant
	non_negative_seed: seed >= 0
	non_negative_increment: increment >= 0
	positive_multiplier: multiplier > 0
	modulus_constraint: modulus > 1

end -- class RANDOM

--| This class is adapted from work in:
--| Discrete-Event System Simulation 
--| by Jerry Banks & John S. Carson, II 
--| Prentice-Hall International Series in 
--| Industrial and Systems Engineering 1984
--| Example 7.12 p 266 which is from
--| IMSL Scientific Subroutine Package [1978], 
--| written in Fortran for IBM 360/370 computers.

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
