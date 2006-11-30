
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
	
	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Works correctly.
	-- Uncomment the first line in body of `make'.  Rerun es3.
	--	Execute `test'.  Every "true" is switched to "false"
	--	and vice versa.
	
class 
	TEST
inherit 
	SINGLE_MATH;
creation	
	make
feature
	
	make is 
		local
			d: DOUBLE;
		do
			print (1.0 = 1.0); io.new_line;
			print (1.0 /= 1.0); io.new_line;
			print (1.0 < 2.0); io.new_line;
			print (1.0 > 2.0); io.new_line;
			print (1.0 <= 2.0); io.new_line;
			print (1.0 >= 2.0); io.new_line;
		end;

end
