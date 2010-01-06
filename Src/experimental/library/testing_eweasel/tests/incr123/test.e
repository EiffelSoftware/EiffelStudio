
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
	TEST2
creation
	make
feature
	make is
		local
			s: ARRAY [ANY];
		do
			c := 29;
			f := 47;
			s := strip ();
			print (s.item (1)); io.new_line;
			print (s.item (2)); io.new_line;
		end
	
end
