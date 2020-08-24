
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
			list: LINKED_LIST [STRING];
		do 
			create list.make;
			list.extend ("weasel") ;
			create x;
			x.set_weasel (list);
			x.try;
		end;

	x: TEST1 [LINKED_LIST [STRING]];
end
