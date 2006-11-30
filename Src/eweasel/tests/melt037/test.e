
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
	SHARED
creation
	make
feature
	make is
		do
			weasel;
		end
	
	weasel is
		do
		ensure then
			post1: 
				old show ("Old expression 1") and
				old show ("Old expression 2") or
				old show ("Old expression 3") and
				old show ("Old expression 4");
			post2: 
				old show ("Old expression 5") and
				old show ("Old expression 6");
		end
end
