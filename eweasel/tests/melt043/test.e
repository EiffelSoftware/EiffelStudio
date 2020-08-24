
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
create
	make
     
feature
     
   	make
		local
			x: TEST1;
			k: INTEGER;
		do
			from k := 1; until k > 1_000_000 loop 
				create x;
				k := k + 1;
			end
      		end;
     

end
