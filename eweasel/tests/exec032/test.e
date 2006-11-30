
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Execute `test'.  Bus error in `is_equal'.

class 
	TEST
creation	
	make
feature
	
	make is
		do
			io.putbool (equal (1, 1)); io.new_line;
			io.putbool (equal (1, 3)); io.new_line;
			io.putbool (equal ('-', '-')); io.new_line;
			io.putbool (equal ('-', '+')); io.new_line;
			io.putbool (equal (true, true)); io.new_line;
			io.putbool (equal (true, false)); io.new_line;
			io.putbool (equal (3.14159, 3.14159)); io.new_line;
			io.putbool (equal (3.14159, 3.14158)); io.new_line;
			io.putbool (equal (3.141596782, 3.141596782)); io.new_line;
			io.putbool (equal (3.141596782, 3.141596781)); io.new_line;
		end;

end
