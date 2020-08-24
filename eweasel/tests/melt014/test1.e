
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	make_me
feature
	make_me (val: TEST)
		do
			io.putstring ("Entering TEST1 make%N");
			name := "Hamster";
			val.set_y ($ARGUMENT);
			io.putstring ("Leaving TEST1 make%N");
		end

	name: STRING;
end
