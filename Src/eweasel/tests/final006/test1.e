
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
creation
	make
feature
	make is
		do
			!!a.make;
			a.b.c.wimp;
			print (a.b.c.weasel); io.new_line;
		end;

	a: TEST2 [TEST4 [BIT 8]]
end
