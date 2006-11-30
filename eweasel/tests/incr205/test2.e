
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
create
	make1, make2
feature
	

	make1 is 
		do 
			print ("Called make1%N") 
		end
	
	make2 is 
		do 
			print ("Called make2%N") 
		end
end
