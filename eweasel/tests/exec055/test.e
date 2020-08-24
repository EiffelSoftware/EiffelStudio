
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
create
	make
feature
	
	make
		do
			weasel.do_nothing 
			create x;
			x.weasel.do_nothing
		end;

	x: TEST1;
end
