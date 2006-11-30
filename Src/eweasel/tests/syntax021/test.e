
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler accepts them, even though
	--	generic constraint in TEST1 is not a Class_type.

class TEST
creation
	make
feature
	make is
		do
		end;

	x: TEST1 [expanded TEST];

end

