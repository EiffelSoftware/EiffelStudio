
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
			y: expanded TEST1 [DOUBLE]
			z: expanded TEST1 [STRING]
		do
			y.set_weasel (47.29);
			z := y;
			io.putstring (z.weasel); io.new_line;
		end
	
end
