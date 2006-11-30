
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
creation
	make
     
feature
     
   	make is
		local
			x: TEST1;
			k: INTEGER;
		do
			from k := 1; until k > 1_000_000 loop
				!!x;
				k := k + 1;
			end
      		end;
     

end
