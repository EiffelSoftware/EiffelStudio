
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- VUAR violation is detected, but is reported as VUAR2 violation.


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
