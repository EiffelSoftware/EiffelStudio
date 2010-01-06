
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 reports syntax error.

class 
	TEST

creation	
	make
feature
	
	make () is 
		do
			print (try1 ()); io.new_line;
			print (try2 ()); io.new_line;
		end;

	try1 (): INTEGER is 
		do
		end;

	try2: DOUBLE;

end
