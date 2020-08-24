
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
			a: TEST1 [DOUBLE];
			b: TEST1 [expanded DOUBLE];
			p: DOUBLE;
			q: expanded DOUBLE;
		do 
			create a;
			a.weasel (p) ;
			create b;
			b.weasel (q);
		end
	
end
