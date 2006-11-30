
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- Run-time panic occurs.

class TEST
creation
	make
feature
	make is
		local
		do
			io.putstring ("Starting creation procedure%N");
			x := not x;
			io.putstring ("Negation completed%N");
			print (x.item (500000)); io.new_line;
			io.putstring ("Print completed%N");
		end;

	x: BIT 500000;
end

