
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts class even though
	-- it does not seem to be legal.

class 
	TEST
creation
	make
feature

	make is
		do
			$INSTRUCTION
		end;

	test1 is
		do
		end;
end

