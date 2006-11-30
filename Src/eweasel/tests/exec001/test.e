
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing. Execute `test'.
	-- Correct values are printed, but not all digits are printed
	--	for a double when using `print' (io.putdouble works fine).
	
class 
	TEST
creation
	make
feature
	
	make is 
		do
			io.putstring ("print (9.87653412345) double: ");
			print (9.87653412345); io.new_line;
			io.putstring ("io.putdouble (9.87653412345): ");
			io.putdouble (9.87653412345); io.new_line;
		
			io.putstring ("print (x) double: ");
			print (x); io.new_line;
			io.putstring ("io.putdouble (x): ");
			io.putdouble (x); io.new_line;
		
		end;

	x: DOUBLE is 9.87653412345;
end

