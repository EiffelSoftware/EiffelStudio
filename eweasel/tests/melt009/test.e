
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, with melting and assertion (invariant).
	-- Execute `test'.
	-- Class invariant violation correctly triggers exception trace
	--	but run-time panic is also reported (only if classes
	--	not frozen).

class TEST
create
	make
feature
	make
		do 
			create x;
			x.test_me;
		end
	
	x: TEST2;
end
