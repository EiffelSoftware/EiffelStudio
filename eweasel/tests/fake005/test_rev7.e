
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature 

	make is
		local
			a: STRING
		do
			!!a.make (1, 1);
			a.put (47, 1);
		ensure
			valid_array: weasel.item (1) = 47;
		end
			
	a: ARRAY [INTEGER];
	
end
