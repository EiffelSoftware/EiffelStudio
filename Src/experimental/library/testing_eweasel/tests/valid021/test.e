
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Compiler does not complain, although the creation procedure
	--	of expanded class TEST1 is not available to TEST
	--	and TEST an an attribute of type TEST1.

class TEST
creation
	make
feature
	make is
		do
		end;

	a: TEST1;

end
