
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
			k: INTEGER
		do
			if k < 10000 then
				io.putstring("At beginning%N");
				io.putint(k // 0); io.new_line;
			end
		rescue
			io.putstring("You knucklehead!%N");
			k := k + 1;
			retry;
		end;

end
