--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature

	make is
		do
			weasel ("29", "47", "29", "47")
		end
	
	weasel (a, b: STRING; s, t: STRING) is
		require
			pre1: (0).equal (a, s)
			pre2: (0).equal (b, t)
		external 
			"C inline"
		alias 
			"printf(%"Hi, weasel!\n%");"
		ensure
			post1: (0).equal (a, s)
			post2: (0).equal (b, t)
		end

end
