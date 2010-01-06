
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Es3 reports violation of VDUS
	-- even though classes appear to be valid.

class 
	TEST
inherit 
	TEST1
		undefine
			f
		end;
creation	
	make
feature
	
	make is
		do
		end;
		
	f is
		once
		end
end
