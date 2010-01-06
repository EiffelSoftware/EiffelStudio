
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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
creation
	make
feature
	make is
		do
			!!x;
			x.test_me;
		end
	
	x: TEST2;
end
