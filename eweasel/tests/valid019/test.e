
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Es3 accepts them without complaint
	-- even though they appear to violate VDRS4.

class 
	TEST
inherit 
	TEST1
		redefine
			f
		end;
creation	
	make
feature
	
	make is
		do
		end;
		
	f: TEST is
		once
		end
end
