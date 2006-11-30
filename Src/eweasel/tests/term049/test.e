
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		local
			y: ANY
		do
			!!weasel.make;
			weasel.extend ("weasel");
			!!x.make;
			x.extend (weasel);
			y := x.i_th (1).i_th (1);
			print (y); io.new_line;
		end;

	x: LINKED_LIST [like weasel];

	weasel: LINKED_LIST [STRING];
end
