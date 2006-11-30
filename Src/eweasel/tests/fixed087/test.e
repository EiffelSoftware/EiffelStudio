
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it, even though NONE
	--	does not conform to `expanded STRING' or `BIT 5'.

class TEST
creation
	make
feature

	make is
		local
			x: expanded TEST1;
			y: BIT 5;
		do
			$INSTRUCTION
		end;
			
end

