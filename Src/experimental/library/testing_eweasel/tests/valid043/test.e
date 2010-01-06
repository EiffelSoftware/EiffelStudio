
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler won't accept `y := << 3 >>',
	-- 	calling it a VJAR violation, although it appears to
	-- 	be valid by General Conformance rule condition 5
	--	(transitivity of conformance for reference types).

class 
	TEST
creation
	make
feature
	
	make is
		local
			x: ARRAY [ANY];
			y: ANY;
		do
			-- x := << 3 >>;
			-- y := x;
			y := << 3 >>;
		end;

end
