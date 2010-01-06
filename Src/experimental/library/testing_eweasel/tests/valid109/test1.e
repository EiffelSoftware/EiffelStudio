
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
creation
	make
feature
	make is
		local
			t: TEST4;
			w: WEASEL;
			list: LINKED_LIST [WEASEL];
		do
			!!t;
			!!w;
			!!list.make;
			list.extend (w);
			!!a.make;
			io.putstring ("Trying%N");
			a.b.try (t, list);
			io.putstring ("Done%N");
		end;

	a: TEST2 [WEASEL, TEST4];

end
