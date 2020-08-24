
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
			y: ANY
		do 
			create weasel.make;
			weasel.extend ("weasel") ;
			create x.make;
			x.extend (weasel);
			y := x.i_th (1).i_th (1);
			print (y); io.new_line;
		end;

	x: LINKED_LIST [like weasel];

	weasel: LINKED_LIST [STRING];
end
