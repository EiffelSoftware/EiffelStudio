
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

create
	make
	
feature
	make is
			-- 
		local
			t: TEST
		do
			create t.make
		end
		
feature
	good: TEST2 is
		do
	--		create {G} Result.default_create
		end
end
