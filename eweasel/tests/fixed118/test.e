
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problems.
	-- Compile classes as is.
	-- Finish_freezing.
	-- Run `test'.
class 
	TEST
create
	make
feature
	
	make
		local
			x: TEST1;
			retrying: BOOLEAN;
			next: INTEGER;
		do
			if not retrying then 
				create x;
				next := preconditions;
			end;	
			if next = preconditions then	
				io.putstring ("Calling violate_precondition%N");
				x.violate_precondition (6);
				io.putstring ("Precondition violation not detected%N");
				next := next + 1;
			end;	
			if next = postconditions then	
				io.putstring ("Calling violate_postcondition%N");
				x.violate_postcondition (5);
				io.putstring ("Postcondition violation not detected%N");
				next := next + 1;
			end;	
			if next = invariants then	
				io.putstring ("Calling violate_invariant%N");
				x.violate_invariant (4);
				io.putstring ("Invariant violation not detected%N");
				next := next + 1;
			end;	
			if next = loops then	
				io.putstring ("Calling violate_loop%N");
				x.violate_loop (3);
				io.putstring ("Loop variant violation not detected%N");
				next := next + 1;
			end;	
			if next = checks then	
				io.putstring ("Calling violate_check%N");
				x.violate_check (2);
				io.putstring ("Check assertion violation not detected%N");
				next := next + 1;
			end
		rescue
			retrying := True;
			next := next + 1;
			io.putstring ("Assertion violation detected%N");
			retry;
		end;

	preconditions, postconditions, invariants, loops, checks: INTEGER = unique;

end
