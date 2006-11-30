
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
			io.putbool (equal (weasel, wimp)); io.new_line;
			io.putbool (weasel.wuss = wimp.wuss); io.new_line;
		end;
		
	weasel: TEST1 is
		do
			io.putstring ("In weasel%N");
		end	

	wimp: TEST1 is
		do
			io.putstring ("In wimp%N");
			!!Result;
		end	

end
