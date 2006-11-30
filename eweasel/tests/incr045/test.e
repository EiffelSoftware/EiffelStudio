
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Execute `test'.  Prints bit string 20 bits long.
	-- Change value of constant `Weasel_bits' to 40.  Recompile.
	--	Execute `test'.  Still prints bit string 20 bits long,
	--	instead of one that is 40 bits long.

class 
	TEST
creation
	make
feature
	make is
		do
			z := 1111111111B;
			print (z); io.new_line;
		end;

	z: BIT weasel_bits;
	
	Weasel_bits: INTEGER is 20;
end

