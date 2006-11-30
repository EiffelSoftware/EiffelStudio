
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1 [TEST2]
		rename
			try as try1
		select
			try1
		end
	TEST1 [expanded TEST2]
		rename
			try as try2
		end
creation
	make
feature
	make is
		once
			try1 (x);
			try1 (y);
			try2 (x);
			try2 (y);
		end
	
	x: TEST2;
	y: expanded TEST2;
end
