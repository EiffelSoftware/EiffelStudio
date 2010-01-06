
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Change `a' to a variable attribute of type TEST.
	-- Recompile.  VUAR violation is detected.
	-- Hit return with no change to classes - compilation finishes
	--	instead of reporting VUAR violation again.


class 
	TEST
creation
	make
feature

	make is
		do
			try (a);
		end;

	a: TEST;

	try (arg: STRING) is
		do
		end
end

