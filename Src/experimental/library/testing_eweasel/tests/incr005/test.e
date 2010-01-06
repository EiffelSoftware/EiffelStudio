
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Add a new class named `G' in file `g.e' in the root cluster.
	-- Recompile.  VCFG violation detected, but pressing return
	--	causes compiler to just proceed with the compilation
	--	even though the violation is still present.

class 
	TEST
creation
	make
feature
	make is
		do
			a.x;
		end;
	
	a: TEST1 [STRING];
end

