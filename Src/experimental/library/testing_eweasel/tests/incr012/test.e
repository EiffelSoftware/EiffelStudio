
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Change value of constant `Weasel_bits' to -10.  Recompile.
	-- Compiler does not detect VTBT violation.

class 
	TEST
creation
	make
feature
	make is
		do
		end;

	b: BIT Weasel_bits;
	
	Weasel_bits: INTEGER is 10;
end

