
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make 
		do 
			io.putstring ("Starting make%N") ;
			create x;
			io.putstring ("After creation%N");
			print (weasel (x).wimp); io.new_line;
		end

	x: TEST1;
	
	weasel (n: TEST1): TEST1
		do
			io.putstring ("In weasel%N") ;
			create Result;
		end
end
