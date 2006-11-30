
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	$PARENTS
	SHARED
creation
	make
feature
	make is
		do
			Current.weasel;
		end
	
	weasel is
		do
		ensure then
			post1: show ("Postcondition 1");
			post2: show ("Postcondition 2");
			post3: show ("Postcondition 3");
		end

end
