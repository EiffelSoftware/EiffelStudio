
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Dies with a PANIC.

class 
	TEST
creation	
	make
feature
	
	make is 
		local
			k: INTEGER;
		do
			if k <= 10000 then
				k := k + 1;
				io.putstring ("Starting make%N");
				io.putstring ("Attempt number "); io.putint (k); 
				io.new_line;
				try;
			end
		rescue
			retry;
		end;

	try is
		require
			0 < 0
		do
			io.putstring ("In try%N");
		ensure
			0 < 0
		end;
end
