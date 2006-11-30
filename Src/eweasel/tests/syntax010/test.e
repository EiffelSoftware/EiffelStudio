
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.  Reports syntax error on `<< >>'.
	
class 
	TEST
creation
	make
feature
	
	make is
		local
			a: ARRAY [ANY];
		do
			a := << >>;
		end;

end
