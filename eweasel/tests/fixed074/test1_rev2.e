
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> STRING]
inherit 
	TEST2
		redefine
			d
		end
		
feature	
	
	a: INTEGER is
		do
		end

	d: INTEGER is
		do
		end

end 
