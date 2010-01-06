
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature
	
	a: TEST1;

	make is
		do
			from
			until 
				a.attribute_field
			loop
				print ("hi");
			end
		end;
	
end 
