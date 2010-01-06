
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  When compilation finishes, comment
	--	out declaration of `x' below and rerun compiler.
	--	Dies with exception trace.


class 
	MY_TEST
creation
	make
feature

	make is
		do
		end;

	x: MY_TEST1;
end


