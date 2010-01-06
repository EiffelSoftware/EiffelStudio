
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit TEST1
	
	undefine
		a
	redefine
		a
	end
creation
	make
feature
	
	a: INTEGER;

	make is
		do
		end;
	
end 
