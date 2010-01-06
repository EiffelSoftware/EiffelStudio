
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
			p: PARENT;
			x: TEST1;
			y: TEST2;
		do
			!TEST1!p.make;
			io.put_integer (p.count); io.new_line;
			!TEST2!p.make;
			io.put_integer (p.count); io.new_line;
		end

end
