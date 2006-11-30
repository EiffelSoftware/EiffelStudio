
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
			w: STRING
			y: TEST1;
			z: STRING
		do
			io.putstring ("Assigning%N");
			y := x;
			io.putstring ("Printing w%N");
			print (w);
			io.putstring ("Printing z%N");
			print (z);
		end;

	x: $ATTRIBUTE_TYPE
end
