
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Change `ANY' to `STRING' in generic constraint in TEST1.  Recompile.
	-- When compiler reports VTGG violation, change `STRING' to back to `ANY' in
	--	the constraint in class TEST1.  Hit return to retry compilation.
	-- Compiler reports VD27, even though classes are valid.

class TEST

inherit
	TEST1 [TEST];	
creation
	make
feature

	make is
		do
		end;

end


