
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make
		local
			a: TEST2 [DOUBLE]
		do
			a.try;
			b.try ;
			create c;
			c.try;
		end

	b: TEST2 [DOUBLE]
	
	c: TEST1 [DOUBLE]
	
end
