
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST4
inherit
	TEST3
		redefine
			make
		end
creation
	make
feature
	make is
		do
			io.put_string ("In TEST4 make%N")
		end
	
	www: INTEGER
end
