
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
			b: TEST2 [STRING]
		do
			!!a;
			!!b;
			b.set_weasel ("weasel");
			a.try (b);
		end

	a: TEST1 [TEST2 [STRING]];
end
