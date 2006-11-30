
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	MEMORY
		redefine
			dispose
		end
creation
	make
feature
	
	make is
		do
			!!s.make (10000);
			s.fill_blank;
		end
	
	s: STRING;
	
	dispose is
		local
			a, b: INTEGER;
		do
			a := a // b;
		end
end

