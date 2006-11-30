
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		redefine
			wimp
		end

creation
	make

feature
	make is
		do
			io.put_string ("Weasel%N");
			wimp
		end
	
	wimp is
		do
			precursor
			io.put_string ("Wimps%N");
			precursor
		end
	
end
