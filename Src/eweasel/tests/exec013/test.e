
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Execute `test'.  Wrong results.

class TEST

creation
	make
feature
	make is
		do
			print (11B = 0011B); io.new_line;
			print (equal (0011B, 11B)); io.new_line;
			print (11B = 1100B); io.new_line;
			print (equal (1100B, 11B)); io.new_line;
		end;

end

