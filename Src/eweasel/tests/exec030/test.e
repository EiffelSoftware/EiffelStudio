
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is, with or without freezing.  Execute `test'.
	-- Length of string "%U%U%U%U%U" should be 5, but is not.

class TEST 
creation
	make
feature
	
	make is
		do
			io.putint (("%U%U%U%U%U").count); io.new_line;
		end;
	
end

