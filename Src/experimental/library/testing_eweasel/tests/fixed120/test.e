
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is, with Ace as is.
	-- Then comment out the last 4 clusters in the Ace
	--	(access, list, storage, traversing).  Recompile.
	-- When compiler reports VTCT violation, add these 4 clusters
	--	back to the Ace (uncomment them).  Hit return.
	--	Exception trace during a pass 2.

class 
	TEST
creation
	make
feature
	make is
		local
			k: INTEGER;
			s: ARRAY [STRING];
		do
			from k := 1; until k > 10000 loop
				s := << "x", "x", "x" >>;
				k := k + 1;
			end
		end;
	

end
