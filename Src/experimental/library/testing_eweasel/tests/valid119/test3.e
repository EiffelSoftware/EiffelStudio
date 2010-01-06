
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	TEST2
		redefine
			make
		end
creation
	make
feature
	make is
		do
			io.put_string ("In TEST3 make%N")
		end

	value1: DOUBLE is 3.14
	
	value2: DOUBLE
end

