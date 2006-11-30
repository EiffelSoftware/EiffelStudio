
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 
inherit 
	TEST2 [DOUBLE, TEST2 [DOUBLE, DOUBLE]] 
		redefine 
			make, f 
		end
	TEST3 
		redefine 
			make, f 
		end 

creation 
	make 

feature 
		make is 
			do
			end
		
		f is 
			do 
			end 
end
