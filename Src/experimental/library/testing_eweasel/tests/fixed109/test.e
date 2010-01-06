
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile class as is.

creation
	make
feature
	
	make is
		local
			x: INTEGER;
		do
			from
			invariant
				x > 0
			until
				true
			loop
			end
		end;
	
end 
