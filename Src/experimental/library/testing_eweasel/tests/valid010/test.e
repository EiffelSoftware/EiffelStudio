
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	-- To reproduce the error:
	-- Compile system with both classes as is.  Finish_freezing.
	-- Then uncomment the rename in the inheritance clause and
	-- also uncomment the body of `make'.
	-- Rerun es3 and then execute the system.
	
inherit TEST1
	rename
		infix "@" as prefix "@"
	end
creation
	make
feature
	
	make is
		local
			x: INTEGER;
		do
			x := @ Current;
			print (x);
		end;
	
end 
