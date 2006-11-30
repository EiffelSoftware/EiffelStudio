
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature
	make is
		local
			x: TEST1 [TEST3]
			t3: TEST3
		do
			create t3.make
			create x.make (t3)
		end

end
    
