
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
			io.putstring ("All done%N");
		end;

	a1: TEST1;
	a2: TEST1;
end
