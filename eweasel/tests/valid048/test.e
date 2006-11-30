
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit TEST2
		redefine
			d
		end
creation
	make
feature
	
	make is
		do
		end;
	
	d: INTEGER is
		external
			"C"
		end;
end 
