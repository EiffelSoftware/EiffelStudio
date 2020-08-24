
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	make
feature
	make
		local
			t: TEST4;
			w: WEASEL;
			list: LINKED_LIST [WEASEL];
		do 
			create t ;
			create w ;
			create list.make;
			list.extend (w) ;
			create a.make;
			io.putstring ("Trying%N");
			a.b.try (t, list);
			io.putstring ("Done%N");
		end;

	a: TEST2 [WEASEL, TEST4];

end
