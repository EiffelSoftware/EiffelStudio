
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
	TEST1
		rename 
			feat as new_feat 
		select 
			new_feat 
		end
	TEST1
		rename 
			feat as new_feat 
		select 
			new_feat 
		end
creation
	make
feature

	make is
		do
		end
	
end

