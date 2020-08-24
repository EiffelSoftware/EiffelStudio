
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
			b: TEST2 [STRING]
		do 
			create a ;
			create b;
			b.set_weasel ("weasel");
			a.try (b);
		end

	a: TEST1 [TEST2 [STRING]];
end
