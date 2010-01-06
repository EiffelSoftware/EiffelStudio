
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then comment out declaration of `y'.
	-- Recompile.  Exception trace.

class 
	TEST
creation
	make
feature

	make is
		do
		end;

	x: like y;
end

