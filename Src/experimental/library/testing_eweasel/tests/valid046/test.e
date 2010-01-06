
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports VTAT, although the
	--	`x' appears to be the final name of an attribute of
	--	TEST whose declared type is a non-Anchored reference type.
	-- For comparison, if `x' is replaced by the 3 commented lines
	--	below it the class compiles fine.

class TEST
creation
	make
feature
	make is
		do
		end;

	x: ARRAY [like x];
	
	-- x: ARRAY [like y];
	-- y: ARRAY [like s];
	-- s: STRING;
end

