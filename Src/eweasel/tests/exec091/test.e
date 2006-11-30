
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			!!y
			try;
		end

	x: expanded TEST1;
	
	y: TEST1;

	try is
		local
			z: expanded TEST1;
		do
		end

end
