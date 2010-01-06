
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, with TEST as root class.  
	-- Compiler exception trace results.

class TEST 
feature

	a: TEST1 [STRING];
end
