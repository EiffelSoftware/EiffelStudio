
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	ttt: like Current
		do 
			create Result;
		end

	invariant_value: BOOLEAN
		local
			b: BOOLEAN;
		do
			io.putstring ("Entering invariant_value%N");
			b := equal (ttt.generator, "TEST1"); 
			io.putstring ("Leaving invariant_value%N");
		end
invariant
	good_ttt: invariant_value
end
