
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
		end
	
feature {ANY}
	
	try is
		require
			good_integer: n > 0
		do
		end
	
feature {MEMORY}
	
	n: INTEGER

end
