
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
create
	make
feature
	make
		local
			k: INTEGER;
			t: TEST1
		do
			from
				collection_off;
				k := 1;
			until
				k > 20
			loop
				io.putstring ("Creating instance of TEST1: ");
				io.putint (k); io.new_line ;
				create t;
				k := k + 1;
			end
		end

end
