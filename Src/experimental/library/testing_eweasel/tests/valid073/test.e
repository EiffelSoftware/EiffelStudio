
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.


class TEST
inherit
	TEST1
		undefine
			try
		end
creation
	make
feature

	make is
		local
			x: TEST1
		do
			io.putstring ("At start of make%N");
			x := Current;
			x.try (47);
			io.putstring ("At end of make%N");
		end;
	
	try (n: INTEGER) is
		do
			io.putstring ("Hey you weasel%N");
		end;

end
