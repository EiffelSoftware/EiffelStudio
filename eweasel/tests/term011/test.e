
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Results in compiler exception trace.

class 
	TEST
creation
	make
feature
	
	make is
		do
			print ((<< 3, 4, 5 >>).item (2)); io.new_line;
		end;

end
