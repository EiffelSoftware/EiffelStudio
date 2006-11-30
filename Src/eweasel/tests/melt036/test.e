
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
			b: ARRAY [INTEGER];
		do
			b := << elem (1), elem (2), elem (3), elem (4) >>;
		end

	elem (k: INTEGER): INTEGER is
		do
			io.putint (k); io.new_line;
			Result := k;
		end

end
