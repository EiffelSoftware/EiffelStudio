
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST1
feature
	
	violate_precondition (n: INTEGER) is
		require
			good_precondition: n > 100
		do
		end;
		
	violate_postcondition (n: INTEGER) is
		do
		ensure
			good_postcondition: n > 100
		end;
		
	violate_invariant (n: INTEGER) is
		do
			field := -1;
		rescue
			field := 0
		end;
		
	violate_loop (n: INTEGER) is
		local
			k: INTEGER
		do
			from
				k := 1;
			variant
				good_variant: 30 - k
			until
				k > 50
			loop
				k := k + 1;
			end;
		end;
		
	violate_check (n: INTEGER) is
		do
			check
				enough_weasels: n < 0
			end
		end;
		
	field: INTEGER;
		
invariant
	good_invariant: field >= 0;
end
