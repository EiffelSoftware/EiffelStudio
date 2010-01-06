
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
			x: expanded TEST1
		once
			io.putstring ("Printing 1%N");
			x := try;
			io.putstring ("Printing 2%N");
			x := try;
			io.putstring ("Printing 3%N");
			x := try;
		end

	try: TEST1 is
		once
			io.putstring ("Try point 1%N");
			$CREATION;
			io.putstring ("Try point 2%N");
			Result.set_a (47);
			io.putstring ("Try point 3%N");
		end
end
