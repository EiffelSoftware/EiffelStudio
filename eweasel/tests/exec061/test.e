
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
			x: ARRAY [BIT 32]
		do
			!!x.make (1, 3);
			io.putstring ("Printing item 1%N");
			print (x.item (1)); io.new_line;
			io.putstring ("Done%N");
		end
	
end
