
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
		do
			inspect
				13
			when uniq2..uniq3 then
			when uniq1..-3 then
			else
				print ("hi");
			end
		end;

	uniq1, uniq2, uniq3: INTEGER is unique;
end 
