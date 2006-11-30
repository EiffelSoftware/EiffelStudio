
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- 	Results are wrong for call numbers 2, 3, 5, 8.

class 
	TEST
inherit
	BASIC_ROUTINES;
creation	
	make
feature
	
	make is
		do
			
			io.putint (bottom_int_div (6, 2)); io.new_line;
			io.putint (bottom_int_div (-6, 2)); io.new_line;
			io.putint (bottom_int_div (6, -2)); io.new_line;
			io.putint (bottom_int_div (-6, -2)); io.new_line;
			
			io.putint (up_int_div (6, 2)); io.new_line;
			io.putint (up_int_div (-6, 2)); io.new_line;
			io.putint (up_int_div (6, -2)); io.new_line;
			io.putint (up_int_div (-6, -2)); io.new_line;
		end;
	
end
