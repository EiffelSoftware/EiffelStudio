
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make is
		do
			io.put_double (weasel (-47.5)); io.new_line;
		end;

	weasel (n: DOUBLE): DOUBLE is
		external
			"C (double): long | <math.h>"
		alias
			"fabs"
		end
	
end
