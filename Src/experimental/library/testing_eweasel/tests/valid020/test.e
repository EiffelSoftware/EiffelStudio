
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Compiler does not complain, although TEST has an attribute
	--	of type `expanded TEST1' and TEST1 has more than
	--	one creation procedure (and they both take arguments).

class TEST
creation
	make
feature
	make is
		do
		end;

	a: expanded TEST1;

end
