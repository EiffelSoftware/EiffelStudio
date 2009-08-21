
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is (without freezing).  Execute `test'.
	-- Prints incorrect results.

class TEST
creation
	make
feature
	
	make is
		local
			z: REAL;
		do
			z := ({REAL_32} 1.0 + {REAL_32} 0.1);
			io.putreal (z); io.putchar('%T');
			print (z); io.new_line;
			
			z := ({REAL_32} 1.0 - {REAL_32} 0.1);
			io.putreal (z); io.putchar('%T');
			print (z); io.new_line;
			
			z := ({REAL_32} 1.0 * {REAL_32} 0.1);
			io.putreal (z); io.putchar('%T');
			print (z); io.new_line;
			
			z := ({REAL_32} 1.0 / {REAL_32} 0.1);
			io.putreal (z); io.putchar('%T');
			print (z); io.new_line;
			io.new_line;
			
		end;

end

