
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
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
create
	make
feature

	make
		do
			create x
			x.try
		end;

	x: $TYPE

end




