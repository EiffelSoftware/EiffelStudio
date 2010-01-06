
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce symptoms:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- 	Body of once routine `try' is never executed even
	--	though the second call does not violate the precondition.
	
class 
	TEST
creation	
	make
feature
	
	make is
		local
			n: INTEGER;
		do
			if n < 3 then
				io.putstring ("Attempt for "); io.putint (n);
				io.new_line;
				try (n);
				n := n + 1;
				io.putstring ("Attempt for "); io.putint (n);
				io.new_line;
				try (n);
			end
		rescue
			io.putstring ("Rescue for "); io.putint (n);
			io.new_line;
			n := n + 1;
			retry;
		end;
		
	try (n: INTEGER) is
		require
			good_arg: n = 1;
		once
			io.putstring ("In try%N");
		ensure
			good_arg: n = 1;
		end;
		
end
