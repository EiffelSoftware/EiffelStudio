
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
creation
	make
feature
	make is
		do
			value1 := value2;
			io.putbool (value1 = value2); io.new_line;
			io.putbool (equal (value1, value2)); io.new_line;
		end

	value1: G;
	
	value2: G;
end
