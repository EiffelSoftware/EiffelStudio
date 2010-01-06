
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST2 [G -> DOUBLE, H -> G] 
inherit 
	$PARENT
	TEST3 
		redefine 
			f, make 
		end 
feature 
	make is 
		do 
		end 

	f is 
		do 
		end 
end
