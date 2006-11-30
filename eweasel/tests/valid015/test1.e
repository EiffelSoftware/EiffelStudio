
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST1 [NONE -> STRING]
feature
	f (x: NONE) is
		local
			k: INTEGER;
			y: NONE;
		do
			k := x.count;
			io.putint (k); io.new_line;
			io.putstring (x); io.new_line;
			y := x;
			io.putstring (y); io.new_line;
		end;

end
