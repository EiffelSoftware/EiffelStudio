
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Execute `test'.  Correct output.
	-- Now change type of feature `x' in this class to `expanded TEST1'.
	-- Recompile.  Execute `test'.  Dies with exception trace.

class TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
			!!x;
			x.try;
		end;

	x: $TYPE;

end




