
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	
	make
		local
			t: TEST1 [TEST2];
			s: TEST2;
		do 
			create s ;
			create t.make (s);
			t.try;
		end

end
