
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the problem:
	-- Compile classes as is.  Es3 reports violation of VMFN.
class 
	TEST
inherit 
	TEST1;
	TEST2;
creation
	make
feature
	
	make is
		do
		end;

end
