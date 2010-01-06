
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature 

	make is
		external "C"
		ensure then
			valid_array: a.item (1) = (old +47.0).rounded;
			valid_array2: a.item (1) = (old (+47.0)).truncated_to_integer;
		end
			
	make2 is
		external "C"
		rescue
		end
			
	a: ARRAY [INTEGER];
	
end
