
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
inherit
	ARGUMENTS
creation 
	make
feature
	
	make is
		do
			io.putstring (argument (1)); io.new_line;
		end;

end

