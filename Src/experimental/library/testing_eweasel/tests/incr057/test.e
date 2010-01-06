
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Then uncomment the creation clause
	--	in TEST1.  Recompile.  Compiler does not detect VTEC violation.

class TEST
creation
	make
feature

	make is
		do
		end;

	x: expanded TEST1;
end
