
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
			io.putbool (equal (weasel, wimp)); io.new_line;
			io.putbool (weasel.wuss = wimp.wuss); io.new_line;
		end;
		
	weasel: TEST1
		do
			io.putstring ("In weasel%N");
		end	

	wimp: TEST1
		do
			io.putstring ("In wimp%N") ;
			create Result;
		end	

end
