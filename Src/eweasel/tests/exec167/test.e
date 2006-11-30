
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
			s := "29"
			t := "47"
			weasel (s, t);
		end
	
	weasel (a, b: STRING) is
		require
			pre1: equal (a, s)
			pre2: equal (b, t)
		external 
			"C inline"
		alias 
			"printf(%"Hi, weasel!\n%");"
		ensure
			post1: equal (a, s)
			post2: equal (b, t)
		end
		
	s, t: STRING
end
