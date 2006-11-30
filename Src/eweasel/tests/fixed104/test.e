
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compilation finishes, comment out first parent
	--	clause in TEST1 and uncomment second one.
	-- Recompile.  Exception trace.

class TEST
creation
	make
feature
	make is
		do
		end;

	g: TEST1 [STRING];

end
