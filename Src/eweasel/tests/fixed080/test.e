
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports syntax error, although
	--	the Assertion in the postcondition appears to be
	--	syntactically legal.

class TEST
creation
	make
feature

	make is
		do
		ensure
			mission_completed:  -- Make sure everything is OK
		end;
	
	try (n: INTEGER) is
		require
			prime_argument: -- `n' is prime
		do
			check
				this_is_true:  -- Nothing in particular
			end
			from
			invariant
				loop_invariant:
			until
				false
			loop
			end
		ensure
			safe_universe:  -- The universe is safe
					-- for democracy
		end
		
invariant
	its_safe:  -- It is so safe you wouldn't believe it
		   -- (or maybe you would)
end

