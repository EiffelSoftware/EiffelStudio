
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  
	-- Then change body of routine `try' in TEST1 to `external "C"'.
	-- Recompile.  Compiler does not detect VDRD violation.

class TEST
inherit
	TEST1;
	TEST2

creation
	make
feature

	make is
		do
		end;


end
