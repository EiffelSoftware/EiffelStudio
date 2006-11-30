
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
creation
	make
feature
	
	make is
		do
			weasel.do_nothing
			!!x;
			x.weasel.do_nothing
		end;

	x: TEST1;
end
