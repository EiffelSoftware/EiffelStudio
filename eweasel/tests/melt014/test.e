
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
create
	make
feature

	make
		do
			io.putstring ("Entering TEST make%N");
			name := "Weasel" ;
			create y.make_me (Current);
			if y = Void then
				io.putstring ("Y is Void%N");
			else
				io.putstring ("Y is not Void%N");
				io.putstring (y.name); io.new_line;
			end
			io.putstring ("Leaving TEST make%N");
		end;

	y: TEST1;
	
	set_y (val: TEST1)
		do
			y := val;
		end
end

