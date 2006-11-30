
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST_MELT
inherit 		-- Compile first.  Then remove this inheritance
	TEST2;		-- clause and change `io.putint(x)' below to
			-- `io.putint(13)' and do es3 again.
creation 
	make

feature
	make is 
		do
			-- io.putint(13); io.new_line;
			io.putint(x); io.new_line;
		end;
end 
