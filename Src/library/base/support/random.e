indexing

	description:
		"Pseudo-random number sequence, linear congruential method";

	copyright: "See notice at end of class";
	names: random;
	date: "$Date$";
	revision: "$Revision$"

class RANDOM inherit

	COUNTABLE_SEQUENCE [INTEGER]
		redefine
			has
		end;

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
			set_seed (default_seed)
		ensure
			seed_set: seed = default_seed
		end

	set_seed (s: INTEGER) is
			-- Choose `s' as the `seed'.
		require
			non_negative: s >= 0
		do
			seed := s
			last_result := seed
			last_item := 0
		ensure
			seed_set: seed = s
		end

feature -- Access

	default_seed: INTEGER is
			-- Default value 123,457;
			-- may be redefined for a new generator.	
		once
			Result := 123_457
		end

	modulus: INTEGER is
			-- Default value 2^31 -1 = 2,147,483,647;
			-- may be redefined for a new generator.	
		once
			Result := 2_147_483_647
		end

	multiplier: INTEGER is 
			-- Default value 7^5 = 16,807;
			-- may be redefined for a new generator.	
		once
			Result := 16_807
		end

	increment: INTEGER is 
			-- Default value 0;
			-- may be redefined for a new generator.	
		once
			Result :=  0
		end

	seed: INTEGER
			-- Seed for sequence.
			
	next_random (n: INTEGER): INTEGER is
			-- Next random number after `n'
			-- in pseudo-random order
		require
			in_range: (n < modulus) and (n >= 0)
		do
			Result := randomize (n)
		ensure
			in_range: (Result < modulus) and (Result >= 0)
		end;

	has (n: INTEGER): BOOLEAN is
			-- Will `n' be part of the random number sequence?
		do
			Result := (n < modulus) and (n >= 0)
		ensure then
			only_: Result = (n < modulus and n >= 0)
		end

	i_th (i: INTEGER): INTEGER is
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

	real_item: REAL is
			-- The current random number as a real between 0 and  1
		local
			r1, r2: REAL
		do
			r1 := item 
			r2 := modulus
			Result := r1 / r2
		end

	double_item: DOUBLE is
			-- The current random number as a double between 0 and 1
		local
			d: DOUBLE
		do
			d := item 
			Result := d / dmod
		end

	real_i_th (i: INTEGER): REAL is
			-- The `i'-th random number as a real between 0 and  1
		local
			r1, r2: REAL
		do
			r1 := i_th (i)
			r2 := modulus
			Result := r1 / r2
		end

	double_i_th (i: INTEGER): DOUBLE is
			-- The `i'-th random number as a double between 0 and 1
		local
			d: DOUBLE
		do
			d := i_th (i)
			Result := d / dmod
		end

feature {NONE} -- Implementation

	randomize (xn: INTEGER): INTEGER is
			-- Next item
		local
			x: DOUBLE
		do
			x := double_mod (dmul * xn + dinc, dmod)
			Result := double_to_integer (x)
		end

	double_mod (x,m: DOUBLE): DOUBLE is
			-- `x' modulo `m'
		do
			Result := x - (floor (x / m) * m)
		end

	last_item: INTEGER 
			-- Last `item' requested 
			--| this can be used for optimising 
			--| calls to item.

	last_result: INTEGER
			-- Value from last call to `item'

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
