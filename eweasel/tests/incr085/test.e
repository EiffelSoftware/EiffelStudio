
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is 
		do 
			io.putstring ("Starting make%N");
			!!x;
			io.putstring ("After creation%N");
			print (weasel (x).wimp); io.new_line;
		end

	x: TEST1;
	
	weasel (n: TEST1): TEST1 is
		do
			io.putstring ("In weasel%N");
			!!Result;
		end
end
