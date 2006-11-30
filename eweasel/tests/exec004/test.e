
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 reports that there is no
	--	feature `_infix_power' in class integer, real or double.
	-- (Uncomment one line at a time below to try each one
	-- individually).
class 
	TEST

creation	
	make
feature
	
	make is 
		local
			i: INTEGER;
			r: REAL;
			d: DOUBLE;
		do
			i := 1;
			r := 1;
			d := 1;
			print ((2 ^ 3) ^ 3); io.new_line;
			print (2 ^ (3 ^ 3)); io.new_line;
			print ((i ^ i) ^ i); io.new_line;
			print (i ^ (i ^ i)); io.new_line;
			print ((r ^ r) ^ r); io.new_line;
			print (r ^ (r ^ r)); io.new_line;
			print (d ^ d ^ d); io.new_line;
			print (2.0 ^ 3.0 ^ 4.0); io.new_line;
		end;

end
