
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
			b: BOOL_STRING;
		do
			!!b.make (0);
			io.putstring ("All done%N");
		end;

end 
