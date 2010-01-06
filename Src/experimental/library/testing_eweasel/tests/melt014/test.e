
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
			io.putstring ("Entering TEST make%N");
			name := "Weasel";
			!!y.make_me (Current);
			if y = Void then
				io.putstring ("Y is Void%N");
			else
				io.putstring ("Y is not Void%N");
				io.putstring (y.name); io.new_line;
			end
			io.putstring ("Leaving TEST make%N");
		end;

	y: TEST1;
	
	set_y (val: TEST1) is
		do
			y := val;
		end
end

