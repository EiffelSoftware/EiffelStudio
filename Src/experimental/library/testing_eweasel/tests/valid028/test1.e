
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> ARRAY [STRING]]
creation
	make
feature
	make (arg: G) is
		do
			x := arg;
		end;

	display is
		do
			io.putstring (x.item (1).out); io.new_line;
			x := x.item (1);
			io.putstring (x.item (1).out); io.new_line;
		end;

	x: G;
end


