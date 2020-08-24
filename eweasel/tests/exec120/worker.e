
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD
create
	make
feature

	execute
		local
			k, item_count, count: INTEGER;
			r: RANDOM;
		do
			item_count :=  100 
			create r.set_seed (47);
			from
				k := 1;
				r.start;
			until
				k > 100000
			loop
				count := r.item \\ item_count ;
				create s.make (count);
				s.fill_blank;
				k := k + 1;
				r.forth;
			end
		end;

	
	s: STRING;
	
end
