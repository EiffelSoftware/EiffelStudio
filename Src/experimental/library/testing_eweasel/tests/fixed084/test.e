
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	
	-- To reproduce the error:
	-- Compile with classes as is.

creation
	make
feature
	
	make is
		local
			x: TEST1;
		do
			!!x;
			x.f;
			x.h;
		end;

end 
