
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Put this class in file `test.e'.  Put class TEST4 in file
	-- 	`test4.e' (both in cluster `root1').  Run es3 using Ace 
	--	below (modified for your site).
	-- When compiler reports violation of VEEN, change name of class
	--	in file `test.e' from TEST to TEST4, the name of an
	--	existing class in another file.  Save and hit return.
	--	Es3 dies with exception trace.

class 
	$CLASS_NAME
creation	
	make
feature
	
	make is
		do
			n := 5;
		end;
	
end
