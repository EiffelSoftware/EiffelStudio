
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
inherit
	SINGLE_MATH
creation	
	make
feature
	
	make is
		do
			print (prime (13));
		end;
	
	prime (n: INTEGER): BOOLEAN is
		local
			s: INTEGER;
		do
			s := ceiling (sqrt (n));
		end;

end
