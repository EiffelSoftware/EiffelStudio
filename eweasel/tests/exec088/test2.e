
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	SHARED
create
	make
feature
	make
		do
			io.putstring ("In TEST2 make%N");
		end;

	x: expanded TEST1;
end
